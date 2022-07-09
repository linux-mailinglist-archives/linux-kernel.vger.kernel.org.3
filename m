Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFB56CABD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGIQtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiGIQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:49:46 -0400
X-Greylist: delayed 2278 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jul 2022 09:49:44 PDT
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394027162;
        Sat,  9 Jul 2022 09:49:44 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oAD3W-0007uY-BP; Sat, 09 Jul 2022 18:11:42 +0200
Message-ID: <ea64c33f-9fc5-7c24-a101-da5d605863e1@birger-koblitz.de>
Date:   Sat, 9 Jul 2022 18:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220702190705.5319-1-olek2@wp.pl>
 <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
 <20220707100630.GC9894@alpha.franken.de>
 <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
 <20220707143930.GA14693@alpha.franken.de>
 <468a2c8578d099eef0e0106fe273f73f5d70ef94.camel@svanheule.net>
From:   Birger Koblitz <git@birger-koblitz.de>
In-Reply-To: <468a2c8578d099eef0e0106fe273f73f5d70ef94.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;git@birger-koblitz.de;1657385384;a94bfab7;
X-HE-SMSGID: 1oAD3W-0007uY-BP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/7/22 17:12, Sander Vanheule wrote:
> On Thu, 2022-07-07 at 16:39 +0200, Thomas Bogendoerfer wrote:
>> On Thu, Jul 07, 2022 at 02:57:15PM +0200, Martin Blumenstingl wrote:

>> IMHO there is the problem, irq-mips-cpu.c can only do CPU irq operations
>> on the same CPU. I've checked MIPS MT specs and it's possible do
>> modify CP0 registers between VPEs. Using that needs changes in
>> irq-mips-cpu.c. But mabye that's not woth the effort as probably
>> all SMP cabable platforms have some multi processort capable
>> interrupt controller implemented.
Not sure I can be of much help. That the patch works on the RTL SoCs is 
mostly empirical and was found in the vendor code.

My understanding from the MIPS documentation is that it is not specified 
what happens when a multi VPE capable IRQ controller triggers CPU 
interrupts: if multiple VPEs are possible targets, then it is not 
defined whether one of them gets them (and which one), multiple, or all. 
So trying to control what happens between VPEs is probably SoC-dependent 
functionality.

Cheers,
   Birger
