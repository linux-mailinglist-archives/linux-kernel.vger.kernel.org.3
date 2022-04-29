Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996BA51586E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381510AbiD2WfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiD2WfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:35:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9C419AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCD35B83793
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E49C385A4;
        Fri, 29 Apr 2022 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651271508;
        bh=F6XtxlFMsWw/+zLuHmTTDTKrGi8MsPPXeHqEOVOZaTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0xfLpHDbrzKBzZ9zNwulve3VViID8M1l/svgI+BvmSYf3vJEWwnQHOlWj9IEKL7C
         5sf9v8oti3lgeZr+yDmLxIu11DcUvmzKaPf2fuS358YdVnj8KAe1+SnGJkuhAW0EDq
         y5SsICjGKkN4WspV0lFhMljsEJhBM28HG6A67AdkF4Ol5+Qtyp7jBEfNjBkvgmApAX
         V1aq4HIEqf8zIg0luLe/OTJKHJWZHF7jAlvrPEd6XGGo7/jGUlYNu+ELu2TQIpvWrE
         utzcnTj9dTIE+y3kEbnIx0W9iKSt4HoxgjBMp+8V8OzlSljBmvzGcU0rYEiPk2p1iB
         Lo8RHcMb5nK8A==
Received: by pali.im (Postfix)
        id 445ADCAF; Sat, 30 Apr 2022 00:31:45 +0200 (CEST)
Date:   Sat, 30 Apr 2022 00:31:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] irqchip/armada-370-xp: Do not touch Performance
 Counter Overflow on A375, A38x, A39x
Message-ID: <20220429223145.4rubhuiu64ktgklp@pali>
References: <20220425113706.29310-1-pali@kernel.org>
 <YmvYrFUfIUvfjrmY@lunn.ch>
 <20220429130524.vs6mlzvotvaortbw@pali>
 <YmxlZncjVnym4kfc@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmxlZncjVnym4kfc@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 April 2022 00:23:34 Andrew Lunn wrote:
> On Fri, Apr 29, 2022 at 03:05:24PM +0200, Pali Rohár wrote:
> > On Friday 29 April 2022 14:23:08 Andrew Lunn wrote:
> > > On Mon, Apr 25, 2022 at 01:37:05PM +0200, Pali Rohár wrote:
> > > > Register ARMADA_370_XP_INT_FABRIC_MASK_OFFS is Armada 370 and XP specific
> > > > and on new Armada platforms it has different meaning. It does not configure
> > > > Performance Counter Overflow interrupt masking. So do not touch this
> > > > register on non-A370/XP platforms (A375, A38x and A39x).
> > > 
> > > Hi Pali
> > > 
> > > Do the Armada 375, 38x and 39x have an over flow interrupt? I assume
> > > not.
> > 
> > Hello! According to documentation there is something named performance
> > counter interrupt, but it is in different register... and this register
> > is not per-cpu.
> 
> O.K, not something which can be quickly added. 
> 
> > > Does this need a fixes tag? Should it be back ported in stable?
> > 
> > git blame show that this functionality appeared in commit 28da06dfd9e4
> > ("irqchip: armada-370-xp: Enable the PMU interrupts").
> 
> It is more a question of:
> 
>  o It must fix a real bug that bothers people (not a, “This could be a
>    problem…” type thing).
> 
> From https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Have you seen bad things happen because of this?
> 
>      Andrew

On those new Armada SoCs that register is used for unmasking interrupts
from another hierarchy. Until you start using those new interrupts there
probably could not be any issue. But in any case unmasking unwanted
interrupt is not a wise idea...

I spotted this because I started using those extended interrupts from
another hierarchy. I'm planning to send a patch which properly export
them via DTS. Consumer would be pci-mvebu.c driver as in this extended
hierarchy are PCIe AER and PME interrupts.

Anyway, Fixes tag is probably better in this situation than stable tag.
So would it be fine to replace it by?

Fixes: 28da06dfd9e4 ("irqchip: armada-370-xp: Enable the PMU interrupts")
