Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C26589D25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiHDN54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiHDN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4E6A32DB4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659621469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqFtL8BJaelGLtc6sKvfB3bxl7K/rtxOrF+XZ2Eo+Iw=;
        b=b02hOcx04ghE0Qv7PHAXkthjbzEak7GwZ+wNA4yNSfkh760qCHlfjXMWp69K9pd3JHxXfI
        atGzD5azeD3EnV/qhHZ2MmjogMCDgMtF6FO3FvtEVo735XRq/rRSIZbrnNPk/rQ+ttSldU
        31ACOIclLEGJvoC9igjYMYyq7zipRfE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-PnX7BJCaNTGji3Pq-bOZsw-1; Thu, 04 Aug 2022 09:57:48 -0400
X-MC-Unique: PnX7BJCaNTGji3Pq-bOZsw-1
Received: by mail-ej1-f71.google.com with SMTP id sd24-20020a1709076e1800b0072b582293c2so6105065ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SqFtL8BJaelGLtc6sKvfB3bxl7K/rtxOrF+XZ2Eo+Iw=;
        b=Rxkd7h2ts9izjqOa3VJ3JsXYpf6CxWA/0AUioWpzv4dHyrMMvZc7BTwA/2PP8BFOC2
         //kvQ+w3dA/50sKZvH7smeg3NdTN01cvsSomV+Ukw6sn6tqU69f+afqiZ4zBtlQqdB2s
         Badw3YKmHEtPD6L8ZOL7Eh8WDvt2cgoTcSluRa8L7DmUFPITZGVHFZmGRx4HcBSjP30M
         frmdBBntBD7HS0VK/oroYZ2r0++R9BOk2rWqDm6YY6spi6tto9KF3yt/2mmOXdccUIn/
         2aDu5lsEQOxE6gcI0pgZGaNysQLtOrH/OAHcMXfcXEQL75ZL1M46lH19DC1k5opwHPiu
         oehw==
X-Gm-Message-State: ACgBeo2XB4EDdyqeZy/rp8oe1lMzOriFvcPGjv1BvPWICJiiLz6WYw1w
        8km2E4GSPuyDfx93TXRZtF+J6bpbAOJWV37TAITq/g83wAMmoYqxt1CMNMofhBN8xayEnBObubd
        h642rcraHLCNd5dJarLudmzKt
X-Received: by 2002:a05:6402:5415:b0:43b:a888:fefe with SMTP id ev21-20020a056402541500b0043ba888fefemr2151845edb.302.1659621467463;
        Thu, 04 Aug 2022 06:57:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6QGYimQMAcLj/kBLzW69u9bQAa2q2ncuQVK4iGhXGyVWszvMWIfJ+XQv4yjszBlrdXG5wc+w==
X-Received: by 2002:a05:6402:5415:b0:43b:a888:fefe with SMTP id ev21-20020a056402541500b0043ba888fefemr2151822edb.302.1659621467258;
        Thu, 04 Aug 2022 06:57:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b007305b8aa36bsm363741ejh.157.2022.08.04.06.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:57:46 -0700 (PDT)
Message-ID: <85cd941e-c892-677b-1582-c294c7efe770@redhat.com>
Date:   Thu, 4 Aug 2022 15:57:46 +0200
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jQgdqbN67OKpAmL31UnjBjyiEUtY-tCrBYwa_HHeD8pg@mail.gmail.com>
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

