Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867D34D16D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbiCHMHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiCHMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:07:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0494028E02;
        Tue,  8 Mar 2022 04:06:38 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KCYtx4Wm1z6801q;
        Tue,  8 Mar 2022 20:05:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 13:06:10 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 12:06:08 +0000
Date:   Tue, 8 Mar 2022 12:06:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v5 3/8] hisi_ptt: Register PMU device for PTT trace
Message-ID: <20220308120607.000064e6@Huawei.com>
In-Reply-To: <d3b555c1-ed7e-f668-7d81-9cc2dbe6ffba@huawei.com>
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
        <20220308084930.5142-4-yangyicong@hisilicon.com>
        <20220308102157.00003725@Huawei.com>
        <d3b555c1-ed7e-f668-7d81-9cc2dbe6ffba@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 19:13:08 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> On 2022/3/8 18:21, Jonathan Cameron wrote:
> > On Tue, 8 Mar 2022 16:49:25 +0800
> > Yicong Yang <yangyicong@hisilicon.com> wrote:
> >   
> >> Register PMU device of PTT trace, then users can use trace through perf
> >> command. The driver makes use of perf AUX trace and support following
> >> events to configure the trace:
> >>
> >> - filter: select Root port or Endpoint to trace
> >> - type: select the type of traced TLP headers
> >> - direction: select the direction of traced TLP headers
> >> - format: select the data format of the traced TLP headers
> >>
> >> This patch adds the PMU driver part of PTT trace. The perf command support
> >> of PTT trace is added in the following patch.
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>  
> > 
> > It seems to me that you ended up doing both suggestions for
> > how to clean up the remove order when it was meant to be
> > a question of picking one or the other.
> > 
> > Otherwise this looks good to me - so with that tidied up
> >   
> 
> Hi Jonathan,
> 
> Thanks for the comments. I'd like to illustrate the reason why I decide to
> manually unregister the PMU device.
> 
> The DMA buffers are devm allocated when necessary. They're only allocated
> when user is going to use the PTT in the first time after the driver's probe,
> so when driver removal the buffers are released prior to the PMU device's
> unregistration. I think there's a race condition.
> 
> IIUC, The PMU device(as the user interface) should be unregistered first then
> we're safe to free the DMA buffers. But unregister the PMU device by devm
> cannot keep that order.

Ok. Please add a comment in the remove() giving this reasoning.

Jonathan

> 
> Thanks,
> Yicong
> 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> >> ---  
> >   
> >> +
> >> +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
> >> +{
> >> +	u16 core_id, sicl_id;
> >> +	char *pmu_name;
> >> +	u32 reg;
> >> +
> >> +	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
> >> +		.module		= THIS_MODULE,
> >> +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
> >> +		.task_ctx_nr	= perf_sw_context,
> >> +		.attr_groups	= hisi_ptt_pmu_groups,
> >> +		.event_init	= hisi_ptt_pmu_event_init,
> >> +		.setup_aux	= hisi_ptt_pmu_setup_aux,
> >> +		.free_aux	= hisi_ptt_pmu_free_aux,
> >> +		.start		= hisi_ptt_pmu_start,
> >> +		.stop		= hisi_ptt_pmu_stop,
> >> +		.add		= hisi_ptt_pmu_add,
> >> +		.del		= hisi_ptt_pmu_del,
> >> +	};
> >> +
> >> +	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
> >> +	core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
> >> +	sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
> >> +
> >> +	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
> >> +				  sicl_id, core_id);
> >> +	if (!pmu_name)
> >> +		return -ENOMEM;
> >> +
> >> +	return perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);  
> > 
> > As below, you can put back the devm cleanup that you had in v4 now you
> > have modified how the filter cleanup is done to also be devm managed.
> >   
> >> +}
> >> +
> >>  /*
> >>   * The DMA of PTT trace can only use direct mapping, due to some
> >>   * hardware restriction. Check whether there is an IOMMU or the
> >> @@ -303,15 +825,32 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
> >>  
> >>  	pci_set_master(pdev);
> >>  
> >> +	ret = hisi_ptt_register_irq(hisi_ptt);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >>  	ret = hisi_ptt_init_ctrls(hisi_ptt);
> >>  	if (ret) {
> >>  		pci_err(pdev, "failed to init controls, ret = %d.\n", ret);
> >>  		return ret;
> >>  	}
> >>  
> >> +	ret = hisi_ptt_register_pmu(hisi_ptt);
> >> +	if (ret) {
> >> +		pci_err(pdev, "failed to register pmu device, ret = %d", ret);
> >> +		return ret;
> >> +	}
> >> +
> >>  	return 0;
> >>  }
> >>  
> >> +void hisi_ptt_remove(struct pci_dev *pdev)
> >> +{
> >> +	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
> >> +
> >> +	perf_pmu_unregister(&hisi_ptt->hisi_ptt_pmu);  
> > 
> > Now you have the filter cleanup occurring using a devm_add_action_or_reset()
> > there is no need to have a manual cleanup of this - you can
> > use the approach of a devm_add_action_or_reset like you had in v4.
> > 
> > As it is the last call in the probe() order it will be the first one
> > called in the device managed cleanup.
> >   
> >> +}
> >> +  
> > 
> > 
> > .
> >   

