Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704B56B8DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiGHLsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiGHLr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93923951F7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657280871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qkbfqfqgKZl4vr074ljOBTMMH/P10CPWSxYVWQ0VaQ=;
        b=FCuSWDvc6F+ue15KbQP1eXfSSY4vA7DWmwMWLy39B5B7mk6rZw0BL4XLr4qhYXCCq8kLfm
        v6QBjIrFghlzfBGtJ6Japz4HsaKf830OSt3rYqTEmRp5C/FvruxPfAHAXZqYYdtBuOT9qn
        i+c72Hs1gyRRLH6xl7r090ltrfwJnwY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-zI-MRcr8OYmy64PPcutmXg-1; Fri, 08 Jul 2022 07:47:50 -0400
X-MC-Unique: zI-MRcr8OYmy64PPcutmXg-1
Received: by mail-wm1-f71.google.com with SMTP id h133-20020a1c218b000000b003a2cf5b5aabso206269wmh.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=4qkbfqfqgKZl4vr074ljOBTMMH/P10CPWSxYVWQ0VaQ=;
        b=tUGaaD+msaHiCLrmXSWb2Mh011sIvPtTgFqOVCqX6+7laJND9UToWQAjlG78vs7of4
         JC8KSM06UQ2LKl4AyL/j3Tiw7An/A8yegeRAXzg7jiq2OEPIQJczFERfXpU3rv5Q2m34
         yHMK6j/w8kf2LndJbHKOcCwQltCHBFi8aWNJcodQ8pUoqXmXoO1fTnzvWOs2JWWk1txh
         MCbNk+Flyp0oc/9Ecs6sCudwncwlfKjUHuu8ZziJJ80nTtUU2tqvmUF6Ns128y4v1oKd
         87co7IAlUBcz+S/BmUMGca05QQUnpi+7u8LsaR+nNNxcz1qhfmD77TZdAIzCyPIKNQqv
         iTQA==
X-Gm-Message-State: AJIora/be1Y22wvLJrXi66XBgGNcgkyXefv7xZ95dU0VCwsRR5gJwzR2
        QYj3U5eKB6/Y9yiO+EPVFEosD7n2QxFRm90A9cRt8sy2dNStKIw8wueGRpw1NCpP/I0cyl0tjjZ
        rmVtcZGtd/npzJemzgQTevXPF
X-Received: by 2002:a5d:5888:0:b0:21d:754b:7afb with SMTP id n8-20020a5d5888000000b0021d754b7afbmr2987070wrf.117.1657280868919;
        Fri, 08 Jul 2022 04:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/4S12fBMAIfaRf6uHmDKcskesUNfg3rO09s8QGSm+icsKU/YKWY8scksGW1bdpOE3Fs4d7Q==
X-Received: by 2002:a5d:5888:0:b0:21d:754b:7afb with SMTP id n8-20020a5d5888000000b0021d754b7afbmr2987044wrf.117.1657280868662;
        Fri, 08 Jul 2022 04:47:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:6300:c44f:789a:59b5:91e9? (p200300cbc7026300c44f789a59b591e9.dip0.t-ipconnect.de. [2003:cb:c702:6300:c44f:789a:59b5:91e9])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe950000000b0021d70a871cbsm10008073wrn.32.2022.07.08.04.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 04:47:48 -0700 (PDT)
Message-ID: <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
Date:   Fri, 8 Jul 2022 13:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Cc:     willy@infradead.org, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        21cnbao@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
In-Reply-To: <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.22 06:24, Andrew Morton wrote:
> On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
>> This patch series implements a mechanism in kernel to allow
>> userspace processes to opt into sharing PTEs. It adds a new
>> in-memory filesystem - msharefs. 
> 
> Dumb question: why do we need a new filesystem for this?  Is it not
> feasible to permit PTE sharing for mmaps of tmpfs/xfs/ext4/etc files?
> 

IIRC, the general opinion at LSF/MM was that this approach at hand is
makes people nervous and I at least am not convinced that we really want
to have this upstream.

What's *completely* missing from the cover letter are the dirty details:
"Actual data is mmap'ed using anonymous pages, ext4/xfs/btfrfs/etc
files.". Gah.

As raised already, "anonymous pages" makes me shiver.


(To me, what I read, this looks like an RFC to me, yet I see "v2". But I
am a little confused why most of the feedback at LSF/MM seems to be
ignored and people are moving forward with this approach. But maybe my
memory is wrong.)

Please, let's look into more generic page table sharing just like
hugetlb already provides to some degree. And if we need additional
alignment requirements to share multiple page table levels, then let's
look into that as well for special users.

-- 
Thanks,

David / dhildenb

