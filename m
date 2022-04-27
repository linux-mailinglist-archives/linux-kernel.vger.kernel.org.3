Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46406511631
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiD0LBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiD0LAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F146140F7BE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651056500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaWDcPzanxqO+4p6Cp0c6BIcDLXXugLTPyjUIyycszU=;
        b=LwnKesIY6CUOeu+OXbkGbdISyZwoNVeoR+jCZi+pj1airbwGEyNSOxOUVoKHs69yanitSr
        Tp10CCYpP3CRATG2MwxnTyWAJ7GK9Vf4VHVD9w0res3j/4YF05NXHb2zDLkC3PlkYjYb1s
        7iPmRBXe9LQYhSO+3ObdTlWzBINlTnw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-X0RclrhIMrybCR8mji5S3g-1; Wed, 27 Apr 2022 06:48:19 -0400
X-MC-Unique: X0RclrhIMrybCR8mji5S3g-1
Received: by mail-wr1-f69.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so602863wri.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ZaWDcPzanxqO+4p6Cp0c6BIcDLXXugLTPyjUIyycszU=;
        b=n0vbLV+GkT8c+/pjaCRnPMGhiVI0ky5HoMmdSiSLGwtCKmm9wRRmY1JSvGjAYj4CWs
         d6Qf28dwezV99QJv6p7hcU9/EpftmrP+Xp6rTl+6tWtTpl/MFvuAk8/CEUHWwdEUC0WA
         aS0rWSPtUsYgL6qhmfowyoQy2EuayjcDVx5Qqd2IFvx02GT21RHPSDyuHBs/BoRH7R/1
         TT0a9GRKl7OK0zfiab7EUssxrQhh2BUI7HgCgvlFCa1MmLp4OyFRdQjpH3krqkwBFff5
         Xc6OTIwjQg1LpXOV3UfXEtYxpN5WsqNXFoahGlLtjxMnY7mbAY3wqI/9iM5KyoG9DIzq
         tKYw==
X-Gm-Message-State: AOAM532+QzZyltMzhaNKN9GbN0oXePJPkn/ipfp+vW66TAWVbzU6bHYu
        g56hzPItDKLwlvkbkjY0W224uTNxKHaVWZ/lLimAzAKMO8MzRdCTFjwj6eDge39mBB+VXDrwgFB
        0K8iLpLmmoHiU1jOPqIFYq8xb
X-Received: by 2002:a05:600c:512a:b0:393:f143:efd5 with SMTP id o42-20020a05600c512a00b00393f143efd5mr8523471wms.109.1651056498536;
        Wed, 27 Apr 2022 03:48:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKaPyZzoxOPSDrT/Z7/O3FY3jGo+DaIfVsgKbkLBQT+Xz115qXPmI/iyhE/pLJuVgn9GUfYA==
X-Received: by 2002:a05:600c:512a:b0:393:f143:efd5 with SMTP id o42-20020a05600c512a00b00393f143efd5mr8523442wms.109.1651056498212;
        Wed, 27 Apr 2022 03:48:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f000:f1c:858e:6a10:ead1? (p200300cbc705f0000f1c858e6a10ead1.dip0.t-ipconnect.de. [2003:cb:c705:f000:f1c:858e:6a10:ead1])
        by smtp.gmail.com with ESMTPSA id q15-20020adfaa4f000000b0020ac7bd4affsm16622191wrd.0.2022.04.27.03.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 03:48:17 -0700 (PDT)
Message-ID: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
Date:   Wed, 27 Apr 2022 12:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
In-Reply-To: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.22 06:28, Naoya Horiguchi wrote:
> Hi,
> 
> This patchset addresses some issues on the workload related to hwpoison,
> hugetlb, and memory_hotplug.  The problem in memory hotremove reported by
> Miaohe Lin [1] is mentioned in 2/4.  This patch depends on "storing raw
> error info" functionality provided by 1/4. This patch also provide delayed
> dissolve function too.
> 
> Patch 3/4 is to adjust unpoison to new semantics of HPageMigratable for
> hwpoisoned hugepage. And 4/4 is the fix for the inconsistent counter issue.
> 
> [1] https://lore.kernel.org/linux-mm/20220421135129.19767-1-linmiaohe@huawei.com/
> 
> Please let me know if you have any suggestions and comments.
> 

Hi,

I raised some time ago already that I don't quite see the value of
allowing memory offlining with poisened pages.

1) It overcomplicates the offlining code and seems to be partially
   broken
2) It happens rarely (ever?), so do we even care?
3) Once the memory is offline, we can re-online it and lost HWPoison.
   The memory can be happily used.

3) can happen easily if our DIMM consists of multiple memory blocks and
offlining of some memory block fails -> we'll re-online all already
offlined ones. We'll happily reuse previously HWPoisoned pages, which
feels more dangerous to me then just leaving the DIMM around (and
eventually hwpoisoning all pages on it such that it won't get used
anymore?).

So maybe we should just fail offlining once we stumble over a hwpoisoned
page?

Yes, we would disallow removing a semi-broken DIMM from the system that
was onlined MOVABLE. I wonder if we really need that and how often it
happens in real life. Most systems I am aware of don't allow for
replacing individual DIMMs, but only complete NUMA nodes. Hm.

-- 
Thanks,

David / dhildenb

