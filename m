Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60CA51B6EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 06:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiEEEQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiEEEQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:16:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7A1C93C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 21:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kPqUPzB7ZQQlCv5tpljxbIPbLYmA0so+DR2l5Jk0zMg=; b=fVfdadQ5Pr5sgP2TEYrIde1mLD
        G6BG/RwDPOqG/wYBd0imGWBVIUtRwNbe5ecX30qffFSkiFMkt3iQxbpF89w5f/jbfDS6jgW67b2Im
        u0Qtnu+aTCO7NJfi8XxBxI9dr7+tZc6T58HIg+LsTweEFdRiIe8kYGkQsWG9q5W7Goj+D6riJhURa
        PmtCey6AvB8S7CMaZ8bHjU1+M9qFsUG3ScJo+4qWrDEBLRyYvhZfMJSHj6X2BybPfL52iCLs9BC3F
        5eqGF4GaOyDI2nYMp5I7TWVGjJUIVAenWRpYO3S3dIB4QiRH635YmScSKo62jDyTgrR+D6mM8xES8
        zhKGZiAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmSr4-00HFa4-KT; Thu, 05 May 2022 04:12:42 +0000
Date:   Thu, 5 May 2022 05:12:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Wait for mutex to become unlocked
Message-ID: <YnNOupZ0o8z0BJEP@casper.infradead.org>
References: <YnLzrGlBNCmCPLmS@casper.infradead.org>
 <20220505015223.5132-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505015223.5132-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:52:23AM +0800, Hillf Danton wrote:
> +++ x/kernel/locking/rwsem.c
> @@ -1464,6 +1464,35 @@ void __sched down_read(struct rw_semapho
>  }
>  EXPORT_SYMBOL(down_read);
>  
> +static void __rwsem_wait(struct rw_semaphore *sem, int read, int state)
> +{
> +	DEFINE_WAIT(wait);
> +	int locked;
> +
> +	prepare_to_wait(&sem->willy_wq, &wait, state);
> +	if (read)
> +		locked = down_read_trylock(sem);

... but then we just acquired the lock.  And the point was to never
acquire the lock.

Also, what's the 'willy_wq' thing?  Do you mean wait_list?
Oh, no, I see, you're pretending that we should add an extra waitq
to the rwsem.  That's very silly.

The point was not to ask "how can we do this", the question was "should we
do this?"  And Thomas, at least for now, is saying "No".

If you want to figure out how to do it properly, see rwsem_add_waiter()
and how it's used.

