Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3D59836D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiHRMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbiHRMur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:50:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADADA72B48;
        Thu, 18 Aug 2022 05:50:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso1076427pjd.1;
        Thu, 18 Aug 2022 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=vJnTLCeVR9FrR1fGRSRdR2jBPsd1aq0zZ9FQzI+eolU=;
        b=MNghI+LDP186da8pPH5kN9fVLYJujS42WIxMQGjKnlNZa8RCbzlRfVTcF3q1cKj0zk
         mcKXl5kVByFhgGoY8VY20bK91f6X/X25Swf/+nFpCSy5Xk28gky5VRN6ZIYUJ3hTSkFa
         Raa6L68H0Toq88Lke3DIDhAoTzplcZQ3DOmDLFEkq7Q3szoxucTNmwtGsFkDZ+PY+KQV
         k0QlCJ4WH0WiUmXCS7ZcMnniRhboVtbtoG+yJvcbnxWPRVoqiZhIy5GYnIJ7QEbKXtlh
         Z1na53a+UmfHyXM5axPf8OcGmJrUXUvuSweboWqtf5+wU0Ddl3sbXs/02kMQ2xfgYRUY
         iRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vJnTLCeVR9FrR1fGRSRdR2jBPsd1aq0zZ9FQzI+eolU=;
        b=4ZynomhOXuyG334Ae9T5CzJllHGHktzHfXmhu1y7W/U9ysGlXZKV3MxlcH9RTNI5yB
         bqos4pzaeD1OFjgp+9e6Rg3rsMVmb3ZpFE4t2G3vL0t2kgiAGhdoQvw1JzMOaxlBojnj
         B7n1sQdL/du5ycgpumDmBW1FrTPfxu3Vo4WPRQmK0MF2kcxyOF/yXB6v4Nuyhb9eQnGR
         b0CiuFUr/DxG5aL9H84iQK4KZ0VjIVgKZIKQCpjSqZSw6x7ScnxglD8np5I1fygWPVRw
         /plJis3cumct88I2VgK6f5oAxoobE7208sYNOCOOeK1MhIEcmIZT0fhtWqocpyCPwiUn
         2KiA==
X-Gm-Message-State: ACgBeo0A/+Cu0GxzScj4Zk0h/TAa+GaZPhwIT35lqVj0oZpt9a31iyIo
        6CR8x/MtfNL/SViPk2pF2x8=
X-Google-Smtp-Source: AA6agR6XIc1+iaF72gu2Yv5kU53Tf7XtCVTsB/UrrSTAgOpxlJ5jT/K/Kg28sATRWPJ7zrAo3Ia6Nw==
X-Received: by 2002:a17:90b:4f49:b0:1f5:c7c:b565 with SMTP id pj9-20020a17090b4f4900b001f50c7cb565mr8929936pjb.32.1660827034057;
        Thu, 18 Aug 2022 05:50:34 -0700 (PDT)
Received: from goorm.ap-northeast-2.compute.internal (ec2-3-39-17-166.ap-northeast-2.compute.amazonaws.com. [3.39.17.166])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b0016d5428f041sm1301228plb.199.2022.08.18.05.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:50:33 -0700 (PDT)
From:   YongSu Yoo <yongsuyoo0215@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, yongsu.yoo@lge.com
Cc:     YongSu Yoo <yongsuyoo0215@gmail.com>
Subject: [PATCH] media: dvb_ca_en50221: A bug is fixed for size write
Date:   Thu, 18 Aug 2022 12:50:27 +0000
Message-Id: <20220818125027.1131-1-yongsuyoo0215@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>

The function of "dvb_ca_en50221_write_data" at source/drivers/media
/dvb-core/dvb_ca_en50221.c is used for two cases.
The first case is for writing APDU data in the function of
"dvb_ca_en50221_io_write" at source/drivers/media/dvb-core/
dvb_ca_en50221.c.
The second case is for writing the host link buf size on the
Command Register in the function of "dvb_ca_en50221_link_init"
at source/drivers/media/dvb-core/dvb_ca_en50221.c.
In the second case, there exists a bug like followings.
In the function of the "dvb_ca_en50221_link_init",
after a TV host calculates the host link buf_size,
the TV host writes the calculated host link buf_size on the
Size Register.
Accroding to the en50221 Spec (the page 60 of
https://dvb.org/wp-content/uploads/2020/02/En50221.V1.pdf),
before this writing operation, the "SW(CMDREG_SW)" flag in the
Command Register should be set. We can see this setting operation
in the function of the "dvb_ca_en50221_link_init" like below.
...
	if ((ret = ca->pub->write_cam_control(ca->pub, slot,
CTRLIF_COMMAND, IRQEN | CMDREG_SW)) != 0)
		return ret;
...
But, after that, the real writing operation is implemented using
the function of the "dvb_ca_en50221_write_data" in the function of
"dvb_ca_en50221_link_init", and the "dvb_ca_en50221_write_data"
includes the function of "ca->pub->write_cam_control",
and the function of the "ca->pub->write_cam_control" in the
function of the "dvb_ca_en50221_wrte_data" does not include
"CMDREG_SW" flag like below.
...
	if ((status = ca->pub->write_cam_control(ca->pub, slot,
CTRLIF_COMMAND, IRQEN | CMDREG_HC)) != 0)
...
In the above source code, we can see only the "IRQEN | CMDREG_HC",
but we cannot see the "CMDREG_SW".
The "CMDREG_SW" flag which was set in the function of the
"dvb_ca_en50221_link_init" was rollbacked by the follwoing function
of the "dvb_ca_en50221_write_data".
This is a bug. and this bug causes that the calculated host link buf_size
is not properly written in the CI module.
Through this patch, we fix this bug.
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index 15a08d8c69ef..13f249b0a080 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -187,7 +187,7 @@ static void dvb_ca_en50221_thread_wakeup(struct dvb_ca_private *ca);
 static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
 				    u8 *ebuf, int ecount);
 static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
-				     u8 *ebuf, int ecount);
+				     u8 *ebuf, int ecount, int size_write_flag);
 
 /**
  * findstr - Safely find needle in haystack.
@@ -370,7 +370,7 @@ static int dvb_ca_en50221_link_init(struct dvb_ca_private *ca, int slot)
 	ret = dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_FR, HZ / 10);
 	if (ret)
 		return ret;
-	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2);
+	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2, CMDREG_SW);
 	if (ret != 2)
 		return -EIO;
 	ret = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, IRQEN);
@@ -778,11 +778,13 @@ static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
  * @buf: The data in this buffer is treated as a complete link-level packet to
  *	 be written.
  * @bytes_write: Size of ebuf.
+ * @size_write_flag: A flag on Command Register which says whether the link size
+ * information will be writen or not. 
  *
  * return: Number of bytes written, or < 0 on error.
  */
 static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
-				     u8 *buf, int bytes_write)
+				     u8 *buf, int bytes_write, int size_write_flag)
 {
 	struct dvb_ca_slot *sl = &ca->slot_info[slot];
 	int status;
@@ -817,7 +819,7 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
 
 	/* OK, set HC bit */
 	status = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND,
-					    IRQEN | CMDREG_HC);
+					    IRQEN | CMDREG_HC | size_write_flag);
 	if (status)
 		goto exit;
 
@@ -1508,7 +1510,7 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 			mutex_lock(&sl->slot_lock);
 			status = dvb_ca_en50221_write_data(ca, slot, fragbuf,
-							   fraglen + 2);
+							   fraglen + 2, 0);
 			mutex_unlock(&sl->slot_lock);
 			if (status == (fraglen + 2)) {
 				written = 1;
-- 
2.17.1

