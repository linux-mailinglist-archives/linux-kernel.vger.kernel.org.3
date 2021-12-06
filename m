Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC8468E38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbhLFASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:18:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:44188 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhLFASL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:18:11 -0500
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1B608gtt022162;
        Sun, 5 Dec 2021 18:08:44 -0600
Message-ID: <07472b315d6adecb874f29128e9b5fe3eadad590.camel@kernel.crashing.org>
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
Cc:     BMC-SW <BMC-SW@aspeedtech.com>
Date:   Mon, 06 Dec 2021 11:08:42 +1100
In-Reply-To: <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-3-neal_liu@aspeedtech.com>
         <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
         <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
         <5d234a400a89f64ad183020b93b68f478f1addc7.camel@kernel.crashing.org>
         <HK0PR06MB3202F55EEE02B9931D9CD4AD80699@HK0PR06MB3202.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-02 at 03:03 +0000, Neal Liu wrote:
> > 
> Let's me describe more details for our hardware behavior and hope you
> understand.
> 
> HUB00[3]: MANUAL_REMOTE_WAKEUP
> HUB00[4]: AUTO_REMOTE_WAKEUP
> 
> Set HUB00[3] implies USB device will do remote wakeup if any write
> command to vhub register.
> Set HUB00[4] implies USB device will do remote wakeup. It can only be
> set in suspend state.
> 
> For current design, d->wakeup_en only controls whether HUB00[4] can
> be set through usb_gadget_ops.wakeup().
> If some applications (take KVM as example) want to wakeup host by
> sending a packet, it won't go through sb_gadget_ops.wakeup().
> We enable HUB00[3] to fix this problem. It won't override above
> mentioned behavior.
> If host has enabled the USB_DEVICE_REMOTE_WAKEUP feature, it has 2
> ways to wakeup host.
> 1. set srp 1 (/sys/device/platform/xxxxxxxxx/udc/xxxxxx/srp)
> 2. emulated device has activity
> If host has disabled the USB_DEVICE_REMOTE_WAKEUP feature, these 2
> ways still cannot wakeup host even if USB bus is in resume state.
> Thanks

So what you are saying is that currently, the various gadgets aren't
calling usb_gadget_wakeup() ?

Ie. it should be a gadget policy to decide when to wake-up I suppose,
but it's true that nothing in the core nor the existing gadgets seem to
handle that.

I think what you propose is a band-aid. The real problem is that the
gadget drivers should trigger wakeups (or the core should do so on
activity).

That said, for now, I don't object to adding that "auto" bit, but I
would prefer if that behaviour was use configurable.

Cheers,
Ben.

