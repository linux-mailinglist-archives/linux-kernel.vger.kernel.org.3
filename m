Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B463C47A32E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhLTBEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:04:31 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10345 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235396AbhLTBEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:04:30 -0500
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; 
   d="scan'208";a="104020185"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2021 10:04:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 505DB416745A;
        Mon, 20 Dec 2021 10:04:26 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/6] usb: sound/soc: Use platform_get_irq*() variants to fetch IRQ's
Date:   Mon, 20 Dec 2021 01:04:05 +0000
Message-Id: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to drop using platform_get_resource() for IRQ types
in preparation for removal of static setup of IRQ resource from DT core
code.

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Note: I have just build tested the patches.

Cheers,
Prabhakar

Lad Prabhakar (6):
  usb: host: fotg210: Use platform_get_irq() to get the interrupt
  usb: renesas_usbhs: Use platform_get_irq() to get the interrupt
  usb: dwc3: Drop unneeded calls to platform_get_resource_byname()
  usb: isp1760: Use platform_get_irq() to get the interrupt
  usb: cdns3: Use platform_get_irq_byname() to get the interrupt
  usb: musb: dsps: Use platform_get_irq_byname() to get the interrupt

 drivers/usb/cdns3/cdns3-plat.c     | 14 ++++++----
 drivers/usb/dwc3/host.c            | 45 +++++++++++++++++-------------
 drivers/usb/host/fotg210-hcd.c     | 11 ++------
 drivers/usb/isp1760/isp1760-if.c   | 16 +++++------
 drivers/usb/musb/musb_dsps.c       | 15 ++++++----
 drivers/usb/renesas_usbhs/common.c | 14 ++++------
 drivers/usb/renesas_usbhs/common.h |  1 -
 drivers/usb/renesas_usbhs/mod.c    | 14 +---------
 8 files changed, 59 insertions(+), 71 deletions(-)

-- 
2.17.1

