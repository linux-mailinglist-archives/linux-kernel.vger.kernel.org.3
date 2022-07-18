Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA5578841
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiGRRW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiGRRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:22:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22DD20BD0;
        Mon, 18 Jul 2022 10:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 989A9B816D4;
        Mon, 18 Jul 2022 17:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C619C341C0;
        Mon, 18 Jul 2022 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658164974;
        bh=4Qf4uY0oktTd//WyjvLyb1YapNMCufZPX8bfRpna8Fw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FKkNKxw/kSvyFnzvgQpX72YSb9C0wtGX2dw4fIAXmH4PuiW1KfVWmvQw7ufO4jw17
         CCIMYspn+W/gj5vVZ0ecOXyXLPHm/lar6IuLDqXPvJvRH17hJhLgXFHKaDD6BhzJ3/
         /BRelt5LBe370HQ7+77hLmEG2GhmkgEdiO9HnS1cQAIcgfiFt3Ydq+beQi//q7gudO
         9vYaMxgMI+okXLTBOHrQhNeulM2Rl4hm5IECw0ieXhVKlWSVkHlfC0Br02d2x75XEO
         0ia8aElEl8j3jewmrubVsUwLCwLxEh5Lf3MfYn5JbAau5ayTV1FFXWluA+hq7fAHli
         qrwQu9hGvA6SA==
Date:   Mon, 18 Jul 2022 18:32:49 +0100
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
Message-ID: <20220718183249.6f411e5c@jic23-huawei>
In-Reply-To: <20220718112446.lucl7omialqri7yv@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
        <20220604145955.2a1108ca@jic23-huawei>
        <20220701115823.vywhifktaxcr72cc@CAB-WSD-L081021.sigma.sbrf.ru>
        <20220713170436.32330fa6@jic23-huawei>
        <20220716162556.2e919bf7@jic23-huawei>
        <20220718112446.lucl7omialqri7yv@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 11:23:59 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Jonathan,
> 
> On Sat, Jul 16, 2022 at 04:25:56PM +0100, Jonathan Cameron wrote:
> > On Wed, 13 Jul 2022 17:04:36 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Fri, 1 Jul 2022 11:59:59 +0000
> > > Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> > >   
> > > > Hello Jonathan,
> > > > 
> > > > This patch has been on the mailing list for one month already, but no
> > > > comments from other IIO reviewers. What do you think we should do with it?
> > > > Is it a helpful change or not?    
> > > 
> > > Given I'm way behind and timing in cycle, I'm probably going to kick this
> > > back to start of the next cycle. Sorry for delay,  
> > Applied to the togreg branch of iio.git.
> > 
> > I'm unlikely to do another pull request this cycle unless there is a delay in
> > the release for some reason (and probably not even if there is), so this
> > is queued up for next cycle.  As such it'll sit exposed only in the testing
> > branch until I rebase on rc1.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Thank you for the patch applied.
> I have one question about the previous already applied patchset
> 
> https://lore.kernel.org/all/20220607183907.20017-1-ddrokosov@sberdevices.ru/
> 
> I see this patchset already merged to linux-next more than a month ago.
> But it's still not available in the linux stable branch. Could you please
> explain what's the problem with this one? Was some bug found during
> linux-next testing stage? Should I fix something?
> 
> Appreciate any help to understand what's I missing.

It's not a fix so it will go in during the merge window in about 2 weeks time.
Won't get backported to Stable though unless we ask for that to happen as it's
not really a fix so I didn't add a marking for it to be picked up for stable
(which would only happen after 5.20-rc1 anyway).

J


> 

