Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2844C4CCDB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiCDGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiCDGa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:30:56 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29E187E1C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:30:07 -0800 (PST)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220304063003epoutp034774c9b0aa8d3d935ccc89287c704a27~ZGbT0OL8I3139631396epoutp03k
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:30:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220304063003epoutp034774c9b0aa8d3d935ccc89287c704a27~ZGbT0OL8I3139631396epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646375403;
        bh=CKvCa2vSPyn0oS01qQTvoJUugmnl2sj9sBd76lEn4+c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sLCuJjLYXyKVqN8/i0d2+hPruGkEm26PY8a3QQ+H5j/Fy5xXT0XQA7HPxCs0ctjHq
         DoRW4CYcNpz2XNH3bDfCi9t/b+t0uLb9J7/Yld0BCSBEIYfEUFV/2K3TVADBSKDmT1
         iOO0LxkvMdlZ7JXVEQkg2Dv75VIIvZrKye0uBh1M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p3.samsung.com (KnoxPortal) with ESMTP id
        20220304063003epcas3p3feeea73ff75564a4465f17eae9e30a8b~ZGbTXDv4q1385613856epcas3p3u;
        Fri,  4 Mar 2022 06:30:03 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4K8ydR1jKcz4x9Q8; Fri,  4 Mar 2022 06:30:03 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220304062609epcas2p1b9e2720d2d7d66438e1eab92546f46cc~ZGX6EdRoG2921429214epcas2p1k;
        Fri,  4 Mar 2022 06:26:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220304062609epsmtrp24a84fdf2ffa5620f2d6f4a4f7e581639~ZGX6BCAHo1333913339epsmtrp2i;
        Fri,  4 Mar 2022 06:26:09 +0000 (GMT)
X-AuditID: b6c32a29-41fff700000074af-05-6221b101f02d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.B3.29871.101B1226; Fri,  4 Mar 2022 15:26:09 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220304062609epsmtip257c1a7031dbc107493a92be0fac2164b~ZGX5zc92_1782517825epsmtip2f;
        Fri,  4 Mar 2022 06:26:09 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: [PATCH v1 0/4] support USB offload feature
Date:   Fri,  4 Mar 2022 15:23:54 +0900
Message-Id: <1027007693.21646375403236.JavaMail.epsvc@epcpadp3>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvC7jRsUkg88/DCxWHJ7HaPHykKbF
        5odX2CzuLJjGZPHkyCJ2i+bF69ksrv95z2jR/vwCm8XlXXPYLBYta2W2aN40hdVi5lpli667
        NxgdeD0u9/UyeSzYVOqxeM9LJo/9c9ewe7Sc3M/i0bdlFaPH501yAexRXDYpqTmZZalF+nYJ
        XBm31xxlK7ggUtG29RJTA+N3gS5GTg4JAROJH7c/MncxcnEICexmlHhyaBEzREJSYuncG+wQ
        trDE/ZYjrBBF3xglumdcZexi5OBgE9CS+L6QEaRGRCBOYsXlPSwgNcwC/cwSG5pvsYIkhAWM
        JWbsv8YCYrMIqEqcn/4DbAGvgKvEm3/zWCAWyEncPNfJPIGRZwEjwypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOCA1NLcwbh91Qe9Q4xMHIyHGCU4mJVEeC01FZKEeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYLLUvTXnz24u1/f7e/YFbLnC
        aTLXeVaI8xfly94zeS/aORtLdHP/+2EjXbJ36WINpwth0i/fTlnIyfCxpEexu9uf1+6D//yp
        HwTSXptvkcwrmPiPoS3g72MdnmsRKnN+RtnLSCv/rFMxSs3PW71j3jvPkMuHehw4dzR/XG3C
        9vxSVyyP0yQTxf65+Q/7U9/93D8t64jbN5NAtmSexsk777RvuhVpw3TiTOh2LbZTFila73Yd
        eHg8IE1y4svV3U82p/cs40lmc0gONVheseRvUMkLMTH2EsPzLj9FHgZIM60zazC4/UbqxhRW
        VrVU0V9TkuatWZnbZJlctJff+0y71gnG4+o5i8uOTP/tkFDdrsRSnJFoqMVcVJwIAPLB46G3
        AgAA
X-CMS-MailID: 20220304062609epcas2p1b9e2720d2d7d66438e1eab92546f46cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CMS-RootMailID: 20220304062609epcas2p1b9e2720d2d7d66438e1eab92546f46cc
References: <CGME20220304062609epcas2p1b9e2720d2d7d66438e1eab92546f46cc@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is for USB offload feature, which makes Co-processor to use
some memories of xhci. Especially it's useful for USB Audio scenario.
Audio stream would get shortcut because Co-processor directly write/read
data in xhci memories. It could get speed-up using faster memory like SRAM.
That's why this also gives vendors flexibilty of memory management.
Below pathches have been merged in AOSP kernel(android12-5.10) and I put
together and split into 3 patches. Plus let me add user(xhci-exynos) module 
to see how user could use it. 

To sum up, it's for providing xhci memories to Co-Processor.
It would cover DCBAA, Device Context, Tranfer Ring, Event Ring, ERST.
It needs xhci hooks and to export some xhci symbols.

ANDROID: usb: host: fix slab-out-of-bounds in xhci_vendor_get_ops
ANDROID: usb: export built-in tracepoint functions
ANDROID: usb: host: Use old init scheme when hook unavailable
ANDROID: usb: host: free the offload TR by vendor hook
ANDROID: usb: host: xhci: provide function prototype for xhci_address_device
ANDROID: usb: host: add bus_suspend/bus_resume to xhci overrides
ANDROID: usb: host: add address_device to xhci overrides
ANDROID: usb: host: add max packet parameter on alloc_transfer_ring hook
ANDROID: usb: host: add xhci hooks for vendor specific container context
ANDROID: usb: host: export xhci symbols for ring management
ANDROID: usb: host: export additional xhci symbols for ring management
FROMLIST: usb: xhci-plat: add xhci_plat_priv_overwrite
FROMLIST: usb: host: export symbols for xhci hooks usage
FROMLIST: usb: host: add xhci hooks for USB offload

Below are owners of patches.

Howard Yen <howardyen@google.com>
Jack Pham <jackp@codeaurora.org>
Puma Hsu <pumahsu@google.com>
J. Avila <elavila@google.com>
chihhao.chen <chihhao.chen@mediatek.com>

Daehwan Jung (4):
  usb: host: export symbols for xhci hooks usage
  usb: host: add xhci hooks for USB offload
  usb: host: add some to xhci overrides for USB offload
  usb: host: add xhci-exynos module

 drivers/usb/host/xhci-exynos.c | 2025 ++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-exynos.h |  150 +++
 drivers/usb/host/xhci-hub.c    |    7 +
 drivers/usb/host/xhci-mem.c    |  160 ++-
 drivers/usb/host/xhci-plat.c   |   43 +-
 drivers/usb/host/xhci-plat.h   |    8 +
 drivers/usb/host/xhci-ring.c   |   22 +-
 drivers/usb/host/xhci.c        |  104 +-
 drivers/usb/host/xhci.h        |   52 +
 9 files changed, 2543 insertions(+), 28 deletions(-)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

-- 
2.31.1


