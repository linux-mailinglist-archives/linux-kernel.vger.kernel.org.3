Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE585A63D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiH3MsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiH3MsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E17212F546;
        Tue, 30 Aug 2022 05:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33539B81B31;
        Tue, 30 Aug 2022 12:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B690C433D6;
        Tue, 30 Aug 2022 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661863683;
        bh=OAh+DLRsxby01KGNRIxvYJEv80iev1FoY/1ihc89qeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kyt2axUo3wku6Kk3CgkAayyGli93rvZpbgEBOq6hOY3guD66TdeR02kLDabuHbj5G
         olUUtuZmmu4CEkPwNGffuxvD4B541E91LtD8pqzBB6xeRb65tHn+DQwTIuZA/ZtuQJ
         ZDNKMpRvi9e4Z7782wlHSxvrTPoc/c/mU5ycgh24=
Date:   Tue, 30 Aug 2022 14:48:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Alan Cox <alan@linux.intel.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] serial: Create uart_xmit_advance()
Message-ID: <Yw4HALWWOWabR/l9@kroah.com>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
 <20220825091707.8112-2-ilpo.jarvinen@linux.intel.com>
 <Yw4CP8y3b9E9XV0K@kroah.com>
 <CAHp75VfQHhPoO3Rpk=o1c2qPJB-tc_6G41n6iz3sv_gP44PLUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfQHhPoO3Rpk=o1c2qPJB-tc_6G41n6iz3sv_gP44PLUw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 03:38:27PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 3:31 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 25, 2022 at 12:17:05PM +0300, Ilpo Järvinen wrote:
> > > A very common pattern in the drivers is to advance xmit tail
> > > index and do bookkeeping of Tx'ed characters. Create
> > > uart_xmit_advance() to handle it.
> > >
> > > Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> > > Fixes: 2d908b38d409 ("serial: Add Tegra Combined UART driver")
> >
> > This commit only adds a new function, it does not "Fix" anything :(
> 
> I'm wondering how to tell stable maintainers about dependencies of
> (not yet applied) patches? In practice I saw that contributors use
> Fixes tag for the entire chain (for the preparatory patches + the real
> fix) when it's not easy / in a nice way to rebase to have a one-patch
> fix followed by refactoring, etc.

It's as if no one has ever had this issue before and wrote it down for
all to read and know what to do in the future.

{sigh}

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

If you don't know the git id, just use the subject line and it should
work the same.

greg "why even write documentation?" k-h
