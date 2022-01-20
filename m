Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284A9495421
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiATSZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232758AbiATSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642703113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlnvntdKeyJn6a4H1tGpGm3klYe/KenHIfs6bqVWGYE=;
        b=ZEU57fg4hA5rrLVpL8BTfW8TJ4aZ8tATFMNLoUZtGNqbxFhIOZo9ctOcr6iuh6JFoPDGGy
        po370Zgc8+DhSC1gAQEdiaUmbX0guVF1w6vNTWOyri3Z9WIKo5qpwO67+bvFNF4bEK0EN+
        fQQ+w79FjQFC9jher9FmA2ZLRaGOIgk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-Aq9WOkzzO2a1gbzrCmH2KQ-1; Thu, 20 Jan 2022 13:25:12 -0500
X-MC-Unique: Aq9WOkzzO2a1gbzrCmH2KQ-1
Received: by mail-ed1-f72.google.com with SMTP id el8-20020a056402360800b00403bbdcef64so6657377edb.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XlnvntdKeyJn6a4H1tGpGm3klYe/KenHIfs6bqVWGYE=;
        b=Sch7hPSHVhuG636KaJKTgV7bME7xsysJyBXaXnSYTjBS0EiEPaG4vMmm00rpfsZvIY
         ++akniq6seSnItLTwVyxOiokPmIaxEoggZ6itrDMHB0weCKSfKdvq8oRwr/d1j/dg4Po
         yyTGFaw/zbRlvmKJVqPIbhgmYcJxxZjSjQLNzOvu3bohI/vMkPWBxwXtu5wQ3/JEUMYH
         wolMDXxJbApYE+BLuIuuVRrFGliha26a2K5iU/hhp1kgC62LqIB4xnIs/J/zf+fqMnjQ
         cl9RcDBk2r/meNPVeVHPM2xh30rvshyPgVpOgJqTv9QnJ04KaWVBsOrEJUco5tagcxX7
         +1wQ==
X-Gm-Message-State: AOAM531Wc/47diOlZn9WXgyjDnFsaqgf0yWk/JtZvj3J81ri1iVHBpU1
        qdPytBP91W6yOxmQDaYRFAhSVbDzO8H6Gupw5WEhWTZiiGs1J1WqxbzhBYAyTU+5d/2KSBF9sGz
        sBESiZXegx4d7YNGFtseqRzhq
X-Received: by 2002:a05:6402:21d4:: with SMTP id bi20mr385570edb.20.1642703110675;
        Thu, 20 Jan 2022 10:25:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzL4ltr5hInC42l83cLMKXDoEXStlOPH8wqTyTd77EKcWq1GJwQnQrfyKMpFyZLHhZ4ojwR4A==
X-Received: by 2002:a05:6402:21d4:: with SMTP id bi20mr385543edb.20.1642703110497;
        Thu, 20 Jan 2022 10:25:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id dk3sm1650309edb.33.2022.01.20.10.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 10:25:10 -0800 (PST)
Message-ID: <ffb88819-a392-84f3-d40f-7406be8e3165@redhat.com>
Date:   Thu, 20 Jan 2022 19:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220120160822.666778608@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 16:55, Peter Zijlstra wrote:
> Add a guarantee for Anon pages that pin_user_page*() ensures the
> user-mapping of these pages stay preserved. In order to ensure this
> all rmap users have been audited:
> 
>  vmscan:	already fails eviction due to page_maybe_dma_pinned()
> 
>  migrate:	migration will fail on pinned pages due to
> 		expected_page_refs() not matching, however that is
> 		*after* try_to_migrate() has already destroyed the
> 		user mapping of these pages. Add an early exit for
> 		this case.
> 
>  numa-balance:	as per the above, pinned pages cannot be migrated,
> 		however numa balancing scanning will happily PROT_NONE
> 		them to get usage information on these pages. Avoid
> 		this for pinned pages.

page_maybe_dma_pinned() can race with GUP-fast without
mm->write_protect_seq. This is a real problem for vmscan() with
concurrent GUP-fast as it can result in R/O mappings of pinned pages and
GUP will lose synchronicity to the page table on write faults due to
wrong COW.

If you're just using it as an optimization, that should work just fine.
I assume all migration will freeze the refcount and consequently  bail
out at that point. In that case, LGTM.


-- 
Thanks,

David / dhildenb

