Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B95589B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiHDL6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbiHDL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB0E2A703
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659614273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=046ape5Wb7onU8FDz6cHK1U7hcZQ095PgL4YhXCnX3o=;
        b=ChFDIzhRPTatiZp9aIl+JQPK0RbT+ZGwyrxYsfXuOQzVfcy7SOPxS4XJicBVlLyDskFQ4X
        /Me/tDo8UPLSgV1rAFqtLcAJhXlLwPocBezdgDlpdEBcLt8GHNzxgmPSINLXMF6hLbL7Nz
        UuW+FntknGTKGfOcj5rP8x6aM2Fngeg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-HfoN02yMPCaoVE-6i10BKg-1; Thu, 04 Aug 2022 07:57:52 -0400
X-MC-Unique: HfoN02yMPCaoVE-6i10BKg-1
Received: by mail-ej1-f71.google.com with SMTP id sh10-20020a1709076e8a00b007307a683095so3733295ejc.15
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=046ape5Wb7onU8FDz6cHK1U7hcZQ095PgL4YhXCnX3o=;
        b=osn3cWO58mmcu9S2/r0UfISbeKA6vmw3M4DQQoyHSXmhjAM9xHof47nIwwcDZ0SICC
         XdsCuTsBy+1XejhQgm/DMmWUCig9Uq92BYvhkuRyAozQgOcgpapTcTe3h8mYnly2tUo8
         2Bq+U55DVjbx/ATQduSJz8uIt3NcPyaVgz3Xj4DcwjQ41cksIX/PzA1YiqHWbHQpzt9Y
         DAbUxaSv5/w493Ocmdwo/8QtSrIOrrNL0pWUim2uKYJgDNUy3je8rfZp+TtNn3GswxdU
         MDoYLJMRkrkj+K+KebJ+hLiPqOSmGakqWGS1SqpsbL/k1ggkQTd/R6GPvv+xg6LWkmi4
         f+aw==
X-Gm-Message-State: ACgBeo0hWGyLFWIWP22F8+nMFxDUV2AC3K6hvmkx1vTp/cc9DpKevA61
        ps5zp+YuL+BDj2pNkYJYtXeTTpc6dvBgGMES7hXfbWHtyzAT/xiajyP5GQAghJUxy8JzGAn4ddX
        7eLMO25ZO0AY+1EOvX/d9dYUT
X-Received: by 2002:aa7:c948:0:b0:43c:78d2:8dd7 with SMTP id h8-20020aa7c948000000b0043c78d28dd7mr1646248edt.370.1659614270507;
        Thu, 04 Aug 2022 04:57:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR60VHkiRiBskOkj1uzhYOtJ8Yw/4GOLhLjClGHILFFLJwFs4d7voxMGlcmEtTW0JcyNsyqhVw==
X-Received: by 2002:aa7:c948:0:b0:43c:78d2:8dd7 with SMTP id h8-20020aa7c948000000b0043c78d28dd7mr1646237edt.370.1659614270318;
        Thu, 04 Aug 2022 04:57:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id gk23-20020a17090790d700b00730560156b0sm276953ejb.50.2022.08.04.04.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 04:57:49 -0700 (PDT)
Message-ID: <29f01ef7-03f7-817b-630b-52be72c83396@redhat.com>
Date:   Thu, 4 Aug 2022 13:57:49 +0200
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jPpsO4OkC=3ZkEwKzQWufwrt6YwMhNv8heEC12chDPTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Sorry for the slow response...

