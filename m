Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2914A71D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbiBBNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344407AbiBBNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643809555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxruncnGKSYEtQADjLUNkNWhCcGBbzpK2sbDwkeQUpo=;
        b=IvlHLOIoAfjxqUryG5VtmgReaCtzLoMtgEAAKndnl8Lqi914pDdVatgXRntOsQovBp53GE
        EyeC3I9hFv8V8pRcIotB0VS/+D0GazCr7QtuFhOA16z9du7/fUdOXcleb1D3uDxp0yBjcv
        uKzYQh460kzzs7wa0ybeaECp/Y3LALQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-e6DPzP5KP7OroaGbcJ6G9A-1; Wed, 02 Feb 2022 08:45:54 -0500
X-MC-Unique: e6DPzP5KP7OroaGbcJ6G9A-1
Received: by mail-ed1-f70.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso10335795edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=YxruncnGKSYEtQADjLUNkNWhCcGBbzpK2sbDwkeQUpo=;
        b=lqaLDjb41dLoj72fDGU8Eths9BtxPY10QFPOE1iyI648SaF69SXL9gUu3ufVuc84G4
         8Wt5Z9Bo20l5bzBUpM6ILteAq+m1+ceMAqYxO9YL/SqJgH8fsXdS/R8uNoD7fd7Wf1n9
         sw2X1Do7hkj3Bjp+lESo5rOaWsiw3HNaRMAWCQVWYQ8UESemSPkn6gzLST36bNsROq9/
         DJFooq1YUIm+tF9WDteCa0qV4RXLwAhLrHkoQOqHxNtK+zj/0RK993PdEfehfWOljn8W
         YoN7rWDYAtDirYXmUnD0APEYgOnuIFicDnTC/tjHow2ig/C+RhIpBbyraRXP5qd9G++f
         q2UA==
X-Gm-Message-State: AOAM532EBonuwgaO2ajwwIPfJ3kDTCLLW/QZJ1p8W76l6IUmiwJDmJp/
        SyCeTj7ooayE7i68UKa6M0XS5poJxKP0XxHYjruvtmrRN52h0bZRRomUsIeaUeRVei+x4Od6fj6
        u94uOC2lGTW8hMs4WqVPX+iut+xfPZfwCLauLuDvMR+hhZrbQkY1nLgC5gNvYA+dk0YQtwpIa
X-Received: by 2002:a05:6402:5248:: with SMTP id t8mr30084298edd.14.1643809552919;
        Wed, 02 Feb 2022 05:45:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqE4L2UK0676VaeKIuCkwGMt3tw/zzsCSLR83dbtSZbWUp25WGEt3s5690JhdDTieh82ha0w==
X-Received: by 2002:a05:6402:5248:: with SMTP id t8mr30084241edd.14.1643809552570;
        Wed, 02 Feb 2022 05:45:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:f800:a55c:e484:3cd9:3632? (p200300cbc709f800a55ce4843cd93632.dip0.t-ipconnect.de. [2003:cb:c709:f800:a55c:e484:3cd9:3632])
        by smtp.gmail.com with ESMTPSA id z8sm15746580ejc.151.2022.02.02.05.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 05:45:52 -0800 (PST)
Message-ID: <c25ad11e-6700-3a11-1a44-f69b4a7fc9e2@redhat.com>
Date:   Wed, 2 Feb 2022 14:45:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v1] drivers/base/node: consolidate node device
 subsystem initialization in node_dev_init()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
References: <20220128151540.164759-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220128151540.164759-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.22 16:15, David Hildenbrand wrote:
> ... and call node_dev_init() after memory_dev_init() from driver_init(),
> so before any of the existing arch/subsys calls. All online nodes should
> be known at that point.
> 
> This is in line with memory_dev_init(), which initializes the memory
> device subsystem and creates all memory block devices.
> 
> Similar to memory_dev_init(), panic() if anything goes wrong, we don't
> want to continue with such basic initialization errors.
> 
> The important part is that node_dev_init() gets called after
> memory_dev_init() and after cpu_dev_init(), but before any of the
> relevant archs call register_cpu() to register the new cpu device under
> the node device. The latter should be the case for the current users
> of topology_init().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

If there are no further comments, then I'll resend as !RFC with a
slightly extended patch description, testing at least under arm64 and
ppc64 as they are relatively easy to test for me.

-- 
Thanks,

David / dhildenb

