Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8325E5A431C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH2GWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiH2GWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:22:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8395422C6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso4421082pjd.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=5qFR00BMuGJipLFoaj2azG9jU2Eo8KYkvyGJ+j0iod8=;
        b=J7MVpEl/nWCi8C71UpWMWf8LhSM/YOsgH7uv8oq8L+8OxEhIVRKRhvRxc9NvBUhI5l
         MdMdDS0+t6zUjS/ZnIpP7bYBD2vUOBIFlEEs9CSaIDTJtCslGdyuAv8KYm5VX9x/194A
         /BZdONbraQtNdC6aTfrJ96przgMqPbnf2YCjk850bPA5a4xo2nuNhaEgXuTYYmKQSysD
         bZFbzPSSQZQNYCZ+V/2TWr6lw3Ngo0lvsvOv9z/T8Xidm9RvcUzcqlzBAtZqh1jOTjWI
         0IFz+rJfEAwDhUtBd9wPbwkhIibKhndCR4In+p128U9vf5kxNlTeeQLa1zt20TWJRc7G
         trFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=5qFR00BMuGJipLFoaj2azG9jU2Eo8KYkvyGJ+j0iod8=;
        b=BybEa40z2O57F1PrzkJ9b9Vv3duLGHgxg7rC8BLzUCSkmUSC/+z4a/Wdw/2AC4PR1O
         wbrAymNxMKioxQq3aHv8ceP4OGlrQcLcpNBq2Xj0AbGGcfbqa3anX8nZrLWhIjlm7Umh
         rMe0v0+7Gc85J+noADONkIEuYcVWAbsDXpHoHU/6yuSFPmMT9pY7n4mCF4zlzPwlqdqS
         SZMxnJTEm52rPdBpi5Hfgo1SJB1w+ApkImkZwSXbKFQaMalSg/4KZHTipERouTFDEzfW
         n0fZjllNGpnOtNyNeA4Ux+dpctmRbvJrRuP8lef9r6KBS4Q0BpSOUe2UF6jNFl8oKbEY
         6Lwg==
X-Gm-Message-State: ACgBeo3+kmCKL2ZgulDVEN1fnCPLtumHi/n6BxSTYbQF6eecdnkrVcJY
        i0yOxwbcap7TmetUkSw8F+JWuQ==
X-Google-Smtp-Source: AA6agR7jvBdZOH5tNUpYmOqD9WuauCQXx1RiCeHYBEQPYpN4K7JdFayWiNaD2bfyIGZLJ0G9qsyDHw==
X-Received: by 2002:a17:903:32cc:b0:174:e627:4909 with SMTP id i12-20020a17090332cc00b00174e6274909mr1332677plr.67.1661754132424;
        Sun, 28 Aug 2022 23:22:12 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id mp10-20020a17090b190a00b001f333fab3d6sm5817972pjb.18.2022.08.28.23.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:22:11 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/3] dt-bindings: sifive-ccache: rename SiFive L2 cache to composible cache
Date:   Mon, 29 Aug 2022 06:22:00 +0000
Message-Id: <20220829062202.3287-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220829062202.3287-1-zong.li@sifive.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since composible cache may be L3 cache if private L2 cache exists, it
should use its original name composible cache to prevent confusion.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml}      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive-ccache.yaml} (92%)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
rename to Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
index 69cdab18d629..1a64a5384e36 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
@@ -12,8 +12,8 @@ maintainers:
   - Paul Walmsley  <paul.walmsley@sifive.com>
 
 description:
-  The SiFive Level 2 Cache Controller is used to provide access to fast copies
-  of memory for masters in a Core Complex. The Level 2 Cache Controller also
+  The SiFive Composable Cache Controller is used to provide access to fast copies
+  of memory for masters in a Core Complex. The Composable Cache Controller also
   acts as directory-based coherency manager.
   All the properties in ePAPR/DeviceTree specification applies for this platform.
 
@@ -27,6 +27,7 @@ select:
         enum:
           - sifive,fu540-c000-ccache
           - sifive,fu740-c000-ccache
+          - sifive,ccache0
 
   required:
     - compatible
@@ -37,6 +38,7 @@ properties:
       - enum:
           - sifive,fu540-c000-ccache
           - sifive,fu740-c000-ccache
+          - sifive,ccache0
       - const: cache
 
   cache-block-size:
-- 
2.17.1

