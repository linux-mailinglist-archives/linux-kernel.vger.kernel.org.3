Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033D4B91B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiBPTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:49:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiBPTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9813F1FFF74
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645040927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g513SF5HE5dJGo2fGBOLLgwg2DHDbXM/NEPim62cYqE=;
        b=fczxFNHCrXkx5XOkahBlaa5BF8cnfIyCkUhka2ML0uK4JUMJ/uZcG1G271qeGzb9ogDS3k
        tv1IQyAQtGq6k6VCF9w89uFbDuBBuLQ6qzWHd3A74Gj20uCKInwBwsKnx9uTDV0A3xwvkV
        rxkl/WMeDtZAcFqwUba8gCi+LO5sk+g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-UlXFKXW9N7GHEJvttbsN6w-1; Wed, 16 Feb 2022 14:48:46 -0500
X-MC-Unique: UlXFKXW9N7GHEJvttbsN6w-1
Received: by mail-ed1-f69.google.com with SMTP id l24-20020a056402231800b00410f19a3103so2230205eda.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g513SF5HE5dJGo2fGBOLLgwg2DHDbXM/NEPim62cYqE=;
        b=7/2bsSk0k7f8w9SPytW1B5Q2op2GVVQm/0Zm+M4I8NnzSMgRQqYIQ1rJZH19d/W5sP
         bzcu9yA9aff07C2U9DuVuwc5+H8B6oPp/6PZIFoCQNVcB1qnxknr/FxJ0QlPrxqi3tCR
         5c2J1UFmI2kvKBnnVpeRhNS2aF9fRPGht7vMkVQ6BeJHo/MQgG+I9HUdDZiltzIpBJR4
         58I/D/x47MvZwUu+DUM1nCWNbHeYVchZmmPgBLWrqw8xLxkM597p5P0/1riM3plb9TA4
         TlMvR0g/3r2HsPCjNCJRYLqJVLvwIinmjwlCZOS7beXYg/fNQMJZeBWY1L6Xy1evLBzt
         pqyQ==
X-Gm-Message-State: AOAM530XLTJBIeG3NXBSHP9+8gr/1h+bxJ0MC3hvE8AMjxrCKFt/l9Xn
        4lFoAi5Yx19uAl5D1jDVHFM+SiUnxeYlsXusLgPlq5BFZyXrPWxRzrwjBqhthedGWFzlezJBgEg
        Dk2eAuoFGspCObNWblehYGzyF
X-Received: by 2002:a17:906:4116:b0:6cd:1980:5ad0 with SMTP id j22-20020a170906411600b006cd19805ad0mr3703369ejk.595.1645040925106;
        Wed, 16 Feb 2022 11:48:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMON0qYvOx6QqzkreXI9Swt4cZKaNePxwWvGtZRanNq4QUNZVQJPSZeBJmGXDgJGmzsxNdLQ==
X-Received: by 2002:a17:906:4116:b0:6cd:1980:5ad0 with SMTP id j22-20020a170906411600b006cd19805ad0mr3703360ejk.595.1645040924959;
        Wed, 16 Feb 2022 11:48:44 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id b4sm269981ejv.108.2022.02.16.11.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:48:44 -0800 (PST)
Message-ID: <dc1e2d11-dbb0-e2d1-bdf0-b38a9b90bea7@redhat.com>
Date:   Wed, 16 Feb 2022 20:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
Content-Language: en-US
To:     Vipin Sharma <vipinsh@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, seanjc@google.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, dmatlack@google.com,
        jiangshanlai@gmail.com, kvm@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211222225350.1912249-1-vipinsh@google.com>
 <20220105180420.GC6464@blackbody.suse.cz>
 <CAHVum0e84nUcGtdPYQaJDQszKj-QVP5gM+nteBpSTaQ2sWYpmQ@mail.gmail.com>
 <Yeclbe3GNdCMLlHz@slm.duckdns.org>
 <7a0bc562-9f25-392d-5c05-9dbcd350d002@redhat.com>
 <YehY0z2vHYVZk52J@slm.duckdns.org> <20220120150502.GC27269@blackbody.suse.cz>
 <CAHVum0fOP-2XcUcG3PqW08DY7CmpDroG6Fcv9KoD1FqLmGpB8w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAHVum0fOP-2XcUcG3PqW08DY7CmpDroG6Fcv9KoD1FqLmGpB8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 18:37, Vipin Sharma wrote:
> Paolo:
> Will you accept a patch which uses real_parent in
> kvm_vm_worker_thread() as suggested by Sean, while I figure out the
> recommendation from Michal about making kthread_stop() wait on
> kernel_wait()?
>          cgroup_attach_task_all(current->real_parent, current)

Yes, of course.

Paolo

