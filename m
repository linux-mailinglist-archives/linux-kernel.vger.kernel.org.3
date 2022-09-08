Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C575B1D77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiIHMns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiIHMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:43:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F04E6237;
        Thu,  8 Sep 2022 05:43:23 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MNdwd4tlGz6857p;
        Thu,  8 Sep 2022 20:39:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:43:20 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Sep
 2022 13:43:20 +0100
Date:   Thu, 8 Sep 2022 13:43:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220908134319.00005f59@huawei.com>
In-Reply-To: <CAHp75VcAhDPLyS=f07qVyiUY_Bh-ZrovWcajn2UkugQt=OCNNQ@mail.gmail.com>
References: <cover.1662454215.git.cmo@melexis.com>
        <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
        <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
        <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com>
        <CAHp75Vc1a1bguLxX7Laewa9f2k9c38KeOD1zsikmC+3=21MnyQ@mail.gmail.com>
        <CAKv63utCSXVgOP4JkEBQSzDWF_s443a-ZbCd8V4tP9=z461McA@mail.gmail.com>
        <CAHp75VcAhDPLyS=f07qVyiUY_Bh-ZrovWcajn2UkugQt=OCNNQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 16:16:07 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Sep 6, 2022 at 4:04 PM Crt Mori <cmo@melexis.com> wrote:
> > On Tue, 6 Sept 2022 at 14:37, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Tue, Sep 6, 2022 at 1:52 PM Crt Mori <cmo@melexis.com> wrote:  
> > > > On Tue, 6 Sept 2022 at 12:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > >
> > > > > Very good and documented code, thanks!
> > > > > I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
> > > > > (due to pm_ptr() usage).
> > > > > Otherwise, with some nitpicks that wouldn't prevent a green light,
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > >  
> > > > I checked DEFINE_.*_PM_OPS usage around drivers and you either have
> > > > SIMPLE (where you define suspend/resume) or you have RUNTIME (for
> > > > runtime suspend/resume), but never are those two together. So I am a
> > > > bit puzzled how to get this working.  
> > >
> > > The one which suits here is called _DEFINE_DEV_PM_OPS(). But it's
> > > basically the same what you put here with the possible unused case.
> > >  
> > I thought underscore prefixed macros are the ones not to be used
> > directly by drivers. I also found no occurrence in current drivers, so
> > it was not something that was done so far?  
> 
> Looks like... Okay, then let's leave it to the maintainer to decide.
> 

Indeed. Discussion ended up at right place. Don't use _DEFINE_DEV_PM_OPS()
in a driver. The solution here is correct as is.

As a side note, I think _DEFINE_DEV_PM_OPS() is getting removed or redefined
as part of tidying up the missing EXPORT_* cases. (I'm too lazy to find the
patch set but it was for mfd drivers).

Jonathan
