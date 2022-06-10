Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49BF545D86
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346845AbiFJHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346795AbiFJHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:32:14 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF820114683
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:32:05 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220610073204epoutp045da324655aa91898b44f14f22190fd93~3MfbHv-g-2654126541epoutp04V
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220610073204epoutp045da324655aa91898b44f14f22190fd93~3MfbHv-g-2654126541epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654846324;
        bh=txhypdCSGxcpzunLj6FnsUocQ8uwPEWPghvi9lfqylE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SbV0HBuDphZSeJJlgk9PcIscy0qTaM87R0B2XZPyd6TS7jXu8Kn+MWzGPOOch5S3C
         zL780ezhttF3+qVMNjJ5y3JlVObPZSEHyfrrKmHg7zAW2heNMS6Gf9KpLremPQptAU
         cbDpw3BxHjW6j1U1F+TAs365fv4vv76tICZL6iN8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220610073203epcas5p48b1d21de23860ce0d8c420bb1c5b7244~3MfaaZ9Vs0315403154epcas5p4-;
        Fri, 10 Jun 2022 07:32:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKCMf3nWFz4x9QK; Fri, 10 Jun
        2022 07:31:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.C4.09762.C63F2A26; Fri, 10 Jun 2022 16:31:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220610073155epcas5p397e45ae128b29d3f99942fddf9afc0a3~3MfThxQSA2825728257epcas5p37;
        Fri, 10 Jun 2022 07:31:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220610073155epsmtrp29ff30484576b9233b60e71ee34d1ab6f~3MfTglCet1438114381epsmtrp2c;
        Fri, 10 Jun 2022 07:31:55 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-c4-62a2f36c7a6c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.3E.08924.B63F2A26; Fri, 10 Jun 2022 16:31:55 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610073153epsmtip132666b6b611e3139683920ed3d69e244~3MfRrOSR92477624776epsmtip1a;
        Fri, 10 Jun 2022 07:31:53 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 0/6] Add support for UFS controller found in FSD SoC
Date:   Fri, 10 Jun 2022 12:59:18 +0530
Message-Id: <20220610072924.12362-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmum7O50VJBh/nKVg8mLeNzeLlz6ts
        FtM+/GS2uLxf22L+kXOsFn0vHjJbbHp8jdXi8q45bBYTVn1jsei+voPNYvnxf0wWi7Z+Ybdo
        3XuE3WLnnRPMDnwel694e2xa1cnmcefaHjaPzUvqPT4+vcXi0bdlFaPH501yHu0HupkCOKKy
        bTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlZSKEvM
        KQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGc8
        vtrCXnCRp+LR7J1sDYzXObsYOTkkBEwkju9dwtLFyMUhJLCbUeLP3gOsEM4nRonnx9vZIZzP
        jBKbtn1hhGmZvbuBCSKxi1Hi5J6TbBBOC5PE7c0PwarYBLQl7k7fAlYlItDMKHGwYxeYwyzQ
        xySx5PZtVpAqYQF3iWPte8A6WARUJVp7trGB2LwCNhIT5hxggtgnL7F6wwFmkGYJga/sEidb
        7rFBJFwk9hx+zwJhC0u8Or6FHcKWkvj8bi9QDQeQ7SGx6I8URDhD4u3y9VA/2EscuDKHBaSE
        WUBTYv0ufZAwswCfRO/vJ0wQnbwSHW1CENWqEs3vrkItkpaY2N3NCmF7SKzq2Qx2pZBArMSJ
        uY3sExhlZiEMXcDIuIpRMrWgODc9tdi0wDgvtRweO8n5uZsYwSlQy3sH46MHH/QOMTJxMB5i
        lOBgVhLhDbi9KEmINyWxsiq1KD++qDQntfgQoykwlCYyS4km5wOTcF5JvKGJpYGJmZmZiaWx
        maGSOK/A/8YkIYH0xJLU7NTUgtQimD4mDk6pBibeck4ttrNZf60e21kt33xeQk7/k3pQybOU
        TynZ6hqG4n90/yn+snq38vCjXidpAekOkR3pb5++ij1Q6DrD7x5Tm5zt1EJ/bY8fu5XWHv1Z
        djauwMYwSXzH04cbH73jOF5mGmfud65Q7iVjyPPdAV/kU82ZTK6vW95p93tqwazGPv5DAZpf
        0yPPHG8Wm6yiFn4pUGnmmtJMTaMm0SkHBfhPuvn4V0nPsmv44zvZ9eiPO5M1TEQPcfPXiv6T
        +ar5tyNuafe6qL+xpwN6eTymTCh+e/s0N6fGp+icMxIefC3TmlbO/HJTiY9v91URzcirH2Mf
        HNp+oUWPc/fTyZapG099uDFzX6wRT031QqV9B5RYijMSDbWYi4oTAZvAZ64KBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSnG7250VJBgsuGls8mLeNzeLlz6ts
        FtM+/GS2uLxf22L+kXOsFn0vHjJbbHp8jdXi8q45bBYTVn1jsei+voPNYvnxf0wWi7Z+Ybdo
        3XuE3WLnnRPMDnwel694e2xa1cnmcefaHjaPzUvqPT4+vcXi0bdlFaPH501yHu0HupkCOKK4
        bFJSczLLUov07RK4Mh5fbWEvuMhT8Wj2TrYGxuucXYycHBICJhKzdzcwdTFycQgJ7GCUaP0/
        kxkiIS1xfeMEdghbWGLlv+dgtpBAE5PEzPu5IDabgLbE3elbmEBsEYF2Ron729lABjELzGKS
        eD/pCSNIQljAXeJY+x4wm0VAVaK1ZxsbiM0rYCMxYc4BJogF8hKrNxxgnsDIs4CRYRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnCQamntYNyz6oPeIUYmDsZDjBIczEoivAG3FyUJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwNQySVMxNrBI
        PODvnG8tP9yS8nsLe4sSchkNDn14sc/qRf2n35sn24of4leaxXXz96+zvg/uqUntD18aJD1z
        Wlpwe7k8v19JhSFHS67nPzELVkEmIbsnm484Fe+OSPY/7sKY+Hnafr778x9PfeEy6xD/Nm+R
        1NJtZ1Q9bBY+FdhkHKJy7H+r+JsDNUYNrNNYOqLv3WwQT2Bl6Nz8ZsvLW8XZt8UexPM+O/Q4
        dH1y2iwLmVLJqqOB97lSrhfOSd37rND1R2u5jN/3ZY/Wn+hy01GaL7rYapJ42haW5sSZezcZ
        mXtUeS+yDFuq2PnrueGaU3N7iqclXihRdrsj5q99sWmKhpH9w7quTU23TQ7WKrEUZyQaajEX
        FScCAGPXBtnBAgAA
