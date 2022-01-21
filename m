Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5260496413
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiAURke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:40:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:27720 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241342AbiAURk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:27 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220121174022epoutp016d4c950996aa5b8417a20dfeb3efea80~MWelfd9kQ3053530535epoutp01g
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220121174022epoutp016d4c950996aa5b8417a20dfeb3efea80~MWelfd9kQ3053530535epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786822;
        bh=yEDZjvfFp+4i7/U7MjWMajMUtHtH/8TAa5UWrXpu5kc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vST/KwXwtWhsMDDXtcBg5u7xLKk7YFTm9CsZQUFXSN6EUJqPfMZf942nhFhCkBTbP
         3tEzBxVaE7EYEDJEnZrLvoyofKc77UmPDooRaY6kkYe0+2zeAj6kpEQWhcZD6xst23
         0+KSpmZHbYZW+VrFC6nYQCJe+iVDznUOtx1+URaI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220121174022epcas5p3b1faa21a077485920eb075eeb5e2a496~MWelBljcg2717827178epcas5p30;
        Fri, 21 Jan 2022 17:40:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JgRV91pn3z4x9Pv; Fri, 21 Jan
        2022 17:40:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.20.06423.100FAE16; Sat, 22 Jan 2022 02:40:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220121174016epcas5p347510c17404c703f6b857bc43413ed2a~MWefryHkd2717827178epcas5p3o;
        Fri, 21 Jan 2022 17:40:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174016epsmtrp11c5ed766b29b877a5b93efbeb9a68894~MWefqzXcp2324623246epsmtrp1h;
        Fri, 21 Jan 2022 17:40:16 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-93-61eaf0018b23
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.A7.08738.000FAE16; Sat, 22 Jan 2022 02:40:16 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174014epsmtip26d90cfad6dd3d9d86d851faf7cb5ccf1~MWedcFI2U0094500945epsmtip2q;
        Fri, 21 Jan 2022 17:40:14 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 00/16] Add support for Tesla Full Self-Driving (FSD) SoC
Date:   Fri, 21 Jan 2022 22:58:24 +0530
Message-Id: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0xTVxjPube9vbh1uRYch7pJcyMJshRaabvL1qqJhZQghmUZS5a47obe
        tYy+0tuO6QhDN950E3QKyoCMTVwxCrUI4th4hTGJOpWnDDSDLK4bDwGZsUBWeuf23+/7Pb5z
        vnM+HBUVYmI82+pkHFbaTGJbeFf6dsVKwaKflt0bw6gHdVcwar1qQEAtnKsAVH3/TT7VOvcE
        oU6uNSGUd2aUTz2qmOZTdztrMar61g8IdX1sGaO+blsRUIVd/QKq769iPrUx2sqjZsbWsH2E
        7kLdBaALPK0CujMFbkzn9ZRiul9Hv8d0l7/5RDc8eIyv+9znAbpl746MsHdy1CaGNjAOCWPN
        shmyrUYNmfamfr9eqZLJpfIk6lVSYqUtjIbUHsiQpmSbg2OQkg9psytIZdAsSybsUTtsLicj
        MdlYp4Zk7AazXWGPZ2kL67Ia462M8zW5TLZbGTS+l2NqW5lG7O7tH/3Z2AcKwMOIMhCGQ0IB
        n16sB2VgCy4irgG4VFuOcsUSgCcn7gm4YhnA25PnwbNIzdQknxM6AXzy83xIEBGfIXB2CtnE
        GPEKnDrtC+EIIgWOHy1BNgMo4Ufg2EYztimEE2lw7XQ1uol5RAxcWnwUCggJNZxZd2PcadGw
        uaU7dCdIVOLw9vIdXhnAg4UWHhvP5Dzh0P+TT8BhMfzjiyIBZ8mBFZ2JHJ0Hv60b4HF4L+we
        rg11QYld8FJnwiaNEi9Ad2AW4ZJCWFIk4twx8NP5kX+T22FleTmfwzrY0dCAcZMfgn8XB5Dj
        4KUz/zdtAMADohg7azEyrNIutzK5/31Nls3iBaF9jEvtAFMPFuN7AYKDXgBxlIwQ2m1+WiQ0
        0IePMA6b3uEyM2wvUAYfqRIVb8uyBRfa6tTLFUkyhUqlUiQlquRkpHDI2EKLCCPtZHIYxs44
        nuUQPExcgGwdJ+v3ld3xGmuKIr/SnGLXo9HDMbtrOuorbl2KioXTPc2NTTOT2j3vP/7u+i8p
        B0905X/QKU1uxxdezk/Pm3xDob57kNZa2POH3J4Dru6rvpu2nlNRI9HXmrpXS/GhwlmNR63v
        aU6LlOQNvbv6lmv1+M64pqj79xcuJs9Mi064zxnCtVcbVV5fW1vml12LvB5ecVOpdkqlShye
        SI3+fV48kftiWcKNt3t++1E5sFfmVxV0tD8HqmKFqHFJ4NuR6lWMDCabtC1z5TsfZ9q2Skoe
        VuZHtc4xZwP728/eWOj/OHewcKWat1FtBqIq//OJR8ZHjnZss6e/ntqeLgxcls6TPNZEy+NQ
        B0v/A0a93EsYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvC7Dh1eJBhO/qFg8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWl3fNYbOYcX4fk8Wp65/ZLBZt/cJu
        0br3CLvF4TftrBb/rm1ksXh8/Q+bg4DHmnlrGD1+/5rE6DGroZfNY9OqTjaPO9f2sHlsXlLv
        ceVEE6tH35ZVjB6fN8kFcEZx2aSk5mSWpRbp2yVwZWz9co+poFe64vXiw4wNjC9Euhg5OSQE
        TCRm3r3N2sXIxSEksINRYu7ZzywQCWmJ6xsnsEPYwhIr/z1nhyhqYpK4cXchWBGbgLbE3elb
        mEBsEQEPibZ/95hBipgFfjFJ7Pt7gxEkISzgLfFn+gxmEJtFQFXi04ePYA28AjYSj//2skFs
        kJdYveEA8wRGngWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIDWUtrB+OeVR/0
        DjEycTAeYpTgYFYS4S3If5UoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTU
        gtQimCwTB6dUA5OjgfXF/edn/b7DXF1zraHj035FK5Uzz7Z8sLZ99zLjQr1XmbzkksMlFZ9C
        fz2YZN3xRCx0k+8fqUWrjh388lzh5Az5e2kunw+m8ir/qlug2HdPUHziyma7X6cWVObuePl3
        7u9LNYWdi01upZpIhX38lcUipLbzyQmb1Ztmp+97YrH4wMt5SxN2pF5YEPctf1Help8tBvvv
        r1LdKTptmv8FX5uwu7e3XnOX/5AWd+TRFOdokajcgIqQbG6ldYU/+hKb9kwK1Xlv9uHJ1yts
        dReOWl1R2S7fuqjl5DzFhrvsp3q2+7xNToo0fP9LreyydasyuxZb89RFrGVGXyY0n1bYqLHb
        77nopIAlM5dLHc10UmIpzkg01GIuKk4EAKxI8L3TAgAA
