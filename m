Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F04753C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbhLOHgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:36:19 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54700
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240652AbhLOHgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:36:13 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 249743F1AA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639553771;
        bh=lH1LVhxxdi1joAcG9QMeOEZioVS7QsVUiTN3+0B9yPI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=snF0R5BUMjyMIE5BS40kakeVNlPU0yB1IldIY41RIkYHZGkjkjSjAJjyJiGG1Qd2V
         8mUHJpLga/kInhFZMgS5pU7cKQeM/r7/Iwb8TNr1KvK5rc/UYbHDlz4d1wkoD+T4hP
         ks13iIbM/2iLflruno70km/ftRQLqymE3zh5BLZ7E8dwc3aysH+Cbmpm0kIDy41ErN
         Aaf3f3d7f9N3JXNuiBRSrd7juYIHlw5OnJSCk86S/CMzg+J/O4Fv1cwh/vhxSdp7uU
         etTAUo880N9RRO5EWMP8rmMt62AAPTaVmSd6KRc23ewvIGmuxmCwQuH+TiSwmh1b7r
         WCe2XlOsJQVKQ==
Received: by mail-lj1-f197.google.com with SMTP id y23-20020a2e3217000000b00218c6ede162so6643678ljy.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lH1LVhxxdi1joAcG9QMeOEZioVS7QsVUiTN3+0B9yPI=;
        b=cInpaMz+nQVUgwm+3UzH7rduruQVVAI//oSp2j2TgFznZT3dQpKLXV4IPpnau42S6f
         fchb06X0+lQ9rKEp5wLfMAfr2JkKOXIF8B/p6LIRTAeM1Ebw/pAeXERjZQLPiptOm+Fn
         /RJW0mZ+D1jsUbpha7p65XidZGNHb/SViH8apf++Wb2E8S+RzgU/lJ3lRiIRhbc+qGPL
         tOFhtuRn//VEFpotobqM6LuQ+5tzhWlt7bDtEAhCmSQr3n1wvZVe9okRb/dRzDihQ4pW
         ZdabpdqWzLH7Ypi+gjNx68WcPvIWBy6GuKUTKYPXuzwBJ2wI3UakNMyvEjSA8zgnlT/H
         BCaQ==
X-Gm-Message-State: AOAM531MclWmvB7C4uc6lk7BDQwAdbkufOG/BMnenbSfusEd3NLaHFJW
        TWXs+c84rNzhGc43A3BhRNTSgxP4CGXf4k05GMuZxdD/QSJ/JiXB7ax9os5JYQUoCCkCKrY5y5V
        En3UEntSm8naGjSNtnFxQHLmWKUEV1Ww2UJBj3pmWwQ==
X-Received: by 2002:a05:6512:3a5:: with SMTP id v5mr8692441lfp.250.1639553770499;
        Tue, 14 Dec 2021 23:36:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOwaghIPjqudOHsOrTqyn0+O2yP9jGP5v1G1NM3rIvGm2dppX7KnT+sQYSYzVH6Kn1f8081Q==
X-Received: by 2002:a05:6512:3a5:: with SMTP id v5mr8692421lfp.250.1639553770272;
        Tue, 14 Dec 2021 23:36:10 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v14sm189836lfe.59.2021.12.14.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 23:36:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: samsung: Fix I2C clocks order in USI binding example
Date:   Wed, 15 Dec 2021 08:36:07 +0100
Message-Id: <163955376463.24562.1462295970065480353.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214170924.27998-1-semen.protsenko@linaro.org>
References: <20211214170924.27998-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 19:09:24 +0200, Sam Protsenko wrote:
> Now that HSI2C binding [1] is converted to dt-schema format, it reveals
> incorrect HSI2C clocks order in USI binding example:
> 
>     .../exynos-usi.example.dt.yaml:
>     i2c@13820000: clock-names:0: 'hsi2c' was expected
>     From schema: .../i2c-exynos5.yaml
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: soc: samsung: Fix I2C clocks order in USI binding example
      commit: d56a8e9c7af835a4f3f88b2ae34f4ba6f7085b7c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
