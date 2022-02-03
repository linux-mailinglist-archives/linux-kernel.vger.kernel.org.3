Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF134A7E25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbiBCDAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:00:08 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:44161 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349085AbiBCDAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:00:07 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220203030005epoutp0305afd1b2432342864093e0e053d1b419~QJ2s2pAwX1330613306epoutp03Y
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:00:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220203030005epoutp0305afd1b2432342864093e0e053d1b419~QJ2s2pAwX1330613306epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643857205;
        bh=VPY4xdN3+juw2xsjAU/pfTNAW2G+JR2rcqmTvV+0eMM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=seTrRcx+PQilVr8sakAzUc5VzEULKt3W2ZXdcMNPRCL8v+R862S82I7eJkTPs4NG/
         dUErtQVkkoOuVFpKyObEhwO9u7oqV3tEMBo1HY+MYqL7N3GU7NWEE083J9vsh9l5Rx
         s0PaTBGPJ43Blh8txtUl6Or7Y13zupBedEFgwToc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220203030004epcas2p42133066e8262f1f2628339641fb21205~QJ2sVK9Hs0692106921epcas2p4H;
        Thu,  3 Feb 2022 03:00:04 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jq3LT5XF0z4x9Q7; Thu,  3 Feb
        2022 03:00:01 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.7F.12141.1354BF16; Thu,  3 Feb 2022 12:00:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220203030000epcas2p2a924a55a5ae60e8685cd62b66a5482f3~QJ2oj0KxE3170731707epcas2p2Y;
        Thu,  3 Feb 2022 03:00:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220203030000epsmtrp2d3b728a1b532a692c4639552d85004c0~QJ2ojBa3x0412104121epsmtrp2v;
        Thu,  3 Feb 2022 03:00:00 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-6c-61fb4531b2a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.59.08738.0354BF16; Thu,  3 Feb 2022 12:00:00 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220203030000epsmtip211817ea3a30b2a4872c0a5bbd3251215~QJ2oZxh5g0268002680epsmtip2B;
        Thu,  3 Feb 2022 03:00:00 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: [PATCH 0/3] support USB offload feature
