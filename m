Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FEE4D1E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349066AbiCHRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348871AbiCHRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58453E0E;
        Tue,  8 Mar 2022 09:19:06 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r13so40808993ejd.5;
        Tue, 08 Mar 2022 09:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9q3WV8lntvCKBr5AGMUQYt2vLNJxP3dIKv5CzuYYyk=;
        b=EomHAnCnZMf+ve0QKtHimO/HaXIZz8c1nmgw5ZV7ou+97SuiYwqDH1fKMGtBRBC9T4
         8EgWeLFW6pRa1r2x/37kcK7Kqle3oV3yvVJ4RNvl2YfaWYz29kCHIgDcdBTZDPIpXAK/
         2H13R/48S5zcbrHDsB1vkNCE5njq1cQX/Jr3CE358rRSgUdAZsIGAapDfiefv1pVrUlb
         q4WfGREMg1O1noSVTtV2kkNx1ERmT8qom4dnGU0SByiefUaC6ZfvUkSe8NOjIHwTyp9o
         NN7oJE2RzFjQO10eJF2o9u147lkL3R21z6K5/KDKmbD8rohoYHFSHS+VI8IkWWN24UfW
         3tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9q3WV8lntvCKBr5AGMUQYt2vLNJxP3dIKv5CzuYYyk=;
        b=Pasu09vkDJT2Ch9C32AstQxc+7RB+uAxmGa+JOL+M9b+Mjy6vA/cQ5z9t4+nS1B0jC
         1hJZLTe7pVQwAwfc46/lFZydOa5L9k4/lEwmuZs8aO1x/WnYCwgG2R8jU1BqDabjUWDB
         oGheG60JQ93DqZgkX174hjxr1rfp2ljNeSmMY+tXCEiMLi0el6oW6cZb216CbBBh9OVu
         DWe/qoOLkVTrR5geFoto3F+247IaEAFJoZ5I3m2dLesBT996+ieplgPXDzYOOUWxO2nN
         NoOhS+4q9kmkktSJ0xhGoREKmWcPFgqOe6HmBNA2oYmEolATiHn5z0/Ri3waNkkkTtkm
         a+yA==
X-Gm-Message-State: AOAM533wBNW5Bi4ENjJfZsgIJMloQtpm5CzuRagJbvRs0LOfol6VQFTW
        Pm3A6LzrQEDPDUQ5W1gHt+Q2BKam6jGd8A==
X-Google-Smtp-Source: ABdhPJzSwQ+91AP4sG3RvTc6d9xsXF4F6ysWcT7GiB3A7tpjSk3n42D3uf4gI2hbc3vQN2Sa3vZDZg==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr13605831ejm.70.1646759945207;
        Tue, 08 Mar 2022 09:19:05 -0800 (PST)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6085044ejb.82.2022.03.08.09.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:19:04 -0800 (PST)
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
Subject: [PATCH v2 00/26] usb: gadget: remove usage of list iterator past the loop
Date:   Tue,  8 Mar 2022 18:17:52 +0100
Message-Id: <20220308171818.384491-1-jakobkoschel@gmail.com>
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

Change since v1:
	- renamed list iterator variable from 'tmp' to 'iter' (Linus)
	- inverted the conditions within the loop (Linus)
	- reverted the check on 'rc' after the loop (Greg & Krzysztof)

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
  usb: gadget: composite: remove usage of list iterator past the loop
    body
  usb: gadget: udc: core: remove usage of list iterator past the loop
    body
  usb: gadget: dummy_hcd: remove usage of list iterator past the loop
    body
  usb: gadget: udc: s3c2410: remove usage of list iterator past the loop
    body

 drivers/usb/gadget/composite.c           | 36 +++++++++++++-----------
 drivers/usb/gadget/configfs.c            | 24 +++++++++-------
 drivers/usb/gadget/legacy/hid.c          | 23 +++++++--------
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 12 ++++----
 drivers/usb/gadget/udc/at91_udc.c        | 12 ++++----
 drivers/usb/gadget/udc/atmel_usba_udc.c  | 13 +++++----
 drivers/usb/gadget/udc/bdc/bdc_ep.c      | 13 ++++++---
 drivers/usb/gadget/udc/core.c            | 20 +++++++------
 drivers/usb/gadget/udc/dummy_hcd.c       | 17 +++++------
 drivers/usb/gadget/udc/fsl_qe_udc.c      | 13 +++++----
 drivers/usb/gadget/udc/fsl_udc_core.c    | 13 +++++----
 drivers/usb/gadget/udc/goku_udc.c        | 12 ++++----
 drivers/usb/gadget/udc/gr_udc.c          | 12 ++++----
 drivers/usb/gadget/udc/lpc32xx_udc.c     | 12 ++++----
 drivers/usb/gadget/udc/max3420_udc.c     | 18 +++++++-----
 drivers/usb/gadget/udc/mv_u3d_core.c     | 12 ++++----
 drivers/usb/gadget/udc/mv_udc_core.c     | 12 ++++----
 drivers/usb/gadget/udc/net2272.c         | 13 +++++----
 drivers/usb/gadget/udc/net2280.c         | 13 +++++----
 drivers/usb/gadget/udc/omap_udc.c        | 12 ++++----
 drivers/usb/gadget/udc/pxa25x_udc.c      | 13 +++++----
 drivers/usb/gadget/udc/pxa27x_udc.c      | 13 +++++----
 drivers/usb/gadget/udc/s3c-hsudc.c       | 12 ++++----
 drivers/usb/gadget/udc/s3c2410_udc.c     | 17 +++++------
 drivers/usb/gadget/udc/tegra-xudc.c      | 12 ++++----
 drivers/usb/gadget/udc/udc-xilinx.c      | 13 +++++----
 26 files changed, 227 insertions(+), 165 deletions(-)


base-commit: 719fce7539cd3e186598e2aed36325fe892150cf
--
2.25.1

