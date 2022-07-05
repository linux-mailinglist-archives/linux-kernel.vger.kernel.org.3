Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C55677E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiGETfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiGETfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9961113F4C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657049709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZb+7m6BwOHgwZTIM3F92SCtoz3eCtsGyAxs0BJcE2M=;
        b=ARHrlYfaZGWSmUK5uLNmrv3CLTH6rMziPjWcurYKv+g1LN84V4QWlFCH7kjYwwyZfS5Mvv
        7o5uVbZTljIsgEq5/aUu21lCA6EaIkicuj4n8M6+4i0BtXgBJ0gesGwSOGqjDSR8sysO1p
        TXCf7CksO0n/dCKhe6jGs9Gi1SPmU34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-vv5yY6AlM9uFERyuIlXRkA-1; Tue, 05 Jul 2022 15:34:29 -0400
X-MC-Unique: vv5yY6AlM9uFERyuIlXRkA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15149833A11;
        Tue,  5 Jul 2022 19:34:04 +0000 (UTC)
Received: from [10.22.16.141] (unknown [10.22.16.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF780456CD9;
        Tue,  5 Jul 2022 19:34:03 +0000 (UTC)
Message-ID: <48a8bde8-8783-e1f6-ef44-c9cae15f71a7@redhat.com>
Date:   Tue, 5 Jul 2022 15:34:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/13] locking/qspinlock: move pv lock word helpers into
 qspinlock.c
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-5-npiggin@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220704143820.3071004-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 10:38, Nicholas Piggin wrote:
> There is no real reason not to keep all the bit manipulation together.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   kernel/locking/qspinlock.c          | 107 ++++++++++++++++------------
>   kernel/locking/qspinlock_paravirt.h |  51 -------------
>   2 files changed, 63 insertions(+), 95 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 7360d643de29..8f2173e22479 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -141,7 +141,24 @@ struct qnode *grab_qnode(struct qnode *base, int idx)
>   
>   #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
>   
> +/**
> + * set_pending - set the pending bit.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,0,* -> *,1,*
> + *
> + * The pending bit is used by the queue head vCPU to indicate that it
> + * is actively spinning on the lock and no lock stealing is allowed.

The pending bit has different usage in pv and non-pv cases. The 
description here refers to the pv case. For non-pv, it is used to avoid 
loading the the extra node cacheline in likely contended case.

Cheers,
Longman

