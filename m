Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F647665C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhLOXQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:16:11 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44562 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhLOXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:16:09 -0500
Received: by mail-oi1-f172.google.com with SMTP id be32so33818657oib.11;
        Wed, 15 Dec 2021 15:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=++wJQfX9SRKTgDa7iRDm4XjqjWaFak1BGA3bq4SdHY8=;
        b=amgBVyhB6CrnasIBRdDbSGBtRuFlXBCAxVShCHiDW65cA8AzgtRo50ir4jugdgs0Aq
         wn4vKhpMjPTY+stSGSUAHTl4DCSeOGVQKdqsqlFnLhiL9dArm5YmRmW94CrFlsrv9Hqy
         K3jcMTtsoP62AiQvGPvWOiLG7gGtII3bEh+i52+k6uekLttKta0pMMm8g2aUqugF7Xdl
         xarGT5mhufbdX6ynjj5VL+QyDLPxxJKH7DePL+9+kEIKJoR0VnRM4dIdSjeBkTC9s5mg
         fVLLWvIkRyGGziJBOzOjS7rtFTUYDQ6iMPb/m8ZcwIYY02DIjW0NRi4anbLX/VAVX93N
         sTjA==
X-Gm-Message-State: AOAM530QaZ9Xwa27LI0GkwN+Cnq9+8Zl+eMpgPMK5qfGcxxKXIGZZhr8
        w9NPYH18G72QK5U53b09UQ==
X-Google-Smtp-Source: ABdhPJzWb+X8AU9phOzqa3L4kDw+icvNMkXfJyKOKnI6KQnWK5fei15LOQROoLYcH56rzggBqu3/sQ==
X-Received: by 2002:a05:6808:3a3:: with SMTP id n3mr1972992oie.81.1639610169310;
        Wed, 15 Dec 2021 15:16:09 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g7sm740166oon.27.2021.12.15.15.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:16:07 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Paul Cercueil <paul@crapouillou.net>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 0/2] usb: musb resource clean-ups
Date:   Wed, 15 Dec 2021 17:07:55 -0600
Message-Id: <20211215230756.2009115-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series reworks the platform device resources of the musb 
child device to avoid using static resources. Setting the parent 
device's DT node on the child device is sufficient for the standard 
resource functions to work.

I ran this thru kernel-ci and didn't see any failures, but I don't know 
if any tested platform uses MUSB driver or if a failure would show up in 
the boot log.

Rob

Rob Herring (2):
  usb: musb: Drop unneeded resource copying
  usb: musb: Set the DT node on the child device

 drivers/usb/musb/am35x.c    |  2 ++
 drivers/usb/musb/da8xx.c    | 20 ++++----------------
 drivers/usb/musb/jz4740.c   |  1 +
 drivers/usb/musb/mediatek.c |  2 ++
 drivers/usb/musb/omap2430.c | 23 ++---------------------
 drivers/usb/musb/ux500.c    | 18 ++----------------
 6 files changed, 13 insertions(+), 53 deletions(-)

-- 
2.32.0

