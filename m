Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A790E53E661
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbiFFPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbiFFPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:00:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D63202FB;
        Mon,  6 Jun 2022 08:00:44 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LGxTy051sz68700;
        Mon,  6 Jun 2022 22:59:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 17:00:42 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 16:00:41 +0100
Date:   Mon, 6 Jun 2022 16:00:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/2] iio: accel: bma400: Add support for single and double
 tap events
Message-ID: <20220606160040.000053f8@Huawei.com>
In-Reply-To: <CAM+2EuLdTtXHGR5Oy6ay3yM__LK8Dea2rhXJMBNV35-S9HdmVg@mail.gmail.com>
References: <20220529040153.4878-1-jagathjog1996@gmail.com>
        <20220529040153.4878-3-jagathjog1996@gmail.com>
        <20220604160153.504e96ae@jic23-huawei>
        <CAM+2EuLdTtXHGR5Oy6ay3yM__LK8Dea2rhXJMBNV35-S9HdmVg@mail.gmail.com>
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

On Sun, 5 Jun 2022 10:38:10 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Jonathan and Andy.
> 
> On Sat, Jun 4, 2022 at 8:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun, 29 May 2022 09:31:53 +0530
> > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >  
> > > Add support for single and double tap events based on the tap threshold
> > > value and minimum quite time value between the taps. INT1 pin is used to
> > > interrupt and event is pushed to userspace.
> > >
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>  
> >
> > Hi Jagath,
> >
> > A few comments inline.
> >
> > Thanks,
> >
> > Jonathan



> > > +
> > > +     /*
> > > +      * acc_filt1 is the data source for the tap interrupt and it is
> > > +      * operating on an input data rate of 200Hz.
> > > +      */
> > > +     if (!data->tap_event_en) {  
> >
> > Feels like checking the wrong thing.  If we need 200Hz, check if the
> > data rate is at 200Hz rather than if the tap_event is not enabled.
> > Obviously same result, but one seems more obvious.  
> 
> if (!data->tap_event_en)
> This checking is to make sure not to execute
> bma400_set_accel_output_data_rate() function while disabling the
> tap event to avoid the negative (-EBUSY) return value from the
> function bma400_set_accel_output_data_rate() when either of
> the tap is enabled.

Ah. Fair enough. It's a little odd looking though. You could push
the check out of bma400_set_accel_output_data_rate() and into
write_raw though would need to be within the lock to avoid potential
race conditions.  Perhaps just not worth the effort.

Jonathan


