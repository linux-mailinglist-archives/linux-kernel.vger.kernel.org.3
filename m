Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5B4FF9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiDMPFC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Apr 2022 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiDMPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:05:01 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5BBCB7;
        Wed, 13 Apr 2022 08:02:39 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t67so4291200ybi.2;
        Wed, 13 Apr 2022 08:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o9E/Fd7er8vrzR0hoxKbsRBehNgp7Hi5w+aGqta8LVo=;
        b=ZlRSDXEc2BnD8fX8ZA/Kt5qnOc/F89MunXvVsKcLuxTmaSX7/2V+LtgkuDwD6KTFHS
         QaloyzY+RuRM8Kdq4sDB8sNF1SpKhf2eOdR3XD1CZiAG+wDL1gCgldGB52bBq6hy2rmX
         DcdOkrATFiQyzy9Rukkv2Q7vVo2+43ZeDWVs/n6tOhut/T2YC4igX4h7yop0oQBxEp3U
         4u6y8QtmPycgkWGSo88Qu9YCwkeUzeyJ+imgdiEbge2SWzS55wIhnA4Vom3Kvhg74YP9
         3hwvy6ZE6y71SYNsNv4ArdfZL72bYhXZ1iQ9qOAqcA7B1IG3SbFtNYArQq9jL7Txyicq
         gZDQ==
X-Gm-Message-State: AOAM532hFMJNUij5gF2uhlrTR2auH/JyhLPsA0ql8jCeRdGkRMCVvL9a
        J2Kk8xMIjwp3t7HE/0nnCVI/JR295pB8Qt6aa/k=
X-Google-Smtp-Source: ABdhPJyEGX14UDKo8czX2MQtVCMfjLlzPCs/cxWXrYPZSQhX828ml81Ny+JhQpUIMZ+gx6t7TX2I5RY3aj0P3sPzYO0=
X-Received: by 2002:a25:e082:0:b0:641:cf5:b91f with SMTP id
 x124-20020a25e082000000b006410cf5b91fmr18025246ybg.482.1649862158896; Wed, 13
 Apr 2022 08:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220329133352.3361248-1-amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220329133352.3361248-1-amadeuszx.slawinski@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 17:02:28 +0200
Message-ID: <CAJZ5v0h2MceA7RMnWYNYjkwtpEupzuSEb_-_YpcUAY7v2gWtmw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/acpi: Preserve ACPI-table override during hibernation
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 3:34 PM Amadeusz Sławiński
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> When overriding NHLT ACPI-table tests show that on some platforms
> there is problem that NHLT contains garbage after hibernation/resume
> cycle.
>
> Problem stems from the fact that ACPI override performs early memory
> allocation using memblock_phys_alloc_range() in
> memblock_phys_alloc_range(). This memory block is later being marked as
> ACPI memory block in arch_reserve_mem_area(). Later when memory areas
> are considered for hibernation it is being marked as nosave in
> e820__register_nosave_regions().
>
> Fix this by marking ACPI override memory area as ACPI NVS
> (Non-Volatile-Sleeping), which according to specification needs to be
> saved on entering S4 and restored when leaving and is implemented as
> such in kernel.
>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>
> Changes in v2:
>  * Changed approach as method used in v1 introduced potential for memory
>    corruption, which was caught by tests.
>  * Adjusted commit message describing above change in approach.
>
> ---
>  arch/x86/kernel/acpi/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 0d01e7f5078c..2eeca97b730b 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1772,7 +1772,7 @@ int __acpi_release_global_lock(unsigned int *lock)
>
>  void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>  {
> -       e820__range_add(addr, size, E820_TYPE_ACPI);
> +       e820__range_add(addr, size, E820_TYPE_NVS);
>         e820__update_table_print();
>  }
>
> --

Given the lack of objections or concerns, applied as 5.19 material, thanks!
