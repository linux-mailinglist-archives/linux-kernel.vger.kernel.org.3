Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C114C0405
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiBVVp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiBVVpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:45:55 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A7BF1390EE;
        Tue, 22 Feb 2022 13:45:29 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMcyO-0007Dp-01; Tue, 22 Feb 2022 22:45:28 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D4C8FC2742; Tue, 22 Feb 2022 22:44:55 +0100 (CET)
Date:   Tue, 22 Feb 2022 22:44:55 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-5.17-rc5/arch/mips/cavium-octeon/executive/octeon-model.c
 bug report
Message-ID: <20220222214455.GB18724@alpha.franken.de>
References: <VI1P189MB0573726CE8E7812C1D91A9519C3B9@VI1P189MB0573.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1P189MB0573726CE8E7812C1D91A9519C3B9@VI1P189MB0573.EURP189.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 05:00:26PM +0000, David Binderman wrote:
> I just ran static analyser cppcheck over the linux kernel 5.17-rc5. It said:
> 
> linux-5.17-rc5/arch/mips/cavium-octeon/executive/octeon-model.c:359:11: style: Variable 'suffix' is reassigned a value before the old one has been used. [redundantAssignment]
> 
> Source code is
> 
>                 if (fus_dat2.cn66xx.nocrypto && fus_dat2.cn66xx.dorm_crypto)
>                         suffix = "AP";
>                 if (fus_dat2.cn66xx.nocrypto)
>                         suffix = "CP";
> 
> Maybe better code:
> 
>                 if (fus_dat2.cn66xx.nocrypto && fus_dat2.cn66xx.dorm_crypto)
>                         suffix = "AP";
>                 else if (fus_dat2.cn66xx.nocrypto)
>                         suffix = "CP";

IMHO this isn't better just different. As I don't have any Cavium docs
about their SoCs, it's hard to say what's the correct way to fix this.
There is the same pattern in CN61XX case

                if (fus_dat2.cn61xx.nocrypto && fus_dat2.cn61xx.dorm_crypto)
                        suffix = "AP";
                if (fus_dat2.cn61xx.nocrypto)
                        suffix = "CP";

which isn't present in the latest Cavium SDK. So maybe just removing

                if (fus_dat2.cn66xx.nocrypto && fus_dat2.cn66xx.dorm_crypto)
                        suffix = "AP";

is more appropriate.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
