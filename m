Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAF56316E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiGAKce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiGAKcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E741276EB1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656671549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4td92aFJQKg+sJntCcVWvWuQk8fqytpXxmE8au2sJjk=;
        b=Ox6EwjCSfLHTjOQq+qgJgHrxzNnAyOPQlHg36r615Rcfdv44TV0ZMpkgf2XXB4/h5SVHi4
        /LbmarMNIzk7QNvJ2ks4T9mPLW/CSIQnw3eLpgukENcwmDeBRMMaoAVC3f1Ce8jo+919jZ
        5oOSWVrOTTIldqgt8OlNfxDznwREaZk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-PjlTxXmCOkGIufMeN3dNiA-1; Fri, 01 Jul 2022 06:32:29 -0400
X-MC-Unique: PjlTxXmCOkGIufMeN3dNiA-1
Received: by mail-wr1-f72.google.com with SMTP id r15-20020adff10f000000b0021bcc217e15so289038wro.19
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4td92aFJQKg+sJntCcVWvWuQk8fqytpXxmE8au2sJjk=;
        b=DdiigTUR/V9UH2brY94dNoX80h+P7CJJRxtuwn3CCKDCaMOiCN0Wsav6JnHnQ+nJ2h
         l/+uAGDkvGszNaSiEIMtZQuW/X6a+TWw1WOFQm948/ITNDwTu/bGoOVjUim7ooKBdaJw
         rCFb5I/vK58nXWc7qf7W3EWjmXL3Go3dKkkjMr0hb4MxPD9T1BXy347kwy6yrKS0SXcj
         +eHIboyEfYl4gCqq6WuKHu4+aSq+d2zv39nUvq+hlSLcoO+0MxhusWhpGikB0aIqtAZZ
         NMMVFUmlTxmZ10R92wAcG+2Lmin9JIKsAWbrcFUNxHn7gTcnYiA/SxC9cVDd0YnDRtOt
         IQvA==
X-Gm-Message-State: AJIora9SM/lfhw/oTR9DAPoAVQEAUOJ75xhk3fJIkKoraZJXHjFaPp8d
        aqDsq4IRBp+wrSU08Fukt3sRbWZv1sQmsYX7NjN+WWevlmaWfrgyBDxqQAP2FL8dGxJg3wbw27I
        +l8FAjQRZc2+hxxJYzU6Sej+L
X-Received: by 2002:a05:600c:a04:b0:39e:e392:ec22 with SMTP id z4-20020a05600c0a0400b0039ee392ec22mr17220737wmp.158.1656671547659;
        Fri, 01 Jul 2022 03:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sxgzfk67USL9MoveUOgUm0gnB/TEMJrBWpLPlvIJyLdbnI/1lrw5z5DuZUFb9Dd1fhLpS5KQ==
X-Received: by 2002:a05:600c:a04:b0:39e:e392:ec22 with SMTP id z4-20020a05600c0a0400b0039ee392ec22mr17220709wmp.158.1656671547393;
        Fri, 01 Jul 2022 03:32:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:e300:d7a0:7fc3:8428:43e5? (p200300cbc709e300d7a07fc3842843e5.dip0.t-ipconnect.de. [2003:cb:c709:e300:d7a0:7fc3:8428:43e5])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0039c99f61e5bsm6727996wmq.5.2022.07.01.03.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 03:32:26 -0700 (PDT)
Message-ID: <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
Date:   Fri, 1 Jul 2022 12:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.22 11:11, Michal Hocko wrote:
> [Cc Jann]
> 
> On Fri 01-07-22 08:43:23, cgel.zte@gmail.com wrote:
>> From: xu xin <xu.xin16@zte.com.cn>
>>
>> The benefits of doing this are obvious because using madvise in user code
>> is the only current way to enable KSM, which is inconvenient for those
>> compiled app without marking MERGEABLE wanting to enable KSM.
> 
> I would rephrase:
> "
> KSM functionality is currently available only to processes which are
> using MADV_MERGEABLE directly. This is limiting because there are
> usecases which will benefit from enabling KSM on a remote process. One
> example would be an application which cannot be modified (e.g. because
> it is only distributed as a binary). MORE EXAMPLES WOULD BE REALLY
> BENEFICIAL.
> "
> 
>> Since we already have the syscall of process_madvise(), then reusing the
>> interface to allow external KSM hints is more acceptable [1].
>>
>> Although this patch was released by Oleksandr Natalenko, but it was
>> unfortunately terminated without any conclusions because there was debate
>> on whether it should use signal_pending() to check the target task besides
>> the task of current() when calling unmerge_ksm_pages of other task [2].
> 
> I am not sure this is particularly interesting. I do not remember
> details of that discussion but checking signal_pending on a different
> task is rarely the right thing to do. In this case the check is meant to
> allow bailing out from the operation so that the caller could be
> terminated for example.
> 
>> I think it's unneeded to check the target task. For example, when we set
>> the klob /sys/kernel/mm/ksm/run from 1 to 2,
>> unmerge_and_remove_all_rmap_items() doesn't use signal_pending() to check
>> all other target tasks either.
>>
>> I hope this patch can get attention again.
> 
> One thing that the changelog is missing and it is quite important IMHO
> is the permission model. As we have discussed in previous incarnations
> of the remote KSM functionality that KSM has some security implications.
> It would be really great to refer to that in the changelog for the
> future reference (http://lkml.kernel.org/r/CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com)
> 
> So this implementation requires PTRACE_MODE_READ_FSCREDS and
> CAP_SYS_NICE so the remote process would need to be allowed to
> introspect the address space. This is the same constrain applied to the
> remote momory reclaim. Is this sufficient?
> 
> I would say yes because to some degree KSM mergning can have very
> similar effect to memory reclaim from the side channel POV. But it
> should be really documented in the changelog so that it is clear that
> this has been a deliberate decision and thought through.
> 
> Other than that this looks like the most reasonable approach to me.
> 
>> [1] https://lore.kernel.org/lkml/YoOrdh85+AqJH8w1@dhcp22.suse.cz/
>> [2] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/
>>

I have various concerns, but the biggest concern is that this modifies
VMA flags and can possibly break applications.

process_madvise must not modify remote process state.

That's why we only allow a very limited selection that are merely hints.

So nack from my side.

-- 
Thanks,

David / dhildenb

