Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5644D4A950B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiBDIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354393AbiBDIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:23:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7791EC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:23:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u15so9864593wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5sGeK/3zIULY8mcUjDAoeUp8Am4Py5KjMfukZVtUtCg=;
        b=pP00aNBpNz0gqLq912D3FrsDyohDLxSUiXYbYFE4lZ1cSAZ4shhM1VcOQmN15WBoea
         hhUz1GNzPPr+aK3uLKPtnQLvemCoLLMlFtDR1CzXxYp8IPW+mDINij/MTfOE/kz1cEpa
         FUfTY26snSJmrmrJAlxc22I0SAisBfj/yKLbsI6ptSHp5yJseYpUqCQzCQhuhFEv/dds
         3ynQR/O+ss5vAVN8MCdCAmgGnsgYIRy6sJ/wyLU1AlwjTsgyI925bkQ/oDMBrJ11WVMF
         x8Pz/EguTvvNo8EX150qG+q7hoqjftvpFRrXa0nQWiindCAO4m98CJz0wKBk4XL6iEKM
         oHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sGeK/3zIULY8mcUjDAoeUp8Am4Py5KjMfukZVtUtCg=;
        b=PWPQy53rDXoW8lubz/K7H5GJb/yElmPQWaPo4a3beUs8zsFWckqiIXwR7RdaKmgYfW
         5Ni0cSPTiymvKAJAl19pymi97FMtQOy/9qy/mJmCXqaLGnKOldKwq8O/CXg718QhCPHr
         QmjsDJShSx6bA/xzH2qYCAp03dJgi1JG3FHXRjqhBbadKsk/0QJw220aLzg7rh2d+tKA
         MoL2j9hl9iTepcjd2QxAwjyO4AaWhDvQS1p2urLMNYbCLKABdQWsMB5+p/7ZhrJ6ai/o
         C+aZB17ywBLNq03OWsTu9sDLeg9hsYhcrfUG4dbTOOTDbmCVc+Eiow4B+UQe5NUs8bF7
         UMEg==
X-Gm-Message-State: AOAM530p8vXqfMWfykqrifXpVyc09H0Nmo3Kz8GaxAwbw3vANrrwd7lz
        nnn5iv1J2sA+pgpPsH8Cg4gBfA==
X-Google-Smtp-Source: ABdhPJzDgLZ/qsNCJ+CQOK6adccIlj7kJfzAaz2V1xc/90+Lr/5d8ENCieD5JUc72n7vL/wte3R1Cw==
X-Received: by 2002:adf:f905:: with SMTP id b5mr1472430wrr.173.1643963007029;
        Fri, 04 Feb 2022 00:23:27 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3fbe:ff10:110:739])
        by smtp.gmail.com with ESMTPSA id s22sm8914078wmj.38.2022.02.04.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 00:23:26 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Dongjin Kim <tobetter@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO domain for GPIOE_2
Date:   Fri,  4 Feb 2022 09:23:18 +0100
Message-Id: <164396299209.31118.14326950420716778840.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127151656.GA2419733@paju>
References: <20220127151656.GA2419733@paju>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Jan 2022 00:16:56 +0900, Dongjin Kim wrote:
> GPIOE_2 is in AO domain and "<&gpio GPIOE_2 ...>" changes the state of
> TF_PWR_EN of 'FC8731' on BPI-M5
> 
> Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/fixes)

[1/1] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO domain for GPIOE_2
      https://git.kernel.org/amlogic/c/a5be3e5d46f373fe1d2ee835c7ede31769c241cd

-- 
Neil