On 7/7/22 21:31, Rafael J. Wysocki wrote:
> On Wed, Jul 6, 2022 at 10:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 7/6/22 14:37, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> acpi_ec_ecdt_probe() is called between acpi_load_tables() and
>>> acpi_enable_subsystem().  It passes ACPI_ROOT_OBJECT as ec->handle
>>> to acpi_ec_setup() and so ACPI_ROOT_OBJECT is passed to
>>> acpi_install_address_space_handler() via ec_install_handlers().
>>>
>>> Next, acpi_ns_validate_handle() converts it to acpi_gbl_root_node
>>> which is passed to acpi_ev_install_space_handler() and the handler is
>>> installed for acpi_gbl_root_node.
>>>
>>> Now, acpi_gbl_root_node is passed to acpi_ev_execute_reg_methods() which
>>> evaluates _REG for any ACPI_ADR_SPACE_EC regions it can find in the
>>> namespace which should not be necessary, because the OS is expected to
>>> make the ECDT operation regions available before evaluating any AML, so
>>> in particular AML is not expected to check the evaluation of _REG before
>>> it accesses these operation regions (see ACPI 6.4, Section 6.5.4,
>>> exception 2 [1]).  Doing that is also problematic, because the _REG
>>> methods for the ACPI_ADR_SPACE_EC regions may depend on various _INI, so
>>> they should be be evaluated before running acpi_initialize_objects() [2].
>>>
>>> Address this problem by modifying acpi_install_address_space_handler()
>>> to avoid evaluating _REG for ACPI_ADR_SPACE_EC regions when the handler
>>> is installed for acpi_gbl_root_node which indicates the ECDT case.
>>>
>>> However, this needs to be accompanied by an EC driver change to
>>> actually trigger the evaluation of _REG for the ACPI_ADR_SPACE_EC
>>> regions when it finds the EC object in the namespace.
>>>
>>> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#reg-region # [1]
>>> Link: https://github.com/acpica/acpica/pull/786 # [2]
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> Note: This change doesn't make any practical difference on any of the systems
>>> in my office.
>>>
>>> ---
>>>  drivers/acpi/acpica/evxfregn.c |   12 ++++++++++++
>>>  drivers/acpi/ec.c              |    7 +++++++
>>>  2 files changed, 19 insertions(+)
>>>
>>> Index: linux-pm/drivers/acpi/ec.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/ec.c
>>> +++ linux-pm/drivers/acpi/ec.c
>>> @@ -1632,6 +1632,13 @@ static int acpi_ec_add(struct acpi_devic
>>>                       acpi_handle_debug(ec->handle, "duplicated.\n");
>>>                       acpi_ec_free(ec);
>>>                       ec = boot_ec;
>>> +                     /*
>>> +                      * Uninstall the EC address space handler and let
>>> +                      * acpi_ec_setup() install it again along with
>>> +                      * evaluating _REG methogs associated with
>>> +                      * ACPI_ADR_SPACE_EC operation regions.
>>> +                      */
>>> +                     ec_remove_handlers(ec);
>>
>> This will call the _REG method to get called with ACPI_REG_DISCONNECT (0)
>> as second argument which may lead to unexpected consequences so I'm not
>> in favor of doing things this way.
>>
>> IMHO it would be much better to instead have flags; or if flags are
>> disliked a separate function to only call _REG later on.
> 
> I'm aware of the _REG(EC, 0) part, but I thought that it might be the
> right thing to do.
> 
> First off, I'm a bit concerned about leaving the EC address space
> handler attached to the root node after we have discovered the proper
> EC object in the namespace, because that's inconsistent with the "no
> ECDT" case.

True, but in the ECDT case the EC opregion should work anywhere
according to the spec, so I believe it is consistent with the spec.

> It leaves a potential problem on the table too, because acpi_ec_add()
> changes boot_ec->handle from ACPI_ROOT_OBJECT to ec->handle and if
> ec_remove_handlers() is called for it after that, it will fail to
> remove the handler, but it will clear the
> EC_FLAGS_EC_HANDLER_INSTALLED flag (so the change above is actually
> incorrect, because it should remove the handler before changing
> boot_ec->handle).

You are right, but this can be fixed by keeping track of the handle
used when registering the handler, e.g. something like this:

From fceb436703bc8f0e29b7613246a83c039b631cb4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 4 Aug 2022 13:38:35 +0200
Subject: [PATCH] ACPI: EC: Fix EC address space handler unregistration

When an ECDT table is present the EC address space handler gets registered
on the root node. So to unregister it properly the unregister call also
must be done on the root node.

Store the ACPI handle used for the acpi_install_address_space_handler()
call and use te same handle for the acpi_remove_address_space_handler()
call.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ec.c       | 4 +++-
 drivers/acpi/internal.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1e93677e4b82..6aa8210501d3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1483,6 +1483,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 			return -ENODEV;
 		}
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
+		ec->address_space_handler_handle = ec->handle;
 	}
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
@@ -1543,7 +1544,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
 	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
