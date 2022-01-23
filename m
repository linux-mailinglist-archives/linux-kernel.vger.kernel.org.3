Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C24974F4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiAWTTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:19:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:44999 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiAWTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:19:40 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220123191938epoutp02e72e7cc99248eafd654080fe1276b3ea~M-H0SAGpE1517915179epoutp02H
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:19:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220123191938epoutp02e72e7cc99248eafd654080fe1276b3ea~M-H0SAGpE1517915179epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965578;
        bh=DsFfey4DK3A1Ho//27/+z58DaPrEa27+FlwKXNLvWtU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=a26iAg40lQi8X+Nq97GbIwXF6r8pBfDy+dIlyn6M857y/6A0+8Q07+bQ1hVRZdoPN
         dsECBmP5CTrBTj3TVWCvuY/uzZ9bfFdZIw0VdnTg8TG4c1KSvXPkeCZNHoTWW8U2qy
         ks+uYZQoTPaJGrYGYY6J6gJksE3PKkUMLI6RrCjM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220123191936epcas5p26c1115af494c399f05bf1d753a4029ac~M-HyvKOc82292122921epcas5p2g;
        Sun, 23 Jan 2022 19:19:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jhjbl2g0yz4x9Pp; Sun, 23 Jan
        2022 19:19:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.37.06423.34AADE16; Mon, 24 Jan 2022 04:19:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220123191930epcas5p2572d936fab64a86238cab945171037d7~M-HssVdrh1893418934epcas5p2h;
        Sun, 23 Jan 2022 19:19:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123191930epsmtrp266334ddc0e2bbd3cfaea1c1d4a301748~M-HsrVOpm2018820188epsmtrp2M;
        Sun, 23 Jan 2022 19:19:30 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-54-61edaa43355b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.C9.08738.14AADE16; Mon, 24 Jan 2022 04:19:29 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191927epsmtip150bc9d9804b88892e59871dc8d37c825~M-Hqi3Ecg0799807998epsmtip1D;
        Sun, 23 Jan 2022 19:19:27 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 00/16] Add support for Tesla Full Self-Driving (FSD) SoC
