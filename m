Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5456899C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiGFNgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiGFNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDB5A5F66
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657114558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/WSNz/O/rseR8ionnlRznfb5hq7WNGNhQFdrjMBEzs=;
        b=UP/bwp+pXA8G1xikyoxdhUpcdGhABm26UwpyjhvXNb3mD5/HXCAcfNCyk6dtRO3tLbtfh4
        OigWMlc2U4zna41nUZMVa35FbBckZvybivuNcMXR18q9HOQlvbk0D89Q6RwsYFT830aQXx
        eYXhwDGpm1jHIXBwLZ9A8aw4jjfTBRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-aLsXVjpKPuyDkby57IeVHQ-1; Wed, 06 Jul 2022 09:35:49 -0400
X-MC-Unique: aLsXVjpKPuyDkby57IeVHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CEF780D3C0;
        Wed,  6 Jul 2022 13:35:49 +0000 (UTC)
Received: from [10.22.8.95] (unknown [10.22.8.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B51CC28129;
        Wed,  6 Jul 2022 13:35:49 +0000 (UTC)
Message-ID: <7e1a7093-2dbd-e5aa-3fae-9ade787cbd41@redhat.com>
Date:   Wed, 6 Jul 2022 09:35:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/13] locking/qspinlock: merge qspinlock_paravirt.h into
 qspinlock.c
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-7-npiggin@gmail.com>
 <YsRy5HHdHhRz9z/9@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YsRy5HHdHhRz9z/9@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 13:20, Peter Zijlstra wrote:
> On Tue, Jul 05, 2022 at 12:38:13AM +1000, Nicholas Piggin wrote:
>> There isn't much reason to keep these separate.
> The reason was so that other paravirt implementations could be added.
>
> The CNA thing was also implemented this way...

Do you have any plan to take CNA [1] some time in the future?

Anyway, the main reason the paravirt code is separated into a separated 
file is to leave only the core part in qspinlock.c so that new users are 
overwhelmed with the messy details for the paravirt code. Putting 
everything into a single can make it harder to read for the newbies.

Also eliminating the preprocessor trick will make it harder to integrate 
a different qspinlock variant, like CNA, into the code base.

Cheers,
Longman

[1] 
https://lore.kernel.org/lkml/20210514200743.3026725-1-alex.kogan@oracle.com/