-		if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
+		if (ACPI_FAILURE(acpi_remove_address_space_handler(
+					ec->address_space_handler_handle,
 					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 			pr_err("failed to remove space handler\n");
 		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 628bf8f18130..140af11d0c39 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -173,6 +173,7 @@ enum acpi_ec_event_state {
 
 struct acpi_ec {
 	acpi_handle handle;
+	acpi_handle address_space_handler_handle;
 	int gpe;
 	int irq;
 	unsigned long command_addr;
--

This fixes ec_remove_handlers() without requiring (IMHO) risky changes
where we call _REG() multiple times.

Also note that ec_remove_handlers() is only ever called from
acpi_ec_driver.remove which in practice never runs since the EC never
gets hot unplugged (arguably the entire remove code could be removed).

> But in order to move the EC address space handler under the EC object,
> it needs to be uninstalled and for this purpose AML needs to be told
> that it's not there, so evaluating _REG(EC, 0) seems reasonable to me
> even though I agree that it is somewhat risky.

I'm pretty worried that calling _REG(EC, 0) will cause problems
the _REG handlers run pretty early on and various BIOS/ACPI table
authors seem to (ab)use this to do some sort of early setup
of some things in _REG, That is pretty much how this whole thread
has started. Given all the weirdness some ACPI tables do in their
_REG handling running _REG 3 times:

1. _REG(EC, 1)
2. _REG(EC, 0)
3. _REG(EC, 1)

really seems like a bad idea to me. I have the feeling that this is
asking for trouble.

> Second, the spec is kind of suggesting doing it (cf. the "These
> operation regions may become inaccessible after OSPM runs
> _REG(EmbeddedControl, 0)" comment in the _REG definition section).

That is boilerplate documentation copy and pasted from all the
other address space handlers the spec defines. I'm not sure if
Windows ever actually calls _REG(EmbeddedControl, 0) and I would
not be surprised if Windows does not do this.

> Moreover, I don't quite like the ACPI_NO_INSTALL_SPACE_HANDLER flag,
> because it causes the "handler installation" to actually do something
> else.

As mentioned before (IIRC) I would be more then happy to respin both
the ACPICA as well as the Linux ACPI bits to introduce / use 2 new
functions for this, lets say:

1. acpi_install_address_space_handler_no__reg()
2. acpi_run_address_space_handler__reg()

?

Regards,

Hans


> 
>>>               }
>>>       }
>>>
>>> Index: linux-pm/drivers/acpi/acpica/evxfregn.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/acpica/evxfregn.c
>>> +++ linux-pm/drivers/acpi/acpica/evxfregn.c
>>> @@ -78,6 +78,18 @@ acpi_install_address_space_handler(acpi_
>>>               goto unlock_and_exit;
>>>       }
>>>
>>> +     /*
>>> +      * Avoid evaluating _REG methods if an EC address space handler is
>>> +      * installed for acpi_gbl_root_node, because this is done in order to
>>> +      * make Embedded Controller operation regions, accessed via the Embedded
>>> +      * Controllers described in ECDT, available early (see ACPI 6.4, Section
>>> +      * 6.5.4, exception 2).
>>> +      */
>>> +
>>> +     if (node == acpi_gbl_root_node || space_id == ACPI_ADR_SPACE_EC) {
>>> +             goto unlock_and_exit;
>>> +     }
>>> +
>>
>> Hmm, I like this in that it is KISS. But OTOH this does mean that
>> acpi_install_address_space_handler() now behaves differently depending on its
>> parameters in a possibly surprising way. So IMHO this feels a bit too clever
>> for our own good, since it may surprise the callers of this function.
>>
>> My biggest problem is, that as indicated above I believe that instead
>> of uninstalling + re-installing the handler we really need to have a way
>> to just call _REG later; and that in turn requires the caller to know if
>> _REG has run or not.
> 
> Well, as stated above, I think it would be prudent to move the handler
> under the EC object proper once it has been discovered.
> 
>> I've posted a new RFC patch series which adds flags to
>> acpi_install_address_space_handler() to not run / only run _REG :
>>
>> https://lore.kernel.org/linux-acpi/20220706201410.88244-1-hdegoede@redhat.com/
>>
>> this then gets used in the drivers/acpi/ec.c patch to defer calling _REG when
>> registering the handler based on the ECDT until the DSDT EC entry is parsed.
>> I personally like how this turns out and IMHO this is cleaner (less hackish)
>> then the proposed solution with calling ec_remove_handlers(ec) :
>>
>> https://lore.kernel.org/linux-acpi/20220706201410.88244-3-hdegoede@redhat.com/
> 
> Overall, I think that we'll need a new "no _REG" variant of
> acpi_install_address_space_handler(), at least for backward
> compatibility with other OSes using ACPICA, but I would call it
> acpi_install_address_space_handler_no_reg() and do all of the flags
> (or BOOL for that matter) passing internally in evxfregn.c.
> 
> Thanks!
> 

