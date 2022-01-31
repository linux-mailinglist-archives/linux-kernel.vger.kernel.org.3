Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446554A3EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiAaJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:02:58 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38536
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232324AbiAaJC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:02:57 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B4F243F1E0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643619776;
        bh=VPxWUBO6RdX14HL+ygIvVwiE8ezYmob4dZE1Vs6HWz8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=URCuYMpETv41RsKCe6JElvsYu2Xa8FwWLPJvJToP7hkADoEHdbfNeYOTjDRChx3rd
         SFdoYd8s+y4H+oC1TCCFzGnOFhmdnjqHLQl3b3t1yNJseYDORYHBnYuH7x+crFtaJg
         vx0/5Wn6tCcNfaf55sHFbO6U9HXAlkVYRDJo7dCquwTra6c+TVASTgbrfzz1Ufrm9o
         VgNWnAF98M1SkV0Whxrz4WMB1Mpp6//IY4B6vAWpIcBG9BpscgqkTiYP97ywayRfmG
         cjjatuVXoV5+97J2F/ICoVUnK3f1KvV3t1YHxyNNE00YHCBi1MaTYJIGNgQym/NyeE
         BRmLxnnuwzu8w==
Received: by mail-wm1-f71.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so9280021wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 01:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPxWUBO6RdX14HL+ygIvVwiE8ezYmob4dZE1Vs6HWz8=;
        b=cUTpNfRpbdH/HtPn1gY0OkqTufhPdJNFT3ckCGAQ3zWpCTdvPUHodtOiDDywRQa6Z3
         CRNK1SQYtgh/mYFJymFJNO+ApQT+tHgJ650Cn66MK+j4CjvwN323ST5Wlw+QmquHhOBI
         rVSGakMbw0wvshD+gBBDAPKaW0WBDgrgvi/pAFVJoSCF+9vLfAExj9871dB8wz92oFyV
         ZvnrysgkTz1kOuTqbs94lnUS4ThuRXJfujSJtINkbTwa4iPxR+VMH1JM6HODx5KUEHj8
         C11B47jwAX6if6TrG25uXdLMUrkkWZEnO1kiSM9ZmrkbjlztUQyuyTVrufrufM74kt5m
         nNKQ==
X-Gm-Message-State: AOAM531SUavsGZFiNhdKFsVZDT/cTzfEjsBKHY1AELfnxTFHglVTtMpG
        cWVDl4Y2yEiN19XmxHDyDp1F652ByCn1vxHCpktPgkrhQd+X/wNOFKjO7f9rdkVnoW16ef+8zMC
        szr/OcinkSzzMOu6TLjTzOEn6Xh7BjHwjW6DH4zuU8g==
X-Received: by 2002:adf:f703:: with SMTP id r3mr16858347wrp.354.1643619776435;
        Mon, 31 Jan 2022 01:02:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBrLJFSY4y+ymZIDvgLm9S/yZmXBOYfaqH+6ywjDWDjBGe7K6nX5M0jnkU0z/nyHAV8DaVrg==
X-Received: by 2002:adf:f703:: with SMTP id r3mr16858318wrp.354.1643619776211;
        Mon, 31 Jan 2022 01:02:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c8sm9219866wmq.34.2022.01.31.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 01:02:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: (subset) [PATCH 1/5] arm64: dts: exynos: align pl330 node name with dtschema
Date:   Mon, 31 Jan 2022 10:02:53 +0100
Message-Id: <164361966593.14585.5079368192105542217.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 18:53:28 +0100, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>   pdma@15610000: $nodename:0: 'pdma@15610000' does not match '^dma-controller(@.*)?$'
> 
> 

Applied, thanks!

[1/5] arm64: dts: exynos: align pl330 node name with dtschema
      commit: 706d8df83c8ec9cbe948ff8c8bd082b7819f4196

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
