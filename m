Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA725203A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiEIRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiEIRh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 722D41882E6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652117611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrOryVoiPth4NEXB/BcHFi4CDETprY0Y6T3t1K6jM1o=;
        b=XWtcTwaQO2P77oTj4pMMvVdC7DjUcTMnMGWGprMinzDe732aZDd0FKIkmdi1Sz3GM+5Uf4
        s/KY1+JwWx1sSZ+aoKTSnhnJhuoQa1mEdMPVfEOKV+wnuK+XKUKjMBcGgvAVmhB+iqLrfd
        Zwh57EhAS5w9gSRgptDVwz3PCDyTtNY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-g1lsrpphPqOcXfj0BvhesA-1; Mon, 09 May 2022 13:33:30 -0400
X-MC-Unique: g1lsrpphPqOcXfj0BvhesA-1
Received: by mail-ed1-f71.google.com with SMTP id s29-20020a50ab1d000000b00427e495f00cso8709136edc.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 10:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BrOryVoiPth4NEXB/BcHFi4CDETprY0Y6T3t1K6jM1o=;
        b=FJiLi2S4IHEt/gOwpCFm4fnV45M8oSckUXhU2AYPYXMmwnZ/3SBlmgjunm3IVKWbHD
         ohFefQFTETS5/+TXRdVUoxOg3ttUvLjI33ntxK+yzuT0Ui68jGUXf5UeJwQVE34Ctidg
         fjtpfi4zcKVpvjPXmMP1BWeZRKmJ5oHyYkBlbi1KHx4wnXYooMhs0CJ+joG/I4T8SUEO
         a44dz9ZG47RzW0vm2FROwQeasjeZgnr+jv4uOYW+zPMs5lYrYOOX9fZr6tTMrj9fDSPD
         QdQa3vBHMqY+3HgB1wJBvxqnQ8R3QWFJRTn2ZoU/gDE+ORwxANFmrr29HT++pJx5m0nw
         Sv8g==
X-Gm-Message-State: AOAM532m6M8mo5KVaLe5jJMYD87dN3uftjJUYb6fdloKdf5TCBJm7crq
        G3/DdbrB78vV4vZakUCPW167tBL7AxFiMBKFpb55xx6WK27d15rVm4wVW5Gy3t3NoA4PnzaYLQ0
        a4frrXGnDAcN1QgoSfWfj3mkV
X-Received: by 2002:a17:906:79c4:b0:6cf:5489:da57 with SMTP id m4-20020a17090679c400b006cf5489da57mr15435345ejo.48.1652117608881;
        Mon, 09 May 2022 10:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaavMaXxuM8ysKOeG2C2lbbsIb3Vfw0b+bxtCrrx8ajotBokbYemcoj+TK9IdWhzV0vUW+mg==
X-Received: by 2002:a17:906:79c4:b0:6cf:5489:da57 with SMTP id m4-20020a17090679c400b006cf5489da57mr15435313ejo.48.1652117608590;
        Mon, 09 May 2022 10:33:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d26-20020a056402079a00b004288d9c0b0asm2927448edy.34.2022.05.09.10.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 10:33:28 -0700 (PDT)
