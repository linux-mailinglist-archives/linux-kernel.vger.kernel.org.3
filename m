Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3E534A95
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbiEZG5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiEZG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:57:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA0F2C667
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:57:50 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3EC1E3F1C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653548263;
        bh=Ye7eLUY2KVbpTNU7R7EP53lRPzenCCRrRZNY2f0Pw2s=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=XjZO7lqkx+arWLHLPSz6iBnBw78rkn+znXI7Owav+lQ3WLWA2SUIRcRT9n/ZhNcZv
         RayLVhCsf0xR0goPd4M1+cFljKTOhn2XZmaUGAStuzQ4iEcZCpRVBfgBdVuIuskwZ1
         STvEniKvQzaIuVVyrw3sYHHBriaHVoBkBBFpb5Zxhr/0JpjYmKsHyZwwBuE2q7GU41
         zXvj7oJC/8TdRnNhRwbCLN2SGfx3oWpcnZnyZ9fhzFXOz9yZ3zzb12YCzmR5PXhCFH
         a8NDyxu/EAuFtqRjsF1+i0OWAtgQr0StsOAyQwbtGc8WzBtlc6UVb+ZKjsNulu2SNU
         s1NSt/upxl9aw==
Received: by mail-ej1-f70.google.com with SMTP id lf18-20020a170906ae5200b006fec8de9f0cso396682ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ye7eLUY2KVbpTNU7R7EP53lRPzenCCRrRZNY2f0Pw2s=;
        b=XTOc/bULno6IzckYBUcrJiqcqVRhnymxVYC9GqqI2wUuXjJRqamw6mSoBkCZlLaIE+
         79aMSk+tX6LNTViQ6PvNG2c5h2UI7UtecrbKY1npanrxyxTlZblAhNEngFmjQtkkziaJ
         GswldyTa2v3V+ou5Hgc2RaRvO2xaoIwM6zgtYTIhfiGYROVmO8x2fF58swNDXSMtMd6o
         qmlSmwY40Ccrx4Nd1pEN14Rb7fbYndTXUnaECaL3pjBlAeXUj2wRS9nmnSP2Cu+wvWRe
         Jz/aCofVVfG2e0PLKh1sxZxFfCZPs0Nd3o7ldqB6NA695WrlyTPvT6C6lQQ8A05N2YMa
         sRcA==
X-Gm-Message-State: AOAM530y0uBze5agdqneYghEy9tYrG8URBYl89Eaay0zSKhrFjXXAJqX
        ejxfV0YrZ9RlagzGs4dtNY9l0G3OsSrc3J2z1QsW+oE+AVKWgMQU8DMhGRnzxzsATz7l6L1dkGu
        pc7jaPkj/3BEKGP80PfnKyDrL90jyv4y+7uusne6i2A==
X-Received: by 2002:a05:6402:3312:b0:42a:e883:5397 with SMTP id e18-20020a056402331200b0042ae8835397mr18160463eda.74.1653548263135;
        Wed, 25 May 2022 23:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR4IFmT/fyGSD8rES9S1+NQ2cUFE7jP02xDAxp+UsJlxwdSHoZNNzwFy42v0L4V/6VSI1Tag==
X-Received: by 2002:a05:6402:3312:b0:42a:e883:5397 with SMTP id e18-20020a056402331200b0042ae8835397mr18160454eda.74.1653548262989;
        Wed, 25 May 2022 23:57:42 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090652cf00b006fed8dfcf78sm220906ejn.225.2022.05.25.23.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 23:57:42 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/2] powerpc: Kconfig.debug: Remove extra empty line
Date:   Thu, 26 May 2022 08:57:37 +0200
Message-Id: <20220526065737.86370-3-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220526065737.86370-1-juerg.haefliger@canonical.com>
References: <20220526065737.86370-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a stray extra empty line.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/powerpc/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 192f0ed0097f..2c019e4ac432 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -305,7 +305,6 @@ config PPC_EARLY_DEBUG_OPAL
 	def_bool y
 	depends on PPC_EARLY_DEBUG_OPAL_RAW || PPC_EARLY_DEBUG_OPAL_HVSI
 
-
 config PPC_EARLY_DEBUG_HVSI_VTERMNO
 	hex "vterm number to use with early debug HVSI"
 	depends on PPC_EARLY_DEBUG_LPAR_HVSI
-- 
2.32.0

