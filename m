Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43308586DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiHAP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHAP0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:26:21 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81BBA1838B;
        Mon,  1 Aug 2022 08:26:19 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oIXJA-0005sx-00; Mon, 01 Aug 2022 17:26:16 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 35F03C0193; Mon,  1 Aug 2022 17:25:59 +0200 (CEST)
Date:   Mon, 1 Aug 2022 17:25:59 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Message-ID: <20220801152559.GA9041@alpha.franken.de>
References: <20220702190705.5319-1-olek2@wp.pl>
 <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org>
 <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
 <20220707100630.GC9894@alpha.franken.de>
 <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
 <20220707143930.GA14693@alpha.franken.de>
 <CAFBinCBq3ydoxtj1VG=kjqbq5NjP1ZnQe_dOAS2Gjm2fNkK9Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBq3ydoxtj1VG=kjqbq5NjP1ZnQe_dOAS2Gjm2fNkK9Yg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 05:50:10PM +0200, Martin Blumenstingl wrote:
> I think for the Realtek SoC's this would be problematic because it's
> using MIPS_GENERIC. My understanding is that in an ideal world all

which SOC are these ?

> platforms would switch to MIPS_GENERIC.
> As an alternative to making irq-mips-cpu capable of changing another
> CPU's registers: would you also be happy with a change that implements
> the following idea (pseudocode) in vsmp_init_secondary():
>     struct device_node *root_node = of_find_node_by_path("/");
> 
>     if (mips_gic_present() ||
>         of_device_is_compatible(root_node, "lantiq,xrx200") ||
>         of_device_is_compatible(root_node, "realtek,some-relevant-soc"))
>         change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
>             STATUSF_IP4 | STATUSF_IP5 |
>             STATUSF_IP6 | STATUSF_IP7);
>     else
>        ...
> 
>     of_node_put(root_node);
> 
> That way we don't risk enabling interrupt lines which shouldn't be
> enabled (on SoCs which we don't know).
> And also it would not cause any issues with MIPS_GENERIC support.

well it's not exactly the abstraction I'm looking for, but it's ok for me
as a short term way to move forward.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
