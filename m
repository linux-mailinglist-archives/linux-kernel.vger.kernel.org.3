Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD225731BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiGMI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiGMI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:57:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B9F271B;
        Wed, 13 Jul 2022 01:57:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 73so9851389pgb.10;
        Wed, 13 Jul 2022 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BbmHqIsS3LgTRBAHaCLnc7YjI6SPA8/UqmwKvGHG6c=;
        b=D7Ohc/n1r3wvmPrwBti8cFe+/g6huQZ9SM8KeSGnhXTZXmg9HjqFE+apKi/zL2InTO
         KPKrYadJyuMATzg/M6obYfYBrhmMz3BcDQU59TB5GcMKcv+mIRH0TO5HQjZqhZOR6DZC
         Lq72gt0usWH07bIVHc2JoayfGdVwAoah4hZbZNm9VspsP2eJXfzE8m1VZ1BcSvN0CJHf
         FFIe8IsBOZdAgVgaWaq4wNwokKg932+uhsrRBg8vRvfgTdBtL8cEA8maa3EgzDVKhX4+
         huO799+X4JwLPz8UF+4VPRvqDWLbGiOmHJE4vgh8xA8W/vuIrkI/svFL4x3nn1v5F97K
         qNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BbmHqIsS3LgTRBAHaCLnc7YjI6SPA8/UqmwKvGHG6c=;
        b=y1kM9jfhgvPV2D6msfnIqU4Lvf9PTxw8PFd/LMDfTy/V7fc2b4g4lNGORITHeC6c9f
         D8T8Dr02wrcEhDioz6IiIDFxkP5UfQ40duh0bd/8QJCbD/1+/A6K5H+WdAsp3/ArYD6B
         ehj409fWIgwgD0538W0zWjlizoI3C3XnT86gFSBDcG3NvAHQkVyrMYTx5gsNhRUpD3gL
         rpsDdD3cFY8s3eaEjKAgYcGsaeqxrvO+i8HBz6VcHG0e8G66Ckq8X3hwDjwVuujvUL/h
         khxsU0v9aahaLzrDACzW/l5tT1pj6mPFR927y5idYYyEwUekiCbA7RhkP5oPRQ9WPCW5
         T9IQ==
X-Gm-Message-State: AJIora9h6LP+7lfKrB3a2i+sX+vy1H0TGvEyj0SnIu+CbfbJqfXhdKYf
        wm0OIv3Sj03OtakP/a5uC8k=
X-Google-Smtp-Source: AGRyM1sL0/JfwjzDQb6MDrfsWbRBcm6ZMKq/4K85O8vUUTLhjMkCBdlEo3fBsc0SIhuhas04OSErUw==
X-Received: by 2002:a05:6a00:1aca:b0:528:1f7d:4ffe with SMTP id f10-20020a056a001aca00b005281f7d4ffemr2422613pfv.16.1657702635083;
        Wed, 13 Jul 2022 01:57:15 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id x13-20020aa78f0d000000b005292729cc5csm8242289pfr.160.2022.07.13.01.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:57:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B022C103993; Wed, 13 Jul 2022 15:57:11 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vladis Dronov <vdronov@redhat.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] Documentation: qat: Use code block for qat sysfs example
Date:   Wed, 13 Jul 2022 15:56:27 +0700
Message-Id: <20220713085627.175604-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713085627.175604-1-bagasdotme@gmail.com>
References: <20220713085627.175604-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot and Stephen Rothwell reported htmldocs warning:

Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.

The warning isn't caused by Date: field pointed by the warning, but rather
by sysfs example that isn't in literal code block.

Add the code block marker.

Link: https://lore.kernel.org/linux-next/20220711204932.333379b4@canb.auug.org.au/
Link: https://lore.kernel.org/linux-doc/202207090803.TEGI95qw-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: d4cfb144f60551 ("crypto: qat - expose device config through sysfs for 4xxx")
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
Cc: Adam Guerin <adam.guerin@intel.com>
Cc: Fiona Trahe <fiona.trahe@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Vladis Dronov <vdronov@redhat.com>
Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-qat | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index a600531e95628f..43e081ec22cc4a 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -46,7 +46,8 @@ Description:	Reports the current configuration of the QAT device and allows
 
 		The following example shows how to change the configuration of
 		a device configured for running crypto services in order to
-		run data compression:
+		run data compression::
+
 			# cat /sys/bus/pci/devices/<BDF>/qat/state
 			up
 			# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
-- 
An old man doll... just what I always wanted! - Clara

