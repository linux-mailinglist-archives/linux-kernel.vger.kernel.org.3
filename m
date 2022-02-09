Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738DD4AF7C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiBIRF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiBIRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C1F9C050CE1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644426301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nGt1sk91AWrErDudwLdxz09p1Z/A3GC5vPQgc/7QHA=;
        b=RM/vMTHZRaHqS9d1YaB4LNqYq4OO3y1HP4fcKYVrc2m7x0j2LVczh9GG0N+Qc4m2eZqdTb
        cqc4yv7aP2+TyPJIyK5I8O+RQECs0s2ToY2DdW/pU4CYARe34x0GRGvtUdGw3fywj78Ar+
        uZNZmGdzRfOfs5LP6mrqCAwXSx/1g1Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-3Y7jE6-3NYKYzUZ542FMwg-1; Wed, 09 Feb 2022 12:04:57 -0500
X-MC-Unique: 3Y7jE6-3NYKYzUZ542FMwg-1
Received: by mail-wm1-f69.google.com with SMTP id f26-20020a7bc8da000000b0037bd7f39dbbso286368wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5nGt1sk91AWrErDudwLdxz09p1Z/A3GC5vPQgc/7QHA=;
        b=yjbGk5T4g0aaGnmCVK1/iPqSfpxwzyUqdfnYi9tlOj5kHNQSjSNZmfQLKcu92jQTBo
         5NXPZ+EuwF15FKy54SkU0l/2LYNFqJDpbmSF8k9DzOyBVQkTOFqgN/RIUqIyggxMm80Q
         31Nzsej6pe5yIDWqLQ666mm78vi/0fYok4ZM7WR/lyI748AEyTNR2ZCX19ZwVoffioco
         Ppf9ZksP3yUjqoXeG6+Rdj9mQmkfR2HOZJc3C7ufHSsfQVlhBNTkshAe5/rrr1Rrl6K/
         R75/eNrL2EX/QpYHAakekTRegHXPoXYfdzeycHZWNaTkzcUj/WaKGZfKp4knPLO9bgp6
         vUWw==
X-Gm-Message-State: AOAM532xuhA0ysuqCAMD5l/jBqbZ+Z5Spoz7lsD0dhFsmwFKvTgiWCyG
        WFFMqItTpPV5pkPWjdX+xWO8hPkYpy0v055pci5Fex6/6jRVk4/IwUH4WpYOnjOq4jIN+zMDBxm
        tQfOC95gKB7RQP3apzQYAzUSk
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr2859438wrv.449.1644426296217;
        Wed, 09 Feb 2022 09:04:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxz9gThGzXLX/giWr/W1JvBYUZrrvATgUCuQX0yG/Chw7zuZKfaPye67aCPQ6VfuNzsiGcx7w==
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr2859414wrv.449.1644426295970;
        Wed, 09 Feb 2022 09:04:55 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14sm5276066wmr.3.2022.02.09.09.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 09:04:55 -0800 (PST)
Message-ID: <46b671fd-3929-4cf0-1e0d-5f6305464238@redhat.com>
Date:   Wed, 9 Feb 2022 18:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
 <YgPbAL0I8Wn7nnNb@smile.fi.intel.com>
 <d32c731b-c06f-2dcb-5a6d-1a84351719b2@redhat.com>
 <CAMuHMdXsAyp18ivtSe-ZVmu6xbBBnvjMuZ=H1w9Gk=Ys4rkCeg@mail.gmail.com>
 <YgPuy1QVv9A7rcCh@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPuy1QVv9A7rcCh@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 17:41, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 05:25:03PM +0100, Geert Uytterhoeven wrote:
>> On Wed, Feb 9, 2022 at 5:07 PM Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
> 
> ...
> 
>> Are they all broken?
> 
> I guess it's incorrect question. The one we need to ask is is OF code broken?
> B/c ACPI can easily cope with this (they are different buses, can't clash).
> 

Yes, it's a problem specific to OF. It works correctly with both ACPI
and legacy platform code.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

