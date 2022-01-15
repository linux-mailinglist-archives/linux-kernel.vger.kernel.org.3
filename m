Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0326348F5B4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 08:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiAOHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 02:40:01 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37448 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229863AbiAOHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 02:39:59 -0500
X-UUID: 991a517948c947e393289d98130031dc-20220115
X-UUID: 991a517948c947e393289d98130031dc-20220115
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1929954255; Sat, 15 Jan 2022 15:39:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 15 Jan 2022 15:39:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 15 Jan 2022 15:39:53 +0800
Message-ID: <fc7207eb9958c487fec5679da73d8f3595cc7bb1.camel@mediatek.com>
Subject: Re: [PATCH v5 25/32] iommu/mtk: Migrate to aggregate driver
From:   Yong Wu <yong.wu@mediatek.com>
To:     Stephen Boyd <swboyd@chromium.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>
Date:   Sat, 15 Jan 2022 15:39:52 +0800
In-Reply-To: <CAE-0n53ao52UX3sJ67UQ3dgj0-DZ0xTeo-NrmW5YVAuXfAnxZw@mail.gmail.com>
References: <20220106214556.2461363-1-swboyd@chromium.org>
         <20220106214556.2461363-26-swboyd@chromium.org>
         <1a3b368eb891ca55c33265397cffab0b9f128737.camel@mediatek.com>
         <CAE-0n53Y3WRy4_QvUm9k9wjjWV7adMDQcK_+1ji4+W25SSeGwg@mail.gmail.com>
         <ff81bc1fe1f1c2060fcf03ba14f1bef584c47599.camel@mediatek.com>
         <CAE-0n53FAHDmCznJ35Xh2aTwXBVwukAM3ioKx8SU9VowSaQSqA@mail.gmail.com>
         <69a10908622512c60790f97942731a8ab989b727.camel@mediatek.com>
         <CAE-0n53ao52UX3sJ67UQ3dgj0-DZ0xTeo-NrmW5YVAuXfAnxZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-14 at 15:30 -0600, Stephen Boyd wrote:
> Quoting Yong Wu (2022-01-14 01:06:31)
> > On Wed, 2022-01-12 at 20:25 -0800, Stephen Boyd wrote:
> > > > 
> > > > [    2.654526] ------------[ cut here ]------------
> > > > [    2.655558] refcount_t: addition on 0; use-after-free.
> > > > 
> > > > After this patch, the aggregate_driver flow looks ok. But our
> > > > driver
> > > > still aborts like this:
> > > > 
> > > > [    2.721316] Unable to handle kernel NULL pointer dereference
> > > > at
> > > > virtual address 0000000000000000
> > > > ...
> > > > [    2.731658] pc :
> > > > mtk_smi_larb_config_port_gen2_general+0xa4/0x138
> > > > [    2.732434] lr : mtk_smi_larb_resume+0x54/0x98
> > > > ...
> > > > [    2.742457] Call trace:
> > > > [    2.742768]  mtk_smi_larb_config_port_gen2_general+0xa4/0x13
> > > > 8
> > > > [    2.743496]  pm_generic_runtime_resume+0x2c/0x48
> > > > [    2.744090]  __genpd_runtime_resume+0x30/0xa8
> > > > [    2.744648]  genpd_runtime_resume+0x94/0x2c8
> > > > [    2.745191]  __rpm_callback+0x44/0x150
> > > > [    2.745669]  rpm_callback+0x6c/0x78
> > > > [    2.746114]  rpm_resume+0x314/0x558
> > > > [    2.746559]  __pm_runtime_resume+0x3c/0x88
> > > > [    2.747080]  pm_runtime_get_suppliers+0x7c/0x110
> > > > [    2.747668]  __driver_probe_device+0x4c/0xe8
> > > > [    2.748212]  driver_probe_device+0x44/0x130
> > > > [    2.748745]  __device_attach_driver+0x98/0xd0
> > > > [    2.749300]  bus_for_each_drv+0x68/0xd0
> > > > [    2.749787]  __device_attach+0xec/0x148
> > > > [    2.750277]  device_attach+0x14/0x20
> > > > [    2.750733]  bus_rescan_devices_helper+0x50/0x90
> > > > [    2.751319]  bus_for_each_dev+0x7c/0xd8
> > > > [    2.751806]  bus_rescan_devices+0x20/0x30
> > > > [    2.752315]  __component_add+0x7c/0xa0
> > > > [    2.752795]  component_add+0x14/0x20
> > > > [    2.753253]  mtk_smi_larb_probe+0xe0/0x120
> > > > 
> > > > This is because the device runtime_resume is called before the
> > > > bind
> > > > operation(In our case this detailed function is
> > > > mtk_smi_larb_bind).
> > > > The issue doesn't happen without this patchset. I'm not sure
> > > > the
> > > > right
> > > > sequence. If we should fix in mediatek driver, the patch could
> > > > be:
> > > 
> > > Oh, the runtime PM is moved around with these patches. The
> > > aggregate
> > > device is runtime PM enabled before the probe is called,
> > 
> > In our case, the component device may probe before the aggregate
> > device. thus the component device runtime PM has already been
> > enabled
> > when aggregate device probe.
> 
> This is always the case. The component device always probes before
> the
> aggregate device because the component device registers with the
> component framework. But the component device can decide to enable
> runtime PM during driver probe or during component bind.
> 
> > 
> > > and there are
> > > supplier links made to each component, so each component is
> > > runtime
> > > resumed before the aggregate probe function is called.
> > 
> > Yes. This is the current flow.
> 
> Got it.
> 
> > 
> > > It means that all
> > > the component drivers need to have their resources ready to power
> > > on
> > > before their component_bind() callback is made.
> > 
> > Sorry, I don't understand here well. In this case, The component
> > drivers prepare the resource for power on in the component_bind
> > since
> > the resource comes from the aggregate driver. Thus, we expect the
> > component_bind run before the runtime resume callback.
> 
> What resource comes from the aggregate device that the component
> device manages in runtime PM?

Here the aggregate device is the iommu device. It knows who enabled the
iommu from the dtsi, then transfers this information to the
component(smi_larb) devices. smi_larb will configure the registers to
enable iommu for these masters in the runtime resume.

> > 
> > Another solution is moving the component's pm_runtime_enable into
> > the
> > component_bind(It's mtk_smi_larb_bind here), then the runtime
> > callback
> > is called after component_bind in which the resource for power on
> > is
> > ready.
> 
> This sounds more correct to me. I'm not an expert on runtime PM
> though
> as I always have to read the code to remember how it works. if the
> device isn't ready for runtime PM until the component bind function
> is
> called then runtime PM shouldn't be enabled on the component device.

Anyway, We should update the SMI driver for this case. I prepare a
patch into this patchset or I send it independently? which way is
better?

The patch could be:

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b883dcc0bbfa..88854c2270a1 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -175,6 +175,8 @@ mtk_smi_larb_bind(struct device *dev, struct device
*master, void *data)
                        larb->larbid = i;
                        larb->mmu = &larb_mmu[i].mmu;
                        larb->bank = larb_mmu[i].bank;
+
+                       pm_runtime_enable(dev);
                        return 0;
                }
        }
@@ -450,7 +452,6 @@ static int mtk_smi_larb_probe(struct
platform_device *pdev)
        if (ret < 0)
                return ret;

-       pm_runtime_enable(dev);
        platform_set_drvdata(pdev, larb);
        ret = component_add(dev, &mtk_smi_larb_component_ops);
        if (ret)

Thanks.

