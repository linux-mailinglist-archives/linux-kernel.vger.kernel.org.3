Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30FD4E22DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbiCUJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiCUJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:03:40 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3598FE7B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:02:11 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220321090206epoutp01a1df40e2aabb95e769f5a3f128f43c7f~eWd6wP33i2991429914epoutp01_
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:02:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220321090206epoutp01a1df40e2aabb95e769f5a3f128f43c7f~eWd6wP33i2991429914epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647853326;
        bh=obaOjAdryqP2qc69EQLjpYCegESyjAgiVw6k4cPxyZo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TklZW5x4B/BgVjI9IX3bpjOYVb9QD8su0GiUUGXeRCycEHeT7U/lQw/eO48zEycSb
         PS6+js5QEx3HWUTruuyjIptelRFqVxkTvneSSnr/C2DQp58HCmcqeHM9iv2ipWcb9J
         CVBt5EK6YrjJK4ovhbwYLE/DfzfNjLMCzIL0glE8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220321090206epcas2p31eaf3d1b8e8c000912fd07a0ab4b9796~eWd6VOA1R3112631126epcas2p3R;
        Mon, 21 Mar 2022 09:02:06 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KMTC00ssCz4x9QC; Mon, 21 Mar
        2022 09:02:04 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.81.16040.A0F38326; Mon, 21 Mar 2022 18:02:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c~eWd2xhO1m0731007310epcas2p1J;
        Mon, 21 Mar 2022 09:02:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321090202epsmtrp1b814ddbe0867f61120e1f78fe0ded0d7~eWd2wwwzq2591125911epsmtrp1W;
        Mon, 21 Mar 2022 09:02:02 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-66-62383f0a0288
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.E7.03370.A0F38326; Mon, 21 Mar 2022 18:02:02 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220321090202epsmtip2e1e01a66a4ff88e0e31169705049d6c7~eWd2n55oj1773717737epsmtip2B;
        Mon, 21 Mar 2022 09:02:02 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com
Subject: [PATCH v3 0/4] support USB offload feature
Date:   Mon, 21 Mar 2022 17:59:50 +0900
Message-Id: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmuS6XvUWSwbV16hZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLC
        XEkhLzE31VbJxSdA1y0zB+gwJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFe
        cWJucWleul5eaomVoYGBkSlQYUJ2xrvX11kL/vBVPDgh0sD4g7uLkZNDQsBEovn0M8YuRi4O
        IYEdjBKHbvxgg3A+MUpsmdTFDOF8ZpSYfLwbyOEAa7mymAsivotR4vXVmewgo4QEfjBKNC0x
        BqlhE9CS+L6QESQsIhAnsbTzEhNIPbPAaiaJ9x8vsoEkhAWMJU7d+w/WyyKgKjFlxjqwOK+A
        q8T7k1uYIM6Tk7h5rhPsCAmBc+wSzV8nMkIkXCTubr7JDGELS7w6voUdwpaSeNnfBmUXS+z6
        1MoE0dzAKNH44ARUg7HErGftjCCXMgtoSqzfpQ/xmLLEkVssIBXMAnwSHYf/skOEeSU62oQg
        GpUlpl+ewAphS0ocfH0OaqCHxLTm+dBgiJXYs6STbQKj7CyE+QsYGVcxiqUWFOempxYbFRjB
        oyg5P3cTIzilabntYJzy9oPeIUYmDsZDjBIczEoivIs/mCcJ8aYkVlalFuXHF5XmpBYfYjQF
        htdEZinR5HxgUs0riTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cCk
        ek9ep/vN5e6nx8unz3uWwlY6TaUl4HLz338fz3K/Fmx1uP9G0EY5MuF7bSEHfyYbv3HVyXXH
        /ldeebFku2Tc3L95kz7oqh71Nlu6Xu4qe5/POi/G5Rsf7X3383T/CdPe/68tfgvnNKje7PV6
        8MdM0XJ60ZInygL6zPv+nJg3q9b4rgozC6O64VLOS3mbHx1gZO9ZK/TIK9JHKtlQ/s2twD3v
        Dv6Z9elg1+u0a2arbJ6WxsgZNDHsjdVJkb1s/oBJzSgpnl9z412xPJ4+IxPX3bb31+5W4pD6
        0brWPk+1ZkqHmfFWk4eSBu/bM5fIGfxJvDdpicoWdZ29zloiu9633knP0vvm6e3hffBOBJcS
        S3FGoqEWc1FxIgCol9Za8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXpfL3iLJYO97IYs7C6YxWTw5sojd
        onnxejaL63/eM1q0P7/AZnF51xw2i0XLWpktmjdNYbWYuVbZouvuDUYHLo/Lfb1MHgs2lXos
        3vOSyWP/3DXsHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXx7vV11oI/fBUPTog0MP7g7mLk
        4JAQMJG4spiri5GLQ0hgB6PE3V+rmLsYOYHikhJL595gh7CFJe63HGGFKPrGKHFi8yMmkGY2
        AS2J7wsZQWpEBOIkVlzewwJSwyywkUli0oNLLCAJYQFjiVP3/oMNYhFQlZgyYx0biM0r4Crx
        /uQWJogFchI3z3UyT2DkWcDIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzjMtLR2
        MO5Z9UHvECMTB+MhRgkOZiUR3sUfzJOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCe
        WJKanZpakFoEk2Xi4JRqYBJ6KChzrzG3tkVc87buA4/iXNMLqtfVldtyzF7nPqlbcVup5Dn/
        dfkHqsx52twRpY8MTE62+x45Ybpo9ZUK3r2h0RNWm4pPmPfjSbKly9QW/8n/ZwYvYYu/P1u7
        JaN57vUd+ms/xseu9MibPSv3h7bAWY7dk7mLN4gc+iT1Ie+gcP1pB2lv96DDaa2G65a8+Dvn
        ef/OHwscDi4OOxnR+X9j1Dz/H5dC21feuWwRt99M6nKchb0Xc/XBqICwvZuex09nXX9FSlGi
        /l5f9K6350ovpXM7n5Wb+D7M5bH09fYNqbbnP2U8X7Wyb19hMeuTI10eyybJLdg34WrCJMvY
        bbvmRhx9cTDVIXLz919ZizOUWIozEg21mIuKEwG+n9RaogIAAA==
X-CMS-MailID: 20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c
References: <CGME20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c@epcas2p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v3 :
- Remove export symbols and xhci hooks which xhci-exynos don't need.
- Modify commit message to clarify why it needs to export symbols.
- Check compiling of xhci-exynos.

Daehwan Jung (4):
  usb: host: export symbols for xhci hooks usage
  usb: host: add xhci hooks for USB offload
  usb: host: add some to xhci overrides for USB offload
  usb: host: add xhci-exynos driver

 drivers/usb/host/Kconfig       |   9 +
 drivers/usb/host/Makefile      |   1 +
 drivers/usb/host/xhci-exynos.c | 982 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-exynos.h |  63 +++
 drivers/usb/host/xhci-hub.c    |   7 +
 drivers/usb/host/xhci-mem.c    | 150 ++++-
 drivers/usb/host/xhci-plat.c   |  43 +-
 drivers/usb/host/xhci-plat.h   |   7 +
 drivers/usb/host/xhci-ring.c   |   1 +
 drivers/usb/host/xhci.c        |  90 ++-
 drivers/usb/host/xhci.h        |  50 ++
 11 files changed, 1379 insertions(+), 24 deletions(-)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

-- 
2.31.1

