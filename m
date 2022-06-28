Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6537555C13B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242286AbiF1Hbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiF1Hba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:31:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E198B2CE28
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Um5LV9TZfJK/7Xe9nngBZtUUBgdIT/9/2MAXYjc5dGg=; b=xO/bZdYigR1qYBQdMym6NXfT0g
        LXTZ/NybmGo4ebB5ibs/oCQCvWCO3t9fGa6fgLVHAPKQntu/blFH9foG4v1d8b2901Xq+M/wrdmuC
        +0MruKVIrrGvGcgMFGHB5KHxAzRyU2mC0+3AoNAIZGUTyT8ip3natLU+EW6ZWCVy6XDYTPP8svpGP
        6QrcpFEt0+uAHb/PprUBLkNuO7rMtv+CXxYzvDAdzlDEXBY5xeELP7O0Gq1ZyC8sKrDDIR0YvkgdV
        r1X7F14Sv10Fq6/07yd+fFmR3v+xfwJ1TS7DjgkSNOrTFnJ+PdypI9KMm+16ju2WnXkyWCivLmx5X
        5zl5zPXQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33060)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o65h0-0001JA-4d; Tue, 28 Jun 2022 08:31:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o65gz-0004jy-GJ; Tue, 28 Jun 2022 08:31:25 +0100
Date:   Tue, 28 Jun 2022 08:31:25 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: Silence proc-v7-bugs.c spam about disabled
 Spectre workarounds
Message-ID: <YrquTaGDYaEfBXjw@shell.armlinux.org.uk>
References: <20220519161310.1489625-1-dmitry.osipenko@collabora.com>
 <253e9ec1-bcd8-c790-95b8-afbcc21e7163@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253e9ec1-bcd8-c790-95b8-afbcc21e7163@collabora.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:23:06AM +0300, Dmitry Osipenko wrote:
> On 5/19/22 19:13, Dmitry Osipenko wrote:
> > Print message about disabled Spectre workarounds only once to stop
> > endless spam into KSMG each time CPU goes out from idling state.
> > This spam makes system unusable with CONFIG_HARDEN_BRANCH_PREDICTOR=n
> > for those who don't care about security and wants maximum performance.
> > 
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  arch/arm/mm/proc-v7-bugs.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
> > index fb9f3eb6bf48..f9730eba0632 100644
> > --- a/arch/arm/mm/proc-v7-bugs.c
> > +++ b/arch/arm/mm/proc-v7-bugs.c
> > @@ -108,8 +108,7 @@ static unsigned int spectre_v2_install_workaround(unsigned int method)
> >  #else
> >  static unsigned int spectre_v2_install_workaround(unsigned int method)
> >  {
> > -	pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n",
> > -		smp_processor_id());
> > +	pr_info_once("Spectre V2: workarounds disabled by configuration\n");
> >  
> >  	return SPECTRE_VULNERABLE;
> >  }
> 
> Hello Russell,
> 
> Could you please apply this patch? I tried to use yours patch tracker
> today and it doesn't allow me to recover my password (server error: MAIL
> FROM command failed Detail: Space shortage).

That should now be working - thanks to apt needlessly consuming 200MB of
space. Please use the patch system, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
