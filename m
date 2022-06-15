Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA754C3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiFOIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345654AbiFOIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:48:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6DB2FE53;
        Wed, 15 Jun 2022 01:48:19 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNJl52Hmbz6H71h;
        Wed, 15 Jun 2022 16:44:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 10:48:15 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 09:48:14 +0100
Date:   Wed, 15 Jun 2022 09:48:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Kai Ye <yekai13@huawei.com>, <herbert@gondor.apana.org.au>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <zhangfei.gao@linaro.org>, <linux-accelerators@lists.ozlabs.org>
Subject: Re: [PATCH v2 2/3] Documentation: add a isolation strategy vfs node
 for uacce
Message-ID: <20220615094813.000026a6@Huawei.com>
In-Reply-To: <YqiCEHTauCoceNNI@kroah.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
        <20220614122943.1406-3-yekai13@huawei.com>
        <YqiCEHTauCoceNNI@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
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

On Tue, 14 Jun 2022 14:41:52 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jun 14, 2022 at 08:29:39PM +0800, Kai Ye wrote:
> > Update documentation describing DebugFS that could help to
> > configure hard error frequency for users in th user space.
> > 
> > Signed-off-by: Kai Ye <yekai13@huawei.com>
> > ---
> >  Documentation/ABI/testing/sysfs-driver-uacce | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> > index 08f2591138af..0c4226364182 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-uacce
> > +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> > @@ -19,6 +19,23 @@ Contact:        linux-accelerators@lists.ozlabs.org
> >  Description:    Available instances left of the device
> >                  Return -ENODEV if uacce_ops get_available_instances is not provided
> >  
> > +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> > +Date:           Jun 2022
> > +KernelVersion:  5.19
> > +Contact:        linux-accelerators@lists.ozlabs.org
> > +Description:    A vfs node that used to configures the hardware  
> 
> What is a "vfs node"?
> 
> > +                error frequency. This frequency is abstract. Like once an hour
> > +                or once a day. The specific isolation strategy can be defined in
> > +                each driver module.  
> 
> No, you need to be specific here and describe the units and the format.
> Otherwise it is no description at all :(

Also, rename it.   A frequency isn't a strategy.  Strategy would be something
like:

* First fault
* Faults in moving time window.
* Faults in fixed time window.

some of which would then need separate controls for the threshold and the
time window - those should be in separate sysfs attributes.

> 
> > +
> > +What:           /sys/class/uacce/<dev_name>/isolate
> > +Date:           Jun 2022
> > +KernelVersion:  5.19  
> 
> 5.19 will not have this change.
> 
> > +Contact:        linux-accelerators@lists.ozlabs.org
> > +Description:    A vfs node that show the device isolated state. The value 0
> > +                means that the device is working. The value 1 means that the
> > +                device has been isolated.  
> 
> What does "working" or "isolated" mean?
> 
> thanks,
> 
> greg k-h

