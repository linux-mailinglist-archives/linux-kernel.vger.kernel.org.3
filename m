Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7968248E8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiANK4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:56:25 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36024 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240580AbiANK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:56:24 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20E7Rpol007927;
        Fri, 14 Jan 2022 04:56:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=PODMain02222019;
 bh=vcj94tszLeuIxqQwMLbDyTnJ/235NTOVKqL7o/ZSjEI=;
 b=K8I9YeiqAnQtBMaPcKaxVSBXouTq+KQs77I6w3WZ9h6Agt4XW+JB8qvjO84ET58Ey91o
 qz72u6G84AERRG3IHAmdyEeyQ2vLltbg1LhViEfh77jWZQes6jNLqOo+bc6WD1iB78rn
 7pJ+u78dqovq4eMGiY3yhXw6+9HvdhQzVL13IxDOZg9rd7pRz574JfjtA5mFA7WFI64h
 VlsQZqWIdJ3ToknaaKmhU1E7Gzvzgh6yPxXKT8gHekJhkoTd74NCtVTlpT1Zk+zeZ20B
 W5ttycdWrW010l79kJkCZPsybGyxjkeKOEL21FhLrznkU0Lpx2+tpaMwQv7G8vucqcEj sA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3djqcb0uya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jan 2022 04:56:22 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 14 Jan
 2022 10:56:20 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 14 Jan 2022 10:56:20 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 56C562A9;
        Fri, 14 Jan 2022 10:56:20 +0000 (UTC)
Date:   Fri, 14 Jan 2022 10:56:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh@kernel.org>
CC:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: ChipIdea USB regression
Message-ID: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: FP5WiD8EWYA-jLLOFixC6QpjY7Qaoaew
X-Proofpoint-ORIG-GUID: FP5WiD8EWYA-jLLOFixC6QpjY7Qaoaew
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

My Zynq based board stopped booting today, a bisect points to this
patch:

commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")

It looks like it gets stuck in some sort of boot loop of doom:

48 locks held by swapper/0/1:
#0: 42a2c0d8 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x12c/0x15c
#1: 42a41cd8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
#2: 42abdcd8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
#3: 42abd8d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
#4: 42abd4d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
#5: 42abd0d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
#6: 42b00cd8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
#7: 42b008d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x2c/0x164
<snip>
[<40100af4>] (__irq_svc) from [<40920270>] (_raw_spin_unlock_irqrestore+0x30/0x5c)
[<40920270>] (_raw_spin_unlock_irqrestore) from [<40433238>] (klist_next+0x84/0xac)
[<40433238>] (klist_next) from [<40503a5c>] (bus_for_each_drv+0x60/0xbc)
[<40503a5c>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
[<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
[<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)
[<405022b8>] (device_add) from [<4050835c>] (platform_device_add+0xa8/0x1f0)
[<4050835c>] (platform_device_add) from [<405f329c>] (ci_hdrc_add_device+0x3b4/0x434)
[<405f329c>] (ci_hdrc_add_device) from [<405f5f0c>] (ci_hdrc_usb2_probe+0x130/0x180)
[<405f5f0c>] (ci_hdrc_usb2_probe) from [<40507e60>] (platform_probe+0x58/0xa8)
[<40507e60>] (platform_probe) from [<4050584c>] (really_probe+0x1d8/0x418)
[<4050584c>] (really_probe) from [<40505c44>] (__driver_probe_device+0x1b8/0x1f0)
[<40505c44>] (__driver_probe_device) from [<40505ca0>] (driver_probe_device+0x24/0xa4)
[<40505ca0>] (driver_probe_device) from [<405060b0>] (__device_attach_driver+0xbc/0x110)
[<405060b0>] (__device_attach_driver) from [<40503aa4>] (bus_for_each_drv+0xa8/0xbc)
[<40503aa4>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
[<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
[<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)
[<405022b8>] (device_add) from [<4050835c>] (platform_device_add+0xa8/0x1f0)
[<4050835c>] (platform_device_add) from [<405f329c>] (ci_hdrc_add_device+0x3b4/0x434)
[<405f329c>] (ci_hdrc_add_device) from [<405f5f0c>] (ci_hdrc_usb2_probe+0x130/0x180)
[<405f5f0c>] (ci_hdrc_usb2_probe) from [<40507e60>] (platform_probe+0x58/0xa8)
[<40507e60>] (platform_probe) from [<4050584c>] (really_probe+0x1d8/0x418)
[<4050584c>] (really_probe) from [<40505c44>] (__driver_probe_device+0x1b8/0x1f0)
[<40505c44>] (__driver_probe_device) from [<40505ca0>] (driver_probe_device+0x24/0xa4)
[<40505ca0>] (driver_probe_device) from [<405060b0>] (__device_attach_driver+0xbc/0x110)
[<405060b0>] (__device_attach_driver) from [<40503aa4>] (bus_for_each_drv+0xa8/0xbc)
[<40503aa4>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
[<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
[<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)
[<405022b8>] (device_add) from [<4050835c>] (platform_device_add+0xa8/0x1f0)
[<4050835c>] (platform_device_add) from [<405f329c>] (ci_hdrc_add_device+0x3b4/0x434)
[<405f329c>] (ci_hdrc_add_device) from [<405f5f0c>] (ci_hdrc_usb2_probe+0x130/0x180)
[<405f5f0c>] (ci_hdrc_usb2_probe) from [<40507e60>] (platform_probe+0x58/0xa8)
[<40507e60>] (platform_probe) from [<4050584c>] (really_probe+0x1d8/0x418)
[<4050584c>] (really_probe) from [<40505c44>] (__driver_probe_device+0x1b8/0x1f0)
[<40505c44>] (__driver_probe_device) from [<40505ca0>] (driver_probe_device+0x24/0xa4)
[<40505ca0>] (driver_probe_device) from [<405060b0>] (__device_attach_driver+0xbc/0x110)
[<405060b0>] (__device_attach_driver) from [<40503aa4>] (bus_for_each_drv+0xa8/0xbc)
[<40503aa4>] (bus_for_each_drv) from [<40505ea8>] (__device_attach+0xc4/0x164)
[<40505ea8>] (__device_attach) from [<405047e0>] (bus_probe_device+0x28/0x84)
[<405047e0>] (bus_probe_device) from [<405022b8>] (device_add+0x590/0x7c4)

I will keep poking it today to see if I can figure out more of
what is actually going wrong, but if any of you guys had any
thoughts/suggestions or if you want me to provide any additional
info all of those would be greatly appreciated.

Thanks,
Charles
