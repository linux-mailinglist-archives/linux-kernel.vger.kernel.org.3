Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB550E373
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiDYOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiDYOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:43:36 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304AB12095;
        Mon, 25 Apr 2022 07:40:28 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B634D12230F;
        Mon, 25 Apr 2022 14:40:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3C992121C6B;
        Mon, 25 Apr 2022 14:40:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650897626; a=rsa-sha256;
        cv=none;
        b=Ch6vIHEfibAUO0Y33V4uRmLlYB3zg5Qld2y9t6lrjyBtVuIznydtFETH46XONTzJ3aWttr
        l8DBtnjAVfp7HPP19a/JR23Hmf7gE+F5ca3bqHxv/bWM3tMbJNUU/VQSYn0fR9jlu8cECq
        tt/200tT8kghZO7WgandRs9WFmqotbUxGI0V9gVe+x/ug4iwyS23gUvTpiZgkpAkd4rXxs
        M5rhKr49sqfmXUSiNR/TFfn3ghOrVamjT1pH80E+lIgxofAvIh9o6jDrWusH/u4wNZB4o4
        7cfLFdol6dw7FLYHgkeMfSPauJ4L9GQtsdZkE5EhhbKmpf/zUjuZei6gpm678w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650897626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=03zhN+hBW8OaOUeJAmtwzMX7G3KCH/6OA0MvZT3k0A8=;
        b=DIUvnXzX6VdyF48SoH2WAsIObwkyhLIA90gZMMVihodSVjz6rNelZAiSJBPBIqFedXY30M
        dvqHtvOQ5UwZ4n6hAzFJnE2cefcOEputBv6GZ9p6UHK2r3ddC2o7JgfZGsj/UaAiiE3E1u
        mW82A+UyMhv+dD3xuQAjbHG5IANyyDRBivMtZPxcSSyHxI4fDnhmB3WTuRVVFC6DUSoCmd
        8aY6QF992h71R9NSeTj5MGrbVxIPg+t41t63ZatQPtrgEmy3x976J8FClz51IqaXqseIo5
        Rrd2IcQEIhJXqbH13GDt+N6Lj6dGK2KM/+xI1EGKJkVol8GUabgGKDPevxA7BQ==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-dhxks;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Industry-Reign: 1b2237d95476f30c_1650897626607_1242597651
X-MC-Loop-Signature: 1650897626606:2627875157
X-MC-Ingress-Time: 1650897626606
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.30 (trex/6.7.1);
        Mon, 25 Apr 2022 14:40:26 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4Kn73D6ZtFznb;
        Mon, 25 Apr 2022 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650897625;
        bh=03zhN+hBW8OaOUeJAmtwzMX7G3KCH/6OA0MvZT3k0A8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=CIjiGs0h73JREbVDCOlL58tN4jqkRDWhDAtCtQwpFBAGohCrM1HccVHCVB7LheRgE
         pzmfna6nUvLlzQibPdnB7Ujuw/qw55VTJlA6w+qSEMOmMefOe0dkpLYcFfLZH019AG
         t7iIlJEt6dQI86pmZLeWvgnP/OXhb1+MdnM4ezJe3fSoo3Y1TZWw3ojW2psl0roFz+
         uvUWOyIMxTDSdNFkDg1k5FYMW7TT2KHk26M1rYVv/Mp0nPbPvYT9rfpwWgpWvPWFvy
         54Gfb3tECE4Gi/8sLkFj/XmbXbh7A0yrntRaiuv9Zd+FG1w14chCvYa+KRJrEJgmvD
         eG8+u0XWv48gA==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 1/4] staging: media: zoran: add logging macros
Date:   Mon, 25 Apr 2022 10:40:15 -0400
Message-Id: <20220425144015.132707-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the zrdev_dbg() (pointing to pci_dbg()), zrdev_err() (pointing
to pci_err()), and zrdev_info() (pointing to pci_info()) macros to the
zoran drivers. These are the preferred method for debugging and this
will allow to extract the device from the zoran struct to make the call.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/zoran/zoran.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index 654c95fa5aba..4f7f71d8e93c 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -19,6 +19,7 @@
 #define _BUZ_H_
 
 #include <linux/debugfs.h>
+#include <linux/pci.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
 #include <media/videobuf2-core.h>
@@ -301,6 +302,18 @@ static inline struct zoran *to_zoran(struct v4l2_device *v4l2_dev)
 
 #endif
 
+/**
+ * Debugging macros
+ */
+#define zrdev_dbg(zr, format, args...) \
+	pci_dbg(zr->pci_dev, format, ##args) \
+
+#define zrdev_err(zr, format, args...) \
+	pci_err(zr->pci_dev, format, ##args) \
+
+#define zrdev_info(zr, format, args...) \
+	pci_info(zr->pci_dev, format, ##args) \
+
 int zoran_queue_init(struct zoran *zr, struct vb2_queue *vq, int dir);
 void zoran_queue_exit(struct zoran *zr);
 int zr_set_buf(struct zoran *zr);
-- 
2.35.1

