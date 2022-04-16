Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E73503510
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiDPIDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiDPID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:03:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039222BDB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:00:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c64so12206540edf.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/eHNQjz4f79BR4/ytGgYvqcYT3Mpa3ln0lhSc14HpYY=;
        b=RB39KqfDVLTc3vVHvaNdKfNaIzsU+s2zPd2pLpxal8+wZyOuu1AijiChM6R0oXAie/
         XPc3IOaSfNmNJ4RqM5TflHFeOtjMd9iYypQGbB9wFAmvXD3BHA1taluEnwb1fvJOHkLi
         I97y+1t4u9Y1Abuj0WISmBuH07jwL44RbvaT3bmhtVfwU008OpFLxPtHFp5zrEVbfPl7
         0DRYsK5yUmFTQAj1Bdlr6iqMSW1j+IKAkIpozdZZlv3oqpq1Ejirjn0UHguu0m1VY1oV
         F6Rr/CUtl1XJINC1fTJluFBQyIDtazV5gbOSmV5+8wO4lAmOkc08cPxuZBXsvrF4TwsJ
         oRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/eHNQjz4f79BR4/ytGgYvqcYT3Mpa3ln0lhSc14HpYY=;
        b=j7nfbauQoyZgNhmHwbIhmDCS6W9Uyg+AbEwUoeyy9YYjjUm+5NlbQLYv/RQOJ0a6SH
         FvW6neH/fAH9oEnneByTUT56Nh8zzew1BArD539tZcGQ1HIPUlMeBdjc/dVaYXAchBRx
         yCmaothefRdkns1KeDznY/ol3rcwQzVKF9bJJYY0Q7DP44xRFpP9kiBdnngmHVdxx1F1
         olS69aiL45QUJ1c8QOvcTgEYcmmKzEbfpwy33xEf+jRgAR8CLsyC8yJ3cCi/OiBERrhQ
         z1veWa672guQcQXhWS7EFgfNEZRq3RSfXEx4UqZeU2X4SfltZvRR6Nw5KSi2z5w9xpfz
         04Nw==
X-Gm-Message-State: AOAM533Pp6Sh+edx38N2ICrS3HZ2CLsyvkEWmz2QiSR9eAe9BhMNc4Y/
        Qjfi449YCH7qIvH2vl3uwlEBrU0Wf6k=
X-Google-Smtp-Source: ABdhPJwO2PmLCY9irpkH2G8a0NtCiv1GAxfZC58sdbmmimQ6EyinxYr6VyR+3jbrn0+2H6i6opuz4A==
X-Received: by 2002:a50:c014:0:b0:41d:5ee9:f354 with SMTP id r20-20020a50c014000000b0041d5ee9f354mr2708599edb.257.1650096053105;
        Sat, 16 Apr 2022 01:00:53 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906c08400b006e82dbd3f6esm2400805ejz.116.2022.04.16.01.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:00:52 -0700 (PDT)
Date:   Sat, 16 Apr 2022 10:00:50 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vt6655: Replace MACvGPIOIn with VNSvInPortB
Message-ID: <0a3c3eb0d4dad544fa281b34c5a70d4a3ab2d9f1.1650094595.git.philipp.g.hortmann@gmail.com>
References: <cover.1650094595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650094595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvGPIOIn with VNSvInPortB.
Next patch will replace all macros VNSvInPortB with ioread8.
The names of macros and the arguments use CamelCase which
is not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 2 +-
 drivers/staging/vt6655/mac.h         | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 897d70cf32b8..8b6efe2126ac 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -377,7 +377,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
 		/* Get GPIO */
-		MACvGPIOIn(priv->port_offset, &priv->byGPIO);
+		VNSvInPortB(priv->port_offset + MAC_REG_GPIOCTL1, &priv->byGPIO);
 
 		if (((priv->byGPIO & GPIO0_DATA) &&
 		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 6221351c6400..a5ce084f6961 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -735,9 +735,6 @@ do {									\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
-#define MACvGPIOIn(iobase, pbyValue)					\
-	VNSvInPortB(iobase + MAC_REG_GPIOCTL1, pbyValue)
-
 #define MACvSetRFLE_LatchBase(iobase)                                 \
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
 
-- 
2.25.1

