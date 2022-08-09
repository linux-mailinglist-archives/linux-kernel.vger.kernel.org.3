Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74AE58E00F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbiHITSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348469AbiHITQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B01DB1D314
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660072203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRqc1okeAHdsmQUrvr7UCGZmXL46y0LkrGmGnuyVW2Y=;
        b=ErKsFnZOPbljpyZ2bqjIKgbO9t4lngDoT+iNhJC8JsMVn4DwQqs+1g/5ZcIsSCDTPxCnWI
        OC61yvChtFXSEUQnrGXTMIKzMft/aisK/jqtzA26F8Bib7iy37tIgbvqJ0vwZvD1//HYD/
        dl4lYlaGsIlV6X3pt855nZOezgEtZ4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641--WjuIR_jNGiVT1QX590i-Q-1; Tue, 09 Aug 2022 15:10:02 -0400
X-MC-Unique: -WjuIR_jNGiVT1QX590i-Q-1
Received: by mail-wm1-f72.google.com with SMTP id j36-20020a05600c1c2400b003a540d88677so2832009wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 12:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=uRqc1okeAHdsmQUrvr7UCGZmXL46y0LkrGmGnuyVW2Y=;
        b=XrjYOdC2/hMUbFAJqybV1501bBw1h/tGoF+Zrc3iD8oXmGWavTLz9OLdBYWSeCk572
         3ot4vC06h7YU+A0uxtToQLjuWfIA5wzMJ0Mvnn9VU6r/C5mwUUmpDQkwHQ2kdCC2J+DP
         1KVxHQClvheWwAUOZoKV/++gIuXrx6oxkofvTpC3RClUW8TD+aG6Hg/1A/GcdH80Gkst
         //htlJuZA02obv2AyRgwkvapGPxPXba3KYREgXl3noUkwDNyQbcsbufEyADg2BkWmgMx
         7MY9Ynkd1wC5M02RVL2wAI3PgoTz/EyTfiaGsSrdps6yTGkNj8Epzn/TO/4ftDqSlD5Y
         zvfw==
X-Gm-Message-State: ACgBeo3RAdWcLQWKh4UPRiOF0ROq2f96VaxkC0gnPwf/yx3o+xvbmpqy
        UKHMvKjZK0T1SiUA7TGOL499MCUko4v1hNezdP273hcTsnHYYctzbqrbVo5Dyvs0V8MrMWqdv0O
        QhjQ+FyuTWitHH+sz3nTdkRkA
X-Received: by 2002:adf:e848:0:b0:220:7dc6:135f with SMTP id d8-20020adfe848000000b002207dc6135fmr15173020wrn.24.1660072201162;
        Tue, 09 Aug 2022 12:10:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+SQNNtefTpJvPGn+VBLgI5xGu/AqwT3DTT0u2MzgOrtbJb/8gsc+bA2KK7SA4FWebAox2Vw==
X-Received: by 2002:adf:e848:0:b0:220:7dc6:135f with SMTP id d8-20020adfe848000000b002207dc6135fmr15173003wrn.24.1660072200926;
        Tue, 09 Aug 2022 12:10:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:3700:aed2:a0f8:c270:7f30? (p200300cbc7053700aed2a0f8c2707f30.dip0.t-ipconnect.de. [2003:cb:c705:3700:aed2:a0f8:c270:7f30])
        by smtp.gmail.com with ESMTPSA id bd14-20020a05600c1f0e00b003a5542047afsm2762941wmb.19.2022.08.09.12.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 12:10:00 -0700 (PDT)
Message-ID: <ac2f75aa-da03-66fb-cb35-ec1b9d69281c@redhat.com>
Date:   Tue, 9 Aug 2022 21:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220808073232.8808-1-david@redhat.com>
 <CAHk-=wiKm3QjM1_XwWNW8P8drW6s0ZeANm7VKy_1c7WH6RSp3g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/gup: fix FOLL_FORCE COW security issue and remove
 FOLL_COW
In-Reply-To: <CAHk-=wiKm3QjM1_XwWNW8P8drW6s0ZeANm7VKy_1c7WH6RSp3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.22 20:48, Linus Torvalds wrote:
> On Mon, Aug 8, 2022 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> For example, a write() via /proc/self/mem to a uffd-wp-protected range has
>> to fail instead of silently granting write access and bypassing the
>> userspace fault handler.
> 
> This, btw, just makes me go "uffd-wp is broken garbage" once more.
> 
> It also makes me go "if uffd-wp can disallow ptrace writes, then why
> doesn't regular write protect do it"?

I remember that it's not just uffd-wp, it's also ordinary userfaultfd if
we have no page mapped, because we'd have to drop the mmap lock in order
to notify user space about the fault and wait for a resolution.

IIUC, we cannot tell what exactly user-space will do as a response to a
user write fault here (for example, QEMU VM snapshots have to copy page
content away such that the VM snapshot remains consistent and we won't
corrupt the snapshot), so we have to back off and fail the GUP. I'd say,
for ptrace that's even the right thing to do because one might deadlock
waiting on the user space thread that handles faults ... but that's a
little off-topic to this fix here. I'm just trying to keep the semantics
unchanged, as weird as they might be.


> 
> IOW, I don't think the patch is wrong (apart from the VM_BUG_ON's that
> absolutely must go away), but I get the strong feelign that we instead
> should try to get rid of FOLL_FORCE entirely.

I can resend v2 soonish, taking care of the VM_BUG_ON as you requested
if there are no other comments.

> 
> If some other user action can stop FOLL_FORCE anyway, then why do we
> support it at all?

My humble opinion is that debugging userfaultfd-managed memory is a
corner case and that we can hopefully stop using FOLL_FORCE outside of
debugging context soon.

Having that said, I do enjoy having the uffd and uffd-wp feature
available in user space (especially in QEMU). I don't always enjoy
having to handle such corner cases in the kernel.

-- 
Thanks,

David / dhildenb

