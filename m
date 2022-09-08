Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B9A5B1F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiIHNrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIHNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:47:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E6B5A68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:47:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r17so4371285pgr.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=9xki9m++Duk4Gulz67WjHVUUPD0rzTzOg7vphwhMkD8=;
        b=C7f8UMyM3uTZrjVlPf0aqv0TO+GID+ONoZ3HAbZuFhrEai+64ku+B9TgoSs2eh97xz
         v2wtwV4Gz8B+nZy9bHlPKu/hjsTT+waemxNE+oY8AIl9n5l7LirFGpENZ2iD5VD9iRDJ
         MWO4fR29/5EAf5h81GbBhspIplwMpIZ8ExbcqmQzYlRaKUrBk4g6p3XLqoG3V1p8TIXs
         YhuWSfQIRCfqe2Ftt8cmljxej9F6OHPuYh70EWiODGWLAjS1ytj6sRxkp8OZFnXEjMmS
         G6ojdkIPe/MEiD6za1cKWka/zjk6xwyS+2BUzUmaodCWrehb2YHdTeRtTOGS31LQx8QB
         FKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=9xki9m++Duk4Gulz67WjHVUUPD0rzTzOg7vphwhMkD8=;
        b=c0tanK+Lj9Z/jc9/KcV6b7n3vnGVUyYVHLUlOahmrskhl7KE39zkK8D/Pvx7g7cl1B
         /E4tfaBTR6ySFJOK5w7LQzzQPJOb/2Bw7H9LMZO1ubdNUdJnFt/Pafxdj2HmZUvy0F+t
         nFwdpRRIjnaPjAqXsGiqOQUWPECOu7BW4/P4oasgGHM2XhmJ5i0haNse/PFgRMYRvvPD
         Soo2rAIs88e2nfZP+dliWgVQVyCcIK5c5JNzTX7DKXBl6u54st983kFBKAWiK8iM7p6K
         W+mbwpbbnB4GavsQZc2udHi+R3UNrOf98+fsjw8pSZzxxkLhyumJMw+OOOP0zBgN43ta
         eoNw==
X-Gm-Message-State: ACgBeo3p1tLbvIl6r3vIjkMFSBubkliL2+NYxPdUfI59uT3/nYsv2InU
        LfBlj4oMwWdGRCeR9Fbk8/U=
X-Google-Smtp-Source: AA6agR7ji54rwhLCIYltWaKcbQmV0a3y5l3CJoRUA3akbZd3iU2K4WnuhKPIREDrSa3OYNAnWoKfgQ==
X-Received: by 2002:a05:6a00:174f:b0:537:6845:8b1a with SMTP id j15-20020a056a00174f00b0053768458b1amr9622443pfc.68.1662644830039;
        Thu, 08 Sep 2022 06:47:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709027e0e00b0017542c2ddabsm14573753plm.288.2022.09.08.06.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:47:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa8d59de-7ff4-153d-082f-f5eb400cd6b6@roeck-us.net>
Date:   Thu, 8 Sep 2022 06:47:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] powerpc/chrp: Revert "Move PHB discovery" and "Make
 hydra_init() static"
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Oliver O'Halloran <oohall@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20210716221159.3587039-1-linux@roeck-us.net>
 <20210717175750.Horde.TLZWyADKWFGAyFWIYtmglA2@messagerie.c-s.fr>
 <20210717162359.GA3130272@roeck-us.net>
 <CAOSf1CGxp2xuEgR=Fb2AL+Ra5owqdN5=MtK6o_MCYqp=+P9arw@mail.gmail.com>
 <f60e0a73-f608-b25c-358e-f4dcb09d8923@csgroup.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <f60e0a73-f608-b25c-358e-f4dcb09d8923@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 23:23, Christophe Leroy wrote:
