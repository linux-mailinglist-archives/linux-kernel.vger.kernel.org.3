Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D248A1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbiAJVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:25:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344461AbiAJVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641849939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZwslwgP+oh5aspfJM1SMOOPqxe5XZQW+9MccJZxeWQ=;
        b=Mxv7LM7eg7SGgjgEVzcD7ofeTfUnuU88hX8/SIj50maR2J0BmSmEYM9LTwCy7gV9qC1+z1
        sn9LDl0aeQJ7//GGr27aWuekuPugQu7/ZdVxgAbY59YBxsBNpC0NDocPOM1pVJqKNI0k0a
        iQewy0RnL7JVpocbiLxGIv6/Pe+3k8o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-iGG1DP4uN_aTFUARfqzjng-1; Mon, 10 Jan 2022 16:25:36 -0500
X-MC-Unique: iGG1DP4uN_aTFUARfqzjng-1
Received: by mail-ed1-f72.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso11307456edd.22
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XZwslwgP+oh5aspfJM1SMOOPqxe5XZQW+9MccJZxeWQ=;
        b=dIrdW2E5CxDjhwtuBCURCGrRUV/U2/d2ixoYv2gbvAvwdxwovnS0DWr7IKhzMrP1w0
         VQL9jDwgcWk3AykbnA04Ee9GavEE3KIV9tCbstw7HqXXAeIJu+Q1eKkpVoCy7clrmpti
         jKwUob/ZZvoDNDQnEdMbENUaY6x94wzSXUQHqx6VhifVYZ4w//9i5U4etlaDxhGYpunK
         LPmVWnesS99EOTmus+6dY8E//22n3ijNXcYU/pW+puEKJYxURu6KzqFwaC90b5sVX9CA
         Z1NVGkEsUT0WMebTRcvaZhCq0Wnm/kIqJhF32Wl47bRB47AGWReeP9n7JxFGdoO/ZYVt
         8xuQ==
X-Gm-Message-State: AOAM530MMbT97SDCOXgvYqd0+IcKx9R0vedBP4XS2P37ZB3a9AgC1Xs+
        nlpx4abpdOWn8LP3YH42nJDw+gScPzkx7UpoWrcOU9PnEP6ZJqMPO0S5yVv2NRvh/GsL3NIWgau
        IbUISImm2RVPQyMmmNqLxY8oS
X-Received: by 2002:a17:906:2a48:: with SMTP id k8mr1283894eje.758.1641849934912;
        Mon, 10 Jan 2022 13:25:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBhmbGGnZjgkUeKScpwDdJY+XydMkS+ToXpC2fefpuPgiCRCJvCwxI9hGbgy9OMa8FNndoyg==
X-Received: by 2002:a17:906:2a48:: with SMTP id k8mr1283870eje.758.1641849934650;
        Mon, 10 Jan 2022 13:25:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id la10sm2830302ejc.22.2022.01.10.13.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 13:25:34 -0800 (PST)
Message-ID: <3f85e298-2e55-2190-21b7-596cfc8388aa@redhat.com>
Date:   Mon, 10 Jan 2022 22:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, stable@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220110171123.GA60297@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220110171123.GA60297@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/10/22 18:11, Bjorn Helgaas wrote:
> On Mon, Jan 10, 2022 at 12:41:37PM +0100, Hans de Goede wrote:
>> Hi All,
>>
>> On 12/17/21 15:13, Hans de Goede wrote:
>>> Some BIOS-es contain a bug where they add addresses which map to system
>>> RAM in the PCI host bridge window returned by the ACPI _CRS method, see
>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>>> space").
>>>
>>> To work around this bug Linux excludes E820 reserved addresses when
>>> allocating addresses from the PCI host bridge window since 2010.
>>>
>>> Recently (2019) some systems have shown-up with E820 reservations which
>>> cover the entire _CRS returned PCI bridge memory window, causing all
>>> attempts to assign memory to PCI BARs which have not been setup by the
>>> BIOS to fail. For example here are the relevant dmesg bits from a
>>> Lenovo IdeaPad 3 15IIL 81WE:
>>>
>>>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>>
>>> The ACPI specifications appear to allow this new behavior:
>>>
>>> The relationship between E820 and ACPI _CRS is not really very clear.
>>> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
>>>
>>>   This range of addresses is in use or reserved by the system and is
>>>   not to be included in the allocatable memory pool of the operating
>>>   system's memory manager.
>>>
>>> and it may be used when:
>>>
>>>   The address range is in use by a memory-mapped system device.
>>>
>>> Furthermore, sec 15.2 says:
>>>
>>>   Address ranges defined for baseboard memory-mapped I/O devices, such
>>>   as APICs, are returned as reserved.
>>>
>>> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
>>> and its apertures are in use and certainly should not be included in
>>> the general allocatable pool, so the fact that some BIOS-es reports
>>> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
>>>
>>> So it seems that the excluding of E820 reserved addresses is a mistake.
>>>
>>> Ideally Linux would fully stop excluding E820 reserved addresses,
>>> but then the old systems this was added for will regress.
>>> Instead keep the old behavior for old systems, while ignoring
>>> the E820 reservations for any systems from now on.
>>>
>>> Old systems are defined here as BIOS year < 2018, this was chosen to make
>>> sure that E820 reservations will not be used on the currently affected
>>> systems, while at the same time also taking into account that the systems
>>> for which the E820 checking was originally added may have received BIOS
>>> updates for quite a while (esp. CVE related ones), giving them a more
>>> recent BIOS year then 2010.
>>>
>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>>> BugLink: https://bugs.launchpad.net/bugs/1878279
>>> BugLink: https://bugs.launchpad.net/bugs/1931715
>>> BugLink: https://bugs.launchpad.net/bugs/1932069
>>> BugLink: https://bugs.launchpad.net/bugs/1921649
>>> Cc: Benoit Grégoire <benoitg@coeus.ca>
>>> Cc: Hui Wang <hui.wang@canonical.com>
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v6:
>>> - Remove the possibility to change the behavior from the commandline
>>>   because of worries that users may use this to paper over other problems
>>
>> ping ?
> 
> Thanks, Hans.  Maybe I'm quixotic, but I'm still hoping for an
> approach based on firmware behavior instead of firmware date.  If
> nobody else tries, I will eventually try myself, but I don't have any
> ETA.

I really do NOT see how doing a better approach later blocks
merging the date based fix now ?

The date based approach can simply be replaced by any better
solution later.

Can we please merge the date based approach now so peoples broken
systems get fixed now, rather then at some unknown later time ?

Regards,

Hans

