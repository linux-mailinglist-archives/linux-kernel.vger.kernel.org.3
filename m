Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2576D4F217E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiDEDhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiDEDhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:37:00 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0AB875
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:35:00 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220405033451epoutp017163395101aa761c62120b9cad1bb951~i4reMl0uD1601216012epoutp01c
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:34:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220405033451epoutp017163395101aa761c62120b9cad1bb951~i4reMl0uD1601216012epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649129691;
        bh=qUlOPPIbR6YFqeEuSn7ct6fr2SJy8qYqqBrlE7bN7cI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VsANSiajmWs+9Ls6bbGu+AUcCLLiAqP1FCP4pZwqIbpLT+Gp5Cf02LGa+QX4Sri5g
         +XbphmrJmhlhODErIOkhqEIqnC5SGxfBAeTMfD5SoPxLKJF5m/Kg2jz41pXgDFnTrp
         aKaeASpynf2QLVNJIgCtWtMrwYJCFbTf1uxUdlJo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220405033450epcas2p45d401a8cb68ffb7eec84a252a2f0d68d~i4rdcVowT2398623986epcas2p4J;
        Tue,  5 Apr 2022 03:34:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KXYDT2TXRz4x9Q3; Tue,  5 Apr
        2022 03:34:49 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.5F.10444.9D8BB426; Tue,  5 Apr 2022 12:34:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220405033448epcas2p31f211cf1cd702ad647f75eee36b2d9f4~i4rbnEBH20326203262epcas2p3C;
        Tue,  5 Apr 2022 03:34:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220405033448epsmtrp2b36ff8e652599ca242fac2b6922bcfed~i4rbmUwiH2142621426epsmtrp2c;
        Tue,  5 Apr 2022 03:34:48 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-c4-624bb8d95073
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.95.03370.8D8BB426; Tue,  5 Apr 2022 12:34:48 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220405033448epsmtip2ab440b9b977be13dd7de76aa829f1e0a~i4rbX7byC0875008750epsmtip2_;
        Tue,  5 Apr 2022 03:34:48 +0000 (GMT)
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
Subject: [PATCH 0/1] tty: serial: samsung: add spin_lock in console_write
Date:   Tue,  5 Apr 2022 12:38:53 +0900
Message-Id: <20220405033854.110374-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTTPfmDu8kg0WNfBYP5m1js7i8X9ui
        efF6NosdDUdYLd7NlbE4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R24PDat6mTz2D93DbvH
        5iX1Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
        aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQv
        XS8vtcTK0MDAyBSoMCE749/DW6wFs1gqTmxvYWtg3MDcxcjJISFgIvHhdwtbFyMXh5DADkaJ
        Y8+7GCGcT4wSq3/+ZwWpEhL4zCgx+3EyTMe8s7+YIYp2MUqc+vCeBcL5yCjR93U+I0gVm4C2
        xPf1i1lBEiICpxklDm8/CuYwgyzZ1f6dCaRKWMBTYu2KqSwgNouAqkRD00Z2EJtXwE5i/qI7
        LBD75CW6//1hgYgLSpyc+QTMZgaKN2+dDXaHhMA9doknE9dBNbhIdO6YxQRhC0u8Or6FHcKW
        kvj8bi8bhF0scbwH5AiQ5gZGibN3DrBCJIwlZj1rB/qBA2iDpsT6XfogpoSAssSRW1B7+SQ6
        Dv9lhwjzSnS0CUE0qkncn3oOarqMxKQjK6Eu8JDYcPACCyQYYyU2PX7ONIFRfhaSb2Yh+WYW
        wt4FjMyrGMVSC4pz01OLjQoM4dGanJ+7iRGcLrVcdzBOfvtB7xAjEwfjIUYJDmYlEd6cIM8k
        Id6UxMqq1KL8+KLSnNTiQ4ymwPCdyCwlmpwPTNh5JfGGJpYGJmZmhuZGpgbmSuK8XikbEoUE
        0hNLUrNTUwtSi2D6mDg4pRqYFtVNbhJxC3tc+nvxxPxJW97XJ29VWrjqks3hhwHrH3yri0i0
        vhEZHMrwUD7vidWtfW1TW9jTWheufMmjeV0jMz4hr1RvIvuRh2950tzu+xmerf636uZzOb5b
        CwRXa5ha/Mn9diTxWrjggzmL/gs6fA34tyIx4e/NXHe/2vTX69gM7KMYHrk1Pls24W3ytYL0
        d1IHnu2fqp1VK79k4TqtKyuqGtf88BPkv1UV8HSazqFcn5trLNyOLHPvVN3otOXciQaGV5mP
        Trz55HvwQ96t8HWLv3+c4JBpa3oi7iHPkt1MX22jvlUp3OHPY1zs292Tn2Vt+vvwsvdbV1U/
        rb7nMGm62Fqm8sSa2kMmCtfOnlZiKc5INNRiLipOBACP7d2iIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvO6NHd5JBue/qVs8mLeNzeLyfm2L
        5sXr2Sx2NBxhtXg3V8bi/PkN7BabHl9jtbi8aw6bxYzz+5gszizuZXfg8ti0qpPNY//cNewe
        m5fUe/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGv4e3WAtmsVSc2N7C1sC4gbmLkZNDQsBE
        Yt7ZX0A2F4eQwA5GibNr9jJCJGQklj/rY4OwhSXutxxhhSh6zyixb+YqsCI2AW2J7+sXgyVE
        BM4zSkx+/IYNxGEW2MMosWb2d7AdwgKeEmtXTGUBsVkEVCUamjayg9i8AnYS8xfdYYFYIS/R
        /e8PC0RcUOLkzCdgNjNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHMJaWjsY96z6oHeIkYmD8RCjBAezkghvTpBnkhBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MlgUSXxhf1M4Sini5VWpKzY1Z+jesJ9cW
        hpvPuF006dLVOIVVyffdJEq3sukHPnn//+QygW7vMHP3uG9vdSzyrkksfpzj777mcmPyuWsP
        GDlb/9dfffTm0fxby+1lJRa1dD98a3QvbbKe1bR/Tmkn6myteQVdFzUULRG76vT5XJnIqZmR
        Yp9kXt7N2Vvm+4tjamSw6FtlyzURi7qMXm+dsy/v/VeDVTOzFhutO/h7dvdkPnM/i6hw/S9N
        rBfL7MMUt/XahpjaT/l2boanyu/Va2QT7thsMZfxWsxdH3F3m7HtirkPBCLjns4zPm595NDX
        9mX9tz5UnaqI8Xp+V0xR6vChZGmvEqmHUdvu9Fk9VWIpzkg01GIuKk4EAGhdkEHQAgAA
X-CMS-MailID: 20220405033448epcas2p31f211cf1cd702ad647f75eee36b2d9f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220405033448epcas2p31f211cf1cd702ad647f75eee36b2d9f4
References: <CGME20220405033448epcas2p31f211cf1cd702ad647f75eee36b2d9f4@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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


Jaewon Kim (1):
  tty: serial: samsung: add spin_lock for interrupt and console_write

 drivers/tty/serial/samsung_tty.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.35.1

