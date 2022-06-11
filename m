Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1221F547278
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiFKGx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiFKGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:53:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58EA4ECCD;
        Fri, 10 Jun 2022 23:53:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x5so1391533edi.2;
        Fri, 10 Jun 2022 23:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICXO/DGJ5boB7mlSd4xiwerKyKmA2ZX08XZZ4pcrKPM=;
        b=b/4pAamShqovIyBl8iI9ztI/LhenZJL57ow6DajHUQpr3t0AucBi/h7muZw96HeOFp
         2t7PkARM1BNVc8+Y4VvVNq+fSBa3XUF+EtEpjh3fu9+ERHFzn3o1Fv6kB7UpzDOZzS22
         965pxi8mqfSrL8XRJz1PqsBoDOrAUoRS67UwiyQz//jPMdKHoUpAtvM5tlwY+jT23VBy
         +3l+FWJN7hB9lw0FuLx+FfqKwhAWBhJbnOx67vP4EWn26XgiLGAH4K3m0pKNF5xjot1d
         NeCuen2wKJ6IwpoZAKKj5sdxSHMC1VB1I/CTsoqblrUkkMdbjQfMgTirQfRi3Qjibbbr
         o6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICXO/DGJ5boB7mlSd4xiwerKyKmA2ZX08XZZ4pcrKPM=;
        b=xNaABUH3W2ICjG+HO6cwLI1YU2igxfEDoc2cGKo1MopNHJKs04qqvsfvHkjaR029RN
         zJWw4SKfqkj/l50KpU3IafmxEmgT+OHClsCPPhT3iNtZHhzirM9G3gv2xUhr6r7XglMc
         nz1iUoYORDP6Tnz+No0rOeaWLQhrJdmH9O0tEQZ43WaDiYiYUbGqcOxWEsgjuz6C+7MB
         kQRwR98mnODqZrHOyObvxPg9Dn886YIbznu+xnvvML8aVvPolSu3fzRJWx37ZrngR3Qq
         QoezZlKckKCGupUFt4Jvej8UItFdnpFmh0ISmx4s6bwfGlTUh5T3rlaMFPRke8Jk5hIH
         8Psw==
X-Gm-Message-State: AOAM533yRf/iww8vDn1jWfdb9mJQJlKS86Bpvvu31KoXldPT57/qTUDE
        Gff2dJR910/8XA4XQp8mgWo=
X-Google-Smtp-Source: ABdhPJzX3VjXieTTER669Yy2w3Q2bZlH8GkmHVjM5Re4odhwdth/2IlxLL9pZkieW72w00pl5GAbgw==
X-Received: by 2002:a50:c407:0:b0:431:39ed:1c5e with SMTP id v7-20020a50c407000000b0043139ed1c5emr38811155edf.402.1654930429342;
        Fri, 10 Jun 2022 23:53:49 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402348e00b0042dc25fdf5bsm874261edc.29.2022.06.10.23.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 23:53:48 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: rockchip: Enable HDMI audio on Quartz64 A
Date:   Sat, 11 Jun 2022 08:53:00 +0200
Message-Id: <20220611065300.885212-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
References: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the i2s0 controller and the hdmi-sound node on
the PINE64 Quartz64 Model A single-board computer.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 59e364b724cc..981c4aeea814 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -310,6 +310,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -540,6 +544,10 @@ &i2c3 {
 	status = "okay";
 };
 
+&i2s0_8ch {
+	status = "okay";
+};
+
 &i2s1_8ch {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s1m0_sclktx
-- 
2.36.1

