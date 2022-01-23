Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1057349737F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiAWRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:11:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43176
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239182AbiAWRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:10:49 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB7344000F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957848;
        bh=/2OIXme4ALl4DAjdA85FQwEEgnqTTVJ2eyUW6QlD2T8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=mvxsgIO2Qs/YGLDagSPcsnxDTvLpndq/7NfXVTsXmaNphrZxCncWSqDEKRs5y+DDZ
         MadWqrbZVlgLFQ49GL34miEZKYpFJIJGGfMtj395/T8d3dVoS5LyljJSCH0Uxcr9BG
         EfXX5WZcFTJWGpbVi6rjqeuik6gm3sxZQAjEtttBWTTZoML2skP7G4RerHPk95OTyb
         Q0qp4X1rNRgr3UbEkMB2uje/emkoJ0RIUgdWO9x8BM6+a168cKjAOvoXESs/BdqoAh
         vhwQCdUOtR5ixKIvJuVD11dDc93WvvNki2U1I09rwzA9/0l3D6HZHugI2PWcrp1xGG
         +U7aC15VWLPZA==
Received: by mail-ed1-f70.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso10442964edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2OIXme4ALl4DAjdA85FQwEEgnqTTVJ2eyUW6QlD2T8=;
        b=E/DFqXJvgPMA2RI7kzihJMsuc+QTSWl48oLJd0RBa4jz4iuuMtTMfM/kUe8f6HzGN8
         vquCwe1J0J+1FDvgqgRk0JuYEdzRkqgOtz0SwK8MlQyXN49GJmk/pQ7BzJoWaVT/NqK+
         drAP1hLZzzsXH6qIGrZjXzeZWvAhOLrW4CF1ciXWHwoW7i+FBVcH+esbs/iqxDbSxsmi
         SL6sFN+gSmD6q4nQCLc/A4+HlMvu3hQ9rZyE62ThMONwARkrHXLKF4rAGpYobg5HXiNH
         OD/c2jDoljuf/hkJY4uzFiRyQ09f0x6g+sgjoqDNxVQtbm6HBpblgTj+9IqGTxOj4bUz
         xuGw==
X-Gm-Message-State: AOAM530XJDVQJCF3hsOQKrcJGPmjBOXw4RbORPh8TEgrwC6cPkMTB/P+
        z9DwO8ilN0EhzquixPbMZ/Oru0rdRbsOiAqPSFrnvFpVC8hegbKS7cCZGEhIeZhh9pqX8yGwsX+
        TEAhkgMFxQiwf4DHUuHqA4IF9CQTXehHG4mfxkiuvAA==
X-Received: by 2002:a17:907:c01:: with SMTP id ga1mr9855504ejc.719.1642957848622;
        Sun, 23 Jan 2022 09:10:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9xL/Mcl66pAOPBWGwufPt3D01t+dIls2WZgVjeMInLwmxcYSEx9LO5kA2ZiiRVdxKHoHp1Q==
X-Received: by 2002:a17:907:c01:: with SMTP id ga1mr9855501ejc.719.1642957848428;
        Sun, 23 Jan 2022 09:10:48 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l2sm5208665eds.28.2022.01.23.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:10:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v2] soc: samsung: Fix typo in CONFIG_EXYNOS_USI description
Date:   Sun, 23 Jan 2022 18:10:40 +0100
Message-Id: <164295777264.25838.905366806236166301.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220114144606.24358-1-semen.protsenko@linaro.org>
References: <20220114144606.24358-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 16:46:06 +0200, Sam Protsenko wrote:
> The proper name is Exynos Auto V9, not V0. It was the typo slipped in
> unnoticed, fix it.
> 
> 

Applied, thanks!

[1/1] soc: samsung: Fix typo in CONFIG_EXYNOS_USI description
      commit: 442b0c08db7e35980bed6af091877f4dda72ffca

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
