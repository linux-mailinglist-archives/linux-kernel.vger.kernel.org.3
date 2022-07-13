Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECEC572CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiGME7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiGME7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:59:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A930F5E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:59:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id os14so17861244ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7H0JOtMHighA4NUcVbg55FWnla2SH6bqiX/5b8b857o=;
        b=akdxdB5uNZw0lylqaVFOuTgTdgXfsnuYjjFJ5KnwqCN0lviQ6bdB4Zw6tnbG8BwLX8
         42Ngvnh48s5MVW/uHatI0fn/ufQUNtUUMz9vmImpbSCG63fGzytMU2vnBs9n6+GoggbO
         1o4t0wPX0PQCkHCjgPzltMDxOXVueT5YL/swWBtGTTI/XR2WGR4UJlVfZKc6sBgChGst
         e47vpGFDhI2Gq1hVvOzu7QKYlh1huL1wJ8h1iiuaGZOeOVEFWbkItONaKOTD7xfGM7q3
         kDpLXaCVEf3SSR46nMSezd5AIO2arMvhwg7TTOhf60d9aZ4c5WmwGoSVcwiZd1B2P90s
         3ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7H0JOtMHighA4NUcVbg55FWnla2SH6bqiX/5b8b857o=;
        b=MjZS3wmXrqN1k0923ilaytQ/60YtefhnFMmPkQz0OdJcaDHmVBYj7aQN9SiATP6Co/
         0E7v5uaUFvj+f47GsECX0LIpf0sBVqDe2to1gmWpZ1CRGzqGhmRie2F6SDE2zNIJ7gjF
         exDstS+GRlE88mTSTtSQzDThPPrViHNsE8l1ITc4Mi6m2W1hSmKA2wM19DA7qQ5nMe9B
         nti6kI7xxjBjMwqEH6B7CV1BEZTVH5H1rSXxigCS6IJQj+Bmwl5rZdll48q5wUBhINEh
         6h3dYMerg+sjEDjoBpc1qd4w/m5HdI/AfBndaWLwGrOOl6lvCsp709DKZ0gx4BaNGLsA
         N++w==
X-Gm-Message-State: AJIora9TQ04dmu8JDYcZl4G9QZxAoVvUed/iVldFn35ycMRHHXGaYAcE
        KLFgrAoT2lrwFnoJpv1ocg8IB2F/H3A=
X-Google-Smtp-Source: AGRyM1toMQafwzlwa483zjFA86aisXRzS8jnUVp3X+1tgX55MFVfh3N4EmqTzBEPf1Xl02aHgEy+TQ==
X-Received: by 2002:a17:907:75f5:b0:72b:40da:a7cd with SMTP id jz21-20020a17090775f500b0072b40daa7cdmr1561552ejc.662.1657688361962;
        Tue, 12 Jul 2022 21:59:21 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id j5-20020a056402238500b004358f6e0570sm7227027eda.17.2022.07.12.21.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:59:21 -0700 (PDT)
Date:   Wed, 13 Jul 2022 06:59:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] staging: vt6655: Rename byBits to bit_mask in two
 macros
Message-ID: <5ac7e8860ecb23232cf5befea024872e7db76d59.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a variable in two macros that use CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b3803143673c..3037502c1883 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,11 +537,11 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvRegBitsOn(iobase, reg_offset, byBits)			\
+#define MACvRegBitsOn(iobase, reg_offset, bit_mask)			\
 do {									\
 	unsigned char byData;						\
 	byData = ioread8(iobase + reg_offset);				\
-	iowrite8(byData | (byBits), iobase + reg_offset);		\
+	iowrite8(byData | (bit_mask), iobase + reg_offset);		\
 } while (0)
 
 #define MACvWordRegBitsOn(iobase, reg_offset, wBits)			\
@@ -551,11 +551,11 @@ do {									\
 	iowrite16(wData | (wBits), iobase + reg_offset);		\
 } while (0)
 
-#define MACvRegBitsOff(iobase, reg_offset, byBits)			\
+#define MACvRegBitsOff(iobase, reg_offset, bit_mask)			\
 do {									\
 	unsigned char byData;						\
 	byData = ioread8(iobase + reg_offset);				\
-	iowrite8(byData & ~(byBits), iobase + reg_offset);		\
+	iowrite8(byData & ~(bit_mask), iobase + reg_offset);		\
 } while (0)
 
 #define MACvWordRegBitsOff(iobase, reg_offset, wBits)			\
-- 
2.37.0

