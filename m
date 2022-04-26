Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D577050F97C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbiDZKCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiDZKBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:01:36 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2835DC9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:20:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220426092025epoutp01e3604279bcecce514b8fbd9f1f6c42a2~pZ8MS75aC0647706477epoutp01t
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:20:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220426092025epoutp01e3604279bcecce514b8fbd9f1f6c42a2~pZ8MS75aC0647706477epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650964825;
        bh=6J4ihhsPsB5BL31c5ThtRphFZfjCPfVkfFHzf+KlIJo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EsW4DIdv+Xl0fiaLhqDFjM6MxxAUIvXIQBeC4ktYAPzWnh5AdejwQ8VxBCZwGolm6
         kSblix20rzsAopEk5BYtQ0S7yzxJ5IsR0tyCddrTiFUvKiunfCUbC3tBbDtNJYSby4
         yW4cCWkSSrQZ8jzolQ1MfO28woaGMSD/OHHNxuUg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220426092025epcas2p36ee5e4fb4c5603e8c43ebd0ae1fa1703~pZ8L6GMwG1096610966epcas2p3h;
        Tue, 26 Apr 2022 09:20:25 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KnbvT6VSMz4x9Pt; Tue, 26 Apr
        2022 09:20:21 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.27.10028.459B7626; Tue, 26 Apr 2022 18:20:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a~pZ8GoDg-v1542715427epcas2p2X;
        Tue, 26 Apr 2022 09:20:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220426092019epsmtrp1ea43592b25a40d170811b03f5c45b950~pZ8GnFaGg2051720517epsmtrp1L;
        Tue, 26 Apr 2022 09:20:19 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-5e-6267b9540d79
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.53.08853.359B7626; Tue, 26 Apr 2022 18:20:19 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092019epsmtip2844f06ca701d179ba95f37b53a64324e~pZ8GdL6RZ2735027350epsmtip2k;
        Tue, 26 Apr 2022 09:20:19 +0000 (GMT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 0/5] add xhci-exynos driver
Date:   Tue, 26 Apr 2022 18:18:43 +0900
Message-Id: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmhW7IzvQkg7c7eS3uLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM6YuvMnY8EHgYp1U46yNDDu5+1i5OSQ
        EDCROPnuK3sXIxeHkMAORol7R5pYIZxPjBLtDbMYIZxvjBJTu3ezwLTc/DSTGcQWEtjLKNEy
        0w3C/sEosfNveBcjBwebgJbE94WMIGERgTiJpZ2XmEDmMAs8YZLY8e4WE0hCWEBP4vn1CWBz
        WARUJd637WQG6eUVcJM4v18EYpWcxM1zncwgvRIC19glVj06AXWDi8S8x2eZIWxhiVfHt7BD
        2FISL/vboOxiiV2fWpkgmhsYJRofnIBqMJaY9aydEWQZs4CmxPpd+iCmhICyxJFbYOOZBfgk
        Og7/ZYcI80p0tAlBNCpLTL88gRXClpQ4+Poc1EAPiYvLlrJDQiFWYl3XPuYJjLKzEOYvYGRc
        xSiWWlCcm55abFRgDI+i5PzcTYzgNKflvoNxxtsPeocYmTgYDzFKcDArifBOVU1LEuJNSays
        Si3Kjy8qzUktPsRoCgyuicxSosn5wESbVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7
        NbUgtQimj4mDU6qBydyvO2Le933brn/vvi+9q4zzQL6f1YZFrvXbBLcfO21gVhmussC4nUPz
        m+TTnTnevTt55p46xHX6mK2P3Et/l6xI8fv//807PZO7ofP6ybD4L8YHmLlu+65aonxK9t79
        R863uhJWzVrw+5T2Ib1jVZvitqnMaZ295eObg9sDojfXvL8492/xzYslL1PzRWY/lt1iKnTd
        QlVG0lzmdfzVu5yiTE9n98T1Wz/cqzg1bOWkXb4ac1fmtx3jP2Xgdss9b9bvsh/HSj/mZ8kf
        +zS9ryyp/t4ef5e5/W6sm29HbHDea5SqkSrhPJ1n6cIVUQGujs8SC/Xnx7pPaTZ8drWqZWeN
        5KyJpR9kHIzq9/UdK1ZiKc5INNRiLipOBAAhKGyM/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvG7wzvQkg81T9S3uLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZUzd+ZOx4INA
        xbopR1kaGPfzdjFyckgImEjc/DSTGcQWEtjNKDFhbzBEXFJi6dwb7BC2sMT9liOsXYxcQDXf
        GCW6+i4CJTg42AS0JL4vZASpERGIk1hxeQ8LiM0s8IZJ4uruJBBbWEBP4vn1CWDzWQRUJd63
        7WQGaeUVcJM4v18EYrycxM1zncwTGHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
        3cQIDjwtzR2M21d90DvEyMTBeIhRgoNZSYR3qmpakhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        C10n44UE0hNLUrNTUwtSi2CyTBycUg1MEycbX1tdzm642onrCLN8u0zIjIRXRyP3l+WtWsLa
        dd1LvSCLbUY9k8bcyqnb5rTOLFwowX0jYMbxw++3tW68sMGq4+9M1utNzBs+LS7uf/b7eKpt
        WeP+rKOtnUk100IKzgQuFzM6JnReckK7sY7It+9bet8p3+4PaSg+36Xu+v2/WueW6xv3neVu
        5Mv7HDpH/Lm97WXF7qPSwpZaLE58QrktKzO7DxWoz6qo6+OtT72qaR3fflv8HsNTJ/Zzm4vb
        /Wf6n9v5Tca6Quz8mffBx86ZfF/4PPPYxWee1oXnvsRXmAt0pKaKv1syY4qo1NbT/s/mr7c7
        Ib6O733ivwnv1mhqpPFofjbXv/bl1X9PJZbijERDLeai4kQAiJYql6sCAAA=
X-CMS-MailID: 20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a
References: <CGME20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is for Samsung Exynos xhci host conroller. It uses xhci-plat
driver mainly and extends some functions by xhci hooks and overrides.

This driver supports USB offload which makes Co-processor to use
some memories of xhci. Especially it's useful for USB Audio scenario.
Audio stream would get shortcut because Co-processor directly write/read
data in xhci memories. It could get speed-up using faster memory like SRAM.
That's why this gives vendors flexibilty of memory management. This feature
is done with xhci hooks and overrides.

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

Daehwan Jung (5):
  usb: host: export symbols for xhci-exynos to use xhci hooks
  usb: host: add xhci hooks for xhci-exynos
  usb: host: xhci-plat: support override of hc driver
  usb: host: add some to xhci overrides for xhci-exynos
  usb: host: add xhci-exynos driver

 drivers/usb/host/Kconfig       |   8 +
 drivers/usb/host/Makefile      |   1 +
 drivers/usb/host/xhci-exynos.c | 567 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-exynos.h |  50 +++
 drivers/usb/host/xhci-hub.c    |   7 +
 drivers/usb/host/xhci-mem.c    | 150 +++++++--
 drivers/usb/host/xhci-plat.c   |  50 ++-
 drivers/usb/host/xhci-plat.h   |   9 +
 drivers/usb/host/xhci-ring.c   |   1 +
 drivers/usb/host/xhci.c        |  90 +++++-
 drivers/usb/host/xhci.h        |  50 +++
 11 files changed, 958 insertions(+), 25 deletions(-)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

-- 
2.31.1

