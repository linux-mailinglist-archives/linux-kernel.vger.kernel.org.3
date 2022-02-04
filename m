Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F331D4A9BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359590AbiBDPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:12:18 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52390
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359592AbiBDPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:12:17 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0CD783F4B6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643987536;
        bh=yOhvfL3K9EM3pgKXGgKC0dd7a7sZ03wRgeDWP6xNUxE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=qdAopGIuC5UhnNZ2qO8rrlHj82bx5gIlNnHgwRVUFddf0Wp6mTk3HoVdqP3HiMLjN
         I2URoFAnfaQpd0JgB+WcpXpgBwca/Oz5uHXDSr8SnxAR8fIeScjmVK57iOkMnjVNku
         sQC+DVuNeJq3jcWRhfUhanDeoZ2ndC7ZlQmFFAWOu+ewpyHjp60d9RQI15dsR3QxD3
         3CtfhxXBYvGwmG6sQC1p3kUlTUfVDtzAn1MFJdro3m2Rchs6UWBcWxun2HmgDHe4iF
         UdkJLq40BkBaJFcy2yqL+hRRTIfNu784kJamBubVAy+Xo+LQWYlwP1x0zbyC1B5fxF
         zPSPePUsu3smw==
Received: by mail-ej1-f69.google.com with SMTP id yz15-20020a170906dc4f00b006c4f36127e8so711989ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOhvfL3K9EM3pgKXGgKC0dd7a7sZ03wRgeDWP6xNUxE=;
        b=NKgMkBnwJBYhJhdrcIpcqEBXD2kxozQmE/sYh1B0kJCIjgUWaA3JWzaSnwS2dI3MEk
         sNW+S/3AXqigaylI3rDxq370sQ/dpm2OJpFtqjyX7YQe1v3p99sm+07TeG+RtQ05WGGl
         lbSQ1QjN9vTd4tR2FFAdlvPIlPUsjf8recvCvWfV9/FhSJ+c8kOmV5zvgfXKm8yZP6Q+
         oglZpSV7qHJg9ma2mFDDxxSiBeE/u7UHdBrDyvXPrFH0XYqPr3/hUzmYL0ZDImi1zici
         5bwx2rCPnCB4cYjHj0NcRGUc3Mo3LMTeMhGirZvqcMKOvZaAdLitu3Qvf1oYF2pa7mi1
         bEJQ==
X-Gm-Message-State: AOAM53144D8UmzNEdq4YrGr+zuMa2RRJ3t/dUARxn3Kjc68/uoyBfI9c
        PytVlzj/LjSmZ5SrpIYSigB1ZPa/qPLWl1yZmIXhi8lTL70vFsH28bQgBIi8bgQoD+j+Zl7w1Sw
        vbjpsImCbiZXghsEawPMeNPn1qdWFX0c+76d5ei8fYw==
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr2827685ejq.120.1643987535444;
        Fri, 04 Feb 2022 07:12:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLnKNw6+erLDFjnoNMlzBft5DfbylVfdBVAIS76vuUg0w0Q2ojfZrmcPS1dn44UaNJfnuToQ==
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr2827667ejq.120.1643987535276;
        Fri, 04 Feb 2022 07:12:15 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h15sm757748ejg.144.2022.02.04.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:12:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 1/6] arm64: dts: exynos: use generic node name for LPDDR3 timings
Date:   Fri,  4 Feb 2022 16:12:11 +0100
Message-Id: <164398752918.81715.4393441551336202631.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
References: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 12:47:44 +0100, Krzysztof Kozlowski wrote:
> The node names should have generic name, so use "timings" for LPDDR3
> timings.  This will also be required by dtschema.
> 
> 

Applied, thanks!

[1/6] arm64: dts: exynos: use generic node name for LPDDR3 timings
      commit: 931dac3d3442bb1ea01be9cbdc53310272b68f77

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
