Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC411576FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiGPPQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:16:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810819C2D;
        Sat, 16 Jul 2022 08:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94F93B80975;
        Sat, 16 Jul 2022 15:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D7AC34114;
        Sat, 16 Jul 2022 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657984564;
        bh=p0ZERu/ntozV2jIJ9K3owHwDHVMMNjdKN6/6/nsZnRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MexK30k8DpvmHYXPEtaJ+RjUzl9lcGG9GS6ClxZPTJIPDtbfJGgJzPH83Jk2zG7sa
         jICbXCCZp5cOXx8P7D5RwrJPUyEgdrgikZ+G3LtTJ9HxtURNe0MQpCBe5nCOA7GZ7j
         +DfVEQgjaQuVyrz2yUjnfhMm6ZYQwa/q0XDhg6lBBWa1CNK3hCzLN/w07zsWFIpgoL
         ExjssNBUldoy8ke9HBv7MTrFxaURvX3VkZiPdio1q4M3d7s+vIDmncdEWD5dI7jcc1
         ADVzGBG9y/rgeBb/mf2Cuo1ETbVPnPawUXQG+vPJo2cqq5xAZbCqX9JAMkh8VW41J8
         Ro/cRUyTpArdQ==
Date:   Sat, 16 Jul 2022 16:25:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] iio: trigger: move trig->owner init to trigger
 allocate() stage
Message-ID: <20220716162556.2e919bf7@jic23-huawei>
In-Reply-To: <20220713170436.32330fa6@jic23-huawei>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
        <20220604145955.2a1108ca@jic23-huawei>
        <20220701115823.vywhifktaxcr72cc@CAB-WSD-L081021.sigma.sbrf.ru>
        <20220713170436.32330fa6@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 17:04:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 1 Jul 2022 11:59:59 +0000
> Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> 
> > Hello Jonathan,
> > 
> > This patch has been on the mailing list for one month already, but no
> > comments from other IIO reviewers. What do you think we should do with it?
> > Is it a helpful change or not?  
> 
> Given I'm way behind and timing in cycle, I'm probably going to kick this
> back to start of the next cycle. Sorry for delay,
Applied to the togreg branch of iio.git.

I'm unlikely to do another pull request this cycle unless there is a delay in
the release for some reason (and probably not even if there is), so this
is queued up for next cycle.  As such it'll sit exposed only in the testing
branch until I rebase on rc1.

Thanks,

Jonathan

> 
> Jonathan
> 
> > 
> > On Sat, Jun 04, 2022 at 02:59:55PM +0100, Jonathan Cameron wrote:  
> > > On Wed, 1 Jun 2022 17:48:32 +0000
> > > Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> > >     
> > > > To provide a new IIO trigger to the IIO core, usually driver executes the
> > > > following pipeline: allocate()/register()/get(). Before, IIO core assigned
> > > > trig->owner as a pointer to the module which registered this trigger at
> > > > the register() stage. But actually the trigger object is owned by the
> > > > module earlier, on the allocate() stage, when trigger object is
> > > > successfully allocated for the driver.
> > > > 
> > > > This patch moves trig->owner initialization from register()
> > > > stage of trigger initialization pipeline to allocate() stage to
> > > > eliminate all misunderstandings and time gaps between trigger object
> > > > creation and owner acquiring.
> > > > 
> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>    
> > > 
> > > Hi Dmitry,
> > > 
> > > I 'think' this is fine, but its in the high risk category that I'd like
> > > to keep it on list for a few weeks before applying.
> > > 
> > > Note I'm still keen that in general we keep the flow such that
> > > we do allocate()/register()/get() as there is no guarantee that the get()
> > > will never do anything that requires the trigger to be registered, even
> > > though that is true today.  Which is another way of saying I'm still
> > > keen we fix up any cases that sneak in after your fix up set dealt with
> > > the current ones.
> > > 
> > > Thanks for following up on this!
> > > 
> > > Jonathan
> > >     
> >   
> 

