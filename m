Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6CD4CECB1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiCFRwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiCFRwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:52:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A1F3E5DB;
        Sun,  6 Mar 2022 09:51:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w4so14454240edc.7;
        Sun, 06 Mar 2022 09:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1sHC6Xk8ZJo08DuzVROXh4Esd+CuhfmZFv4uGHlwk+M=;
        b=EEvkjMNywY4oF2c5mrnpcqCp5FoCPw334cGIv0cmdOBtW81bzJ9LqxFKiV+98acAKV
         0ju3vfoIc2jnStgxoewNjOKNG8wT4f9dMzryh+NCq8xMb3SB6vwq5W6SDVcR5sfHUD2F
         OJiNtcLxwDi9LGrqxvthxHmCsnLIUmixF1tr7eVqIRPYaHNztb9aLhF6dfsd0mpGG8WL
         X0/2TIy2TVaQNxlzNyh6cG1qxJpdBtLWeZzlZMZ2/NUeH3SKKXC2TklGFPsJ+TDZw6Z1
         MPGWgMY32ZzocJ2q8zMuLpZedccQD+UayRt0agOip4/nDYAoFOi9mQU2DPeJCXntAnPK
         8BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1sHC6Xk8ZJo08DuzVROXh4Esd+CuhfmZFv4uGHlwk+M=;
        b=ueVF8xJgBQqjNm4/zz3BtMRa6jaX+yvk5SPRgRWfWbaWX+F49l65tDKWJeIKv8CPFD
         QvmkB0D/0n015JXstEIx3KoZuf438ru/b/+S9cvN4Fphta1apNX63e/2AAy7KIC00cju
         B2fiP6rzXg9Wn1CdpqeUH8+DP+zmb/xenKclfol8J1cpaaKV05OmLUleZstvA47CLSTY
         MsFBok8Fog2dGzB+EC6M4JNlWEf1pr6qIwK3zxwCTGE9T3HIb3Oyn/z3RBT6KMAqtwzQ
         T0JcBhVteI8ugFv5VVFWlGVgkjtUkSDR7/j/S+GQY6R57KuMBxLH1ku+uTFeOxMjChMF
         I4+w==
X-Gm-Message-State: AOAM532gghsDpNEmvqAJHFZ/iAQ4WqEkyoNQ4pXirdaw8U80yvVIaB7K
        jj62Fb4hh1QHLJ94MBZ9YofI5OBIfhZ9z2l7
X-Google-Smtp-Source: ABdhPJyc22m5/ALErbRpRTh2XeUC5yNaZMHuKbVd8vo5meeNd5UuqpZDLskh9+j+VbijF/OjTkI1jg==
X-Received: by 2002:a50:fd0f:0:b0:416:e62:ccec with SMTP id i15-20020a50fd0f000000b004160e62ccecmr7651074eds.300.1646589069555;
        Sun, 06 Mar 2022 09:51:09 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090601d400b006caff964e30sm4052606ejj.19.2022.03.06.09.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 09:51:09 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH 00/26] usb: gadget: remove usage of list iterator past the loop
Date:   Sun,  6 Mar 2022 18:50:08 +0100
Message-Id: <20220306175034.3084609-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ok, let's start here.

This patch set removes any use of the list iterator variable past
the list body. This will allow defining the list iterator variable
within the list_for_each_entry_*() macros to avoid any (invalid)
use after the loop. If no break/goto was hit during list traversal
the list iterator variable would otherwise be a bogus pointer
since it is computed on something that is not actually an element
of the list.

I've basically followed what we discussed in:
https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/

There are some cases where it might be possible to 'ditch' the tmp
variable and refactor the code past the loop into the loop body.
For the sake of keeping the *_dequeue() functions more similar, I've
decided against doing it for some and leaving it in others.

In general there are four use cases after the loop body here:

1) using &req->req in a comparision after the loop
2) using the iterator as a pointer in a comparision after the loop
3) use the &iterator->list to compare with the head to see if the
	loop exits early
4) using the iterator past the loop but using the rc variable to see if the
	loop exits early