> Hi All,
> 
> Le 18/07/2021 à 18:09, Oliver O'Halloran a écrit :
>> On Sun, Jul 18, 2021 at 2:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On Sat, Jul 17, 2021 at 05:57:50PM +0200, Christophe Leroy wrote:
>>>> Guenter Roeck <linux@roeck-us.net> a écrit :
>>>>
>>>>> This patch reverts commit 407d418f2fd4 ("powerpc/chrp: Move PHB
>>>>> discovery") and commit 9634afa67bfd ("powerpc/chrp: Make hydra_init()
>>>>> static").
>>>>>
>>>>> Running the upstream kernel on Qemu's brand new "pegasos2" emulation
>>>>> results in a variety of backtraces such as
>>>>>
>>>>> Kernel attempted to write user page (a1) - exploit attempt? (uid: 0)
>>>>> ------------[ cut here ]------------
>>>>> Bug: Write fault blocked by KUAP!
>>>>> WARNING: CPU: 0 PID: 0 at arch/powerpc/mm/fault.c:230
>>>>> do_page_fault+0x4f4/0x920
>>>>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.2 #40
>>>>> NIP:  c0021824 LR: c0021824 CTR: 00000000
>>>>> REGS: c1085d50 TRAP: 0700   Not tainted  (5.13.2)
>>>>> MSR:  00021032 <ME,IR,DR,RI>  CR: 24042254  XER: 00000000
>>>>>
>>>>> GPR00: c0021824 c1085e10 c0f8c520 00000021 3fffefff c1085c60 c1085c58
>>>>> 00000000
>>>>> GPR08: 00001032 00000000 00000000 c0ffb3ec 44042254 00000000 00000000
>>>>> 00000004
>>>>> GPR16: 00000000 ffffffff 000000c4 000000d0 0188c6e0 01006000 00000001
>>>>> 40b14000
>>>>> GPR24: c0ec000c 00000300 02000000 00000000 42000000 000000a1 00000000
>>>>> c1085e60
>>>>> NIP [c0021824] do_page_fault+0x4f4/0x920
>>>>> LR [c0021824] do_page_fault+0x4f4/0x920
>>>>> Call Trace:
>>>>> [c1085e10] [c0021824] do_page_fault+0x4f4/0x920 (unreliable)
>>>>> [c1085e50] [c0004254] DataAccess_virt+0xd4/0xe4
>>>>>
>>>>> and the system fails to boot. Bisect points to commit 407d418f2fd4
>>>>> ("powerpc/chrp: Move PHB discovery"). Reverting this patch together with
>>>>> commit 9634afa67bfd ("powerpc/chrp: Make hydra_init() static") fixes
>>>>> the problem.
>>>>
>>>> Isn't there more than that in the backtrace ? If there is a fault blocked by
>>>> Kuap, it means there is a fault. It should be visible in the traces.
>>>>
>>>> Should we fix the problem instead of reverting the commit that made the
>>>> problem visible ?
>>>>
>>>
>>> I do not think the patch reverted here made the problem visible. I am
>>> quite sure that it introduced it. AFAIS the problem is that the new code
>>> initializes and remaps PCI much later, after it is being used.
>>
>> Right. The bug is that on 32bit platforms the PHB setup also maps one
>> of the PHB's IO space as "ISA IO space" as a side effect. There's a
>> handful of platforms (pegasos2 is one) which use an i8259 interrupt
>> controller and configuring that requires access to IO / ISA space. The
>> KUAP faults we're setting are because isa_io_base is still set to zero
>> so outb() and friends are accessing the zero page.
>>
>> I don't think there's any real reason why we need to have PCI fully
>> set up to handle that situation. A few platforms already have early
>> fixup code which parses the DT directly rather than using the fields
>> of pci_controller (which are parsed from the DT anyway) and I'm pretty
>> sure we can do something similar.
>>
>>> Also, the
>>> patch introducing the problem was never tested on real hardware (it even
>>> says so in the patch comments). That by itself seems to be quite
>>> problematic for such an invasive patch, and makes me wonder if some of
>>> the other PHB discovery related patches introduced similar problems.
>>
>> The legacy platforms are maintained on a best-effort basis. Ellerman's
>> CI farm covers most of the powerpc CPU types, but there's no real way
>> to test the bulk of the platforms in the tree since most of the
>> hardware is currently in landfill.
>>
>>> Anyway, I do not use or have that hardware. I was just playing with the
>>> latest version of qemu and ended up tracking down why its brand new
>>> pegasos2 emulation no longer boots with the latest Linux kernel.
>>> I personally don't care too much if ppc/chrp support is broken in the
>>> upstream kernel or not. Please take this patch as problem report,
>>> and feel free to do with it whatever you like, including ignoring it.
>>
>> Problem reports are fine and appreciated. I'd be less cranky if you
>> included the kernel config you used in the initial report since I
>> wasted an hour of my saturday trying to replicate it with various
>> kernel configs that had SMP enabled since that's what the
>> chrp_defconfig uses.
>>
> 
> 
> What is the status now ? I see this revert patch is still hanging around in patchwork, is there still a problem ?
> 

Presumably, but my understanding was "we are not going to fix this",
so I stopped testing with the pegasos2 emulation a long time ago.

Guenter
