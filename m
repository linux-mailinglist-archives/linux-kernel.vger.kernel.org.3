Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED47454B7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345084AbiFNRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiFNRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:50:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D334673;
        Tue, 14 Jun 2022 10:50:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id s12so18657693ejx.3;
        Tue, 14 Jun 2022 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmDKqsh2oZWR7s2YwH+5e/H1/JJVJGhbhyO8uGLahfw=;
        b=nhgL7jZLaDOjeykvNjYlb1d3NgpnUqhakHHnuBDtGRbm7tvkX/v+9SrT9gNcSbeOBQ
         LJSN1OJH8gdzOdV4Xh3nKcetziUnvkr6mwhHwjGF9r7hmK3WWl46fHyK1sRyHRIz1IYU
         lArlp4Iu9Lgp5BEzMCs9uzZlgJOGX/tS+8U3DdM6aMW353A0b5o+w+ClrMtfHWTA3DO8
         pyH3nUVOZEB6fUJwYePFLEZMPZ8zLDhWLTDX7GDG52nvm8Q6Zw1K1FTxJH0/UcriviJO
         hvJPrJdmLWMbtpnmzAWvYJSweefWgNl58d6aZ19G8OcsQikp+CAy2Vp2iFT0ofxRNaub
         04GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmDKqsh2oZWR7s2YwH+5e/H1/JJVJGhbhyO8uGLahfw=;
        b=FyHsqlM7ikuDKPi8tk8w+tqdwRi8EWy9qvbq0kdud8yfuazFEKKQ4gGB1zMi6wNlvm
         /QUCv1YJagWl1Tvs9JT1yDUcD19LSr/BLTyaqOR+ld5IhngAsrJ3MEUj76OCGueBTlyy
         eUaIGrpGMXIij/injOEuKu6h2+ZwE4q6NevpFmkUSrXNgtthT7OlpcaUl8WvKYc9sTb7
         8cVDPuIBVP4x4cA6u1Rfc6d+7jZmaGcxfNdGr0w3wOsopEjXoI+1nh++5RtNI77U1y43
         f+ZooqyDEjMKyMUKSq8EFxePDpQNOruH1v9hl44/KFDSUXF4BjGioYxjlEP0u0m1t9qg
         I/8Q==
X-Gm-Message-State: AJIora9b1NIW2dvmSOhlctJ+cgcIZtzuYuKDqr1ZWFSMuQ27CIu57If8
        CphUova+3CSyhx+Nn5iCGAmdmQgrETtAhQ==
X-Google-Smtp-Source: ABdhPJzNCLZrd0x4nKJdxKaons9gsaAJagLSGLJrc8mg7xgrgZPUgYiMXT4K0xqjouHP86Bao1Oi9w==
X-Received: by 2002:a17:907:7810:b0:6e7:ef73:8326 with SMTP id la16-20020a170907781000b006e7ef738326mr5242986ejc.429.1655229018022;
        Tue, 14 Jun 2022 10:50:18 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id d2-20020aa7d5c2000000b0042dd630eb2csm7395200eds.96.2022.06.14.10.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:50:17 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] media: hdpvr: fix error value returns in hdpvr_read
Date:   Tue, 14 Jun 2022 19:50:02 +0200
Message-Id: <20220614175002.120931-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error return values are supposed to be negative in hdpvr_read. Most
error returns are currently handled via an unsigned integer "ret". When
setting a negative error value to "ret", the value actually becomes a
large positive value, because "ret" is unsigned. Later on, the "ret"
value is returned. But as ssize_t is a 64-bit signed number, the error
return value stays a large positive integer instead of a negative
integer. This can cause an error value to be interpreted as the read
size, which can cause a buffer overread for applications relying on the
returned size.

Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Note:
I found this issue using my own-developed static analysis tool to find
inconsistent error return values. As I do not have the necessary
hardware to test, I could not test this patch. I only compile-tested
this on x86-64. I found this issue on v5.19-rc2.
I manually verified the issue report by looking at the code.

 drivers/media/usb/hdpvr/hdpvr-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 60e57e0f1927..fd7d2a9d0449 100644
--- a/drivers/media/usb/hdpvr/hdpvr-video.c
+++ b/drivers/media/usb/hdpvr/hdpvr-video.c
@@ -409,7 +409,7 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
 	struct hdpvr_device *dev = video_drvdata(file);
 	struct hdpvr_buffer *buf = NULL;
 	struct urb *urb;
-	unsigned int ret = 0;
+	int ret = 0;
 	int rem, cnt;
 
 	if (*pos)
-- 
2.36.1

