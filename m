Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946D858ADEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiHEQLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiHEQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F38C71BF0
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659715897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDt22zsCsVGrbg9q8dPTaduQ2hORoxHmBldXfY6vzAc=;
        b=dm/NdEyAD1Yr1+BDWbbcacTjZre9Zu5cL/GzbsukXEVHQQ/hU7aD4y+Vg9xtdgzbXkzHMI
        cHfCKZ5p9x84NhSqUPiX1z7VRhRw2hVPKp9cF1SWEowR1imbfKl7+5GFrpm2riEXSM11qh
        3/OfOzSq6s4Hty5nPzFKu3T6P4S4Wo0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-bfnXTwRENbiisZIGl60tyA-1; Fri, 05 Aug 2022 12:11:36 -0400
X-MC-Unique: bfnXTwRENbiisZIGl60tyA-1
Received: by mail-wm1-f72.google.com with SMTP id q10-20020a1ce90a000000b003a4f6e08166so562364wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=hDt22zsCsVGrbg9q8dPTaduQ2hORoxHmBldXfY6vzAc=;
        b=I0TC9n9Yl8gMY4uv4aOvTg4P4S4iYx6F5Cnhscz+yLFz94Nx0UT9+WRbYwJgssrBi7
         xbqlpFXiG4wKIakOYU7jPWZNTVTmCbNHFgC/ef0cYD+wKfuRUtjWgxhRcRMFkPa+wL69
         VuAth0PDKCT/iMWE/BXJfq+Eh1kLvcbe6wbt+z29tdfiadWlz3y+fucGoIBoMpOb4sLD
         71xXSDK0VZHP2ZJ/gGVBlct8YZzHy5ncFP4ZIonJVrJ1RFK1gjeuAv5yjn8KgrcBLq+q
         yNUhVA57FbRTDYDNxBGkeqa7njZIptl5M7E1JEPFJGIPbo3TZl4V2ucjOqhnWwWGNCTa
         /G/w==
X-Gm-Message-State: ACgBeo26yCYEYohz0Wg5XNHIM4rkZzPW8zrDOIdivAtzQ7JIjpmOAKhk
        JZ6uqkWiWlgWztf6Wjzjwpm4dyoaJ/dKxUc52ZiQlmyaAdrxIrgJpGVERv1sQPF228+MC8v+rVq
        SYm7xuAaoRxErN3RzmWaW5fLm
X-Received: by 2002:a5d:5273:0:b0:220:5d3e:c50f with SMTP id l19-20020a5d5273000000b002205d3ec50fmr4964719wrc.291.1659715894972;
        Fri, 05 Aug 2022 09:11:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4udtf/a4YHeijwoGO6Qa35YGkwnp+iDFfapRsOcZTilnRWoETsppr0kdNEFB4CmsFBOxkxpA==
X-Received: by 2002:a5d:5273:0:b0:220:5d3e:c50f with SMTP id l19-20020a5d5273000000b002205d3ec50fmr4964692wrc.291.1659715894774;
        Fri, 05 Aug 2022 09:11:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b0039db31f6372sm10699400wmq.2.2022.08.05.09.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:11:34 -0700 (PDT)
Message-ID: <58c2a14d-f8e2-4cc6-a2f7-68214405aae9@redhat.com>
Date:   Fri, 5 Aug 2022 18:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v4 3/8] hugetlbfs: move routine remove_huge_page to
 hugetlb.c
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-4-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220706202347.95150-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.22 22:23, Mike Kravetz wrote:
> In preparation for code in hugetlb.c removing pages from the page
> cache, move remove_huge_page to hugetlb.c.  For a more descriptive
> global name, rename to hugetlb_delete_from_page_cache.  Also,> rename huge_add_to_page_cache to be consistent.

"hugetlb_add_to_page_cache"

> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

