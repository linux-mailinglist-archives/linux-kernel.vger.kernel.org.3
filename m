Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7645D51D16D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349438AbiEFGhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbiEFGhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:08 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BC66206
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:24 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220506063320epoutp030a407673fad1069641de4bbc5cd10031~scHKDid0B0393303933epoutp03f
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220506063320epoutp030a407673fad1069641de4bbc5cd10031~scHKDid0B0393303933epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651818800;
        bh=UoxbgRPuhct4Fhd+B8dwdlXh1yYrD6h+9jGksHt8h7Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aS97B2EpHqW7kEoKwTU2+BsasVflCNHrpQs2jefSuhdHcjZgWnISVtsi3+CSopauv
         mk2rj/M/sOb7T28w0NDFVN+L+ArwXNPRsD5WoVqXHREbV8JL3NBadPiiK1dpS1h7Nl
         RtHjQznVO3LP3kwxRazdR62PL/V2C4F8MXGXSZ30=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220506063319epcas2p4305144f9691321ff51ed8191f9608f0f~scHJUZcNL0959509595epcas2p4D;
        Fri,  6 May 2022 06:33:19 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Kvgk44LnXz4x9Q2; Fri,  6 May
        2022 06:33:16 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.03.09694.C21C4726; Fri,  6 May 2022 15:33:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220506063316epcas2p197ed75070ed4f4ba29439f5c0def90b4~scHGEUzQX1116211162epcas2p1X;
        Fri,  6 May 2022 06:33:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506063316epsmtrp156daa5c81d0585df92d070d0918eeb4d~scHGDXeDn3084030840epsmtrp1g;
        Fri,  6 May 2022 06:33:16 +0000 (GMT)
X-AuditID: b6c32a48-47fff700000025de-5f-6274c12c394a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.45.11276.B21C4726; Fri,  6 May 2022 15:33:15 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506063315epsmtip2764ef37fc2119eecc5bae8928032a0c7~scHFyLbbR0424804248epsmtip2b;
        Fri,  6 May 2022 06:33:15 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
        EXYNOS ARM ARCHITECTURES), sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com, Daehwan Jung <dh10.jung@samsung.com>
Subject: [PATCH v5 0/6] Add xhci-exynos for Exynos SOC
Date:   Fri,  6 May 2022 15:31:13 +0900
Message-Id: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmua7OwZIkg8fbFS0ezNvGZvF30jF2
        i2NtT9gt7iyYxmRxavlCJovmxevZLObcNLK4+/AHi8Xe11vZLTY9vsZqcXnXHDaLGef3MVks
        WtbKbNFytJ3FonnTFFaLzxseM1p03b3BaDHpoKjF/iteDsIev39NYvT49nUSi8fshossHjtn
        3WX3WLznJZPHplWdbB53ru1h89g/dw27x+Yl9R59W1YxeqzfcpXF4/MmuQCeqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAPlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGa/frGIsOCZS
        se35T5YGxq0CXYycHBICJhJn+maydDFycQgJ7GCUOLv2CxOE84lR4vXt91DON0aJ2efvM8G0
        LN+wnRUisZdR4vmKDijnB6PEnf6v7F2MHBxsAloS3xcygsRFBKYzS5xc08sG4jALnGSWuLxn
        ETvIKGEBM4kZiw4ygtgsAqoSUzY3s4DYvAKuEhd+zGGHWCcncfNcJzNIs4TAFg6JtosXoe5w
        kWhZvBeqSFji1fEtULaUxMv+Nii7WGLXp1YmiOYGRonGByeYIRLGErOetTOCnMosoCmxfpc+
        iCkhoCxx5BbYDcwCfBIdh/+yQ4R5JTrahCAalSWmX57ACmFLShx8fQ5qoIfEh+P32UBsIYFY
        idsnFjBPYJSdhTB/ASPjKkax1ILi3PTUYqMCE3g0JefnbmIEJ1stjx2Ms99+0DvEyMTBeIhR
        goNZSYRXeFZJkhBvSmJlVWpRfnxRaU5q8SFGU2B4TWSWEk3OB6b7vJJ4QxNLAxMzM0NzI1MD
        cyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFINTNwOG04Er70iZOJ9M2K9974dzt7r5F/uzTM+
        k5epU/fjYMxr2615n9cl35/NlzPpN8s69qOHmUw6NthvPLZ/20o3fxnbT1m2O/bxab2d6ZFn
        2BS1rL/c7miyTc/x9pag7I/S7f9NTxyd1fvy7AGNtd39ji7vF17P7wu6fP13Ndv2SW5BDWd5
        bzJPDfr6yqozw/VshPPCqdHvt31/cXCOJ+uxZfHvZq5h6qstTAnI5frDFiiovMqTRXJyz6qT
        3Nf1QisWzXh3bm7dygliKetPPhR/WH+25MKf3M9VyTr/rqVUZC39M7/qqNa0EAGNK97TxNNn
        crgsyZBeb3h9xRzpry1cKzNEPsitUI+csbLCgFmJpTgj0VCLuag4EQCBdfP4PwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvK7OwZIkg8W2Fg/mbWOz+DvpGLvF
        sbYn7BZ3Fkxjsji1fCGTRfPi9WwWc24aWdx9+IPFYu/rrewWmx5fY7W4vGsOm8WM8/uYLBYt
        a2W2aDnazmLRvGkKq8XnDY8ZLbru3mC0mHRQ1GL/FS8HYY/fvyYxenz7OonFY3bDRRaPnbPu
        snss3vOSyWPTqk42jzvX9rB57J+7ht1j85J6j74tqxg91m+5yuLxeZNcAE8Ul01Kak5mWWqR
        vl0CV8brN6sYC46JVGx7/pOlgXGrQBcjJ4eEgInE8g3bWUFsIYHdjBKd+2wg4pISS+feYIew
        hSXutxyBqvnGKPFlRmwXIwcHm4CWxPeFjCBhEYG5zBJbtxZ1MXJxMAucZZb483Q1G0hCWMBM
        Ysaig2BFLAKqElM2N7OA2LwCrhIXfsyBmi8ncfNcJ/MERp4FjAyrGCVTC4pz03OLDQsM81LL
        9YoTc4tL89L1kvNzNzGCw15Lcwfj9lUf9A4xMnEwHmKU4GBWEuEVnlWSJMSbklhZlVqUH19U
        mpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTYUuu5P7aeLM1K9UZqo/rWqbd
        M5Ld3e3+8hWD9PrDX0QmBa996JEoE50y2UBm5sGp8a9WBQZsLl73a9GBruzIrhTW5UKt5TLF
        Wj8DBI5bqKov+p6X+E/N6AbfbyOfzi3/+tff9PbWf6O024np8+/4WvHlEy7t/dusHjXDnfvx
        cWNxrri2NQ3v7UIDnn8oPRRg2HxUkmH5Dc6LNn7qy7blb9n7cv6nm7nn9vVExDvubXt5TjPm
        g969cy92PfXj8FzTNEH4MPMPtmvfOa/uXbJn6/SnU2U+Rll6cs8W0tnCybck5ny14aO+ipka
        3ZYC4Y+3b7Rezta2dtPc6x9X1mXN6VXZOn2rTcbqpd+WPjt+VImlOCPRUIu5qDgRACOopwjq
        AgAA
