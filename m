Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353ED4812D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhL2MrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:47:04 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39664
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238488AbhL2MrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:47:02 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 47FDC3FFDA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640782021;
        bh=EiFThceYXJIfaUy1FiYlSzDZJI3YYnQAhDfGO4ROhTw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DERWsw6mtJjJxtBo/02tikpkcHlkFI5jGSoJowuWIOunHxSWRCDp77cM8EVj+CYg4
         x/tt5WAoxiZ7YPyDPz0JZERopmNXjYx+YpUF+ZLSWj06hxiej2ThKO+GqdGkmUDCZD
         INEZdax4sC9NLSpzJdrzkovW61inmMmovA+HtzcnvtmHo90/MDyqdT89MROsE/sRBX
         fM/I5i5O/S4BSd6OI8ctJ2uNjRLVoy9YwXjX1LbCTeLrDKb6RbEo3VqNyW/Y3Kr/Ix
         AMTtSK3hjjBNJPmr50i/+SIG8IWhS/YTFvj9MLa01lf3IExSacWPakSvD3ey/4/Sra
         hS7eYQE8v7i3w==
Received: by mail-lf1-f72.google.com with SMTP id v139-20020a194891000000b0042a2927eaa8so168707lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 04:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EiFThceYXJIfaUy1FiYlSzDZJI3YYnQAhDfGO4ROhTw=;
        b=YywY4lYkkc9YiLmuDaNIja0276e+Bu/jeG+Q+LtPaW609N5nkfGA+oA4T3FCjXw1jl
         KTR0Uh8XEHixqhJFjX1v65bplJgykKbIecl0L9L+lytSOaiaec8LIJW/X3hGJU68MwZu
         aZsr8cvpLffsJU/d4nfKFB4GTXPzfWXQ85Am+DeDdRrf2VI9xSOv0+vr49s7cOk4nINx
         /aMH7lTEzLilndKMO//5JSbdLtBpz+aGlv47wsoJQGakwbPmoUIFSco1XiDD9GWdHBHx
         BVBhgM4k0+Tai3cqjQNHyDgSt6YVeuEK6q7oIadGvMGODoOAA+fXJKsdAyS0vHwaoNVv
         CuFA==
X-Gm-Message-State: AOAM533hLFnZrEDiQgPplWYhGAJbPkNqprNGSTxd6YjQQDqVnlWGEo3d
        M+l/zJpPQJU07nO8Ol8zqfxHmpBF990OJt0gUMAQEf1+qmzUFh7U56ThJSW0ivAfiaYdy7Qyoqp
        mw5WdHn3a9OS2MfKkp5jOZEdH7MN1GaEiDW1b35iz9g==
X-Received: by 2002:ac2:5f0d:: with SMTP id 13mr23094265lfq.584.1640782020449;
        Wed, 29 Dec 2021 04:47:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpQql3Aar4Mwf1v33RisqPFjfwL9ts2alHH57FGrI6mbQVzAUGmcSa9BNYuLmqblZ4JTIcfw==
X-Received: by 2002:ac2:5f0d:: with SMTP id 13mr23094236lfq.584.1640782020117;
        Wed, 29 Dec 2021 04:47:00 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e11sm711158ljn.73.2021.12.29.04.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 04:46:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 0/5] mfd/extcon/regulators: max77843: add dtschema/bindings
Date:   Wed, 29 Dec 2021 13:46:26 +0100
Message-Id: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The max77843 shares some parts with max77693 but it lacked bindings.  All
its compatibles were undocumented.  Add basic bindings for max77843,
matching existing devicetree.  These are not complete bindings, but
rather reverse-engineered to match current state.

I do not have access to device with MAX77843, so if anyone else
volunteers to be the bindings maintainer, please join.

Dependencies
============
1. Patch 1/5 (dts): nothing depends on it, sending here so Rob's automatic
   checker won't complain about DTS.
   I will take it via Samsung SoC tree.

2. The patch 4/5 (mfd bindings) depends on regulator and extcon, so they
   should come together (3+4+5).

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  arm64: dts: exynos: Align MAX77843 nodes with dtschema on TM2
  dt-bindings: extcon: maxim,max77843: add MAX77843 bindings
  regulator: dt-bindings:  maxim,max77843: add MAX77843 bindings
  dt-bindings: mfd: maxim,max77843: add MAX77843 bindings
  MAINTAINERS: mfd: cover MAX77843 by Maxim PMIC/MUIC for Exynos boards
    entry

 .../bindings/extcon/maxim,max77843.yaml       |  40 +++++
 .../bindings/mfd/maxim,max77843.yaml          | 144 ++++++++++++++++++
 .../bindings/regulator/maxim,max77843.yaml    |  55 +++++++
 MAINTAINERS                                   |   2 +
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  17 ++-
 5 files changed, 255 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml

-- 
2.32.0

