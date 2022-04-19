Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1509B507181
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353733AbiDSPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbiDSPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C0442983F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650381408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TprSd6iS8CwHEGbEo2Pp6pPvZm5RCS8b27XAexnlOdU=;
        b=Zum76MX55ZIj678gIB2rLy4M7fHC0ZvONojgLrzFEECANplf0kIXY2iQC2MRxw2b5iCP+A
        PQTeL46gO1H7NyAaq6j1r9qs5HE0tU4aUDBGzdgTJ0nx0lxQcjcaWEzEBTwwOvFQFTSbsN
        EkL62sBfxciX7D6OAjPFbSVEoYaT9zI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-59uCz-xVNtGdIkd0yePLEQ-1; Tue, 19 Apr 2022 11:16:47 -0400
X-MC-Unique: 59uCz-xVNtGdIkd0yePLEQ-1
Received: by mail-ej1-f69.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso6144810ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TprSd6iS8CwHEGbEo2Pp6pPvZm5RCS8b27XAexnlOdU=;
        b=Cf/NQ2OhZatYP/axx4C2kkUldvab9PB9FpgDWwUGZn+LpezK4PQ+sDrwvGRtIcfSg5
         sL5Ox17qIKcaU30EIDwWe6MsroxKNYDt9BbrjWA09VmWtrknN4IaPhb/bu0TZnWzzVNn
         a1m1IVkqRZm5Wdvs5qH/N5JmpJUunOIuT2iwNU9lAKEdVpxgYFOMqO/FTJSmYd0K0OnA
         fT6J6z4r/ReV8E6hfz+cCa1Esq+olD0rVMx6IhG7pXqo1gBb5T1g7krRtWJwUOOiRC47
         8pTT0rmS7yZI171L6VKvKpFb/EhwkgU2x28HAZqAeixkLEr6ksqHX1ULSLLY+iYGOQbK
         c5bw==
X-Gm-Message-State: AOAM532HDCdp1Om+c9QB8OeA+LhS9YH8TFtL+uic03Hhw2XdUTGdjC2P
        edw6Wc01cXa63MytMN+j1Tj70bYdDanKTDFczHFjbRJMqzZykyFohGTlCYNoNdyfAPUGzmOV4m1
        C7iVkntJF9pHWdBmOw6v31BPx
X-Received: by 2002:a05:6402:2707:b0:419:5b7d:fd21 with SMTP id y7-20020a056402270700b004195b7dfd21mr18080889edd.51.1650381406275;
        Tue, 19 Apr 2022 08:16:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw18CPPidZzM4Xbfwkt3ek9bzEBkyCPsPRICfPBrtlhrm7au+bNwcIyLgDqgRbU3/caGDQUfg==
X-Received: by 2002:a05:6402:2707:b0:419:5b7d:fd21 with SMTP id y7-20020a056402270700b004195b7dfd21mr18080855edd.51.1650381406015;
        Tue, 19 Apr 2022 08:16:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm5788338ejy.37.2022.04.19.08.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 08:16:45 -0700 (PDT)
Message-ID: <7fa9afde-5cc4-2e5d-30ac-ccc6ff4c8039@redhat.com>
Date:   Tue, 19 Apr 2022 17:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/3] x86/PCI: Log E820 clipping
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220419150344.GA1198281@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220419150344.GA1198281@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/19/22 17:03, Bjorn Helgaas wrote:
> On Tue, Apr 19, 2022 at 11:59:17AM +0200, Hans de Goede wrote:
>> On 1/1/70 01:00, Bjorn Helgaas wrote:
>>> This is still work-in-progress on the issue of PNP0A03 _CRS methods that
>>> are buggy or not interpreted correctly by Linux.
>>>
>>> The previous try at:
>>>   https://lore.kernel.org/r/20220304035110.988712-1-helgaas@kernel.org
>>> caused regressions on some Chromebooks:
>>>   https://lore.kernel.org/r/Yjyv03JsetIsTJxN@sirena.org.uk
>>>
>>> This v2 drops the commit that caused the Chromebook regression, so it also
>>> doesn't fix the issue we were *trying* to fix on Lenovo Yoga and Clevo
>>> Barebones.
>>>
>>> The point of this v2 update is to split the logging patch into (1) a pure
>>> logging addition and (2) the change to only clip PCI windows, which was
>>> previously hidden inside the logging patch and not well documented.
>>>
>>> Bjorn Helgaas (3):
>>>   x86/PCI: Eliminate remove_e820_regions() common subexpressions
>>>   x86: Log resource clipping for E820 regions
>>>   x86/PCI: Clip only host bridge windows for E820 regions
>>
>> Thanks, the entire series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Thank you!
> 
>> So what is the plan to actually fix the issue seen on some Lenovo models
>> and Clevo Barebones ?   As I mentioned previously I think that since all
>> our efforts have failed so far that we should maybe reconsider just
>> using DMI quirks to ignore the E820 reservation windows for host bridges
>> on affected models ?
> 
> I have been resisting DMI quirks but I'm afraid there's no other way.

Well there is the first match adjacent windows returned by _CRS and
only then do the "covers whole region" exception check. I still
think that would work at least for the chromebook regression...

So do you want me to give that a try; or shall I write a patch
using DMI quirks. And if we go the DMI quirks, what about
matching cmdline arguments?  If we add matching cmdline arguments,
which seems to be the sensible thing to do then to allow users
to test if they need the quirk, then we basically end up with my
first attempt at fixing this from 6 months ago:

https://lore.kernel.org/linux-pci/20211005150956.303707-1-hdegoede@redhat.com/

> I think the web we've gotten into, where vendors have used E820 to
> interact with _CRS in incompatible and undocumented ways, is not
> sustainable.
> 
> I'm not aware of any spec that says the OS should use E820 to clip
> things out of _CRS, so I think the long term plan should be to
> decouple them by default.

Right and AFAICT the reason Windows is getting away with this is
the same as with the original Dell _CRS has overlap with
physical RAM issue (1), Linux assigns address to unassigneds BAR-s
starting with the lowest available address in the bridge window,
where as Windows assigns addresses from the highest available
address in the window. So the real fix here might very well be
to rework the BAR assignment code to switch to fill the window
from the top rather then from the bottom. AFAICT all issues where
excluding _E820 reservations have helped are with _E820 - bridge
window overlaps at the bottom of the window.

IOW these are really all bugs in the _CRS method for the bridge,
which Windows does not hit because it never actually uses
the lowest address(es) of the _CRS returned window.

Regards,

Hans



1) At least I read in either a bugzilla, or email thread about
this that Windows allocating bridge window space from the top
was assumed to be why Windows was not impacted.





> Straw man:
> 
>   - Disable E820 clipping by default.
> 
>   - Add a quirk to enable E820 clipping for machines older than X,
>     e.g., 2023, to avoid breaking machines that currently work.
> 
>   - Add quirks to disable E820 clipping for individual machines like
>     the Lenovo and Clevos that predate X, but E820 clipping breaks
>     them.
> 
>   - Add quirks to enable E820 clipping for individual machines like
>     the Chromebooks (and probably machines we don't know about yet)
>     that have devices that consume part of _CRS but are not
>     enumerable.
> 
>   - Communicate this to OEMs to try to prevent future machines that
>     need quirks.
> 
> Bjorn
> 

