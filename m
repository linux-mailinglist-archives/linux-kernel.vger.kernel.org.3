Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D15A7930
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiHaIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHaIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:38:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFD19BB70
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:38:15 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHcsw1khDz67mY4;
        Wed, 31 Aug 2022 16:34:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 10:38:12 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 09:38:11 +0100
Date:   Wed, 31 Aug 2022 09:38:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [jic23-iio:testing 124/129] drivers/iio/accel/msa311.c:993:24:
 warning: format specifies type 'unsigned char' but the argument has type
 'unsigned int'
Message-ID: <20220831093810.00006112@huawei.com>
In-Reply-To: <20220831002405.m3j5sug2rz7bdz5s@Rockosov-MBP>
References: <202208290618.wU7mHfOp-lkp@intel.com>
        <20220830110329.00000d18@huawei.com>
        <CAHp75VfA=w+Q2ccdTiQXeWRw0wSjbkUf6J3+tp-kE50mxdkTNg@mail.gmail.com>
        <20220831002405.m3j5sug2rz7bdz5s@Rockosov-MBP>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Wed, 31 Aug 2022 03:24:05 +0300
Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Hello Jonathan and Andy,
> 
> Sorry for such a late response, a couple of days ago my daughter was born.
> So I couldn't reach my laptop :)

Congratulations and good luck! :)

> 
> Please find my thoughts below.
> 
> > > > >> drivers/iio/accel/msa311.c:993:24: warning: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Wformat]  
> > > >                                               "msa311-%hhx", partid);
> > > >                                                       ~~~~   ^~~~~~
> > > >                                                       %x
> > > >    1 warning generated.  
> >   
> > > >    992                msa311->chip_name = devm_kasprintf(dev, GFP_KERNEL,  
> > > >  > 993                                                   "msa311-%hhx", partid);  
> >   
> > > I'm thinking intent here was to limit range of what was printed. Maybe better to use
> > > local u8 variable or cast?
> > >
> > > I can fix it up if that's fine with you - or even better send me a patch that fixes
> > > it however you prefer!  
> > 
> > Looking back at what Linus said about those specifiers, I would rather
> > go with simple %x or %02x.
> > 
> > P.S. Surprisingly many C developers don't know the difference between
> > %hhx and %02x, which is easy to check by
> > 
> >   char a = -1;
> >   printf("%hhx <==> %02x\n", a, a);
> >   a = 217;
> >   printf("%hhx <==> %02x\n", a, a);  
> 
> Thank you for pointing to Linus answer. I have explored it at the link:
> 
> https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> 
> Actually, Linus described one exception to this rule, which I have
> in my patch. I have an integer which I want to print as a char.
> I see that Linus mentions it's a bad idea. I agree with that. But
> currently %hhx => %02x replacement breaks the requested behavior, %02x
> will not shrink integer value to char. I want to say, maybe it's better
> just cast the value to u8 type and print as %x. What do you think? I can
> prepare such a patch.
> 
> P.S. Andy's example to show the difference between %hhx and %02x makes
> more clear why such a replacement is not acceptable here.
> 
> Output:
> ff <==> ffffffff
> d9 <==> ffffffd9
> 
In this case the storage is an unsigned int, not an unsigned char.
Hence the value will be small and positive.  So I'm fairly sure you
won't hit the above because it's

0x000000ff --> ff
0x000000d9 --> d9

The range is limited to 8 bits because that's all the underlying register
holds.

Jonathan


