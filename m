Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B44598629
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245701AbiHROio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbiHROil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:38:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D042A27B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:38:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AED423F1B0;
        Thu, 18 Aug 2022 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660833518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUOvmGlI7wKmxNcPCdGuGwwDa2NbX/abFNr9NqvjZw0=;
        b=WTIWY82Tw3Hdv5YfNhdNbZM8aNcndiPzlXWodezlbSWP76veCfJVWjrJRKLlP4PpYEP5Dz
        t4jwu7T0cSGfyQoAApWGJ6k39sZ8cq/C5QGyp3jaTn9GiJXy0jCbRiWUe7IvV7Zx/i4svV
        8WCM+aoixUtRivXbxcgX5ZnquJ3Q/ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660833518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUOvmGlI7wKmxNcPCdGuGwwDa2NbX/abFNr9NqvjZw0=;
        b=Qvtj/6cdFermErecQBQFHbe+hG4VSqe3HCWyLb1VdkqMFe7kYXdMih9LM1ncjvIeE7EDOa
        bhh8Bd9qWXAQkDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F466139B7;
        Thu, 18 Aug 2022 14:38:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BYdTAe5O/mJ0AQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 18 Aug 2022 14:38:38 +0000
Message-ID: <5679405a-b3c3-6dc5-783f-7ebeda7c9bf0@suse.cz>
Date:   Thu, 18 Aug 2022 16:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-2-bigeasy@linutronix.de>
 <alpine.DEB.2.22.394.2208181136560.1901102@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <alpine.DEB.2.22.394.2208181136560.1901102@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 11:42, Christoph Lameter wrote:
> On Wed, 17 Aug 2022, Sebastian Andrzej Siewior wrote:
> 
>> + *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
>> + *   which means the lockless fastpath cannot be used as it might interfere with
>> + *   an in-progress slow path operations. In this case the local lock is always
>> + *   taken but it still utilizes the freelist for the common operations.
> 
> The slub fastpath does not interfere with slow path operations and the

That's true on !PREEMPT_RT because a slowpath operation under
local_lock_irqsave() will disable interrupts, so there can't be a
fastpath operation in an interrupt handler appearing in the middle of a
slowpath operation.

On PREEMPT_RT local_lock_irqsave() doesn't actually disable interrupts,
so that can happen. IIRC we learned that the hard way when Mike
Galbraith was testing early versions of my PREEMPT_RT changes for SLUB.

> fastpath does not require disabling preemption or interrupts if the
> processor supports local rmv operations. So you should be able to use the
> fastpath on PREEMPT_RT.
> 
> If the fastpath is not possible then you need to disable preemption and
> eventually take locks etc and then things may get a bit more complicated.

Yeah that's basically the solution for PREEMPT_RT, take the local_lock.



