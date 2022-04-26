Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6E510490
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353368AbiDZQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353270AbiDZQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:53:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CB483AC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD1E5210EE;
        Tue, 26 Apr 2022 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650991732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DubEXr42x7ds9x6qz/cIwq44DoNP3XgeihwGdGP9I2U=;
        b=0WxDKb6VSamYzyLeuic7Kd7xeeRn1cZ5B9ZSw2nR35pKDRMeOv6FcD633Qi8THF3wOfDsK
        fKOynFZqPoUWfI67DI3AjPXc+xy0z5Gs5Z5CUY6L1iah/FnyzgzM+SsNmmlzZWWfvEzbkD
        XR5uN7zofOgcRadGLNL0Oewj7PnxM1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650991732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DubEXr42x7ds9x6qz/cIwq44DoNP3XgeihwGdGP9I2U=;
        b=iOjoOWFBvIGLUEaxnxZ9ZqwJCYAh/ZivbsazEqWSgqB+l2vHXhqBr5iESa7VHYImtAIw2T
        a2a+vb581nd0D8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB33113223;
        Tue, 26 Apr 2022 16:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ySQcKXQiaGLiCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 16:48:52 +0000
Message-ID: <d3ac62ae-740a-5261-2762-7d8120fb8fd2@suse.cz>
Date:   Tue, 26 Apr 2022 18:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
 <20220420095906.27349-6-mgorman@techsingularity.net>
 <0d6bf5a97777bec1e0b425f2fb33dbb80d848621.camel@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <0d6bf5a97777bec1e0b425f2fb33dbb80d848621.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 18:42, Nicolas Saenz Julienne wrote:
> On Wed, 2022-04-20 at 10:59 +0100, Mel Gorman wrote:
>> @@ -3082,15 +3093,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>>   */
>>  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>>  {
>> -	unsigned long flags;
>>  	int to_drain, batch;
>>  
>> -	local_lock_irqsave(&pagesets.lock, flags);
>>  	batch = READ_ONCE(pcp->batch);
>>  	to_drain = min(pcp->count, batch);
>> -	if (to_drain > 0)
>> +	if (to_drain > 0) {
>> +		unsigned long flags;
>> +
>> +		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
>> +		local_irq_save(flags);
> 
> Why dropping the local_lock? That approach is nicer to RT builds, and I don't
> think it makes a difference from a non-RT perspective.

I think the separate irq_disable+spin_lock here is actually broken on RT
config, as explained in Documentation/locking/locktypes.rst. pcp->lock would
have to be a raw_spin_lock.

> That said, IIUC, this will eventually disappear with subsequent patches, right?

So it wouldn't be mergeable even as a temporary step.

> 
>> +
>> +		spin_lock(&pcp->lock);
>>  		free_pcppages_bulk(zone, to_drain, pcp, 0);
>> -	local_unlock_irqrestore(&pagesets.lock, flags);
>> +		spin_unlock(&pcp->lock);
>> +
>> +		local_irq_restore(flags);
>> +	}
>>  }
>>  #endif
>>  
