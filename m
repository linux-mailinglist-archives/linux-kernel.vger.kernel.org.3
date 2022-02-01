Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE04A5858
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiBAIO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:14:59 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56566
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234578AbiBAIO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:14:58 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C97913F1E0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643703297;
        bh=boQfkEd/Axzz4Ha9OlxxnWi1WdYV8vP07YnaJvP+r/8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=N+w3AMJdUgRA0k5Xz9NwgTMUjSFzfDuw4Qg4vvrVULaQW1IG81UezMEdsPGbCNz/0
         VgU+qAc2LCgXzj04WqrjgYqZ0mVKrIXPVN2J87jve+wtxCe+p8FyLWtrb8vdukLaLE
         RNAUHWMR9sqfXq+vxs7hn5ns9U933MlGlWz57Y/1HCkvrtCxPCaWDiStJv4VEYRYVb
         RMRRBWpG7vd/9JIoqCw9vuMN3SLX51OGlGSQRLaYmaEwKUiU2CTDWtW2PZ5LfUXpXl
         d/MUQ4rzi2SQ/IapGvr9IiwUoa08TpyYs+w7jo2X3Gft3IBhHUA0+BqGeoTn5ah2fJ
         ufBgg/FJ2cFSQ==
Received: by mail-ej1-f69.google.com with SMTP id gb4-20020a170907960400b0069d1ebc4538so6186951ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=boQfkEd/Axzz4Ha9OlxxnWi1WdYV8vP07YnaJvP+r/8=;
        b=OuW2bj9s0uZKBU35/aCa70TimXnPnGf4J/d0jeM8DDA6lk45I4Xn/Nmqh6cR8D7KJF
         qRt0gZnu1tPQ9ULSln0mhENc8ohYw4R82OOyG9zIuHE5qSs1VYfEu88v+Nak7sjiEi1+
         tUFITbIjtgQMJhxCQJe9SNfVhOwqWke/a9002bm34UGvFp95kpTmb2B9Uy2q3WIcFpsQ
         O1qEsORjAz3T/rRwborQ9mZKB/p5/Nr3quhcEZfjTkTuGx7aDnZyr/lb2OuVXPlpBuBL
         PQryMM78p7MyGPRICBkoT+pLqGfuCTHHvjN0LLR5NCt2imNkr/wpRiZhCeiY0s+8cK2/
         JEIA==
X-Gm-Message-State: AOAM532GTUK7GmK8r6+NewblLzF0Gs01jYfmah/jKTrNCEtMohrup0Eq
        GCxHubUtKmL10d+hAyDeYumZAkqZZDCUMwZa/9QSJJhnJj1JGYwA4uXr0b3CNB2DvYuttu8KUHj
        dROCM7TpSBp1yNgalUvOmHXsf5S6w7hJUgKHMBmsGUA==
X-Received: by 2002:a05:6402:2754:: with SMTP id z20mr24075549edd.235.1643703297529;
        Tue, 01 Feb 2022 00:14:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgfi4y9EhHDRDWpF0JFjBFlkVKbHHjVy1Mb8dmncTyyzB+oiFhGTButtSrBYmktoLV7QbEVw==
X-Received: by 2002:a05:6402:2754:: with SMTP id z20mr24075530edd.235.1643703297366;
        Tue, 01 Feb 2022 00:14:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g12sm19113517edv.89.2022.02.01.00.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:14:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] pinctrl: samsung: improve wake irq info on console
Date:   Tue,  1 Feb 2022 09:14:21 +0100
Message-Id: <164370325802.11962.5143419688902708508.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220130232122.GA119248@adroid>
References: <20220130232122.GA119248@adroid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 00:21:22 +0100, Martin Jücker wrote:
> Improve the wake irq message by also printing the bank name and hwirq
> number that matches this irq number.
> 
> 

Applied, thanks!

[1/1] pinctrl: samsung: improve wake irq info on console
      commit: 3652dc070bad335d6feb31402bb4ab1ad58d5cb6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
