Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC65953E6DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbiFFPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiFFPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:13:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B782B25A;
        Mon,  6 Jun 2022 08:13:12 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LGxmK6K06z67PsD;
        Mon,  6 Jun 2022 23:12:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 6 Jun 2022 17:13:10 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 16:13:09 +0100
Date:   Mon, 6 Jun 2022 16:13:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] iio: trigger: move trig->owner init to trigger
 allocate() stage
Message-ID: <20220606161302.000026ed@Huawei.com>
In-Reply-To: <20220606113829.kmiudrofm2s6onpc@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
        <20220604145955.2a1108ca@jic23-huawei>
        <20220606113829.kmiudrofm2s6onpc@CAB-WSD-L081021.sigma.sbrf.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
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

On Mon, 6 Jun 2022 11:37:42 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Jonathan,
> 
> Thank you for comments. I have a several questions about the flow,
> please find them below.
> 
> On Sat, Jun 04, 2022 at 02:59:55PM +0100, Jonathan Cameron wrote:
> > On Wed, 1 Jun 2022 17:48:32 +0000
> > Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> >   
> > > To provide a new IIO trigger to the IIO core, usually driver executes the
> > > following pipeline: allocate()/register()/get(). Before, IIO core assigned
> > > trig->owner as a pointer to the module which registered this trigger at
> > > the register() stage. But actually the trigger object is owned by the
> > > module earlier, on the allocate() stage, when trigger object is
> > > successfully allocated for the driver.
> > > 
> > > This patch moves trig->owner initialization from register()
> > > stage of trigger initialization pipeline to allocate() stage to
> > > eliminate all misunderstandings and time gaps between trigger object
> > > creation and owner acquiring.
> > > 
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>  
> > 
> > Hi Dmitry,
> > 
> > I 'think' this is fine, but its in the high risk category that I'd like
> > to keep it on list for a few weeks before applying.
> >   
> 
> Could you please explain what it means? Do you have some testing branch
> with such dangerous patches or do we need just to wait other developers
> for more points of view? Thanks in advance.

The second - so far I haven't applied it anywhere.

> 
> > Note I'm still keen that in general we keep the flow such that
> > we do allocate()/register()/get() as there is no guarantee that the get()
> > will never do anything that requires the trigger to be registered, even
> > though that is true today.  Which is another way of saying I'm still
> > keen we fix up any cases that sneak in after your fix up set dealt with
> > the current ones.  
> 
> I fully agree with you. I suppose to resolve such a problem we need to
> have some indicators that the trigger is already registered or not.
> From my point of view, trig->list entry fits well to answer this question.
> Trigger is added to the global IIO triggers list during register()
> execution, so we can just check that entry is not empty to make sure that
> trigger is registered.
> 
> I've sent a v2 patch version, where I use trig->list entry empty status to
> warn it:
> 
> https://lore.kernel.org/linux-iio/20220606111316.19265-1-ddrokosov@sberdevices.ru/

Great!

Jonathan

> 
> > 
> > Thanks for following up on this!
> > 
> > Jonathan
> >   
> 

