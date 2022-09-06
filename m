Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0B5AF484
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiIFTkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiIFTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FDA491F6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662493196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ipDmQ48fSdnKUDgmzFqHXYya44lh/1wuhiABbNwvM7Y=;
        b=ck9ijTxR/Q73O0X3pJmd4vxIxuwEJpBkYFM5b0wEQxI7dnuE98GfACBeZdMDy5Grd/VEdJ
        K14QOSu4yJgx8iLBwMaOwyekUtQZfbuLbkiBfYobOJQP+DQIeZ1l3tGS6Ei/8kAWo0Ezjr
        VNL2x2JgHynC+fP4CMvNbz7SdMjw9jU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-178-E2LB8JCcMzicL81fqN3SeA-1; Tue, 06 Sep 2022 15:39:55 -0400
X-MC-Unique: E2LB8JCcMzicL81fqN3SeA-1
Received: by mail-qt1-f200.google.com with SMTP id b10-20020a05622a020a00b003437e336ca7so9961662qtx.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ipDmQ48fSdnKUDgmzFqHXYya44lh/1wuhiABbNwvM7Y=;
        b=fBQlHXNc2O+2KaiZRkyl/hAMxGvMSh9nywXi0o00rbYwkyUbbEI1oQEK0FyIwWFfC/
         WuWzZM/tcycZjEePolVjfIz7XHlNyGBmdnCMtAbhSAPAUcwpy/GusDSokSVlqDrdaFBy
         U6pXatkcQG/y6IJGshWYRvbE3uWOko8FFWDpJ/CYIwn+BUBWNarorrrEh4PzOi9sXYIX
         JxtWEOSSblBVEEDmvlGfXo335yFvR44wZIFHnZvKGtxH1XrIUv0+siWuj+50LQVoN+mZ
         q+WkiBru4fkvdH6ySJyPP4zM+c3j/NpD6Zb/0ysSbAws+hd8JqT88y7xuFMwYrp6rJBp
         K6iw==
X-Gm-Message-State: ACgBeo1hZ7+i3EPSASfUagcBr1RDN0DaEbyXBkWlBCsEXVWWi/x63u4c
        y5hAxIygHTEbnfWzBEXQnk5CPK5m9C/ihqOpbqFujlCzlnikh6XnKcSBd9fdsMkJNpJHHBxKWvm
        Ff/ylpERaXjOJ7lK7dj0ZIZIA
X-Received: by 2002:a05:620a:2591:b0:6c9:cc85:87e3 with SMTP id x17-20020a05620a259100b006c9cc8587e3mr165292qko.577.1662493195306;
        Tue, 06 Sep 2022 12:39:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ttYQWiRMBv+iRAUF0TI1KrYDEUj4oUMahpKt92mQKBQU68PcCAvUwsnwEAqRUP4s0fa6Zng==
X-Received: by 2002:a05:620a:2591:b0:6c9:cc85:87e3 with SMTP id x17-20020a05620a259100b006c9cc8587e3mr165268qko.577.1662493195065;
        Tue, 06 Sep 2022 12:39:55 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bk22-20020a05620a1a1600b006b9c9b7db8bsm12167528qkb.82.2022.09.06.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:39:54 -0700 (PDT)
Date:   Tue, 6 Sep 2022 15:39:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 19/28] mm: disallow do_swap_page to handle
 page faults under VMA lock
Message-ID: <YxeiB2la/9fZEzLO@xz-m1.local>
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-20-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901173516.702122-20-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:35:07AM -0700, Suren Baghdasaryan wrote:
> Due to the possibility of do_swap_page dropping mmap_lock, abort fault
> handling under VMA lock and retry holding mmap_lock. This can be handled
> more gracefully in the future.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 9ac9944e8c62..29d2f49f922a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3738,6 +3738,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	vm_fault_t ret = 0;
>  	void *shadow = NULL;
>  
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +		ret = VM_FAULT_RETRY;
> +		goto out;
> +	}
> +

May want to fail early similarly for handle_userfault() too for similar
reason.  Thanks,

-- 
Peter Xu

