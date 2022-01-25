Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7549B9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454731AbiAYRPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:15:42 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55146
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242186AbiAYRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:33 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B780F3F1CA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130712;
        bh=g7yYrXHImPhCQwOj0UskOn25n3xq1OGmRzWasb1bHQQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hkdgSmAcmhMivsu2URlDkCXI8f63RavIJYIzrssxpjF1rnioTXzejmjLjtnZ6qPvf
         xnqUJS/AVKxZxn6/OSmfufnnU2veX8jPodPaXTf9ftVnQp2m6EEp2ou0cln9sW59ya
         fBlTS9I7bf+2r+3JVU+EiJUkjRQwMyt1RnPVTxQ4botx5jnQ3eZfD4XFuzkDHit2GX
         tP9CbpmovQtBDPJJT26Ys9nZM1YsNtQ5N3VyQrdXOL/qsyCou2qJyhxqoWmz3x2Faj
         KFOu3mEZBYE8ndQEnlkux4R1GB+8PrxYA4d37Sucns4ZTGTfGq4VZPfaIBA1h3edA7
         wuy2KPSKxrllA==
Received: by mail-wr1-f70.google.com with SMTP id h12-20020adfa4cc000000b001d474912698so3321720wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7yYrXHImPhCQwOj0UskOn25n3xq1OGmRzWasb1bHQQ=;
        b=kq6y7VvzRHoWvEImhyZRYcnJ3vf+XIA2p33DJRl1k963gAZhp7BMlJn2pwHSRn/f/g
         7P095I02o1YF4X2TYtH7LfcYq1SSzUE6VWIcl1xDevrdeduNcm4LBISxk3UMnRiwX7um
         a5uu4QcB3qyK4MBEX8arJWw453D8aeTUbwQJQb6/danLgSYB7/Whwvuo4bqZ/qLjOODS
         UIA4BIKPqrO9pqi6O3Db3Kujgf28Z17GMl8Wn+13r/lTzrzheVvqHZ1GXS6ASf+Un2se
         NYaP9TFRoUy6Wb610YlVRqmNyZK92/W8WwkeqJ9Mi96/MvbhpCVIJRoDChw4oN1iqJyl
         T2Vw==
X-Gm-Message-State: AOAM533RhEJ9VFm6WMzEpY0lHn2mVLQ6YBO2kOHfigDsZBPU6knNozO9
        yRmkKpfh5+csvew0My5wrDDvDVar2w6d6sq/Ell4ri1SlYMHEa707/o73xK0ZWDYrrbxz7A8+KZ
        b0BhOxdjghOFrH70OhHjb3YrJeRJstOmTsg6QCkGlNQ==
X-Received: by 2002:adf:e592:: with SMTP id l18mr18490657wrm.217.1643130712379;
        Tue, 25 Jan 2022 09:11:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmNgL2L2/wufXJkt0M/aVg1sqAVlqZZAkIIrefWSMS+S6RErnsKS/CAuAI5H838RBZZxTQ1g==
X-Received: by 2002:adf:e592:: with SMTP id l18mr18490639wrm.217.1643130712199;
        Tue, 25 Jan 2022 09:11:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f8sm1185826wmg.44.2022.01.25.09.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:11:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-fsd@tesla.com,
        linus.walleij@linaro.org, olof@lixom.net, soc@kernel.org,
        sboyd@kernel.org, linux-clk@vger.kernel.org, arnd@arndb.de,
        linux-samsung-soc@vger.kernel.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, pankaj.dubey@samsung.com,
        s.nawrocki@samsung.com
Subject: Re: (subset) [PATCH v5 13/16] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Tue, 25 Jan 2022 18:11:04 +0100
Message-Id: <164313065136.81319.902005401446620690.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141644.71052-14-alim.akhtar@samsung.com>
References: <20220124141644.71052-1-alim.akhtar@samsung.com> <CGME20220124142951epcas5p255712c3a9e37b9542687587d8114bda3@epcas5p2.samsung.com> <20220124141644.71052-14-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 19:46:41 +0530, Alim Akhtar wrote:
> Add device tree bindings for the Tesla FSD ARM SoC.
> 
> 

Applied, thanks!

[13/16] dt-bindings: arm: add Tesla FSD ARM SoC
        commit: d25c5eb511df3439cd91517bcbce4b274f8972b9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
