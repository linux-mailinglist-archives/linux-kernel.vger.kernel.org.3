Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB07E51096B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354352AbiDZUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354346AbiDZUFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:05:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE381A3B4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:02:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p18so18512172edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcyuOtlGkrHpiyVRHzfMUPq93LO4hiMR0wu0sGE6h1A=;
        b=i0jSI/MY02miYxjMbMT0TKDysQ+XAl/mRs6m2SDrlO6CLHPV2YTVkef50KHzGzo4zj
         vTPtP8t/Aq05A+i8sSc6Ob8qgfLnVOYq6MqUDHFsRgkehZrJ9mH5o9KF3YJMaMgvRcH1
         frbTqFkXHoExt+KVvbyYAG/xvApSxI66p25tloqCYkhzQ4EfTl6UgjuYf4AN603u8qJI
         n36Gp7EQVPZPFtNYHeF5y57vb5UCGucuC4j5ga9OMhS6d68wOVfCo951ZaxQvSOliu+W
         dwlmYjZMq4TbXQZuxes2XWp+LNNO3xWSNbSXSqvQyQCL9VkInliHJci93ma/dNAD+yzA
         R/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcyuOtlGkrHpiyVRHzfMUPq93LO4hiMR0wu0sGE6h1A=;
        b=dsWquLdoiFMXYtO+pg7XpYVUfJ1Z3cZzDVkQ88aYHKis2OYH8jqGZsDzjEoVDo4XLk
         Y9OAHQUSAWSwm0tsUxDUjk9pdxDeIoqkcZAaq3n1TdRW2ImlmOqkDozYH5apVD3Fs3dV
         pVYoDbQ2KUG+ivfwLOFMNgvb+joCLuOQFXBldWehjAEWWWQlzsLgjp2cbDQ3eOgH6WU9
         obja6WcBmvpOySxUN7Sc91X1XfgL2QINgoGWrDtUKJ95ZewGax1mT38LM2/1IZ9UIJ6d
         TWF3URUb/UVRZGK7BmvyWuI9XaOM7HFi9KGmK5jic5ghkkGjZdZMfIWzUABg4W/voJ+O
         3XhA==
X-Gm-Message-State: AOAM532ReMZoZGqyjM1FEwtVfmAeEhtguo7WDMd/rrc8Hhlqx52YLUla
        gfZ3hYHLplKYSmFFx/N5ENI=
X-Google-Smtp-Source: ABdhPJxRQiA+UJ8cidWqFEJAN0lTQ1uxCUTB7bCP3hQSs3eEw8GAF9Y7bhfG7xoGhKsBQdwAbbyWVA==
X-Received: by 2002:a05:6402:d5:b0:41d:6518:86e4 with SMTP id i21-20020a05640200d500b0041d651886e4mr26407725edu.322.1651003340826;
        Tue, 26 Apr 2022 13:02:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm5312576ejc.28.2022.04.26.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:02:20 -0700 (PDT)
Date:   Tue, 26 Apr 2022 22:02:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: vt6655: Replace MACvReadMIBCounter with
 VNSvInPortD
Message-ID: <50cbf7b87759dbfe023554fc42a499dd923b7f8c.1651001609.git.philipp.g.hortmann@gmail.com>
References: <cover.1651001609.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651001609.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvReadMIBCounter with VNSvInPortD and as it
was the only user, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Shorted and simplified patch description
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

