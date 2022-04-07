Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4464F76FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiDGHOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiDGHO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:14:29 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0E63206A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:12:28 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220407071226epoutp035c304e136ec031270effd8a4c3a888cb~ji8BE3DTR2081420814epoutp03V
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:12:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220407071226epoutp035c304e136ec031270effd8a4c3a888cb~ji8BE3DTR2081420814epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649315546;
        bh=l7xJjaagiLTfCODKz8+QKDCkzzsU969u/zrB90J2OgI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CNy6XJCnXD2b3t/C+iOIQAwWSCnS+3+FEO9K6DRW/G7F5fx2fMXeCJp2LtqU14zAL
         vdVP5AxkV6YiGSkb/pt5nJEa5y5i4y7FjEhYnRXkUKNsBaL6IDTMKAaeqIbANhnXXr
         xyKo1dh7U2lHnhTSx8VhpTZ4+0bX3r+lJdJ2f70A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220407071225epcas2p339c2289b6c7c5b32d7fc99e7942bf385~ji8AjpAl61510115101epcas2p3e;
        Thu,  7 Apr 2022 07:12:25 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KYsyc0Z88z4x9Pv; Thu,  7 Apr
        2022 07:12:24 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.26.25540.7DE8E426; Thu,  7 Apr 2022 16:12:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220407071223epcas2p2f25428844528dbd505d1b49e0778133d~ji79_RzF93109231092epcas2p20;
        Thu,  7 Apr 2022 07:12:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220407071223epsmtrp2aa847720b15dccbeb1552341fa698391~ji799ccbE0860608606epsmtrp2_;
        Thu,  7 Apr 2022 07:12:23 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-95-624e8ed7aee4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.96.24342.6DE8E426; Thu,  7 Apr 2022 16:12:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220407071222epsmtip1b87c83bb15ef3fd808e69de7d47aed6e~ji79vSI-K2313523135epsmtip1j;
        Thu,  7 Apr 2022 07:12:22 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3 0/1] tty: serial: samsung: add spin_lock in console_write
Date:   Thu,  7 Apr 2022 16:16:18 +0900
Message-Id: <20220407071619.102249-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTQvd6n1+SwdkXMhYP5m1js7i8X9ui
        efF6NosdDUdYLd7NlbE4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R24PDat6mTz2D93DbvH
        5iX1Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
        aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQv
        XS8vtcTK0MDAyBSoMCE74+rp+SwF31grJv79xNrA+JCli5GTQ0LARKJ5Ti9TFyMXh5DADkaJ
        /5fnM0M4nxgl1sy8CZX5xijRtWoLG0zLpEnz2SESexkllt19ygSSEBL4yCgx91gyiM0moC3x
        ff1iVpAiEYHTjBKHtx8Fc5hBluxq/w7UwcEhLOAj8WyJFkgDi4CqxJymi+wgNq+AnURnbzcT
        xDZ5ie5/f1gg4oISJ2c+AbOZgeLNW2eD3SohcI9d4tyZDqiPXCTWn3oNdaqwxKvjW9ghbCmJ
        z+/2QsWLJY73fGeCaG5glDh75wArRMJYYtazdkaQ45gFNCXW79IHMSUElCWO3ILayyfRcfgv
        O0SYV6KjTQiiUU3i/tRzUNNlJCYdWQl1vofE912HWCDhEyvR1b+JZQKj/Cwk38xC8s0shL0L
        GJlXMYqlFhTnpqcWGxUYw2M1OT93EyM4WWq572Cc8faD3iFGJg7GQ4wSHMxKIrxVuT5JQrwp
        iZVVqUX58UWlOanFhxhNgeE7kVlKNDkfmK7zSuINTSwNTMzMDM2NTA3MlcR5vVI2JAoJpCeW
        pGanphakFsH0MXFwSjUwLVftaFg7Oa9fQnTOi2Ihu8OTPGQPTd3VNGPKr657U/yj3u//5HZV
        SGjC/KUaZzibnVU+1mtdv2nC8SFyt6ZyQYdcyKnqKZJc7IKW92XXPRVbZ2F+e8lqLZslv9KP
        G65YkBOz9KyVeemiGXzqwmEbTl3g8VzHbVFm4xR/lGtR/bXt/g+1SrYlqr99IuvGLaJwpM0/
        8crLyQ3zry7WElF0fuc/R+yTskjz/IqvR7stt889rbbx4+uyl5H9p3ez/X0sce+P2PuV/9d7
        FL29HJzoJmYTXjF1j/CBq8+1uiyWFmcKsbxyfnDZ3qTtI/ME1b21N2fo2m1ovmxpor7DOIAt
        5cC089m+z5hzr3q9ld3yWomlOCPRUIu5qDgRAD8hCEcfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnO71Pr8kg7O7GS0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Nx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3sjtweWxa1cnmsX/uGnaP
        zUvqPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugSvj6un5LAXfWCsm/v3E2sD4kKWLkZNDQsBE
        YtKk+exdjFwcQgK7GSUunOyCSshILH/WxwZhC0vcbznCClH0nlHi3dNmsCI2AW2J7+sXgyVE
        BM4zSkx+/IYNxGEW2MMosWb2d2aQKmEBX4kd/96CjWIRUJWY03SRHcTmFbCT6OztZoJYIS/R
        /e8PC0RcUOLkzCdgNjNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtc
        mpeul5yfu4kRHMJamjsYt6/6oHeIkYmD8RCjBAezkghvVa5PkhBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M0yQVmX2bypeJ38hyqowPKzllGKjkfNRw
        x+Vwe8GuSyaJ8n53+I1/scq/zlBuWez9+MJT3qy4e2o/XlXN3cXFMaF5okHKwh279O/06Qdd
        1Tq/avfjE5Uls826WDKTcn2u5egd8NFeU/bm/Y+iz4E/H/6VeWWk8c0+zuuhd5sWyzqlTxy1
        WmckTSZMdFj8xvHA5m6fmMjXEUInZkSKXTLLWcsn/Dej8blWj7X6vrKomzYePAcuP/vJ4PF7
        TsWG6t2HBD4dCNq2aJbCvnnVH7TNX/DNW7K77aqLyKsXMaaFJiY74/8Hn2JSsWpiZZh70/D4
        G7bdiaKLt61fLcMxr/rFhkSb+PMNVcUvrTdFeT5RYinOSDTUYi4qTgQAOin67tACAAA=
X-CMS-MailID: 20220407071223epcas2p2f25428844528dbd505d1b49e0778133d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220407071223epcas2p2f25428844528dbd505d1b49e0778133d
References: <CGME20220407071223epcas2p2f25428844528dbd505d1b49e0778133d@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When console and printk log are printed at the same time,
they are called through tty driver and console driver concurrently.
In this case, this could lead to potintial issue that
data loss or fifo full.

This issue also occurred with other drivers and has been fixed.
"serial: amba-pl011: lock console writes against interrupts"
 - https://lkml.org/lkml/2012/2/1/495

---
Changes since v2:
 - value of lock is chanaged to true/false

Changes since v1:
 - locked variable type changed bool from int
 - spin_lock() changed to spin_lock_irqsave()

Jaewon Kim (1):
  tty: serial: samsung: add spin_lock for interrupt and console_write

 drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.35.1