Jakob Koschel (26):
  usb: gadget: fsl: remove usage of list iterator past the loop body
  usb: gadget: bdc: remove usage of list iterator past the loop body
  usb: gadget: udc: atmel: remove usage of list iterator past the loop
    body
  usb: gadget: udc: pxa25x: remove usage of list iterator past the loop
    body
  usb: gadget: udc: at91: remove usage of list iterator past the loop
    body
  usb: gadget: goku_udc: remove usage of list iterator past the loop
    body
  usb: gadget: udc: gr_udc: remove usage of list iterator past the loop
    body
  usb: gadget: lpc32xx_udc: remove usage of list iterator past the loop
    body
  usb: gadget: mv_u3d: remove usage of list iterator past the loop body
  usb: gadget: udc: mv_udc_core: remove usage of list iterator past the
    loop body
  usb: gadget: net2272: remove usage of list iterator past the loop body
  usb: gadget: udc: net2280: remove usage of list iterator past the loop
    body
  usb: gadget: omap_udc: remove usage of list iterator past the loop
    body
  usb: gadget: s3c-hsudc: remove usage of list iterator past the loop
    body
  usb: gadget: udc-xilinx: remove usage of list iterator past the loop
    body
  usb: gadget: aspeed: remove usage of list iterator past the loop body
  usb: gadget: configfs: remove using list iterator after loop body as a
    ptr
  usb: gadget: legacy: remove using list iterator after loop body as a
    ptr
  usb: gadget: udc: max3420_udc: remove using list iterator after loop
    body as a ptr
  usb: gadget: tegra-xudc: remove using list iterator after loop body as
    a ptr
  usb: gadget: composite: remove check of list iterator against head
    past the loop body
  usb: gadget: pxa27x_udc: replace usage of rc to check if a list
    element was found
  usb: gadget: udc: s3c2410: replace usage of rc to check if a list
    element was found
  usb: gadget: udc: core: replace usage of rc to check if a list element
    was found
  usb: gadget: dummy_hcd: replace usage of rc to check if a list element
    was found
  usb: gadget: udc: s3c2410: replace usage of rc to check if a list
    element was found

 drivers/usb/gadget/composite.c           | 18 ++++++++++--------
 drivers/usb/gadget/configfs.c            | 20 ++++++++++++--------
 drivers/usb/gadget/legacy/hid.c          | 23 ++++++++++++-----------
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 10 ++++++----
 drivers/usb/gadget/udc/at91_udc.c        | 10 ++++++----
 drivers/usb/gadget/udc/atmel_usba_udc.c  | 11 +++++++----
 drivers/usb/gadget/udc/bdc/bdc_ep.c      | 11 ++++++++---
 drivers/usb/gadget/udc/core.c            | 16 ++++++++++------
 drivers/usb/gadget/udc/dummy_hcd.c       | 11 ++++++-----
 drivers/usb/gadget/udc/fsl_qe_udc.c      | 11 +++++++----
 drivers/usb/gadget/udc/fsl_udc_core.c    | 11 +++++++----
 drivers/usb/gadget/udc/goku_udc.c        | 10 ++++++----
 drivers/usb/gadget/udc/gr_udc.c          | 10 ++++++----
 drivers/usb/gadget/udc/lpc32xx_udc.c     | 10 ++++++----
 drivers/usb/gadget/udc/max3420_udc.c     | 11 +++++++----
 drivers/usb/gadget/udc/mv_u3d_core.c     | 10 ++++++----
 drivers/usb/gadget/udc/mv_udc_core.c     | 10 ++++++----
 drivers/usb/gadget/udc/net2272.c         | 11 ++++++-----
 drivers/usb/gadget/udc/net2280.c         | 11 +++++++----
 drivers/usb/gadget/udc/omap_udc.c        | 10 ++++++----
 drivers/usb/gadget/udc/pxa25x_udc.c      | 11 +++++++----
 drivers/usb/gadget/udc/pxa27x_udc.c      |  9 +++++----
 drivers/usb/gadget/udc/s3c-hsudc.c       | 10 ++++++----
 drivers/usb/gadget/udc/s3c2410_udc.c     | 11 ++++++-----
 drivers/usb/gadget/udc/tegra-xudc.c      | 10 ++++++----
 drivers/usb/gadget/udc/udc-xilinx.c      | 11 +++++++----
 26 files changed, 184 insertions(+), 123 deletions(-)


base-commit: 719fce7539cd3e186598e2aed36325fe892150cf
--
2.25.1

