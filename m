Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76F4B3E65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiBMX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:27:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiBMX1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:27:05 -0500
X-Greylist: delayed 171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 15:26:59 PST
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E585133A;
        Sun, 13 Feb 2022 15:26:58 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9A7ADFF802;
        Sun, 13 Feb 2022 23:26:51 +0000 (UTC)
Message-ID: <992dccb9-590a-c7b7-146f-d134fb399f7e@heyquark.com>
Date:   Mon, 14 Feb 2022 10:26:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] Upstreaming Linux for Nintendo Wii U
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>
Cc:     "linkmauve@linkmauve.fr" <linkmauve@linkmauve.fr>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "j.ne@posteo.net" <j.ne@posteo.net>
References: <0020d47c-0e23-822c-33f5-ccb7ea4c1072@heyquark.com>
 <87ee49sktb.fsf@mpe.ellerman.id.au>
 <41c696de-0e04-61e1-610c-73e9440c5c19@csgroup.eu>
From:   Ash Logan <ash@heyquark.com>
In-Reply-To: <41c696de-0e04-61e1-610c-73e9440c5c19@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 12/2/22 00:11, Christophe Leroy wrote:
> Hi Ash,
> 
> Le 11/02/2022 à 12:29, Michael Ellerman a écrit :
>> Ash Logan <ash@heyquark.com> writes:
>>> - Like the Wii before it, the Wii U has a small amount of RAM at address
>>> zero, a gap, then a large amount of RAM at a higher address. Instead of
>>> the "map everything and reserve the gap" approach of the Wii, we loop
>>> over each memblock and map only true RAM[9]. This seems to work, but as
>>> far as I can tell is unique amongst powerpc32 platforms, so it's worth
>>> pointing out. (Note: I've been told this doesn't work anymore after some
>>> KUAP changes[10], so this point might be moot; haven't investigated)
>>
>> We'd need more detail on that I guess. Currently all the 32-bit
>> platforms use the flat memory model, which assumes RAM is a single
>> contiguous block. Though that doesn't mean it all has to be used or
>> mapped, like the Wii does. To properly support your layout you should be
>> using sparsemem, but it's possible that's more trouble than it's worth,
>> I'm not sure. How far apart are the low and high blocks of RAM, and what
>> are their sizes?
> 
> Can you provide details on what's happening with KUAP changes ?
> 
> You are pointing to series https://lkml.org/lkml/2021/6/3/204
> 
> Does it work when CONFIG_PPC_KUAP is not selected or doesn't it work
> either ?
> 
> Are you able to bisect which commit of that series is the culprit ?

Emmanuel told me about this during their work on 5.13 which I wasn't 
involved in, and now can't remember any of the details, so I guess I 
don't actually have any more information.
I'm working on getting a baseline setup for 5.15 (just udbg and the 
like), so if there is an issue I should soon find out about it and will 
get back to you.

> Thanks
> Christophe

Thanks,
Ash