On 8/4/22 15:51, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Thu, Aug 4, 2022 at 1:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> Sorry for the slow response...
> 
> No sweat.
> 
>> On 7/7/22 21:31, Rafael J. Wysocki wrote:
>>> On Wed, Jul 6, 2022 at 10:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 7/6/22 14:37, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> acpi_ec_ecdt_probe() is called between acpi_load_tables() and
>>>>> acpi_enable_subsystem().  It passes ACPI_ROOT_OBJECT as ec->handle
>>>>> to acpi_ec_setup() and so ACPI_ROOT_OBJECT is passed to
>>>>> acpi_install_address_space_handler() via ec_install_handlers().
>>>>>
>>>>> Next, acpi_ns_validate_handle() converts it to acpi_gbl_root_node
>>>>> which is passed to acpi_ev_install_space_handler() and the handler is
>>>>> installed for acpi_gbl_root_node.
>>>>>
>>>>> Now, acpi_gbl_root_node is passed to acpi_ev_execute_reg_methods() which
>>>>> evaluates _REG for any ACPI_ADR_SPACE_EC regions it can find in the
>>>>> namespace which should not be necessary, because the OS is expected to
>>>>> make the ECDT operation regions available before evaluating any AML, so
>>>>> in particular AML is not expected to check the evaluation of _REG before
>>>>> it accesses these operation regions (see ACPI 6.4, Section 6.5.4,
>>>>> exception 2 [1]).  Doing that is also problematic, because the _REG
>>>>> methods for the ACPI_ADR_SPACE_EC regions may depend on various _INI, so
>>>>> they should be be evaluated before running acpi_initialize_objects() [2].
>>>>>
>>>>> Address this problem by modifying acpi_install_address_space_handler()
>>>>> to avoid evaluating _REG for ACPI_ADR_SPACE_EC regions when the handler
>>>>> is installed for acpi_gbl_root_node which indicates the ECDT case.
>>>>>
>>>>> However, this needs to be accompanied by an EC driver change to
>>>>> actually trigger the evaluation of _REG for the ACPI_ADR_SPACE_EC
>>>>> regions when it finds the EC object in the namespace.
>>>>>
>>>>> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#reg-region # [1]
>>>>> Link: https://github.com/acpica/acpica/pull/786 # [2]
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>
>>>>> Note: This change doesn't make any practical difference on any of the systems
>>>>> in my office.
>>>>>
>>>>> ---
>>>>>  drivers/acpi/acpica/evxfregn.c |   12 ++++++++++++
>>>>>  drivers/acpi/ec.c              |    7 +++++++
>>>>>  2 files changed, 19 insertions(+)
>>>>>
>>>>> Index: linux-pm/drivers/acpi/ec.c
>>>>> ===================================================================
>>>>> --- linux-pm.orig/drivers/acpi/ec.c
>>>>> +++ linux-pm/drivers/acpi/ec.c
>>>>> @@ -1632,6 +1632,13 @@ static int acpi_ec_add(struct acpi_devic
>>>>>                       acpi_handle_debug(ec->handle, "duplicated.\n");
>>>>>                       acpi_ec_free(ec);
>>>>>                       ec = boot_ec;
>>>>> +                     /*
>>>>> +                      * Uninstall the EC address space handler and let
>>>>> +                      * acpi_ec_setup() install it again along with
>>>>> +                      * evaluating _REG methogs associated with
>>>>> +                      * ACPI_ADR_SPACE_EC operation regions.
>>>>> +                      */
>>>>> +                     ec_remove_handlers(ec);
>>>>
>>>> This will call the _REG method to get called with ACPI_REG_DISCONNECT (0)
>>>> as second argument which may lead to unexpected consequences so I'm not
>>>> in favor of doing things this way.
>>>>
>>>> IMHO it would be much better to instead have flags; or if flags are
>>>> disliked a separate function to only call _REG later on.
>>>
>>> I'm aware of the _REG(EC, 0) part, but I thought that it might be the
>>> right thing to do.
>>>
>>> First off, I'm a bit concerned about leaving the EC address space
>>> handler attached to the root node after we have discovered the proper
>>> EC object in the namespace, because that's inconsistent with the "no
>>> ECDT" case.
>>
>> True, but in the ECDT case the EC opregion should work anywhere
>> according to the spec, so I believe it is consistent with the spec.
> 
> That's until the proper EC object is discovered, though.
> 
>>> It leaves a potential problem on the table too, because acpi_ec_add()
>>> changes boot_ec->handle from ACPI_ROOT_OBJECT to ec->handle and if
>>> ec_remove_handlers() is called for it after that, it will fail to
>>> remove the handler, but it will clear the
>>> EC_FLAGS_EC_HANDLER_INSTALLED flag (so the change above is actually
>>> incorrect, because it should remove the handler before changing
>>> boot_ec->handle).
>>
>> You are right, but this can be fixed by keeping track of the handle
>> used when registering the handler, e.g. something like this:
>>
>> From fceb436703bc8f0e29b7613246a83c039b631cb4 Mon Sep 17 00:00:00 2001
>> From: Hans de Goede <hdegoede@redhat.com>
>> Date: Thu, 4 Aug 2022 13:38:35 +0200
>> Subject: [PATCH] ACPI: EC: Fix EC address space handler unregistration
>>
>> When an ECDT table is present the EC address space handler gets registered
>> on the root node. So to unregister it properly the unregister call also
>> must be done on the root node.
>>
>> Store the ACPI handle used for the acpi_install_address_space_handler()
>> call and use te same handle for the acpi_remove_address_space_handler()
>> call.
>>
>> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/ec.c       | 4 +++-
>>  drivers/acpi/internal.h | 1 +
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 1e93677e4b82..6aa8210501d3 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -1483,6 +1483,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>                         return -ENODEV;
>>                 }
>>                 set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>> +               ec->address_space_handler_handle = ec->handle;
>>         }
>>
>>         if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>> @@ -1543,7 +1544,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>  static void ec_remove_handlers(struct acpi_ec *ec)
>>  {
>>         if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>> -               if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
>> +               if (ACPI_FAILURE(acpi_remove_address_space_handler(
>> +                                       ec->address_space_handler_handle,
>>                                         ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
>>                         pr_err("failed to remove space handler\n");
>>                 clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 628bf8f18130..140af11d0c39 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -173,6 +173,7 @@ enum acpi_ec_event_state {
>>
>>  struct acpi_ec {
>>         acpi_handle handle;
>> +       acpi_handle address_space_handler_handle;
>>         int gpe;
>>         int irq;
>>         unsigned long command_addr;
>> --
> 
> This works.
> 
> I would rename address_space_handler_handle to something like
> address_space_handler_holder.

Ok, I'll rename this for the official upstream submission.

>> This fixes ec_remove_handlers() without requiring (IMHO) risky changes
>> where we call _REG() multiple times.
>>
>> Also note that ec_remove_handlers() is only ever called from
>> acpi_ec_driver.remove which in practice never runs since the EC never
>> gets hot unplugged (arguably the entire remove code could be removed).
> 
> Indeed.
> 
>>> But in order to move the EC address space handler under the EC object,
>>> it needs to be uninstalled and for this purpose AML needs to be told
>>> that it's not there, so evaluating _REG(EC, 0) seems reasonable to me
>>> even though I agree that it is somewhat risky.
>>
>> I'm pretty worried that calling _REG(EC, 0) will cause problems
>> the _REG handlers run pretty early on and various BIOS/ACPI table
>> authors seem to (ab)use this to do some sort of early setup
>> of some things in _REG, That is pretty much how this whole thread
>> has started. Given all the weirdness some ACPI tables do in their
>> _REG handling running _REG 3 times:
>>
>> 1. _REG(EC, 1)
>> 2. _REG(EC, 0)
>> 3. _REG(EC, 1)
>>
>> really seems like a bad idea to me. I have the feeling that this is
>> asking for trouble.
> 
> OK, fair enough.
> 
>>> Second, the spec is kind of suggesting doing it (cf. the "These
>>> operation regions may become inaccessible after OSPM runs
>>> _REG(EmbeddedControl, 0)" comment in the _REG definition section).
>>
>> That is boilerplate documentation copy and pasted from all the
>> other address space handlers the spec defines. I'm not sure if
>> Windows ever actually calls _REG(EmbeddedControl, 0) and I would
>> not be surprised if Windows does not do this.
>>
>>> Moreover, I don't quite like the ACPI_NO_INSTALL_SPACE_HANDLER flag,
>>> because it causes the "handler installation" to actually do something
>>> else.
>>
>> As mentioned before (IIRC) I would be more then happy to respin both
>> the ACPICA as well as the Linux ACPI bits to introduce / use 2 new
>> functions for this, lets say:
>>
>> 1. acpi_install_address_space_handler_no__reg()
> 
> So we need this in ACPICA, because it doesn't make sense to drop and
> re-acquire the namespace mutex around _REG evaluation in the non-EC
> case.

Right, just like the flags changes in this RFC getting this fixed
will require some work on the ACPICA side + then Linux changes
using the new ACPICA functions.

> But as stated before I would prefer to introduce an
> acpi_install_address_space_handler_internal() taking an additional
> BOOL run__reg argument  and I would define
> acpi_install_address_space_handler() and the new
> acpi_install_address_space_handler_no__reg() as wrappers around it.

Right, that is how it will look like inside ACPICA, but API consumers
will just see a new acpi_install_address_space_handler_no__reg()
getting introduced.

> 
>> 2. acpi_run_address_space_handler__reg()
> 
> So this would just be a wrapper around acpi_ev_execute_reg_methods()
> that would acquire the namespace mutex around it, right?  [I think
> that it should also acquire acpi_gbl_namespace_rw_lock along the lines
> of acpi_walk_namespace(), though.]

Ack.

> I would call it acpi_execute_reg_methods() then.

acpi_execute_reg_methods() works for me.

I'll try to prepare a new ACPICA pull-req with the discussed
changes + a Linux series on top sometime the coming few weeks.

Regards,

Hans