Message-ID: <3e92c4b6-8976-2bd4-ebe2-465990eb66d2@redhat.com>
Date:   Mon, 9 May 2022 19:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220507153142.GA568130@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220507153142.GA568130@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/7/22 17:31, Bjorn Helgaas wrote:
> On Sat, May 07, 2022 at 12:09:03PM +0200, Hans de Goede wrote:
>> Hi Bjorn,
>>
>> On 5/6/22 18:51, Bjorn Helgaas wrote:
>>> On Thu, May 05, 2022 at 05:20:16PM +0200, Hans de Goede wrote:
>>>> Some BIOS-es contain bugs where they add addresses which are already
>>>> used in some other manner to the PCI host bridge window returned by
>>>> the ACPI _CRS method. To avoid this Linux by default excludes
>>>> E820 reservations when allocating addresses since 2010, see:
>>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>>>> space").
>>>>
>>>> Recently (2019) some systems have shown-up with E820 reservations which
>>>> cover the entire _CRS returned PCI bridge memory window, causing all
>>>> attempts to assign memory to PCI BARs which have not been setup by the
>>>> BIOS to fail. For example here are the relevant dmesg bits from a
>>>> Lenovo IdeaPad 3 15IIL 81WE:
>>>>
>>>>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>>>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>>>
>>>> The ACPI specifications appear to allow this new behavior:
>>>>
>>>> The relationship between E820 and ACPI _CRS is not really very clear.
>>>> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
>>>>
>>>>   This range of addresses is in use or reserved by the system and is
>>>>   not to be included in the allocatable memory pool of the operating
>>>>   system's memory manager.
>>>>
>>>> and it may be used when:
>>>>
>>>>   The address range is in use by a memory-mapped system device.
>>>>
>>>> Furthermore, sec 15.2 says:
>>>>
>>>>   Address ranges defined for baseboard memory-mapped I/O devices, such
>>>>   as APICs, are returned as reserved.
>>>>
>>>> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
>>>> and its apertures are in use and certainly should not be included in
>>>> the general allocatable pool, so the fact that some BIOS-es reports
>>>> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
>>>>
>>>> So it seems that the excluding of E820 reserved addresses is a mistake.
>>>>
>>>> Ideally Linux would fully stop excluding E820 reserved addresses,
>>>> but then various old systems will regress.
>>>> Instead keep the old behavior for old systems, while ignoring
>>>> the E820 reservations for any systems from now on.
>>>>
>>>> Old systems are defined here as BIOS year < 2018, this was chosen to
>>>> make sure that pci_use_e820 will not be set on the currently affected
>>>> systems, the oldest known one is from 2019.
>>>>
>>>> Testing has shown that some newer systems also have a bad _CRS return.
>>>> The pci_crs_quirks DMI table is used to keep excluding E820 reservations
>>>> from the bridge window on these systems.
>>>>
>>>> Also add pci=no_e820 and pci=use_e820 options to allow overriding
>>>> the BIOS year + DMI matching logic.
>>>>
>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>>>> BugLink: https://bugs.launchpad.net/bugs/1878279
>>>> BugLink: https://bugs.launchpad.net/bugs/1931715
>>>> BugLink: https://bugs.launchpad.net/bugs/1932069
>>>> BugLink: https://bugs.launchpad.net/bugs/1921649
>>>> Cc: Benoit Grégoire <benoitg@coeus.ca>
>>>> Cc: Hui Wang <hui.wang@canonical.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>>> +	 * Ideally Linux would fully stop using E820 reservations, but then
>>>> +	 * various old systems will regress. Instead keep the old behavior for
>>>> +	 * old systems + known to be broken newer systems in pci_crs_quirks.
>>>> +	 */
>>>> +	if (year >= 0 && year < 2018)
>>>> +		pci_use_e820 = true;
>>>
>>> How did you pick 2018?  Prior to this patch, we used E820 reservations
>>> for all machines.  This patch would change that for 2019-2022
>>> machines, so there's a risk of breaking some of them.
>>
>> Correct. I picked 2018 because the first devices where using E820
>> reservations are causing issues (i2c controller not getting resources
>> leading to non working touchpad / thunderbolt hotplug issues) have
>> BIOS dates starting in 2019. I added a year margin, so we could make
>> this 2019.
>>
>>> I'm hesitant about changing the behavior for machines already in the
>>> field because if they were tested at all with Linux, it was without
>>> this patch.  So I would lean toward preserving the current behavior
>>> for BIOS year < 2023.
>>
>> I see, I presume the idea is to then use DMI to disable E820 clipping
>> on current devices where this is known to cause problems ?
>>
>> So for v8 I would:
>>
>> 1. Change the cut-off check to < 2023
>> 2. Drop the DMI quirks I added for models which are known to need E820
>>    clipping hit by the < 2018 check
>> 3. Add DMI quirks for models for which it is known that we must _not_
>>    do E820 clipping
>>
>> Is this the direction you want to go / does that sound right?
> 
> Yes, I think that's what we should do.  All the machines in the field
> will be unaffected, except that we add quirks for known problems.

I've been working on this today. I've mostly been going through
the all the existing bugs about this, to make a list of DMI matches
for devices on which we should _not_ do e820 clipping to fix th
kernel being unable to assign BARs there.

I've found an interesting pattern there, all affected devices
are Lenovo devices with "IIL" in there device name, e.g. :
"IdeaPad 3 15IIL05". I've looked up all Lenovo devices which
have "IIL" as part of their DMI_PRODUCT_VERSION string here:
https://github.com/linuxhw/DMI/

And then looked them up at https://linux-hardware.org/ and checked
their dmesg to see if they have the e820 problem other ideapads
have. I've gone through approx. half the list now and all
except one model seem to have the e820 problem.

So it looks like we might be able to match all problem models
with a single DMI match.

So the problem seems to be limited to one specific device
series / range and this is making me have second thoughts
about doing a date based cut-off at all. Trying to switch
over any models which are new in 2023 is fine, the problem
with a DMI BIOS date approach though is that as soon as some
new management-engine CVE comes out we will also see BIOS
updates with a year of 2023 for many existing models, of
up to 3-4 years old at least; and chances are that some of
those older models getting BIOS updates will be bitten by
this change.

So as said I'm having second thoughts about the date based
approach. Bjorn, what do you think of just using DMI quirks
to disable e820 clipping on known problematic models and
otherwise keeping things as is ?

Note I'm also fine with going with the 2023 date based
approach, I'm just wondering if that will be a good idea
and not something which we might regret later.

Regards,

Hans


p.s.

I've seen your email about the Acer laptop; I'll take
a look at that coming Wednesday.

