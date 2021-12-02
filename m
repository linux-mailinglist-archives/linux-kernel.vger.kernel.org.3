Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C583F46610C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbhLBKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:03:05 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35623 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhLBKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:02:59 -0500
Received: by mail-ed1-f41.google.com with SMTP id v1so113487511edx.2;
        Thu, 02 Dec 2021 01:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NypUDYvmH0MHXHQA77GvHsd6Iy6POgRp9+KytAO7ImY=;
        b=wT9iMXbwPSMM7/w9BkrJp6dxS1AT7YIZhHz5z5lzO3iqVQYYUnCZgkZrGpxc2VCIXw
         5OX18qBhJfkHXXUL4SoLeDgUkMiAMlh3YTA3KUlqTgXT7BPKJ45RW2xApl8FUjh4CVs5
         fbnrjLrRiOP+9CNVj5+YelWmTGDntH8hjkOPKZr13Kifb/WLzKl+hAYBIA34zpfWTUvk
         CAjLt1PRK43jCmllJc+ZoOhTj0x6D9x+8eUfzuew2kS4/+Hz7tbaSgvZW36Tgchip13t
         EUAYhQAZjgLb1ZBLYjdf0SR5XASoaU/Gsu2h3Vq/xREE2uHNroAINPLhbJ0/YnXiYBEp
         nxhg==
X-Gm-Message-State: AOAM533ts4PMAxNtRghZ/tyXP/BbqaXNES4AsOZNa974J/lvmZ5LGn7C
        JW5qbno4uSdZbY6gQFAXsM0=
X-Google-Smtp-Source: ABdhPJxcgi1lcp2R/iZSMYZphyGfUkA/cNp9BVuOdBExhdM3ZQm/6jvATO7kYMvBfeBvAY0Cyketmg==
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr14106111ejc.247.1638439176513;
        Thu, 02 Dec 2021 01:59:36 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id gb18sm1577180ejc.95.2021.12.02.01.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 01:59:35 -0800 (PST)
Message-ID: <a0968570-a25a-a7e3-3ee5-b7275286c9d1@kernel.org>
Date:   Thu, 2 Dec 2021 10:59:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] x86: mm: add x86_64 support for page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-4-pasha.tatashin@soleen.com>
 <f81a6434-9f38-947e-02a8-9a9191285e52@kernel.org>
 <cadf2582-3004-92b9-ab5a-cb39259fa36c@kernel.org>
 <CA+CK2bBfcrxDyxnV+xc680AP+sJGHSpong6a+b_vvWcRsB2CcA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CA+CK2bBfcrxDyxnV+xc680AP+sJGHSpong6a+b_vvWcRsB2CcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 12. 21, 14:55, Pasha Tatashin wrote:
> On Wed, Dec 1, 2021 at 3:44 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> On 01. 12. 21, 9:00, Jiri Slaby wrote:
>>> On 23. 11. 21, 22:48, Pasha Tatashin wrote:
>>>> Add page table check hooks into routines that modify user page tables.
>>>
>>> Hi,
>>>
>>> I bisected to this as this causes crashes during modules load:
>>
>> And it's not enough to unset CONFIG_PAGE_TABLE_CHECK_ENFORCED. I had to
>> unset CONFIG_PAGE_TABLE_CHECK completely to get rid of this.
> 
> Hi,
> 
> Thanks for reporting this. Seems like module load for some reasons
> does not like the static branches. However, I was not able to repro
> this. Could you please share your config and the module that you were
> loading?

It's the openSUSE's -next config:
https://raw.githubusercontent.com/openSUSE/kernel-source/linux-next/config/x86_64/vanilla

But with CONFIG_IWLMEI=n (as that fails to link).

One has to load i915, other modules (71 on my system) are apparently fine.

i915 tries to patch your `page_table_check_disabled' which is defined as 
`DEFINE_STATIC_KEY_TRUE_RO':
 > jump_label_add_module: key=__tracepoint_mmap_lock_released 
(ffffffff93f36d88) mod=0000000000000000
 > jump_label_add_module: key=hugetlb_free_vmemmap_enabled_key 
(ffffffff94873560) mod=0000000000000000
 > jump_label_add_module: key=devmap_managed_key (ffffffff94902700) 
mod=0000000000000000
 > jump_label_add_module: key=page_table_check_disabled 
(ffffffff939da760) mod=0000000000000000
 > BUG: unable to handle page fault for address: ffffffff939da768

regards,
-- 
js
suse labs
