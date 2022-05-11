Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15BD523B84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbiEKR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbiEKR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D297252535
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652290079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cS5E6UtIkG/hFuUJaz85MfZ3xWqLO1I63lqGQCOfSNw=;
        b=I/TWgzq3wZ9tX0ZdebCt2Q/QHoEGdPYJKy2I8L7/cNTyZWGwdwbZSzRhlGCtN6tmfx/BC6
        JqcQOwhwIwI/p9a/+DRB9vmDd2HqFj6kLhz8QkMo1X+ID1Fq+Rp88X/AXsQI4eO4RH/Pg+
        F/+rBhl64Z3KDHfKPuo2zSU8u7VQ4+A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-NLw7j5g-PsyUxl6Q_nqAzA-1; Wed, 11 May 2022 13:27:58 -0400
X-MC-Unique: NLw7j5g-PsyUxl6Q_nqAzA-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c02d6000000b003928cd3853aso3113405wmc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cS5E6UtIkG/hFuUJaz85MfZ3xWqLO1I63lqGQCOfSNw=;
        b=Os9vvbAngRtq4XnKOhpso1BhBCbtgmUXR3lkzMge74vQ88UA8Bzg9/ce7HxpHG2HIz
         rs+noBelYgWSAdvmXY2aN9bPdKJGFsa/JHoUQWTrD9qINlCtuNvoWj+bWeJ9Witre9v0
         /4RGHCORZ+lo1tV8m6HXJakisFqzr1+ONeud3WGS0fSnfrn2o27VjP54WrhPf3VT1bs5
         MvuI5dvc+CqdmsUbtgzMUWjoDIeo3wmIzzqo+VmNPNxUB86LH/O3FUtYthXuoQekOxsT
         8f4XUpfliLqVX/0FIKP6ZZzBEjq+8jrH0fURzeIQ2rten3yFyyhN30f4W2O26bm6/JB9
         1aDA==
X-Gm-Message-State: AOAM5320XR6hC7XBxU7ijA76g4C0RqSN1Oj/sOQCoKvvlG0KdjF7vPNq
        aZvW7+8rASXdY1la+3/JfNPFb+ZWhvBBTn6vjIvYSrcbaV1yNQCxMqqhux2RNHPT5pe/heSpg/J
        mTFSZ9GWGJei/Ew0pVDNatJ/t
X-Received: by 2002:a7b:c4d8:0:b0:393:fecd:2718 with SMTP id g24-20020a7bc4d8000000b00393fecd2718mr6012819wmk.23.1652290077483;
        Wed, 11 May 2022 10:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBTzXKBES23B3psLkzxI9cGRRJgtAEIRhBp8LvQHOEvCQMFPcLMWgEwEKr1C169Li1EVKAzw==
X-Received: by 2002:a7b:c4d8:0:b0:393:fecd:2718 with SMTP id g24-20020a7bc4d8000000b00393fecd2718mr6012790wmk.23.1652290077160;
        Wed, 11 May 2022 10:27:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d694c000000b0020c5253d8c3sm2174483wrw.15.2022.05.11.10.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:27:55 -0700 (PDT)
Message-ID: <55e85b3e-dd6a-1dc2-719d-c6be9d5124c0@redhat.com>
Date:   Wed, 11 May 2022 19:27:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 migration
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     catalin.marinas@arm.com, will@kernel.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
 <a4baca670aca637e7198d9ae4543b8873cb224dc.1652270205.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a4baca670aca637e7198d9ae4543b8873cb224dc.1652270205.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.22 14:04, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
> 
> When migrating a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it and remap it with
> a migration pte entry. This is correct for PMD or PUD size hugetlb,
> since they always contain only one pmd entry or pud entry in the
> page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes. So we will nuke or remap only one pte
> or pmd entry for this CONT-PTE/PMD size hugetlb page, which is
> not expected for hugetlb migration. The problem is we can still
> continue to modify the subpages' data of a hugetlb page during
> migrating a hugetlb page, which can cause a serious data consistent
> issue, since we did not nuke the page table entry and set a
> migration pte for the subpages of a hugetlb page.
> 
> To fix this issue, we should change to use huge_ptep_clear_flush()
> to nuke a hugetlb page table, and remap it with set_huge_pte_at()
> and set_huge_swap_pte_at() when migrating a hugetlb page, which
> already considered the CONT-PTE or CONT-PMD size hugetlb.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Makes sense to me.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

