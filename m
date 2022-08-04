Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE87589E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiHDPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbiHDPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1ADE186E2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659625861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbBM6LfGo4KWfy1uIO3wL/1ZF+r7xhnNoYSVlZWIlqw=;
        b=EGlv42MUUhfadSLzAxQ3H8Bda5gH7ta+Dy3ccleUhB4jQa2BeVLe74lk0DNNEVLghZPOms
        jxfsLkXA0Kfy+Eizvd29HQ4cN4brQH4Oot6iKIXbXRbM2LSihWh7nk3Sd+CbM1ZQkIAlBP
        Ae26kq5BFDo82PVvIYLeXnFDeW+dHwg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-TSR4IxzzOSG2yyv6hvUXiQ-1; Thu, 04 Aug 2022 11:11:00 -0400
X-MC-Unique: TSR4IxzzOSG2yyv6hvUXiQ-1
Received: by mail-ed1-f70.google.com with SMTP id i5-20020a05640242c500b0043e50334109so27355edc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NbBM6LfGo4KWfy1uIO3wL/1ZF+r7xhnNoYSVlZWIlqw=;
        b=4Kykg9An4zS3vzq2Hyc8rxQUJL4it4uLrNZ2AE27WER3WusA5ct8IWEXnh6sASVWRg
         ZLlWhe2Q6j1m+eLgPegXTUiCH/ln1tPws19UFz2PSQFci2f8GN9Y3xwBlq7mBpxOYyGA
         tBy7Ur5YV9HSD/tMRZvmFUHBZ8YuGsDQX8RxCDK8hQeeqVC0y+fAmO6AIqAQNx60Lo77
         TMUVp4dQkg8Fbb2Q3o/oc5sy55Xp7C2Uq3SqPhqc0xR9vpW6sds7Z4x7D9DB7N24GkTY
         RB4egR7ARfwpzdC879Ek+Qs6I8qHGjIxFtUysXzd+T1WFHQrSmele3iCjOJUmPFs0KWm
         ktiA==
X-Gm-Message-State: ACgBeo30aKHkqUYQ7+T2hykwG5A4PDaA1AE6/ujufrCYQ/u8sdq28Pxk
        h1Syp8RjzWQc+TXIyXHtTs5t/K5VO1u7YwMa1C4Vko5hzVBTIPz9UVVcBo8hM9B56QT6/7pPRmz
        ot+obyhckhjdqRCMHoxKaE1Kb
X-Received: by 2002:a05:6402:27c6:b0:43d:6fab:146e with SMTP id c6-20020a05640227c600b0043d6fab146emr2457569ede.376.1659625858665;
        Thu, 04 Aug 2022 08:10:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7AIOICmu+HP/KwQJ54TcB2qu5m+CP/plD2mV7ZSzDBiwOcr5/CIWWdEmrYShSXfGwyzLhHtA==
X-Received: by 2002:a05:6402:27c6:b0:43d:6fab:146e with SMTP id c6-20020a05640227c600b0043d6fab146emr2457549ede.376.1659625858392;
        Thu, 04 Aug 2022 08:10:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b007081282cbd8sm436689ejb.76.2022.08.04.08.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:10:57 -0700 (PDT)
Message-ID: <6210d0b9-c732-7f61-5d18-a244477155eb@redhat.com>
Date:   Thu, 4 Aug 2022 17:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC][PATCH] ACPI: EC: Make evaluate acpi_ec_add() _REG for EC
 operation regions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5592689.DvuYhMxLoT@kreacher>
 <be219334-456f-c2f1-7102-4a3b01e8cd59@redhat.com>
 <CAJZ5v0jPpsO4OkC=3ZkEwKzQWufwrt6YwMhNv8heEC12chDPTA@mail.gmail.com>
 <29f01ef7-03f7-817b-630b-52be72c83396@redhat.com>
 <CAJZ5v0jQgdqbN67OKpAmL31UnjBjyiEUtY-tCrBYwa_HHeD8pg@mail.gmail.com>
 <85cd941e-c892-677b-1582-c294c7efe770@redhat.com>
 <CAJZ5v0iz5Ps2meDjJTJKctkLcptRpz_=WLcEX4E+PnB6ikdQmQ@mail.gmail.com>
 <CAJZ5v0iTz300VGdQxQLpqHQ-LQ-p5Tjt2+d069zRZtUaGRxqxA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0iTz300VGdQxQLpqHQ-LQ-p5Tjt2+d069zRZtUaGRxqxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/4/22 16:11, Rafael J. Wysocki wrote:
