Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660EC54E24F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377220AbiFPNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377096AbiFPNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:45:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437273120C;
        Thu, 16 Jun 2022 06:45:52 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LP3N46PqQz680Bd;
        Thu, 16 Jun 2022 21:45:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 15:45:49 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 16 Jun
 2022 14:45:48 +0100
Date:   Thu, 16 Jun 2022 14:45:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "yekai(A)" <yekai13@huawei.com>
CC:     Kai Ye via Linux-accelerators 
        <linux-accelerators@lists.ozlabs.org>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
Message-ID: <20220616144547.00003093@Huawei.com>
In-Reply-To: <f4fde630-a2ba-2416-5091-33c510c30593@huawei.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
        <20220614122943.1406-4-yekai13@huawei.com>
        <20220615140249.000077f8@Huawei.com>
        <f4fde630-a2ba-2416-5091-33c510c30593@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...

> >  
> >> +	hw_err->tick_stamp = jiffies;
> >> +	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {  
> >
> > These are ordered (I think). Could take advantage of that by
> > maintaining count of elements in parallel to the list then walking
> > list in right direction + stop when you reach last one to need
> > deleting.
> >  
> 
> thanks, The current list + jiffies solution seems more simple.

If list always remains relatively short then that's probably fine.

> >  
> >> +		if ((hw_err->tick_stamp - err->tick_stamp) / HZ >
> >> +		    SECONDS_PER_HOUR) {
> >> +			list_del(&err->list);
> >> +			kfree(err);
> >> +		} else {
> >> +			count++;
> >> +		}
> >> +	}
> >> +	list_add(&hw_err->list, &qm->uacce_hw_errs);
> >> +
> >> +	if (count >= isolate->hw_err_isolate_hz)
> >> +		atomic_set(&isolate->is_isolate, 1);
> >> +
> >> +	return 0;
> >> +}
> >> +  
> >
> > ...
> >  
> >> +static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
> >> +						const char *buf)
> >> +{
> >> +	struct hisi_qm *qm = uacce->priv;
> >> +	unsigned long val = 0;
> >> +
> >> +#define MAX_ISOLATE_STRATEGY	65535
> >> +
> >> +	if (atomic_read(&qm->uacce_ref))
> >> +		return -EBUSY;
> >> +
> >> +	/* must be set by PF */
> >> +	if (atomic_read(&qm->isolate_data.is_isolate) || uacce->is_vf)  
> >
> > Why is the file visible on the vf?  Hide it or don't register it for vfs.  
> Because VF devices can be registered with UACCE. So this file node can 
> be visited on the vf. We're not sure if someone else's device is the 
> same as qm. So i configure it this way by driver. the 'isolate_strategy' 
> must be set by pf.
> 

If possible have the uacce registration from the driver provide information
on whether this applies to the VF.  Much better to have no file presented
by the VF than one that always returns an error code.

Jonathan

