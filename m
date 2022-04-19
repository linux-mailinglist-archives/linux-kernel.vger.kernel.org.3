Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1287C506826
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbiDSKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiDSKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E23E2253D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650362363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYCbCMusX5qnw2HYP1MeCveqjGocg9sXBdk9ZKPneIA=;
        b=Thwk5o7GlihFoojS/x1bNX6b0IQX0L60zR6QZBD91tau2qL3K1ezwNe0FpVtpfC70nPAJO
        j1ys3833bXC6U/gFkQcd/WJjEuidAlcp9dusaEb98zOo/JneFADp7AJh6GAMCf7HcIdwb0
        1ZiWMAzfnqfgQM/EH/2qg25NoCgYRkw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-wRAoStKBNJSYVhe0iNQwWw-1; Tue, 19 Apr 2022 05:59:20 -0400
X-MC-Unique: wRAoStKBNJSYVhe0iNQwWw-1
Received: by mail-ed1-f71.google.com with SMTP id cn27-20020a0564020cbb00b0041b5b91adb5so10672813edb.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZYCbCMusX5qnw2HYP1MeCveqjGocg9sXBdk9ZKPneIA=;
        b=qeowRbpqIjH+lS63v6sk8NxcFv1Jw7gzGeFQLqO83LJAL/Jbjk00YV4vZhK/v7jQYa
         ZvmrTu1vJkXg6nYxJtjGBqPcjTUh9IyhRwtTZXNY07vwvEsIoN8Ve2s4V4Ukdvig8qKW
         dn+yySgxhS4Z3SK6VZ7RJ77Hz4otDNGgq8aHkNuhplha9HbFf5hK/URtx0EFPAdRfVSf
         RjayckoTbMJU1W5qVOHfj24r5aN87DMslQDb8koyeqfVWVaa8deIhLbu7DYD+wiywVnL
         DOLwffCSinWQ4QY8P5+y3E7bbbLFCuCii0AP178aMxK3c4IGNS1e2bmkwlCcVUvJJNSK
         HOHw==
X-Gm-Message-State: AOAM532OQNBkpVehdWwXPHfMB/PkxP5ykaYskt2XmRcZhND6I2H1Iir8
        7eyTUQVmk4AN11NmGMgiR3tNvDshotXe2F9rq+p5oH80m4+4wRdtz8LMwwDzhnNRl9Hsy0MDdC+
        jD4evU/jqqDFwnu3RS6S3e7hh
X-Received: by 2002:a17:907:96a1:b0:6e8:9dce:c3bc with SMTP id hd33-20020a17090796a100b006e89dcec3bcmr12479265ejc.589.1650362359322;
        Tue, 19 Apr 2022 02:59:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPj/oCA2jmmG43YRFtvikiwgaJYI1/P+OfA2QaPriTfw/gSnUO1tnTCTWh6or2Q3Awqulg1A==
X-Received: by 2002:a17:907:96a1:b0:6e8:9dce:c3bc with SMTP id hd33-20020a17090796a100b006e89dcec3bcmr12479257ejc.589.1650362359077;
        Tue, 19 Apr 2022 02:59:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id vw17-20020a170907059100b006e8732d1944sm5460828ejb.5.2022.04.19.02.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:59:18 -0700 (PDT)
Message-ID: <d75ede81-49da-855a-6679-c3315089e067@redhat.com>
Date:   Tue, 19 Apr 2022 11:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/3] x86/PCI: Log E820 clipping
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220414182252.758742-1-helgaas@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220414182252.758742-1-helgaas@kernel.org>
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

Hi All,

On 1/1/70 01:00, Bjorn Helgaas wrote:
> This is still work-in-progress on the issue of PNP0A03 _CRS methods that
> are buggy or not interpreted correctly by Linux.
> 
> The previous try at:
>   https://lore.kernel.org/r/20220304035110.988712-1-helgaas@kernel.org
> caused regressions on some Chromebooks:
>   https://lore.kernel.org/r/Yjyv03JsetIsTJxN@sirena.org.uk
> 
> This v2 drops the commit that caused the Chromebook regression, so it also
> doesn't fix the issue we were *trying* to fix on Lenovo Yoga and Clevo
> Barebones.
> 
> The point of this v2 update is to split the logging patch into (1) a pure
> logging addition and (2) the change to only clip PCI windows, which was
> previously hidden inside the logging patch and not well documented.
> 
> Bjorn Helgaas (3):
>   x86/PCI: Eliminate remove_e820_regions() common subexpressions
>   x86: Log resource clipping for E820 regions
>   x86/PCI: Clip only host bridge windows for E820 regions

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series.

So what is the plan to actually fix the issue seen on some Lenovo models
and Clevo Barebones ?   As I mentioned previously I think that since all
our efforts have failed so far that we should maybe reconsider just
using DMI quirks to ignore the E820 reservation windows for host bridges
on affected models ?

That or implement 3 of:

> So I think the progression is:
>
>  1) Remove anything mentioned in E820 from _CRS (4dc2287c1805 [7]).
>     This worked around some issues on Dell systems.
>
>  2) Remove things mentioned in E820 unless they cover the entire
>     window (5949965ec934 [8])
>
>  3) Coalesce adjacent _CRS windows, *then* remove things mentioned in
>     E820 unless they cover the entire (coalesced) window (current
>     proposal)

Regards,

Hans