Date:   Thu,  3 Feb 2022 11:57:31 +0900
Message-Id: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7bCmha6h6+9Eg/UtbBZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yA6fH5b5eJo8Fm0o9Fu95yeSx
        f+4ado++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvM
        TbVVcvEJ0HXLzAG6SUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1ya
        l66Xl1piZWhgYGQKVJiQnfFxjmDBf4GK1gMzmRsYJ/B1MXJySAiYSMxZ1snUxcjFISSwg1Fi
        zo5LUM4nRom+/nZmCOczo8Sre+fYYVqud9+DSuxilHiyYzJUyw9GiTW/v7N0MXJwsAloSXxf
        yAjSICIQJ7G0E2Iss8BUJomOWfdYQBLCAgYSryZeZAaxWQRUJe7/f8cEYvMKuEnM+riQFWKb
        nMTNc51g2yQE9rFLbHv2BeoMF4mn/fuZIGxhiVfHt0DFpSQ+v9vLBmEXS+z61MoE0dzAKNH4
        4AQzRMJYYtazdkaQS5kFNCXW79IHMSUElCWO3AK7jVmAT6Lj8F92iDCvREebEESjssT0yxOg
        TpOUOPj6HNRAD4mOB71gtpBArETrvjfsExhlZyHMX8DIuIpRLLWgODc9tdiowAQeScn5uZsY
        wclMy2MH4+y3H/QOMTJxMB5ilOBgVhLh3bvwe6IQb0piZVVqUX58UWlOavEhRlNgeE1klhJN
        zgem07ySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLpiSWp2ampBalFMH1MHJxSDUwRi6/vrBZ3
        WZRb73um4bzYsTkv50+ZzNwyP+JCTG6xGOPTa4/nn9T8fm7xNDHl9HPTl/Fwza7rOfxpbtCU
        +xXB+/5Psr65x5dBecMyncuBgbv2pLH9mxH1sIjf//HKI10szcvalTtbGFNm3/M8fXpic4PE
        PNXF+++bzl38oUpG8OG/veItd/Xt0p5Kr+j6ofL+6YyfbHnX5y0Jqzzfcql5z7+ghrD1f1Ot
        mppOeH6oif+/knW3TGJ2HXedV9RT30YbnjS3KL/IL1bSP7Jk6tqcGnXXhDG/5jj97V/nnL3T
        VKPyY5yWFpcvWdj1f+JE+ds3Le6+WvPz6yf/91l9f09O7J+ZxdvXlufz9V+kdymXEktxRqKh
        FnNRcSIAKuRkg+8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42LZdlhJXtfA9XeiwZbfBhZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yA6fH5b5eJo8Fm0o9Fu95yeSx
        f+4ado++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK+DhHsOC/QEXrgZnMDYwT+LoYOTkkBEwk
        rnffY+5i5OIQEtjBKNH7/zAjREJSYuncG+wQtrDE/ZYjrBBF3xglTu6+AJTg4GAT0JL4vhCs
        XkQgTmLF5T0sIDXMArOZJDYfvw6WEBYwkHg18SIziM0ioCpx//87JhCbV8BNYtbHhawQC+Qk
        bp7rZJ7AyLOAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZweGlp7WDcs+qD3iFG
        Jg7GQ4wSHMxKIrx7F35PFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFq
        EUyWiYNTqoFpi5G85k7xlbuPySh9y1W8VxliWhC/XFvoufmP4Dqj9EMz1mvMXmT8OnJ53+TJ
        EXorz02fOKtgsme7jbaKX9Tdq+lbjrBN2WmTWZbHqe3A37As9tvTI0cl2dyj9/M7TdEXk1u6
        1fayuaX176bHmoWK5805728+4x4Zel/XelvnmYdlSyUjxcUzp7Ilvg+YFsIR5b2m6H1Rz5VL
        DEKHr/onyeaX86hHGnz51xsrHV0bdtHiyWIu3bKFMjbTNi2szfH4y8QRc1vGsVTxsepEhkzX
        E9Wm3ou6jN8zuj7sNej2cTu3ctX7y108dnIZok7xfjVCE6ac31IomPBrS1lt8AKrh7oTKv5k
        HeaZLSmyVomlOCPRUIu5qDgRAGWiudGeAgAA
X-CMS-MailID: 20220203030000epcas2p2a924a55a5ae60e8685cd62b66a5482f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220203030000epcas2p2a924a55a5ae60e8685cd62b66a5482f3
References: <CGME20220203030000epcas2p2a924a55a5ae60e8685cd62b66a5482f3@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is for USB offload feature, which makes Co-processor to use
some memories of xhci. Especially it's useful for USB Audio scenario.
Audio stream would get shortcut because Co-processor directly write/read
data in xhci memories. It could get speed-up using faster memory like SRAM.
That's why this also gives vendors flexibilty of memory management.
Below pathches have been merged in AOSP kernel(android12-5.10) and I put
together and split into 3 patches.

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
chihhao.chen <chihhao.chen@mediatek.com>)

Daehwan Jung (3):
  usb: host: export symbols for xhci hooks usage
  usb: host: add xhci hooks for USB offload
  usb: host: add some to xhci overrides for USB offload

 drivers/usb/host/xhci-hub.c  |   7 ++
 drivers/usb/host/xhci-mem.c  | 160 ++++++++++++++++++++++++++++++-----
 drivers/usb/host/xhci-plat.c |  43 +++++++++-
 drivers/usb/host/xhci-plat.h |   8 ++
 drivers/usb/host/xhci-ring.c |  22 ++++-
 drivers/usb/host/xhci.c      | 104 ++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  52 ++++++++++++
 7 files changed, 368 insertions(+), 28 deletions(-)

-- 
2.31.1

