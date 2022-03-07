Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0C4CFC15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiCGK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbiCGK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:43 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6513DD6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:18:54 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220307101851epoutp02ef48ada9b9a1413173af8eab5aaf2a06~aEe7gBWAb2928629286epoutp02K
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:18:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220307101851epoutp02ef48ada9b9a1413173af8eab5aaf2a06~aEe7gBWAb2928629286epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646648331;
        bh=Kb6tFL38p/51Ujt6kbG9fDPLFNH2AUQdXeP5zu7XRT8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MLsJED6oUS0yCYXQ3St2wrWSVUu1TKSCtzWUOfTaCJDh0/q5Rkz07X3+QcCqD8JN3
         2K7J/pBP6GfFkctOwubdXjs5fgMFZwQiaUpPXP/ipw55fxRDQXI161ODtVYt17crbR
         ngRc5vBdSKH4WLARy0ghST/dBypG15SkTOSghQmo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220307101850epcas2p276defcc566fe19be94606481b05a520b~aEe67hPy-3254732547epcas2p2R;
        Mon,  7 Mar 2022 10:18:50 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KBvZ11TTcz4x9Q9; Mon,  7 Mar
        2022 10:18:49 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.C2.25540.969D5226; Mon,  7 Mar 2022 19:07:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220307101848epcas2p1bc9c7992d4b25f78b37c7ca4672f1066~aEe46fklG2100421004epcas2p15;
        Mon,  7 Mar 2022 10:18:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307101848epsmtrp2932e7d1a9be757cbb9ce5d843af4b1de~aEe45tY8C2681026810epsmtrp2w;
        Mon,  7 Mar 2022 10:18:48 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-93-6225d96936a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.36.03370.80CD5226; Mon,  7 Mar 2022 19:18:48 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220307101848epsmtip27340d16b0ff4b5792184dd4370022f55~aEe4rg4Ew0097100971epsmtip2k;
        Mon,  7 Mar 2022 10:18:48 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: [PATCH v2 0/4] support USB offload feature
Date:   Mon,  7 Mar 2022 19:17:32 +0900
Message-Id: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmuW7mTdUkg9YdbBYvD2labH54hc3i
        zoJpTBZPjixit2hevJ7N4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgcfj
        cl8vk8eCTaUei/e8ZPLYP3cNu0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzuhvPcNc8J6n4uLpiAbGZVxdjBwcEgIm
        ElPaxbsYuTiEBHYwSvyfNpkdwvnEKPHo+lJWCOczo0Tb/S7GLkZOsI7Zx3dBVe1ilPh2/S9U
        1Q9GiYt77jKDzGUT0JL4vhCsQUQgTmJp5yUmkBpmgatMEks2HGMHSQgLGEvMPbieFcRmEVCV
        WHPtKDOIzSvgJvFwwUV2iG1yEjfPdTKDNEsIXGOXuDmlHeoMF4kXB16wQdjCEq+Ob4FqkJL4
        /G4vVLxYYtenViaI5gZGicYHJ5ghEsYSs56BDOIAOklTYv0ufUhgKEscucUCUcEr0bDxN9hI
        ZgE+iY7Df9khSnglOtqEIEqUJaZfnsAKYUtKHHx9jhmixENix2lOkLCQQKxE58HrjBMY5WYh
        rFrAyLiKUSy1oDg3PbXYqMAYHl3J+bmbGMHJT8t9B+OMtx/0DjEycTAeYpTgYFYS4b1/XiVJ
        iDclsbIqtSg/vqg0J7X4EKMpMOgmMkuJJucD029eSbyhiaWBiZmZobmRqYG5kjivV8qGRCGB
        9MSS1OzU1ILUIpg+Jg5OqQam6pkv7SO+KjFvj/ig2sTqL3dbw9agKWDC5qvHGrZeXGKvJ887
        Ofl+bfEj5cbQ1KQF6eJbOOp/iTzVOymhun158P11Oum+MqccVesuruO8YWgQFrxv9Zt4h18N
        /puN33FG9K/7K+rR1u8+78eT++XHFl3RPOraNd1V+F5mg+vH8JCjhn/PbFrrkcQhsuWy2Vs/
        rvNBElWxH/s2l6hxV3cxLD8k+qN1YkMcq35TwqosC3vn5XmfXu5JuqEW96tGZ3GDasu06wx9
        j5/Ebvfc8lDQYLLe54RNK9RT7M/bnnnjK1W8cWqVypzVdsl/bu7U4TeSP9d8su7zwidhl1+p
        nXyQXTlzbfeGuSl/V9ma/1+lxFKckWioxVxUnAgApTzT8wcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSvC7HHdUkg2nNchYvD2labH54hc3i
        zoJpTBZPjixit2hevJ7N4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgcfj
        cl8vk8eCTaUei/e8ZPLYP3cNu0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBl9LeeYS54z1Nx
        8XREA+Myri5GTg4JAROJ2cd3sXcxcnEICexglNh59zcrREJSYuncG+wQtrDE/ZYjrBBF3xgl
        jk/fytzFyMHBJqAl8X0hI0iNiECcxIrLe1hAapgF7jNJnH/3HWyQsICxxNyD68FsFgFViTXX
        jjKD2LwCbhIPF1yEWiAncfNcJ/MERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNz
        NzGCQ09LawfjnlUf9A4xMnEwHmKU4GBWEuG9f14lSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        ha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmg1xBndCdW50npLPo58m9NWiL7+KomNixdO1St30p
        20I0GuImTXhweo1VwHcm8bVt+8LczhmqmvHY8lZtCdD9Mm3ThrZMFadJsz/bTODRvMPEc/hN
        b8b/HR84edluCzbNmvn35jpTQfk28T/LasKvvVz/tMz/0hLevr/ixqnn07X2lTTkKGe3l6sz
        xB/SNSl5/azJev/zZdeW8xYeOmhkfmGxxUyjU0/nt210jn30eEr+n3sej3PmRVe7+L58F6w0
        ucZR6UO5rVcDl9KPledUFx/5fnHdpduqr1RFH54MTrLNE/84LeRQ6392np9brW8xdlffueiY
        fkE3Kvx0+qbzDX938eySKzomE8gw0SxCiaU4I9FQi7moOBEA5DEJ36wCAAA=
X-CMS-MailID: 20220307101848epcas2p1bc9c7992d4b25f78b37c7ca4672f1066
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307101848epcas2p1bc9c7992d4b25f78b37c7ca4672f1066
References: <CGME20220307101848epcas2p1bc9c7992d4b25f78b37c7ca4672f1066@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
That's why this gives vendors flexibilty of memory management.
Several pathches have been merged in AOSP kernel(android12-5.10) and I put
together and split into 3 patches. Plus let me add user(xhci-exynos)
module to see how user could use it. 

To sum up, it's for providing xhci memories to Co-Processor.
It would cover DCBAA, Device Context, Transfer Ring, Event Ring, ERST.
It needs xhci hooks and to export some xhci symbols.

Changes in v2 :
- Fix commit message by adding Signed-off-by in each patch.
- Fix conflict on latest.

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
 drivers/usb/host/xhci.h        |   54 +
 9 files changed, 2545 insertions(+), 28 deletions(-)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

-- 
2.31.1

