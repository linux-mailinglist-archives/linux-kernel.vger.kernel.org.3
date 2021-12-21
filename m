Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1652947B666
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhLUAKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:10:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36398 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhLUAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:10:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3642B21106;
        Tue, 21 Dec 2021 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640045408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYGvME1uSoFSCaAxR1iahCMCOfGqv/V5I/AkMxpnPwM=;
        b=wo/prubQnHjPsISXZey/6LTJRpRurrIterEPtoEXLgCpjHPEdAcl9q01JvuPTJfOL8RzP0
        /EnP3IS9Bz/0yoykv2QPoPQdSqkl+CQJk+BwD1lIOPjgqwEMmURhGJwtuP6ZVWJDF4kv2Q
        qSfHYozjS7xQ/NKzJX3baEIa450jSBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640045408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYGvME1uSoFSCaAxR1iahCMCOfGqv/V5I/AkMxpnPwM=;
        b=K2saZED9w9gv56a35gJso7sh/N2EnF8115dgwJ708p9tmlZH6J49S3dbg+iIXrgI7q7UFt
        ect+ezDZkbVTZpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B159139F6;
        Tue, 21 Dec 2021 00:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gJOoBWAbwWG0AQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Dec 2021 00:10:08 +0000
Message-ID: <3ec33e65-1080-96be-f8bb-0012e3b87387@suse.cz>
Date:   Tue, 21 Dec 2021 01:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: manual merge of the akpm-current tree with the slab
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
References: <20211203181951.79618878@canb.auug.org.au>
 <20211217233953.28062c5b@canb.auug.org.au>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211217233953.28062c5b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 13:39, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 3 Dec 2021 18:19:51 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the akpm-current tree got a conflict in:
>> 
>>   mm/memcontrol.c
>> 
>> between commit:
>> 
>>   eefa12e18a92 ("mm/memcg: Convert slab objcgs from struct page to struct slab")
>> 
>> from the slab tree and commit:
>> 
>>   93e959c235eb ("mm/memcg: relocate mod_objcg_mlstate(), get_obj_stock() and put_obj_stock()")
>> 
>> from the akpm-current tree.
>> 
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>> 
...
>>  -int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>>  -				 gfp_t gfp, bool new_page)
>>  +int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
>>  +				 gfp_t gfp, bool new_slab)
>>   {
>>  -	unsigned int objects = objs_per_slab_page(s, page);
>>  +	unsigned int objects = objs_per_slab(s, slab);
>>   	unsigned long memcg_data;
>>   	void *vec;
>>   
> 
> This is now a conflict between the slab tree and Linus' tree.

Thanks, rebased slab-next to v5.16-rc6 to avoid the conflict.