X-CMS-MailID: 20220610073155epcas5p397e45ae128b29d3f99942fddf9afc0a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610073155epcas5p397e45ae128b29d3f99942fddf9afc0a3
References: <CGME20220610073155epcas5p397e45ae128b29d3f99942fddf9afc0a3@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for UFS controller found in FSD SoC.
The HCI is almost same as found on other Exynos SoCs with minor
differences. This also adds the required UFS-PHY driver changes.

Patch 2/7: common change to handle different CDR offsets

*Changes since v2:
- Addressed review comments from Chanho
- collected reviewed-by, tested-by tags
- rebased on next-20220609

*Changes since v1:
- Addressed review comments from Bart, Krzysztof, Chanho
- collected Ack-by tags
- rebased on next-20220602


Alim Akhtar (6):
  dt-bindings: phy: Add FSD UFS PHY bindings
  phy: samsung-ufs: move cdr offset to drvdata
  phy: samsung-ufs: add support for FSD ufs phy driver
  dt-bindings: ufs: exynos-ufs: add fsd compatible
  ufs: host: ufs-exynos: add mphy apb clock mask
  ufs: host: ufs-exynos: add support for fsd ufs hci

 .../bindings/phy/samsung,ufs-phy.yaml         |   1 +
 .../bindings/ufs/samsung,exynos-ufs.yaml      |   1 +
 drivers/phy/samsung/Makefile                  |   1 +
 drivers/phy/samsung/phy-exynos7-ufs.c         |   3 +
 drivers/phy/samsung/phy-exynosautov9-ufs.c    |   2 +
 drivers/phy/samsung/phy-fsd-ufs.c             |  58 +++++++
 drivers/phy/samsung/phy-samsung-ufs.c         |   6 +-
 drivers/phy/samsung/phy-samsung-ufs.h         |   3 +-
 drivers/ufs/host/ufs-exynos.c                 | 143 +++++++++++++++++-
 drivers/ufs/host/ufs-exynos.h                 |   1 +
 10 files changed, 216 insertions(+), 3 deletions(-)
 create mode 100644 drivers/phy/samsung/phy-fsd-ufs.c


base-commit: ff539ac73ea559a8c146d99ab14bfcaddd30547a
-- 
2.25.1

