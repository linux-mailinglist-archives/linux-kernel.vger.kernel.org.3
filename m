Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63D75A60E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiH3KhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiH3KhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:37:11 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB76ACA39
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DU06GE7cSjryR44sAECLs8jlZ+7rZinYc9K/a6o0bmk=; b=pf45+9+UKuY1SqBphhzjBfCNSK
        we1uceyBQIGsULpbtl/6ePzRfGrlIgEzo8flHB/lKcV6jobxrWUCLACDjJwrCJPxF5vTfFS3oVZ9m
        lDp12pMPLjS+3ASmnN+sJPYmiuYdhfTyvgN/hYl7vnYxr2wFqN5cBoyDpuT8EwVxcrYzCdII0bQjX
        aCkjofUSgYkyCD5KFrkCsRi+pqjvwwhTAlTkbtnMLh7i90rEJ1UMjfsA1hvvL5FBsj9h0nv3EIoQ/
        ZixSJ7TgJAj8cbK465Q9xvE0WbTSt69m+vR4XpWiPX+Ga7cwQ9MRguKH4om5RgpRQvIBooru+UZha
        ExBmBjtw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34000)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oSyc4-0002cx-Na; Tue, 30 Aug 2022 11:36:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oSyc3-0001R1-Pq; Tue, 30 Aug 2022 11:36:55 +0100
Date:   Tue, 30 Aug 2022 11:36:55 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in
 amba_probe()
Message-ID: <Yw3oR6WhM0O5LQX5@shell.armlinux.org.uk>
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
 <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk>
 <b120e94b-4b43-6d8a-a136-41417cb250cc@huawei.com>
 <Yw3hfGV4DYyJ0Gno@shell.armlinux.org.uk>
 <2452e7b0-d4fd-2e27-a336-bf87b85a8d50@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2452e7b0-d4fd-2e27-a336-bf87b85a8d50@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 06:31:14PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/8/30 18:07, Russell King (Oracle) wrote:
> > For an amba driver, drv->bus will always be pointing at amba_bustype.
> > That always has a "match" operation. Therefore, the default of '1'
> > above will *never* be used for an AMBA driver.
> > 
> > If drv->bus does not point at amba_bustype, then amba_probe() will
> > not be called for "drv".
> > 
> > Therefore, amba_match() must always be called before amba_probe().
> 
> Oh, I was careless. I think it's drv->match. But the processing flow
> will continue to go to "dev->bus->probe".
> 
> __driver_attach():
>         ret = driver_match_device(drv, dev);
>         if (ret == 0) {
>                 /* no match */
>                 return 0;
>         } else if (ret == -EPROBE_DEFER) {               <------no return in this branch
>                 dev_dbg(dev, "Device match requests probe deferral\n");
>                 dev->can_match = true;
>                 driver_deferred_probe_add(dev);
>         } else if (ret < 0) {
>                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
>                 return ret;
>         } /* ret > 0 means positive match */
> 
>         ... ...
>         driver_probe_device(drv, dev);
>              ......
>                   dev->bus->probe

And that makes no sense, is an already known issue, and there is a patch
to fix it:

https://lore.kernel.org/all/20220817184026.3468620-1-isaacmanjarres@google.com/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
