Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D75A184D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiHYSFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbiHYSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:05:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE47CB42
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:05:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso2925842wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vL5A1E76Veik6n5XYhBLm8foWbkD11MRUns8HQxABwE=;
        b=JBu5IQX8xe8tZjdbGeompjkIOFOyxa8s4kf8oTt5/4iy+ew9NtRcz93SqBwZKVTH44
         XSdAW+mE0EBfMORK/DcJ/HhDfbIXtj/PbZ5sea2exMk16ewDx2KqpZnwbgdEXC4ytHiG
         wNZOaW7Kn0mUT/o9KM/1CeOxe8k2BqedSQwU7Vmdxw7S6o6J1QBYVnljbRYUHtL8Fq/C
         zWMboFXBmamwDWcfekdax/A2hGXwxPEtCBAUymQ89xqCr+PqaSKOnDPnBvJn0RxTHdFB
         5uLa1/gbuGWjSGVhwBx0x0USLViBAK/Vcsatsl0X0NYVcwgcFSMO/DMn14PsnKLejou7
         7keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vL5A1E76Veik6n5XYhBLm8foWbkD11MRUns8HQxABwE=;
        b=3rJF3pPSLPN/Y47bFhDRk8csdTf9HlvE2t94Z4ds1tOY9L/zHjv/7UxI4H5Yd9In6/
         Bnh1PuQ0cEwbQ1Pizu9JOaaBfsy6pUUhnFwhkjoiMnq/zvjx/ksyvkRtbaK4Kb+IQJvm
         EDEzLAKbu8zRI1O86c2cQLCRIxMoHvlcq1CURBtFq+u3gKO0BY/7l18YSFpc8tHh/9ei
         XPPApynGkLAuO3DxRLWjaFjV9qEVIttcpkRivxMGiw9jI4/CverHkctYLluJYd4Lz0KX
         YI6P/0/RHOCNvHneswQHYrq+HdX5XedIoxX5GgHfPZpBCZWgpu2sO9nWMRB5DZ5o1mpd
         OJgQ==
X-Gm-Message-State: ACgBeo0ib/wHj5Ru7+tQPAIQPNp53BBcydk7gbcrLoBp1+qyF5TDcut0
        rPnDKmKg13UzLIMV9fingLMjrA==
X-Google-Smtp-Source: AA6agR7Iv4zB7rXpV1buE/jjnhbKekVEkxkgj8UkRFjcXWAe8us7XcoEngBVxTPwI+UzghxBpBOk8w==
X-Received: by 2002:a05:600c:17d0:b0:3a6:8235:504e with SMTP id y16-20020a05600c17d000b003a68235504emr2881496wmo.58.1661450727396;
        Thu, 25 Aug 2022 11:05:27 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6044000000b002254a7f4b9csm14967970wrt.48.2022.08.25.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:05:27 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Sagar Kadam <sagar.kadam@sifive.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: dts: microchip: use an mpfs specific l2 compatible
Date:   Thu, 25 Aug 2022 19:04:18 +0100
Message-Id: <20220825180417.1259360-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220825180417.1259360-1-mail@conchuod.ie>
References: <20220825180417.1259360-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

PolarFire SoC does not have the same l2 cache controller as the fu540,
featuring an extra interrupt. Appease the devicetree checker overlords
by adding a PolarFire SoC specific compatible to fix the below sort of
warnings:

mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long

Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Fixes: 34fc9cc3aebe ("riscv: dts: microchip: correct L2 cache interrupts")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 718d077b2549..3a00e4c765a5 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -185,7 +185,7 @@ soc {
 		ranges;
 
 		cctrllr: cache-controller@2010000 {
-			compatible = "sifive,fu540-c000-ccache", "cache";
+			compatible = "microchip,mpfs-ccache", "sifive,fu540-c000-ccache", "cache";
 			reg = <0x0 0x2010000 0x0 0x1000>;
 			cache-block-size = <64>;
 			cache-level = <2>;
-- 
2.37.1