> On Thu, Aug 4, 2022 at 4:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Aug 4, 2022 at 3:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 8/4/22 15:51, Rafael J. Wysocki wrote:
>>>> Hi Hans,
>>>>
>>>> On Thu, Aug 4, 2022 at 1:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> Sorry for the slow response...
>>>>
>>>> No sweat.
>>>>
>>>>> On 7/7/22 21:31, Rafael J. Wysocki wrote:
>>>>>> On Wed, Jul 6, 2022 at 10:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 7/6/22 14:37, Rafael J. Wysocki wrote:
>>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>>
>>>>>>>> acpi_ec_ecdt_probe() is called between acpi_load_tables() and
>>>>>>>> acpi_enable_subsystem().  It passes ACPI_ROOT_OBJECT as ec->handle
>>>>>>>> to acpi_ec_setup() and so ACPI_ROOT_OBJECT is passed to
>>>>>>>> acpi_install_address_space_handler() via ec_install_handlers().
>>>>>>>>
>>>>>>>> Next, acpi_ns_validate_handle() converts it to acpi_gbl_root_node
>>>>>>>> which is passed to acpi_ev_install_space_handler() and the handler is
>>>>>>>> installed for acpi_gbl_root_node.
>>>>>>>>
>>>>>>>> Now, acpi_gbl_root_node is passed to acpi_ev_execute_reg_methods() which
>>>>>>>> evaluates _REG for any ACPI_ADR_SPACE_EC regions it can find in the
>>>>>>>> namespace which should not be necessary, because the OS is expected to
>>>>>>>> make the ECDT operation regions available before evaluating any AML, so
>>>>>>>> in particular AML is not expected to check the evaluation of _REG before
>>>>>>>> it accesses these operation regions (see ACPI 6.4, Section 6.5.4,
>>>>>>>> exception 2 [1]).  Doing that is also problematic, because the _REG
>>>>>>>> methods for the ACPI_ADR_SPACE_EC regions may depend on various _INI, so
>>>>>>>> they should be be evaluated before running acpi_initialize_objects() [2].
>>>>>>>>
>>>>>>>> Address this problem by modifying acpi_install_address_space_handler()
>>>>>>>> to avoid evaluating _REG for ACPI_ADR_SPACE_EC regions when the handler
>>>>>>>> is installed for acpi_gbl_root_node which indicates the ECDT case.
>>>>>>>>
>>>>>>>> However, this needs to be accompanied by an EC driver change to
>>>>>>>> actually trigger the evaluation of _REG for the ACPI_ADR_SPACE_EC
>>>>>>>> regions when it finds the EC object in the namespace.
>>>>>>>>
>>>>>>>> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#reg-region # [1]
>>>>>>>> Link: https://github.com/acpica/acpica/pull/786 # [2]
>>>>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Note: This change doesn't make any practical difference on any of the systems
>>>>>>>> in my office.
>>>>>>>>
>>>>>>>> ---
>>>>>>>>  drivers/acpi/acpica/evxfregn.c |   12 ++++++++++++
>>>>>>>>  drivers/acpi/ec.c              |    7 +++++++
>>>>>>>>  2 files changed, 19 insertions(+)
>>>>>>>>
>>>>>>>> Index: linux-pm/drivers/acpi/ec.c
>>>>>>>> ===================================================================
>>>>>>>> --- linux-pm.orig/drivers/acpi/ec.c
>>>>>>>> +++ linux-pm/drivers/acpi/ec.c
>>>>>>>> @@ -1632,6 +1632,13 @@ static int acpi_ec_add(struct acpi_devic
>>>>>>>>                       acpi_handle_debug(ec->handle, "duplicated.\n");
>>>>>>>>                       acpi_ec_free(ec);
>>>>>>>>                       ec = boot_ec;
>>>>>>>> +                     /*
>>>>>>>> +                      * Uninstall the EC address space handler and let
>>>>>>>> +                      * acpi_ec_setup() install it again along with
>>>>>>>> +                      * evaluating _REG methogs associated with
>>>>>>>> +                      * ACPI_ADR_SPACE_EC operation regions.
>>>>>>>> +                      */
>>>>>>>> +                     ec_remove_handlers(ec);
>>>>>>>
>>>>>>> This will call the _REG method to get called with ACPI_REG_DISCONNECT (0)
>>>>>>> as second argument which may lead to unexpected consequences so I'm not
>>>>>>> in favor of doing things this way.
>>>>>>>
>>>>>>> IMHO it would be much better to instead have flags; or if flags are
>>>>>>> disliked a separate function to only call _REG later on.
>>>>>>
>>>>>> I'm aware of the _REG(EC, 0) part, but I thought that it might be the
>>>>>> right thing to do.
>>>>>>
>>>>>> First off, I'm a bit concerned about leaving the EC address space
>>>>>> handler attached to the root node after we have discovered the proper
>>>>>> EC object in the namespace, because that's inconsistent with the "no
>>>>>> ECDT" case.
>>>>>
>>>>> True, but in the ECDT case the EC opregion should work anywhere
>>>>> according to the spec, so I believe it is consistent with the spec.
>>>>
>>>> That's until the proper EC object is discovered, though.
>>>>
>>>>>> It leaves a potential problem on the table too, because acpi_ec_add()
>>>>>> changes boot_ec->handle from ACPI_ROOT_OBJECT to ec->handle and if
>>>>>> ec_remove_handlers() is called for it after that, it will fail to
>>>>>> remove the handler, but it will clear the
>>>>>> EC_FLAGS_EC_HANDLER_INSTALLED flag (so the change above is actually
>>>>>> incorrect, because it should remove the handler before changing
>>>>>> boot_ec->handle).
>>>>>
>>>>> You are right, but this can be fixed by keeping track of the handle
>>>>> used when registering the handler, e.g. something like this:
>>>>>
>>>>> From fceb436703bc8f0e29b7613246a83c039b631cb4 Mon Sep 17 00:00:00 2001
>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>> Date: Thu, 4 Aug 2022 13:38:35 +0200
>>>>> Subject: [PATCH] ACPI: EC: Fix EC address space handler unregistration
>>>>>
>>>>> When an ECDT table is present the EC address space handler gets registered
>>>>> on the root node. So to unregister it properly the unregister call also
>>>>> must be done on the root node.
>>>>>
>>>>> Store the ACPI handle used for the acpi_install_address_space_handler()
>>>>> call and use te same handle for the acpi_remove_address_space_handler()
>>>>> call.
>>>>>
>>>>> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>  drivers/acpi/ec.c       | 4 +++-
>>>>>  drivers/acpi/internal.h | 1 +
>>>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>>>> index 1e93677e4b82..6aa8210501d3 100644
>>>>> --- a/drivers/acpi/ec.c
>>>>> +++ b/drivers/acpi/ec.c
>>>>> @@ -1483,6 +1483,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>>>>                         return -ENODEV;
>>>>>                 }
>>>>>                 set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>>>>> +               ec->address_space_handler_handle = ec->handle;
>>>>>         }
>>>>>
>>>>>         if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>>>>> @@ -1543,7 +1544,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>>>>  static void ec_remove_handlers(struct acpi_ec *ec)
>>>>>  {
>>>>>         if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>>>>> -               if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
>>>>> +               if (ACPI_FAILURE(acpi_remove_address_space_handler(
>>>>> +                                       ec->address_space_handler_handle,
>>>>>                                         ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
>>>>>                         pr_err("failed to remove space handler\n");
>>>>>                 clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>>>>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>>>>> index 628bf8f18130..140af11d0c39 100644
>>>>> --- a/drivers/acpi/internal.h
>>>>> +++ b/drivers/acpi/internal.h
>>>>> @@ -173,6 +173,7 @@ enum acpi_ec_event_state {
>>>>>
>>>>>  struct acpi_ec {
>>>>>         acpi_handle handle;
>>>>> +       acpi_handle address_space_handler_handle;
>>>>>         int gpe;
>>>>>         int irq;
>>>>>         unsigned long command_addr;
>>>>> --
>>>>
>>>> This works.
>>>>
>>>> I would rename address_space_handler_handle to something like
>>>> address_space_handler_holder.
>>>
>>> Ok, I'll rename this for the official upstream submission.
>>>
>>>>> This fixes ec_remove_handlers() without requiring (IMHO) risky changes
>>>>> where we call _REG() multiple times.
>>>>>
>>>>> Also note that ec_remove_handlers() is only ever called from
>>>>> acpi_ec_driver.remove which in practice never runs since the EC never
>>>>> gets hot unplugged (arguably the entire remove code could be removed).
>>>>
>>>> Indeed.
>>>>
>>>>>> But in order to move the EC address space handler under the EC object,
>>>>>> it needs to be uninstalled and for this purpose AML needs to be told
>>>>>> that it's not there, so evaluating _REG(EC, 0) seems reasonable to me
>>>>>> even though I agree that it is somewhat risky.
>>>>>
>>>>> I'm pretty worried that calling _REG(EC, 0) will cause problems
>>>>> the _REG handlers run pretty early on and various BIOS/ACPI table
>>>>> authors seem to (ab)use this to do some sort of early setup
>>>>> of some things in _REG, That is pretty much how this whole thread
>>>>> has started. Given all the weirdness some ACPI tables do in their
>>>>> _REG handling running _REG 3 times:
>>>>>
>>>>> 1. _REG(EC, 1)
>>>>> 2. _REG(EC, 0)
>>>>> 3. _REG(EC, 1)
>>>>>
>>>>> really seems like a bad idea to me. I have the feeling that this is
>>>>> asking for trouble.
>>>>
>>>> OK, fair enough.
>>>>
>>>>>> Second, the spec is kind of suggesting doing it (cf. the "These
>>>>>> operation regions may become inaccessible after OSPM runs
>>>>>> _REG(EmbeddedControl, 0)" comment in the _REG definition section).
>>>>>
>>>>> That is boilerplate documentation copy and pasted from all the
>>>>> other address space handlers the spec defines. I'm not sure if
>>>>> Windows ever actually calls _REG(EmbeddedControl, 0) and I would
>>>>> not be surprised if Windows does not do this.
>>>>>
>>>>>> Moreover, I don't quite like the ACPI_NO_INSTALL_SPACE_HANDLER flag,
>>>>>> because it causes the "handler installation" to actually do something
>>>>>> else.
>>>>>
>>>>> As mentioned before (IIRC) I would be more then happy to respin both
>>>>> the ACPICA as well as the Linux ACPI bits to introduce / use 2 new
>>>>> functions for this, lets say:
>>>>>
>>>>> 1. acpi_install_address_space_handler_no__reg()
>>>>
>>>> So we need this in ACPICA, because it doesn't make sense to drop and
>>>> re-acquire the namespace mutex around _REG evaluation in the non-EC
>>>> case.
>>>
>>> Right, just like the flags changes in this RFC getting this fixed
>>> will require some work on the ACPICA side + then Linux changes
>>> using the new ACPICA functions.
>>>
>>>> But as stated before I would prefer to introduce an
>>>> acpi_install_address_space_handler_internal() taking an additional
>>>> BOOL run__reg argument  and I would define
>>>> acpi_install_address_space_handler() and the new
>>>> acpi_install_address_space_handler_no__reg() as wrappers around it.
>>>
>>> Right, that is how it will look like inside ACPICA, but API consumers
>>> will just see a new acpi_install_address_space_handler_no__reg()
>>> getting introduced.
>>
>> Well, one more thing about it.
>>
>> This would be a very generic interface with a very specific use case.
>> Moreover, the use case in question is already detectable in
>> acpi_install_address_space_handler().
>>
>> Namely, the _REG evaluation can be skipped automatically if an
>> ACPI_ADR_SPACE_EC handler is installed at the root of the ACPI
>> namespace (because it doesn't even make sense to evaluate _REG then).
>> If this is done, we don't need the extra argument.
> 
> More specifically, bail out of acpi_ev_execute_reg_methods() early if
> the space ID is ACPI_ADR_SPACE_EC and node is the namespace root, in
> which case the EC address space can be regarded as a "must always be
> accessible" one.

I'm not really in favor of hiding the conditions under which _REG
calling is skipped in this way.

If you look at this RFC patch int introduces a EC_FLAGS_EC_REG_CALLED
flag in drivers/acpi/ec.c and then later on uses that flag to
determine that _REG still needs to be called when ec_install_handlers()
is called the second time when actually probing/parsing the ACPI EC
object.

If we hide the conditions under which _REG is skipped inside
ACPICA, then determining  when to call the new
acpi_execute_reg_methods() method is going to be somewhat tricky and
more over anyone reading the code then needs to also figure out that
acpica originally skipped this and under which conditions it was
orignally skipped.

IMHO having drivers/acpi/ec.c in full control over when to skip
(and thus also when to run _REG later) is cleaner then splitting
this over 2 different code bases.

Regards,

Hans


