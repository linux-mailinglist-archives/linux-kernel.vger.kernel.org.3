Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E3C48DF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiAMVSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiAMVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:18:25 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F3EC061574;
        Thu, 13 Jan 2022 13:18:25 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso7909979otf.0;
        Thu, 13 Jan 2022 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhIUZEyLkSCGKc1UkQdjKABPVPiYlDrmgBY5iTyEfnQ=;
        b=kfCYDOIwjO5zYFAj467OnoWk6vFNfpF21UB/Y8CjghGbDlgAY6KtHfnoEzZn12RZic
         vaqrkd4JZ4D6FflEP6nKSOSaHrMBFHo6v8uqIA/FkKKceoCidKboHcqNs7/psr5UgM3o
         NNrzoHd+ymJzr7dTFAZ6r+B7NH0XuEEl+pHDo5CK8h8myM5yw7pUqzoh7UBUfEjU+IQ5
         y2SCDx5CDUEOKtUS0gac4h/83qhREAr+lc8IZkFuhk6P4s6nNy1y2LMbPzsZRVyQGN2p
         /qOODnFGXx+wsD9laL3pBpEHPCNwpRrMKGI76OYpOshuYLws10bcwiqcJyU3VjVHJVfu
         r+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhIUZEyLkSCGKc1UkQdjKABPVPiYlDrmgBY5iTyEfnQ=;
        b=tyy42acYjYWTGL2EKKpeOJgW/NuUcw/1eExXKbm+coE8NWtW2ym7yRLDlO62migp3L
         XjirRDLsYBzriCx78U7V4FqS3G0aorsyBOrSH3RKvBsmoZnSad8T8incANojnqijQxG/
         u6YTGYHlr8/MwugWhx4ghCe4oBjbbjL7N0HKB5XCrFrJWnkdd52cu2GU7NyEhNjNoskI
         D3S2r/whHT+MstRRSiw8VvfHc8xiLbTtOFA7ca/4/Z3TkJwNXXAVaUymhyNaJrBToYa0
         XZ234fJkPIiR+2oPcc2LezLJU4qjiev6oReUYUQmGApSm9tgPyLvftdQyWVQ2ahZo/VG
         mAOg==
X-Gm-Message-State: AOAM532DTu9ckz789M+gQwgcNj1K9jiwIBR4IEmjRq8f+rvq7RG5/Uuz
        OCTV+PMlp2yn98a+v/kqu8E=
X-Google-Smtp-Source: ABdhPJwlPvNEuK39AHfpxsyj9XIKIhhFFrRo9lAnrK7Q+YbNmpsGjP53cLUDAwb+N+udui/QQg8Ylw==
X-Received: by 2002:a9d:4e4:: with SMTP id 91mr4516525otm.45.1642108704859;
        Thu, 13 Jan 2022 13:18:24 -0800 (PST)
Received: from Andrews-MBP-2.attlocal.com ([2600:1700:19e0:3310:f8ba:b1e:54e1:cdfc])
        by smtp.gmail.com with ESMTPSA id z188sm932015ooa.8.2022.01.13.13.18.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 13:18:24 -0800 (PST)
From:   Andrew Geissler <geissonator@gmail.com>
X-Google-Original-From: Andrew Geissler <geissonator@yahoo.com>
To:     joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Andrew Geissler <geissonator@yahoo.com>,
        linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH 2/2] ARM: dts: aspeed: everest: add reset-cause-pinhole
Date:   Thu, 13 Jan 2022 15:17:35 -0600
Message-Id: <20220113211735.37861-2-geissonator@yahoo.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220113211735.37861-1-geissonator@yahoo.com>
References: <20220113211735.37861-1-geissonator@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GPIO is used on the everest system to indicate the BMC was reset
due to a physical pinhole reset.

It has been verified that the previous name for this pin has not been
utilized by userspace so the name change is ok.

See the following doc for more information:
https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index f48b33b0c606..6b5d5c56951f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -271,7 +271,7 @@ &gpio0 {
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"PIN_HOLE_RESET_IN_N","","battery-voltage-read-enable",
-				"PIN_HOLE_RESET_OUT_N","","",
+				"reset-cause-pinhole","","",
 				"factory-reset-toggle","",
 	/*G0-G7*/	"","","","","","","","",
 	/*H0-H7*/	"led-rtc-battery","led-bmc","led-rear-enc-id0","led-rear-enc-fault0","","","","",
-- 
2.25.1

