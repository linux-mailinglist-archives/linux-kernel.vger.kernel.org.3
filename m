Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5FF49B9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443938AbiAYROr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:14:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54930
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1389942AbiAYRLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:11:55 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 53D8F3F1D0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130711;
        bh=nJD04sb6YlgkCDJRA+fLgaKrPYRbjxz+KSgh9HtSg7M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Hy+Xq28Q947HPl7lWkrTl4U8LKoN8K00zLywrsYmMuXZLqThbz8AysF9eYc4TN5Ja
         tiZPDHhAhektlFDFDhIcJvxO4ELMAgIyAeFLU2l+jlWQ/qpGtdeMMKNzXB6EqFa9LK
         TyIo8bq8577NNl138slYoRvpNA4PCM/ONqIrvqjMblA7Ae1OaEgQcC9dGsuwAGc7Pa
         kzzxo75Na+RlmVJxtFDfzZzhRpS59PJhDSLOAvxaHgZ26djQ/gXXgw9Lzzg+nqhKCY
         3qex8utXZ2Ks+DTvdD8hfzhV0+djXSB7lVGODQjidPsNwlbCIcAVz8+6MKyAFRS7V8
         Qy+9jWj1Eg1ag==
Received: by mail-wm1-f70.google.com with SMTP id j18-20020a05600c1c1200b0034aeea95dacso1430224wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJD04sb6YlgkCDJRA+fLgaKrPYRbjxz+KSgh9HtSg7M=;
        b=37p8RpJIHJD7Llxyhq2uUIRvre4dvcmscKrIX1LVBo5rWEm1E/wEusSYNju++ewlrE
         17An1ZhixdpjE6K2Fe+z/QqfBBtVNwW3XDCg659gFoNk7xNv/pZzkxfts/yia2AM5X/M
         ayq3QZBehx0FiZI4wIWu66ARSrXaFRMvXbDspQNT8WKkM3DFziX/rXQNhE92slm5+QQH
         pw41xfp3ns5aV1+2KTxOsUInFUPiVkcfI8p08/+BqJuPlF/LjM8IAdPmqAK0Tiz26Xrn
         m1FXC5WkYTLp9n/6JIMBmUO1Z3KWN/5zdSoI7gEHj0yFM13BHTZQQ2wFTII9nWAcdMVb
         Q4qQ==
X-Gm-Message-State: AOAM533sxGQCn6Uwd/1/Yb9in2f2ZKJKKBh5NWfYs3Wa8Vc8aKe3WL1j
        hdQeA4QvrzXe4YnmmDEoCmamTpS2DNmqPouptaLrvt6nQNCximwp36/K6tzJ1/R/rBIDK5UubIF
        to3p6CqfnjrygXa1pNIY/B/kVusJOr97G3ygieQ2Wkw==
X-Received: by 2002:adf:aa4b:: with SMTP id q11mr275077wrd.133.1643130710993;
        Tue, 25 Jan 2022 09:11:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPqH6ulE3sqPBWWffAmdgL6WA3sDpkRpkDHhrb5WblxRR/QVuQqNilQduWRS+6/UDQMl7bTA==
X-Received: by 2002:adf:aa4b:: with SMTP id q11mr275059wrd.133.1643130710867;
        Tue, 25 Jan 2022 09:11:50 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f8sm1185826wmg.44.2022.01.25.09.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:11:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux-fsd@tesla.com, olof@lixom.net, sboyd@kernel.org,
        linux-clk@vger.kernel.org, arnd@arndb.de,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        catalin.marinas@arm.com, robh+dt@kernel.org, soc@kernel.org,
        s.nawrocki@samsung.com
Subject: Re: (subset) [PATCH v5 01/16] dt-bindings: add vendor prefix for Tesla
Date:   Tue, 25 Jan 2022 18:11:03 +0100
Message-Id: <164313065135.81319.13219734487510623073.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141644.71052-2-alim.akhtar@samsung.com>
References: <20220124141644.71052-1-alim.akhtar@samsung.com> <CGME20220124142857epcas5p4af44b43ce57414ad6667c84753c36f16@epcas5p4.samsung.com> <20220124141644.71052-2-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 19:46:29 +0530, Alim Akhtar wrote:
> Add vendor prefix for the Tesla (https://www.tesla.com)
> 
> 

Applied, thanks!

[01/16] dt-bindings: add vendor prefix for Tesla
        commit: a5a93e9b9ab9b4f367a773b32bbe1687006d75b7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
