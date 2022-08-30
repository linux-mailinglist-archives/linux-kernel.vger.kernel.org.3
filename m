Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFB5A6452
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiH3NCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiH3NCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:02:49 -0400
X-Greylist: delayed 1608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 06:02:46 PDT
Received: from smtp2.uni-freiburg.de (smtp2.uni-freiburg.de [IPv6:2001:7c0:2500:4::25:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA58674CCD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:02:46 -0700 (PDT)
Delivery-date: Tue, 30 Aug 2022 15:02:46 +0200
Received: from fe2.uni-freiburg.de ([132.230.2.222] helo=uni-freiburg.de) port 54700 
        by smtp2.uni-freiburg.de with esmtp
        ( Exim )
        id 1oT0TD-0008CD-6L
        for linux-kernel@vger.kernel.org; Tue, 30 Aug 2022 14:35:56 +0200
Received: from [132.230.8.113] (account simon.rettberg@rz.uni-freiburg.de HELO computer)
  by mail.uni-freiburg.de (CommuniGate Pro SMTP 6.3.14)
  with ESMTPSA id 94944979; Tue, 30 Aug 2022 14:35:56 +0200
Date:   Tue, 30 Aug 2022 14:35:55 +0200
From:   Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Cc:     Rafael Gieschke <rafael.gieschke@rz.uni-freiburg.de>
Subject: [PATCH] drm/display: Don't assume dual mode adaptors support i2c
 sub-addressing
Message-ID: <20220830143555.22064236@computer>
Organization: Rechenzentrum Uni Freiburg
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dual mode adaptor ("DP++") detection code assumes that all adaptors
support i2c sub-addressing for read operations from the DP-HDMI adaptor ID
buffer.  It has been observed that multiple adaptors do not in fact
support this, and always return data starting at register 0.  On
affected adaptors, the code failed to read the proper registers that
would identify the device as a type 2 adaptor, and handled those as
type 1, limiting the TMDS clock to 165MHz.
Fix this by always reading the ID buffer starting from offset 0, and
discarding any bytes before the actual offset of interest.

Signed-off-by: Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>
Reviewed-by: Rafael Gieschke <rafael.gieschke@rz.uni-freiburg.de>
---
We had problems with multiple different "4k ready" DP++ adaptors only
resulting in 1080p resolution on Linux.  While one of them turned out to
actually just be a type1 adaptor, the others, according to the data
retrieved via i2cdump, were in fact proper type2 adaptors, advertising a
TMDS clock of 300MHz.  As it turned out, none of them supported
sub-addressing when reading from the DP-HDMI adaptor ID buffer via i2c.
The existing code suggested that this is known to happen with "broken"
type1 adaptors, but evidently, type2 adaptors are also affected.
We tried finding authoritative documentation on whether or not this is
allowed behaviour, but since all the official VESA docs are paywalled,
the best we could come up with was the spec sheet for Texas Instruments'
SNx5DP149 chip family.[1]  It explicitly mentions that sub-addressing is
supported for register writes, but *not* for reads (See NOTE in
section 8.5.3).  Unless TI blatantly and openly decided to violate the
VESA spec, one could take that as a strong hint that sub-addressing is
in fact not mandated by VESA.

[1] https://www.ti.com/lit/ds/symlink/sn75dp149.pdf
---
 .../gpu/drm/display/drm_dp_dual_mode_helper.c | 52 ++++++++++---------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
index 3ea53bb67..6147da983 100644
--- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
@@ -63,23 +63,42 @@
 ssize_t drm_dp_dual_mode_read(struct i2c_adapter *adapter,
 			      u8 offset, void *buffer, size_t size)
 {
+	int ret;
+	u8 zero = 0;
+	char *tmpbuf;
+	/*
+	 * As sub-addressing is not supported by all adaptors,
+	 * always explicitly read from the start and discard
+	 * any bytes that come before the requested offset.
+	 * This way, no matter whether the adaptor supports it
+	 * or not, we'll end up reading the proper data.
+	 */
 	struct i2c_msg msgs[] = {
 		{
 			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
 			.flags = 0,
 			.len = 1,
-			.buf = &offset,
+			.buf = &zero,
 		},
 		{
 			.addr = DP_DUAL_MODE_SLAVE_ADDRESS,
 			.flags = I2C_M_RD,
-			.len = size,
-			.buf = buffer,
+			.len = size + offset,
+			.buf = NULL,
 		},
 	};
-	int ret;
 
+	tmpbuf = kmalloc(size + offset, GFP_KERNEL);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+	msgs[1].buf = tmpbuf;
 	ret = i2c_transfer(adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret == ARRAY_SIZE(msgs))
+		memcpy(buffer, tmpbuf + offset, size);
+
+	kfree(tmpbuf);
+
 	if (ret < 0)
 		return ret;
 	if (ret != ARRAY_SIZE(msgs))
@@ -208,18 +227,6 @@ enum drm_dp_dual_mode_type drm_dp_dual_mode_detect(const struct drm_device *dev,
 	if (ret)
 		return DRM_DP_DUAL_MODE_UNKNOWN;
 
-	/*
-	 * Sigh. Some (maybe all?) type 1 adaptors are broken and ack
-	 * the offset but ignore it, and instead they just always return
-	 * data from the start of the HDMI ID buffer. So for a broken
-	 * type 1 HDMI adaptor a single byte read will always give us
-	 * 0x44, and for a type 1 DVI adaptor it should give 0x00
-	 * (assuming it implements any registers). Fortunately neither
-	 * of those values will match the type 2 signature of the
-	 * DP_DUAL_MODE_ADAPTOR_ID register so we can proceed with
-	 * the type 2 adaptor detection safely even in the presence
-	 * of broken type 1 adaptors.
-	 */
 	ret = drm_dp_dual_mode_read(adapter, DP_DUAL_MODE_ADAPTOR_ID,
 				    &adaptor_id, sizeof(adaptor_id));
 	drm_dbg_kms(dev, "DP dual mode adaptor ID: %02x (err %zd)\n", adaptor_id, ret);
@@ -233,11 +240,10 @@ enum drm_dp_dual_mode_type drm_dp_dual_mode_detect(const struct drm_device *dev,
 				return DRM_DP_DUAL_MODE_TYPE2_DVI;
 		}
 		/*
-		 * If neither a proper type 1 ID nor a broken type 1 adaptor
-		 * as described above, assume type 1, but let the user know
-		 * that we may have misdetected the type.
+		 * If not a proper type 1 ID, still assume type 1, but let
+		 * the user know that we may have misdetected the type.
 		 */
-		if (!is_type1_adaptor(adaptor_id) && adaptor_id != hdmi_id[0])
+		if (!is_type1_adaptor(adaptor_id))
 			drm_err(dev, "Unexpected DP dual mode adaptor ID %02x\n", adaptor_id);
 
 	}
@@ -343,10 +349,8 @@ EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
  * @enable: enable (as opposed to disable) the TMDS output buffers
  *
  * Set the state of the TMDS output buffers in the adaptor. For
- * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register. As
- * some type 1 adaptors have problems with registers (see comments
- * in drm_dp_dual_mode_detect()) we avoid touching the register,
- * making this function a no-op on type 1 adaptors.
+ * type2 this is set via the DP_DUAL_MODE_TMDS_OEN register.
+ * Type1 adaptors do not support any register writes.
  *
  * Returns:
  * 0 on success, negative error code on failure
-- 
2.35.1
