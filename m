Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB135237F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbiEKQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244414AbiEKQAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 655DCE7B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652284840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOFRlNCe+cijJPqNmh7zu1HVKPr5QW/1GHwHYeuiOFI=;
        b=PiCRkhT61iSvrDad1KI9jqTBbVbSwU5TUbAdzVu9w3FYWSQKi2QaL2vFQrmA7zLsaYM/G3
        5FV4qEu39CSS8ucFX6zB3L1MFetjwtJmsezbNi9hsMnoBUYmHXfYfcADKwHcAddqYPlYke
        n2B4Lqzqmku33Tx13+F9bT/maFtm3Jg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-o0Hg4Z2rN9yheGWvI2H9PA-1; Wed, 11 May 2022 12:00:34 -0400
X-MC-Unique: o0Hg4Z2rN9yheGWvI2H9PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FBC883397C;
        Wed, 11 May 2022 16:00:34 +0000 (UTC)
Received: from [10.22.16.235] (unknown [10.22.16.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFFF4141562C;
        Wed, 11 May 2022 16:00:33 +0000 (UTC)
Message-ID: <b64b39ab-58a0-8046-026a-8d635f3f762b@redhat.com>
Date:   Wed, 11 May 2022 12:00:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] locking/qrwlock: Reduce cacheline contention for
 rwlocks used in interrupt context
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20220510192134.434753-1-longman@redhat.com>
 <20220510192134.434753-2-longman@redhat.com>
 <20220511083036.GY76023@worktop.programming.kicks-ass.net>
 <7eff9889-56fe-503c-94ea-376054c6579b@redhat.com>
 <20220511133459.GZ76023@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220511133459.GZ76023@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 09:34, Peter Zijlstra wrote:
> On Wed, May 11, 2022 at 08:44:55AM -0400, Waiman Long wrote:
>
>>> I'm confused; prior to this change:
>>>
>>> 	CPU0			CPU1
>>>
>>> 	write_lock_irq(&l)
>>> 				read_lock(&l)
>>> 				<INRQ>
>>> 				  read_lock(&l)
>>> 				  ...
>>>
>>> was not deadlock, but now it would AFAICT.
>> Oh you are right. I missed that scenario in my analysis. My bad.
> No worries; I suppose we can also still do something like:
>
> void queued_read_lock_slowpath(struct qrwlock *lock, int cnts)
> {
> 	/*
> 	 * the big comment
> 	 */
> 	if (unlikely(in_interrupt())) {
> 		/*
> 		 * If not write-locked, insta-grant the reader
> 		 */
> 		if (!(cnts & _QW_LOCKED))
> 			return;
>
> 		/*
> 		 * otherwise, wait for the writer to go away.
> 		 */
> 		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> 		return;
> 	}
>
> 	...
> }
>
> Which saves one load in some cases... not sure it's worth it though.

Yes, it is a micro-optimization that can be done. The gain, if any, 
should be minor though.

Cheers,
Longman

