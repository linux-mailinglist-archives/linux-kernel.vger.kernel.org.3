Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C54F5E31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiDFM21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiDFM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:27:39 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFFB3B38FE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:18:32 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220406081826epoutp0116e56b3ab56f1f8e5efde1387368d843~jQMXKZpTn1340813408epoutp016
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:18:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220406081826epoutp0116e56b3ab56f1f8e5efde1387368d843~jQMXKZpTn1340813408epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649233106;
        bh=p6WjyG0D56W0LsXgoOg+5KDf28ARCj8LZvKlXFfllAA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tdMbJUaF9YSvf0w+99mD5M18K+zcp8N5aIZHiOyzQgEnOiF0Uc+3rU+PC4s59fNYM
         pdoWMTwg9qjYUmE5vrOYfvzM8I0jzrt8n846lNVAn/LAlhY++MBn/w3O2L7LjTTGhf
         sLChbohFrI/6GQkdBkw/mQf0SrU7LZJqKfPSDFQU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220406081825epcas2p1c18bf3794cd10716a60c54d57ff94777~jQMWZm6392685226852epcas2p19;
        Wed,  6 Apr 2022 08:18:25 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KYHTD2MYjz4x9Q8; Wed,  6 Apr
        2022 08:18:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.98.40405.0DC4D426; Wed,  6 Apr 2022 17:18:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220406081823epcas2p3789ef3ac3956e4713dd1b55c8a49fb05~jQMUUFSte1543915439epcas2p3E;
        Wed,  6 Apr 2022 08:18:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220406081823epsmtrp2dff5487decd39d735a18bc684f7e5ecf~jQMUTRpTe2599125991epsmtrp2b;
        Wed,  6 Apr 2022 08:18:23 +0000 (GMT)
X-AuditID: b6c32a46-ba1ff70000009dd5-12-624d4cd0956f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.A4.24342.FCC4D426; Wed,  6 Apr 2022 17:18:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220406081823epsmtip16d40a770200b048ea71f777b57d900f4~jQMUFgwZP2385123851epsmtip1R;
        Wed,  6 Apr 2022 08:18:23 +0000 (GMT)
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
Subject: [PATCH v2 0/1] tty: serial: samsung: add spin_lock in console_write
Date:   Wed,  6 Apr 2022 17:22:15 +0900
Message-Id: <20220406082216.11206-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTXPeCj2+SwfdlXBYP5m1js7i8X9ui
        efF6NosdDUdYLd7NlbE4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R24PDat6mTz2D93DbvH
        5iX1Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
        aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQv
        XS8vtcTK0MDAyBSoMCE7Y+3X/4wFW1gruhc0MDUwrmfpYuTkkBAwkVi16RtzFyMXh5DADkaJ
        3c3nmCCcT4wSJybfYIRwvjFKLNkyD8jhAGtpPx0FEd/LKPHo/mcWCOcjo8Sa7/sYQeayCWhL
        fF+/mBUkISJwmlHi8PajYA4zyJJd7d+ZQKqEBXwkZrTNZAexWQRUJZaf7WcFsXkFbCUWzXsN
        daG8RPe/PywQcUGJkzOfgNnMQPHmrbPBLpcQeMQu8fjmZ6gGF4lFP38xQ9jCEq+Ob2GHsKUk
        Pr/bywZhF0sc7/nOBNHcwChx9s4BVoiEscSsZ+1gjzILaEqs36UP8bOyxJFbUHv5JDoO/2WH
        CPNKdLQJQTSqSdyfeg5quozEpCMrmSBsD4kFjZfA4kICsRKtb04xTmCUn4Xkm1lIvpmFsHcB
        I/MqRrHUguLc9NRiowIjeLQm5+duYgSnSy23HYxT3n7QO8TIxMF4iFGCg1lJhLcq1ydJiDcl
        sbIqtSg/vqg0J7X4EKMpMHwnMkuJJucDE3ZeSbyhiaWBiZmZobmRqYG5kjivV8qGRCGB9MSS
        1OzU1ILUIpg+Jg5OqQamacFlKzICHl9edinw1w1xn5jLSYv0pmree/XleqHdbO9m9ZJrmQF/
        FBgnLmVbtiB/x45/2mZtrxM2zy246eaan5sov+xhUqPcoWns7pMab91cuUlrnc+Rv8UFVROL
        g4unKF6KZKt7wXqtUYMrR1nfVEY/bn7gYZ/kiZdWnlZ0Clp8gOeOeYO5wJRbhyzWf7sQHnBz
        QYm9ktmESQvYV6bNSeFQW/9ZNXKLauhjppcslvO7E/z13RpcVDrWXa98x1X/vfLX9Bqe8D+m
        pZbbLM5NV1rFGjFv49JLpdIbVBq41z577t5c9/HjhOtnd197qVRcKKPTyRAqtYKn4M4h74T9
        Bx4oL1fw/h6hOH3iLpZVSizFGYmGWsxFxYkAldYtcyAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnO55H98kg+9z1C0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Nx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3sjtweWxa1cnmsX/uGnaP
        zUvqPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStj7df/jAVbWCu6FzQwNTCuZ+li5OCQEDCR
        aD8d1cXIxSEksJtR4umMbexdjJxAcRmJ5c/62CBsYYn7LUdYIYreM0qce/IHrIhNQFvi+/rF
        YAkRgfOMEpMfv2EDcZgF9jBKrJn9nRmkSljAR2JG20ywDhYBVYnlZ/tZQWxeAVuJRfNes0Cs
        kJfo/veHBSIuKHFy5hMwmxko3rx1NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytO
        zC0uzUvXS87P3cQIDmAtzR2M21d90DvEyMTBeIhRgoNZSYS3KtcnSYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamDs3jtkV/JTZKzGPq15jTELIlLCuJ
        TVPvgF7Ilp19nhss30dZXBR4ELlqR823Nc0fnznOYW4++DRm3vb1B+NfisdlbHy8syh7gtfH
        ScLGu14wr07Vt7vg59054fdiTtGkiw36+9nC/L0D9iWkiz3jXiB47PjV/hXaJT0n3IOFJXbw
        VTF7xa3YWzhvEp+SR9Wvh39unmJVfmw4/bV5Tq7LtfXOny5NE3AKmrT4kY7D3HMaLfv3+/Rx
        aWheVbBjf79yn2Ofut+0Nmsz15BWHWWTar2DG+6dfNoZI1aoWbejy8e4cWWmzCTejG2dxWdO
        ZM1JuWpySHvRZJMSG74Vq6Od3q5vFu+YmNLYc0n/RpcSS3FGoqEWc1FxIgAjW+vNzwIAAA==
X-CMS-MailID: 20220406081823epcas2p3789ef3ac3956e4713dd1b55c8a49fb05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220406081823epcas2p3789ef3ac3956e4713dd1b55c8a49fb05
References: <CGME20220406081823epcas2p3789ef3ac3956e4713dd1b55c8a49fb05@epcas2p3.samsung.com>
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
 - https://lkml.org/lkml/2012/2/1/495

---
Chnages since v1:
 - locked variable type changed bool from int
 - spin_lock() changed to spin_ock_irqsave()

Jaewon Kim (1):
  tty: serial: samsung: add spin_lock for interrupt and console_write

 drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.35.1

