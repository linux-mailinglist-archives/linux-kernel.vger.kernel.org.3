Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0209C54C165
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbiFOFwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiFOFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:52:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D7237C3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:52:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BFB21F8F7;
        Wed, 15 Jun 2022 05:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655272328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v/x4ZySKfHwpoxJoLmQ6/CEe5d9dpWm2UprmRWYwfdk=;
        b=tTf8FArWBTRRcFiGPusJuPgESG0J0pohqhiqMl5mo1rDGn6qXyD7wtBFk4sNKguyJIPEpo
        f0+tSq6/mI/MIqEMamN5PLarhTkSiCEo6nAxSk3UjOxDRrPkrUqmsfPGy662H1FcLVbM2i
        3Kwd6g50d2o6X5hoI9l4/+uuW7H/cJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655272328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v/x4ZySKfHwpoxJoLmQ6/CEe5d9dpWm2UprmRWYwfdk=;
        b=eA+EsViOVx0+KXG5OotvslK7j1lZSX6mympWHW0HPBvU9zmQsflTXBY9Z5r4yKmpeyvpqo
        sSzZ1ERs5Cz7VUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7486139EC;
        Wed, 15 Jun 2022 05:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WfQEJodzqWKeYgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 15 Jun 2022 05:52:07 +0000
Date:   Wed, 15 Jun 2022 07:52:06 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, gregkh@linuxfoundation.org
Subject: Re: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw
 error happens
Message-ID: <YqlzhlrjJhqvUV4I@localhost.localdomain>
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
 <20220615020005.246295-2-pizhenwei@bytedance.com>
 <Yqle3M18fuEJE0qn@localhost.localdomain>
 <dbe19d10-beb1-bbdc-7935-3e1cfa46e3e8@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbe19d10-beb1-bbdc-7935-3e1cfa46e3e8@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:18:23PM +0800, zhenwei pi wrote:
> Hi,
> 
> Because memory_failure() may be called by hardware error randomly,
> hw_memory_failure should be protected by mf_mutex to avoid this case:
> int unpoison_memory(unsigned long pfn)
> {
>     ...
>     if (hw_memory_failure) {
>     }
>     ... --> memory_failure() happens, and mark hw_memory_failure as true
>     mutex_lock(&mf_mutex);

Yeah, I am aware of that.
But once memory_failure() sets hw_memory_failure to true, it does not really matter
whether unpoison_memory() checks that while holding or not the lock, does it?

Note that it does not really matter in the end, but I am just curious whether
there is any strong impediment to that. 


-- 
Oscar Salvador
SUSE Labs