X-CMS-MailID: 20220506063316epcas2p197ed75070ed4f4ba29439f5c0def90b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220506063316epcas2p197ed75070ed4f4ba29439f5c0def90b4
References: <CGME20220506063316epcas2p197ed75070ed4f4ba29439f5c0def90b4@epcas2p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is for Samsung Exynos xHCI host conroller. It uses xhci
platform driver and extends some functions by xhci hooks and overrides.

This driver supports USB offload which makes Co-processor to use
some memories of xhci. Especially it's useful for USB Audio scenario.
Audio stream would get shortcut because Co-processor directly write/read
data in xhci memories. It could get speed-up using faster memory like SRAM.
That's why this gives vendors flexibilty of memory management. This feature
is done with xhci hooks and overrides.

It supports USB offload only for first connected device. It follows normal
sequence from 2nd device.

Changes in v2 :
- Fix commit message by adding Signed-off-by in each patch.
- Fix conflict on latest.

Changes in v3 :
- Remove export symbols and xhci hooks which xhci-exynos don't need.
- Modify commit message to clarify why it needs to export symbols.
- Check compiling of xhci-exynos.

Changes in v4 :
- Modify commit message to clarify why it needs to export symbols.
- Add a function for override of hc driver in xhci-plat.
- Make xhci-exynos extending xhci-plat by xhci hooks and overrides.
  (vendor_init / vendor_cleanup hooks are useful from here v4)
- Change the term (USB offload -> xhci-exynos) on subject of patches.

Changes in v5 :
- Rename subject of cover-letter.
- Add code in xhci_alloc_segments_for_uram.
- Add code for supporting several devices.
- Move adding xhci_address_device to other commit.
  (usb: host: add some to xhci overrides for xhci-exynos
    -> usb: host: export symbols for xhci-exynos to use xhci hooks)
- Add new commit (usb: dwc3: dwc3-exynos: add host init)

Daehwan Jung (6):
  usb: host: export symbols for xhci-exynos to use xhci hooks
  usb: host: add xhci hooks for xhci-exynos
  usb: host: xhci-plat: support override of hc driver
  usb: host: add some to xhci overrides for xhci-exynos
  usb: host: add xhci-exynos driver
  usb: dwc3: dwc3-exynos: add host init

 drivers/usb/dwc3/dwc3-exynos.c | 100 ++++-
 drivers/usb/host/Kconfig       |   8 +
 drivers/usb/host/Makefile      |   1 +
 drivers/usb/host/xhci-exynos.c | 775 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-hub.c    |   7 +
 drivers/usb/host/xhci-mem.c    | 150 ++++++-
 drivers/usb/host/xhci-plat.c   |  50 ++-
 drivers/usb/host/xhci-plat.h   |   9 +
 drivers/usb/host/xhci-ring.c   |   1 +
 drivers/usb/host/xhci.c        |  90 +++-
 drivers/usb/host/xhci.h        |  57 +++
 11 files changed, 1222 insertions(+), 26 deletions(-)
 create mode 100644 drivers/usb/host/xhci-exynos.c

-- 
2.31.1