Date:   Mon, 24 Jan 2022 00:37:13 +0530
Message-Id: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTQ9d51dtEg84lfBYP5m1js/g76Ri7
        xftlPYwW84+cY7XY+PYHk8WUP8uZLDY9vsZq8bHnHqvF5V1z2CxmnN/HZHHq+mc2i0Vbv7Bb
        tO49wm5x+E07q8W/axtZLB5f/8PmIOCxZt4aRo/fvyYxesxq6GXz2LSqk83jzrU9bB6bl9R7
        XDnRxOrRt2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjP2XTvAXHBftuLS7n62BsZm8S5GTg4JAROJJ9uus4HYQgK7GSXm
        TNeBsD8xSpydzdjFyAVkf2aU2HFpOQtMw+ymdjaIxC5Gia2nJzFBOC1MEitPtYGNYhPQlrg7
        fQsTiC0i4CZxo7EDrIhZ4BWTxPV/q8GKhAW8JU7d/csKYrMIqEo0794L1sArYC2xYHMnM8Q6
        eYnVGw4wgzRLCPRySDzp7WaFSLhIvJ2+D8oWlnh1fAs7hC0l8fndXqAFHEB2tkTPLmOIcI3E
        0nnHoF6wlzhwZQ4LSAmzgKbE+l36IGFmAT6J3t9PmCA6eSU62oQgqoEue3cVqlNaYmI3zAEe
        Els+HYKGXKxE47rVzBMYZWYhDF3AyLiKUTK1oDg3PbXYtMAwL7UcHjXJ+bmbGMHpUctzB+Pd
        Bx/0DjEycTAeYpTgYFYS4S3If5UoxJuSWFmVWpQfX1Sak1p8iNEUGEoTmaVEk/OBCTqvJN7Q
        xNLAxMzMzMTS2MxQSZz3dPqGRCGB9MSS1OzU1ILUIpg+Jg5OqQYmXXmWe1tXOO09LzfrU/r/
        zXXH/+1cUmNuvEU1dYVSUdt50VWzw7TCSs635irHNT9pvpMzN9en0PyK4tbwtrz2Qpfbs3Zk
        bHtSMeuDSpK+pGPBvtWbNbu3t5as4o/3bGVZFP22i1dufWMpU82S+kilE9GPbtUZ9E/SVq+f
        4+p2ikO7YPLUmlbO61mKJZNdVucXtiuLGv9PzrDfsyGxtqP+2WlRdX6zK6/VO9ctsnYXkxTS
        WF5ZsVSuYW3hm31+Z5k4+VYXKU7kqi7Ydm5jSaNfpvxkzeONa+su1ORmv20O9XKwni1w5urt
        oOYTmgmHdLVDPuhGMm7y/22xRnHBJKlP+y9d9tvMsFFkV8buYCWW4oxEQy3mouJEALro2MQY
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnK7jqreJBs/PW1g8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWl3fNYbOYcX4fk8Wp65/ZLBZt/cJu
        0br3CLvF4TftrBb/rm1ksXh8/Q+bg4DHmnlrGD1+/5rE6DGroZfNY9OqTjaPO9f2sHlsXlLv
        ceVEE6tH35ZVjB6fN8kFcEZx2aSk5mSWpRbp2yVwZey7doC54L5sxaXd/WwNjM3iXYycHBIC
        JhKzm9rZQGwhgR2MEs2n5SHi0hLXN05gh7CFJVb+ew5kcwHVNDFJXNw8GayBTUBb4u70LUwg
        toiAh0Tbv3vMIEXMAr+YJPb9vcEIkhAW8JY4dfcvK4jNIqAq0bx7L1gDr4C1xILNncwQG+Ql
        Vm84wDyBkWcBI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgMNbS2sG4Z9UHvUOM
        TByMhxglOJiVRHgL8l8lCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1
        CCbLxMEp1cCk9W/irYuqG1c2fbpsE1/uIfV+luAqIYebdV1nF9XLv7H/r3dxr3jWNNa6B04y
        ey9cOjtj4Qe1RObEDytW1W3/MCnJgCv85fEp2nV8ng94HvIcLviqeeE2l2rJK+9Z83uYs97u
        ZFBXS71qb7c/TYDv0zoDg+PxT+aem8d7Mijd6+VB1gPrVnoJf3m97sOMuvozL2Ntrxy0Src/
        sHXTp85P/Geuaz52nzSh5e+r87Oneavn7GHyz9gsKOl6SmbB4fS5++dq3eHlYe696sKUceHx
        iY3KeaFWybM7VZ+wSNizLHnKJvT/UOKUrowYTu93qWaKm1lClu24Wv288JL9jcCzXlOVpn2I
        rKs+Pi1+3w3rKCWW4oxEQy3mouJEABd1kKbSAgAA
X-CMS-MailID: 20220123191930epcas5p2572d936fab64a86238cab945171037d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123191930epcas5p2572d936fab64a86238cab945171037d7
References: <CGME20220123191930epcas5p2572d936fab64a86238cab945171037d7@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds basic support for the Tesla Full Self-Driving (FSD)
SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
as well as several IPs.

Patches 1 to 9 provide support for the clock controller
(which is designed similarly to Exynos SoCs).

The remaining changes provide pinmux support, initial device tree support.

- Changes since v3
* Addressed Stefen's review comments on patch 14/16
* Fixed kernel test robot warning on patch 04/16
* rebsaed this series on Krzysztof's pinmux new binding schema work [1]

- Changes since v2
* Addressed Krzysztof's and Stephen's review comments
* Added Reviewed-by and Acked-by tags
* Rebased on next-20220120

- Changes since v1
* fixed make dt_binding_check error as pointed by Rob
* Addressed Krzysztof's and Rob's review comments
* Added Reviewed-by and Acked-by tags
* Dropped SPI, MCT and ADC from this series (to be posted in small sets)

NOTE: These patches are based on Krzysztof's pinmux for-next branch
      commit = 832ae134ccc1 
[1] https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git/log/?h=for-next

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
 .../bindings/pinctrl/samsung,pinctrl.yaml     |    1 +
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


base-commit: 832ae134ccc1c78a2f5ec81b7010dd24c3c49535
-- 
2.25.1

