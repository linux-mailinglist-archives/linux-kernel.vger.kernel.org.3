Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01050CC43
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiDWQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiDWQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:25:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFAD25C7D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=z02aSPrMSCAVo2bRecHxPZns4c36BZS2YhNAHKVWubk=; b=sU/814VjbeVdw/r/UPn9SmEBVp
        1feqmUs1hirqfh1HYZJllXNdVZvPVXMVKZxV1WXO6hRC46Nq8yyOcDFMToj6MvLsbBoqSFAAQxpuW
        Omw4VwfutTQUQmCA/MdR3hpfgjo2/SH0l+4FFmeVe83e9wwHIaTe/qDUCHxqtKU6kVGo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1niIW9-00HATB-FM; Sat, 23 Apr 2022 18:21:53 +0200
Date:   Sat, 23 Apr 2022 18:21:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
Message-ID: <YmQnoQhrcbEzst/J@lunn.ch>
References: <20220421015728.86912-1-nathan@nathanrossi.com>
 <87mtgfgx7d.wl-maz@kernel.org>
 <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
 <87fsm6ahnh.wl-maz@kernel.org>
 <YmFJ4zKn/9MpjhOh@lunn.ch>
 <CA+aJhH1uRWrW1+WJiWoH7pge49gc=SvWQ1L+UpLk+Hin5eo4uQ@mail.gmail.com>
 <YmKdajB8ufVz5meG@lunn.ch>
 <CA+aJhH27-TkorTqKVYBvHLz-8-0Pkbmjvx+aekb-24N75OAAKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aJhH27-TkorTqKVYBvHLz-8-0Pkbmjvx+aekb-24N75OAAKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:58:23PM +1000, Nathan Rossi wrote:
> On Fri, 22 Apr 2022 at 22:19, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > If you have a PCIe device that you can use with the 370 rd.
> >
> > Sorry, nothing on its bus.
> >
> > The only device i have which might make sense testing is a
> > WRT1900ac. That has an Armada XP dual core. I could try building a UP
> > kernel for it, but i guess you have tried that already with your
> > machine in order to test a UP setup?
> 
> I have tested with SMP=n on a Armada 385 without any issues. So no
> need to do that on the Armada XP.
> 
> There is still value in testing on the WRT1900ac device since so far I
> have only tested on a Armada 385. The Armada XP does have
> registers/etc. of the MPIC very similar to the 370, compared to the
> 385 having some significant differences. So if it is not too
> problematic to test on (it appears to have its wifi attached via
> PCIe?) please do.

Hi Nathan

Turns out the WiFi drivers are in a sorry state. There is no mainline
driver. There is an OpenWRT driver, but it has not been updated for a
few years, tries to use get_fs() set_fs() pci_map_single() etc.

I've mostly used this platform for Ethernet switch development, so
i've never tried the WiFi before. I had no idea it was so broken...

So sorry, i cannot test this.

     Andrew
