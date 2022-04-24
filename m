Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A046B50D047
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiDXHrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiDXHrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:47:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524CC1EC58
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x18so16726356wrc.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XMF+gMN9bhGYDlM3pFVKQ1yvAcKiJtAzC5AwaU+IPA0=;
        b=ZDvOWeSp+/f+BDi5HK/bFni4dJxfkbK0SvMwv6Qv1BBbaWjz9cpBB3+1cnJiwvpx7l
         qVVPXrWkM/gykvnbz7qxAcvCNT5xwNqLyVtGZ17yEBYa66Jry6HeoQ8ocI2YqgGSkoMT
         anq66aTWr06mE2O7zvptqqGUNntZgHbTxRW2E1K7O8xirFNTijsz8Xe+w1AIRcI1P+8D
         qzTOOFd/A3TmXpdH1sWnIAe22pj5M9RWEBBkJzMfDKGrTzMoJXCnjPYqp95qtspZ3Qd7
         i1a8zenCfN/uotMDBSejcN0N7iiv8CqUz4lTBU4yA4Y1PQNg08PUQ2k1PzXMrCI4qO53
         D3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XMF+gMN9bhGYDlM3pFVKQ1yvAcKiJtAzC5AwaU+IPA0=;
        b=3VpzsNiSCxB5TXOjiBaGpJR5EM8+lwnUviiwUNVxqgE239hFyPf9GIr3wLnZ0+rKUW
         qTCuIzYDroRqG/buw5GI0QAfhIqosNcjmasXK8vEQqIfnSP8VPgvj2UYB7Bz1SivcOUJ
         PgMM+UXRvGZqxvXdt6TvOsR33l9rbj4hfth5uTIGpT5stYhVlBlxAY8iA7SHS5ORGgql
         0lynz5Sxa+nd7rAQGkMP+JZBGMzgMTSF3Ui483+MIFYKkjdleWRvJu5JgG2qn95Qe2D4
         nhUI0FfNDdv8eJIWj++Xvko0tOT7lZAUjJNApZQgEXinh45USlGhVtHIe2YVZgoRVDN0
         S1Fg==
X-Gm-Message-State: AOAM532gWonJquNGVZOfWphCjZrgjZX5+/ifuvcngr0Br7LdzXiHA0Yy
        2qEkg+NE5Cyn2rFzYk97Fpw=
X-Google-Smtp-Source: ABdhPJzhxDdUI4l6zvYKUDfy+krONxhiqUq+YF1HSrTGYdkqScYp0jMP9GJQcs/+uc4U3vk5h8PRTA==
X-Received: by 2002:a05:6000:1f91:b0:207:b6b1:64a9 with SMTP id bw17-20020a0560001f9100b00207b6b164a9mr9687866wrb.286.1650786253911;
        Sun, 24 Apr 2022 00:44:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c441000b0038ebcbadcedsm10016908wmn.2.2022.04.24.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 00:44:13 -0700 (PDT)
Date:   Sun, 24 Apr 2022 09:44:11 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: vt6655: Replace MACvReadMIBCounter with
 VNSvInPortD
Message-ID: <2a50f3e99b15db2100f93e1e1a2b5cbc13b82882.1650784817.git.philipp.g.hortmann@gmail.com>
References: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvReadMIBCounter with VNSvInPortD.
Last patch within this patch series will replace all macros
VNSvInPortD with ioread32. The names of macros and the arguments
use CamelCase which is not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 2 +-
 drivers/staging/vt6655/mac.h         | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 08b955c71b3c..7cceb57a5139 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1042,7 +1042,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Read low level stats */
-	MACvReadMIBCounter(priv->port_offset, &mib_counter);
+	VNSvInPortD(priv->port_offset + MAC_REG_MIBCNTR, &mib_counter);
 
 	low_stats->dot11RTSSuccessCount += mib_counter & 0xff;
 	low_stats->dot11RTSFailureCount += (mib_counter >> 8) & 0xff;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 4c6739862188..74b45e1f0963 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -684,9 +684,6 @@ do {									\
 #define MACvSelectPage1(iobase)				\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1)
 
-#define MACvReadMIBCounter(iobase, pdwCounter)			\
-	VNSvInPortD(iobase + MAC_REG_MIBCNTR, pdwCounter)
-
 #define MACvEnableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.25.1

