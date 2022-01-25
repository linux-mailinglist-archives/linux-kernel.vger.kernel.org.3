Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2EB49B9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456788AbiAYRPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:15:53 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51452
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243279AbiAYRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:33 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 34E6340045
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130714;
        bh=7TxHx9Az3jP4GXjS7R/xWiSSbyyuPYk/buescVNcwdc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=YnoP8Uc27tQitB3oZ3Hm/Snj3o/62XM1NgL3NHYAdwIK6V8LbZ0uDdao7d25o9ra6
         yKYjKrCu0M4+nsDtpLc01nhbzF4W3MogmDBbNzmbDhJ3qSI702Eg+JMUhJA1A0Kn86
         9VEcTLWdswnVBaNUZ0Akl91ft2jS9VYzffWZeJa+urzG62x7Jo2SkqEdYUBCEZyy7F
         TaOzDBndkVzSoeObcVLI8lXx4UoILj07QJaazmPYgPnhcWA3tinSOMQN6S2ESSW6Yr
         /Gjy7MB1aenvVzONa4DG1VQrmzvPl80RaZvgCer4TuFr7TPpRj2P7q1yXJ9fB6jwA0
         Wb6l5ROjX7DpA==
Received: by mail-wr1-f72.google.com with SMTP id b3-20020a5d4b83000000b001d676462248so3360822wrt.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TxHx9Az3jP4GXjS7R/xWiSSbyyuPYk/buescVNcwdc=;
        b=a+7F9mbld9y0q0WBu9N5rlGzfEum67y/mZBdyhSbbdHklAqMRZDZ+8KbWkCQ+tY5cj
         zN+bkkrWTk8ivnIEmHtG6wsh6cilT+sM+aXCP7gEotDzA1QJhHq+midonrQ2xKVoa4i7
         WgJxGRzoxyMt+RuEngcLXCXAnFmX/n01Utse0CVArRK+PI3wEUOfGM+dU1P/XTCxrK0Q
         x/FVnSl6GPL6v+3TZYYpnjACislUCL4lag12LENR6re9x50UeDCEyQQDxh+uCjEtPdmP
         VloJDyOw7LbRkkUJ96fBxteE1R0vscPiO+uMO/ER2kepohkBBCOBj4/iIQkM6xrF/qzB
         kp/Q==
X-Gm-Message-State: AOAM531DgcsV6d67SACEG9eK/K5LksHqfueF8auZjSr3HrOGenhRT3l8
        jEGJBFv0CRpYV2R6ehNxav5DNfrUUCteEELg+McW3vWaLzB31HSbRrFaBP/FsM2DXdrQW2dJ9N8
        zbzOhVUVOOzo/81SgwVq2sr1h9E8xG9y6ywvo5Yqipg==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr20072637wri.695.1643130713847;
        Tue, 25 Jan 2022 09:11:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8Ro1jAI/vmvdBovPg/nvWvSQlSJjY4J64VwAZ+jbuns+Jsv8ut2Ic5OsKXwBEP9xJuQdKxw==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr20072595wri.695.1643130713542;
        Tue, 25 Jan 2022 09:11:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f8sm1185826wmg.44.2022.01.25.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:11:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arjun K V <arjun.kv@samsung.com>, linux-fsd@tesla.com,
        olof@lixom.net, linux-clk@vger.kernel.org,
        Shashank Prashar <s.prashar@samsung.com>,
        s.nawrocki@samsung.com, Sriranjani P <sriranjani.p@samsung.com>,
        devicetree@vger.kernel.org,
        Aswani Reddy <aswani.reddy@samsung.com>, robh+dt@kernel.org,
        soc@kernel.org, Ajay Kumar <ajaykumar.rs@samsung.com>,
        linus.walleij@linaro.org, sboyd@kernel.org,
        Chandrasekar R <rcsekar@samsung.com>, arnd@arndb.de,
        linux-samsung-soc@vger.kernel.org, catalin.marinas@arm.com,
        pankaj.dubey@samsung.com
Subject: Re: (subset) [PATCH v5 14/16] arm64: dts: fsd: Add initial device tree support
Date:   Tue, 25 Jan 2022 18:11:05 +0100
Message-Id: <164313065136.81319.1739143646413756082.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141644.71052-15-alim.akhtar@samsung.com>
References: <20220124141644.71052-1-alim.akhtar@samsung.com> <CGME20220124142957epcas5p27ab08d4eb02fe53a03e2b36ab1d913f8@epcas5p2.samsung.com> <20220124141644.71052-15-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 19:46:42 +0530, Alim Akhtar wrote:
> Add initial device tree support for "Full Self-Driving" (FSD) SoC
> This SoC contain three clusters of four cortex-a72 CPUs and various
> peripheral IPs.
> 
> 

Applied, thanks!

[14/16] arm64: dts: fsd: Add initial device tree support
        commit: f984dabdb5e16afb0f69b05a11ca9eeffa5b9a73

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