X-CMS-MailID: 20220121174016epcas5p347510c17404c703f6b857bc43413ed2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174016epcas5p347510c17404c703f6b857bc43413ed2a
References: <CGME20220121174016epcas5p347510c17404c703f6b857bc43413ed2a@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds basic support for the Tesla Full Self-Driving (FSD)
SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
as well as several IPs.

Patches 1 to 9 provide support for the clock controller
(which is designed similarly to Exynos SoCs).

The remaining changes provide pinmux support, initial device tree support.

- Changes since v2
* Addressed Krzysztof's and Stephen's review comments
* Added Reviewed-by and Acked-by tags
* Rebased on next-20220120

- Changes since v1
* fixed make dt_binding_check error as pointed by Rob
* Addressed Krzysztof's and Rob's review comments
* Added Reviewed-by and Acked-by tags
* Dropped SPI, MCT and ADC from this series (to be posted in small sets)

NOTE: These patches are based on next-20220120

Alim Akhtar (16):
  dt-bindings: add vendor prefix for Tesla
  dt-bindings: clock: Add bindings definitions for FSD CMU blocks
  dt-bindings: clock: Document FSD CMU bindings
  clk: samsung: fsd: Add initial clock support
  clk: samsung: fsd: Add cmu_peric block clock information
  clk: samsung: fsd: Add cmu_fsys0 clock information
  clk: samsung: fsd: Add cmu_fsys1 clock information
  clk: samsung: fsd: Add cmu_imem block clock information
  clk: samsung: fsd: Add cmu_mfc block clock information
  clk: samsung: fsd: Add cam_csi block clock information
  dt-bindings: pinctrl: samsung: Add compatible for Tesla FSD SoC
  pinctrl: samsung: add FSD SoC specific data
  dt-bindings: arm: add Tesla FSD ARM SoC
  arm64: dts: fsd: Add initial device tree support
  arm64: dts: fsd: Add initial pinctrl support
  arm64: defconfig: Enable Tesla FSD SoC

 .../devicetree/bindings/arm/tesla.yaml        |   27 +
 .../bindings/clock/tesla,fsd-clock.yaml       |  198 ++
 .../bindings/pinctrl/samsung-pinctrl.txt      |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    8 +
 arch/arm64/Kconfig.platforms                  |    6 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/tesla/Makefile            |    3 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   39 +
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    |  335 +++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  673 ++++++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/samsung/Kconfig                   |    8 +
 drivers/clk/samsung/Makefile                  |    1 +
 drivers/clk/samsung/clk-fsd.c                 | 1803 +++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 |    1 +
 drivers/clk/samsung/clk-pll.h                 |    1 +
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    |   71 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |    2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |    1 +
 include/dt-bindings/clock/fsd-clk.h           |  150 ++
 21 files changed, 3332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tesla.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
 create mode 100644 arch/arm64/boot/dts/tesla/Makefile
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-evb.dts
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi
 create mode 100644 drivers/clk/samsung/clk-fsd.c
 create mode 100644 include/dt-bindings/clock/fsd-clk.h


base-commit: 7fc5253f5a13271e9df35d6b936ff97b74540a59
-- 
2.25.1

