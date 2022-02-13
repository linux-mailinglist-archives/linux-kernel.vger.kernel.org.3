Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F44B3E60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiBMXYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:24:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBMXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:24:23 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA95133A;
        Sun, 13 Feb 2022 15:24:15 -0800 (PST)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 0E53DC5FA5;
        Sun, 13 Feb 2022 23:24:07 +0000 (UTC)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ABF89C0003;
        Sun, 13 Feb 2022 23:23:53 +0000 (UTC)
Message-ID: <df076a15-052a-1cb5-c618-e473f51d91e3@heyquark.com>
Date:   Mon, 14 Feb 2022 10:23:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] Upstreaming Linux for Nintendo Wii U
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr
References: <0020d47c-0e23-822c-33f5-ccb7ea4c1072@heyquark.com>
 <87ee49sktb.fsf@mpe.ellerman.id.au>
From:   Ash Logan <ash@heyquark.com>
In-Reply-To: <87ee49sktb.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your response!

On 11/2/22 22:29, Michael Ellerman wrote:
> Ash Logan <ash@heyquark.com> writes:
>> Hello,
> 
> Hi Ash,
> 
> I can't really answer all your questions, but I can chime in on one or
> two things ...
> 
>> - Right now I've made a new platform (like ps3) rather than joining the
>> GameCube and Wii in embedded6xx, since that is marked as BROKEN_ON_SMP.
>> The Wii U is a 3-core system, though a CPU bug[8] prevents existing
>> userspaces working with it. Bit of a "cross that bridge when we get
>> there" situation, though I'm reluctant to prevent that possibility by
>> using a BROKEN_ON_SMP platform.
> 
> I'm happy for it to be a new platform. I'd almost prefer it to be a
> separate platform, that way you can make changes in your platform code
> without worrying (as much) about breaking other platforms.

Sounds good to me! Since a lot of the architecture is the same as the 
Wii and GameCube, maybe once things are working well for Wii U we can 
look at refactoring those out too - a "nintendo" platform? Not a concern 
for now though.

>> - Like the Wii before it, the Wii U has a small amount of RAM at address
>> zero, a gap, then a large amount of RAM at a higher address. Instead of
>> the "map everything and reserve the gap" approach of the Wii, we loop
>> over each memblock and map only true RAM[9]. This seems to work, but as
>> far as I can tell is unique amongst powerpc32 platforms, so it's worth
>> pointing out. (Note: I've been told this doesn't work anymore after some
>> KUAP changes[10], so this point might be moot; haven't investigated)
> 
> We'd need more detail on that I guess. Currently all the 32-bit
> platforms use the flat memory model, which assumes RAM is a single
> contiguous block. Though that doesn't mean it all has to be used or
> mapped, like the Wii does. To properly support your layout you should be
> using sparsemem, but it's possible that's more trouble than it's worth,
> I'm not sure. How far apart are the low and high blocks of RAM, and what
> are their sizes?

 From the devicetree:

memory {
     device_type = "memory";
     reg = <0x00000000 0x02000000        /* MEM1 - 32MiB */
            0x08000000 0x00300000        /* MEM0 - 3MiB  */
            0x10000000 0x80000000>;      /* MEM2 - 2GiB  */
};

We could probably drop MEM0 without anybody missing it, so let's say a 
256MiB gap between MEM1 and MEM2.
sparsemem does look like a good option, though I note it depends on 
ppc64, so yeah, might be a lot of trouble for the benefit of two 
platforms (Wii and Wii U).
I'm currently attempting to get something baseline running on 5.15, will 
see if the memblock thing still works so I can have a patch for RFC.

>> - Due to the aformentioned DMA restrictions and possibly a fatal
>> bytemasking bug on uncached mappings[11], I have been wondering if it'd
>> be better to just give up on the SRAM at address 0 altogether and use it
>> as VRAM or something, loading the kernel at a higher address.
> 
> Don't you have exceptions entering down at low addresses? Even so you
> could possibly trampoline them up to the kernel at a high address.

Maybe? Looking through head_book3s_32.S that appears to be the case. 
Will probably stick with physaddr 0 for now then.

>> In terms of platform bringup, the key issue is whether to be embedded6xx
>> or not and what output device to use. Beyond that it's just things like
>> IRQ controller drivers, should be pretty straightforward. I think on our
>> end, we'll start rebasing to 5.15 (LTS) and start sending patches from
>> there. I know getting closer to HEAD is preferable, this project has
>> just moved very slowly in the past and being on LTS has been a lifesaver.
> 
> As I said I'm happy for it to be a new platform. If there ends up being
> a lot of shared code we can always refactor, but embedded6xx is only
> ~1500 LOC anyway.
> 
> One thing that has come up with previous console port submissions is the
> requirement for patches to be signed off. The docs are here if you
> aren't familiar with them:
>    https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

No problem, will make sure everything is signed off by the people involved.

> Otherwise your plan sounds good to me, 4.19 is pretty old so getting up
> to 5.15 would be a good start. Then submit whatever bits you can and
> chip away at it.
> 
> cheers

Thanks,
Ash
