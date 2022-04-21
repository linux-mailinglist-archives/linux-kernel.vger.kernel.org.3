Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E350A263
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389354AbiDUObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389245AbiDUOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D23EAA3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z8so5793873oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f15a6+xs9NKJFvzgc2IaMpJjhmhU9m6JYAJXpBSlmQ4=;
        b=GKovL9nANToRyZUk1FRQ0ruMbSCG6mExQ7WgGwAqcv6efGQ6iFB0cjuBb1IYzEjcAQ
         V0uukMlDIw+8fdnu+V5L4I1231iNwscQ0LgsWWrysQbrns9dZRY4p1djuPuX2O/eKHRh
         04R1ESluDrwj4bwa3vHy2TUmHrFtQtKE5MgidrqSTrv9UcyjtqM4AKAgen4PqIsw1k6L
         ViGyVfQ5BEhXHkFGTktehSiFiUNU9q9qJVjzEco/gmdKP0cSANt/zemK+yd9NVcjMTN5
         6hJkub9SSUGz6clQRrV2epVnMdOPzJ68SCrst8zrnvc10lNOlO+9Ap3RicG+7d16faZf
         9AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f15a6+xs9NKJFvzgc2IaMpJjhmhU9m6JYAJXpBSlmQ4=;
        b=G2lwcrMVNo1GCwhZ8oMQfvOADuFJdeGuITcgybb3Wl7UtVea4tSzhMT2DO8hrS/yKq
         mUekxt24tCVtgdAPF8aAEbI608d7LfZYQOlS3ZKGjsmPpTWi3I5MfJCvbQH+QckJeY9s
         HEabooQ/odPUeirkMnikAHdgpvCBXR682aAeVUBTJZF8h7FGCrOCDs5/RglNkJAfxjSe
         BN651pidrQJ4r0FG37sYghxsd2361x47U3OOJBY+ESDJmZfvXNn210w/W64Dn9xm8eJ4
         1BZJCUb7tsJm+dHuICfmBM4s/SjZmNWZgD7l9W4zWwDBmJwNZTkC4J15+WWcE/MFzBPV
         nkUg==
X-Gm-Message-State: AOAM530MV61+YOnqvVHpu/zViEQP/pZGcf3MsA4UxGvY1a82avMmNcJ9
        z1s7+5TBrs0HGt0sLDfdYs7kdQ==
X-Google-Smtp-Source: ABdhPJysEHvqrQEzG8iRGi09wuDzsYuWrHm1z8tT37vWTxvOJc/5UdL4tDFWA+G7EieWnjvNBWep8w==
X-Received: by 2002:aca:d1a:0:b0:322:35db:2c0 with SMTP id 26-20020aca0d1a000000b0032235db02c0mr16227oin.82.1650551237184;
        Thu, 21 Apr 2022 07:27:17 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Olof Johansson <olof@lixom.net>, marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        jamipkettunen@somainline.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/23] ARM: dts: qcom-*-sony*: Mention SONY board names in DT filenames
Date:   Thu, 21 Apr 2022 09:26:54 -0500
Message-Id: <165055095991.2574292.5049219728779482349.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220415115633.575010-2-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org> <20220415115633.575010-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 13:56:11 +0200, Konrad Dybcio wrote:
> SONY phones/tables are based on a common board ('platform'). Devices
> based on the same are often close to identical. Mention their association
> in filenames, like it's done in arm64 DTs.
> 
> 

Applied, thanks!

[01/23] ARM: dts: qcom-*-sony*: Mention SONY board names in DT filenames
        commit: 73618b43dc5af291be0eb150f4ba8a3c1a5c5436
[02/23] ARM: dts: qcom-msm8974: Remove properties that are always overriden
        commit: eba5e62045b2848042435ae0503d7c2354edf2af
[03/23] ARM: dts: qcom-msm8974*: Fix UART naming
        commit: b905c34ae7db6b564589f02fa7eac7afaa0294e9
[04/23] ARM: dts: qcom-msm8974*: Fix I2C labels
        commit: bb167546d06847a8729c973fe5165a231fd5c39d
[05/23] ARM: dts: qcom-msm8974: Fix up mdss nodes
        commit: 4de36f7b6d0e7e792d36800ac6c5e3392b59573a
[06/23] ARM: dts: qcom-msm8974: Fix up SDHCI nodes
        commit: 64cf62683b5398e46cf967c308be95685137626a
[07/23] ARM: dts: qcom-msm8974*: Rename msmgpio to tlmm
        commit: 087c9704d5bb322dd5db52938416caeaf4cdc3c3
[08/23] ARM: dts: qcom-apq8074-dragonboard: Use &labels
        commit: 9f440d17e2309c7d14eba0898c775be6d6e6d6b7
[09/23] ARM: dts: qcom-msm8974-fp2: Use &labels
        commit: 409ab7dc57c41d9db54d221f4d247e229ba34cf9
[10/23] ARM: dts: qcom-msm8974-lge-nexus5: Use &labels
        commit: 1c1574e24990e9f9d753958745b8274874241158
[11/23] ARM: dts: qcom-msm8974-klte: Use &labels
        commit: 1d59524b9181e17110ae7b809c62a6a66f336fd6
[12/23] ARM: dts: qcom-msm8974-{"hon","am"}ami: Commonize and modernize the DTs
        commit: 5c554c2d67a8c6c43a1fb542cbc73c33ff04c344
[13/23] ARM: dts: qcom-msm8974-castor: Use &labels
        commit: 598a1e333224e73ae8f078ed6aa8dcd416cfb490
[14/23] ARM: dts: qcom-msm8974pro: Use &labels
        commit: 7bdc6d8c37c0848da6646484aa1b5e3554525ee5
[15/23] ARM: dts: qcom-msm8974pro-*: Use the 8974pro name in DT filenames
        commit: c919956818361826903707e023efbb6db7b49091
[16/23] ARM: dts: qcom-msm8974: Convert ADSP to a MMIO device
        commit: 2daa785817dd35172b856c30fc5148b2773b6891
[17/23] ARM: dts: qcom-msm8974: Sort and clean up nodes
        commit: f300826d27be7f7f671c922bf57007c98c683590
[18/23] ARM: dts: qcom-msm8974*: Enable IMEM unconditionally
        commit: 9f43e1973840955c0bd639c504095fba5f565e20
[19/23] ARM: dts: qcom-msm8974*: Consolidate I2C/UART/SDHCI
        commit: 1dfe967ec7cfb03b468d096a69d945070f1cd2a0
[20/23] ARM: dts: qcom-msm8974*: Clean up old GPIO declarations
        commit: 09db313d392b42a3a356867d84dc933bcb4556ef
[21/23] ARM: dts: qcom-msm8974-rhine: Add NFC and enable I2C hosts
        commit: e82be679de942decbcdaac82aecbcd1277e03fd1
[22/23] ARM: dts: qcom-msm8974-rhine: Add pstore node
        commit: e63d4c51997af75cdf3f096c333a957b4579e43a
[23/23] ARM: dts: qcom-msm8974*: Remove unnecessary include
        commit: 4b6a151f17cbea6e9bd5b043d0e6e7d19b77c3f7

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
