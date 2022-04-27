Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EC51109E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357914AbiD0Fp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357909AbiD0Fp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:45:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D896157839
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:42:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so1160079ejo.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMHZgrL14j5Eu1vGvc1pa7d08VpLRco0ITN1E2naAGU=;
        b=hwnuYTwi4Z5GZc7YCqkVM+xwZHPM0hta6hRXgAbn/USsuEC0vV6avH+LJclxaMLUU2
         OtLZzgxSMmUoXMgazlyhd/dcZ2x6OFKvoU0uy1f/BPTebIAwOSiQuOxI5vX9gEmqkLH6
         pWMGfVHBWSKhFB/PYXVQ9nvTf8dd2iPm8uY4hvgqGCwwQ5bNJEZrHipIXJrWnxN0T1SB
         Y4Ria3wzmKFLgAH3JOWWRpB/mOhlRsL570AWJgsQHtDrUuZKrc57+/dceh2SkQUyyr6N
         eiRGo7XyUgbrCwWjx9m0HAPUP+Fi7DflKX6OHrjLxjH+pxXSLw9yJCs7ft9QXEYelPeA
         nUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMHZgrL14j5Eu1vGvc1pa7d08VpLRco0ITN1E2naAGU=;
        b=BrWF0soi7L3oRcHc9+fz12i2IjBbQbwFcSZjevDLz9Dj2uQnHVede6fgPZtNO4smkN
         hPnCme9educc19ZSLhqySE8izgiUBE5GUycWiKC/yaN4K3nYVF3uAMEHqUe76EnasYLd
         esjAIYTvAjkLoWVNnqLz1e4e1qZt9dg3Qose+HZ4wHNzyv0K1WyjRrEC3DNdIMffeBlD
         b3mfnMJWrKYNxK22mO6fR/f54F/H911iI7NY6yNOqppqOEbsThlQGx9eOtcUiBqsfBi3
         Zf5kV0MRLej0IA4IArZOKL6/6UGCamj5HxX2/diiZhZLJBT/+73e0erdgY3H3Ldci/uR
         Cjhg==
X-Gm-Message-State: AOAM532zGZ4dsYKFyU+c2NXV5EU22Upe3FNHqSpQR/aPZRYjPewFqzKK
        l2cX6W4OyyhaChNnFJ+nJp0=
X-Google-Smtp-Source: ABdhPJy02EToPB7vA/s4nyBZ4B7b3ijKtBR6+W66CPzwBC60CX6c8sNh345MK1O/F+erU3M69O+U7Q==
X-Received: by 2002:a17:907:961c:b0:6f3:a3f9:bcef with SMTP id gb28-20020a170907961c00b006f3a3f9bcefmr9665241ejc.425.1651038135826;
        Tue, 26 Apr 2022 22:42:15 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6056299eje.183.2022.04.26.22.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 22:42:15 -0700 (PDT)
Date:   Wed, 27 Apr 2022 07:42:13 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] staging: vt6655: Replace MACvReadMIBCounter with
 VNSvInPortD
Message-ID: <e1b7156e2c689cf53c738642fd9b33816ec89f92.1651036713.git.philipp.g.hortmann@gmail.com>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
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
V2 -> V3: Added missing version in subject
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

