Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F403464397
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbhK3Xq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:46:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:48193 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhK3Xqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:46:54 -0500
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1AUNbo5u025795;
        Tue, 30 Nov 2021 17:37:51 -0600
Message-ID: <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Date:   Wed, 01 Dec 2021 10:37:50 +1100
In-Reply-To: <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-3-neal_liu@aspeedtech.com>
         <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
         <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 09:47 +0000, Neal Liu wrote:
> > Should this  be controlled by d->wakeup_en ? IE, we have a feature for the
> > host to enable/disable remote wakeup, should we honor it ?
> 
> For KVM usage, remote keyboard packet would be sent if user wants to do remote wakeup.
> In this case, d->wakeup_en is not used.
> Set VHUB_CTRL_AUTO_REMOTE_WAKEUP to enable HW automatically signaling wakeup if
> any packet would be transferred.

Sorry, I don't fully understand your explanation here.

Normally, a USB device will do remote wakeup if it's instructed to do
so via the appropriate feature being set, which is what wakeup_en
reflects. I hadn't originally plumbed it in, I forgot why, I think
something was either not properly documented or not working when I
wrote that driver.

You seem to want to override the behaviour and always send a remote
wakeup packet no matter what. I am not sure this is desirable for all
use cases, and might be something we want to make configurable, no ?

I'm trying to understand your sentence, you seem to imply that the only
use case here is "KVM" (as in remote USB on a server system) which I
can probably agree with... mostly.

And you say in that case, we should always do remote wakeup whenever an
emulated USB device has any activity (keyboard or otherwise),
regardless of whether the server has enabled the feature or not.

Am I correct ? What's the rationale here ?

Cheers,
Ben.


