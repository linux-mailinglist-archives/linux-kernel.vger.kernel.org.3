Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901644C2F02
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiBXPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiBXPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:09:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE41768FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:08:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE0A21F44A;
        Thu, 24 Feb 2022 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645715311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhvPrxKDo3y/k7N1v/aQZypDM44hzAqHa4NLnDVbyn0=;
        b=qUigAGK7UglM1Ax/0DG1gTM7UhXJC+olGB5Jg6pKHUWADN3ajguSfV3usOJPwsWLt7De8W
        rYVMcfreJ6E5Ltd2sdUkc8x/v/hkQMPAFNs45Xk8s+UHh+TgTpfJ1mfvKVhHZAggpK5xah
        nRZfMBkwn/On4f7qssX0e/CVxP7H2Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645715311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhvPrxKDo3y/k7N1v/aQZypDM44hzAqHa4NLnDVbyn0=;
        b=BgpBY+F4QZehnI1+NwH3WEFm5LjqdVPa7G7nWnCc7qX7/fo/cbcwvOQ64jll+/lfvrwTZo
        EWf6ME0hN4ddEDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8388A13AF7;
        Thu, 24 Feb 2022 15:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h6hFH2+fF2IcVQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Feb 2022 15:08:31 +0000
Message-ID: <10429c77-9492-bf9f-be6f-94e52393213e@suse.cz>
Date:   Thu, 24 Feb 2022 16:08:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported
 size
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-4-42.hyeyoo@gmail.com>
 <8915b858-b46d-0acd-bebd-80a0c9882a7e@suse.cz>
 <YheIxyO/2lcD+aBR@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YheIxyO/2lcD+aBR@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 14:31, Hyeonggon Yoo wrote:
> On Thu, Feb 24, 2022 at 01:48:47PM +0100, Vlastimil Babka wrote:
>> On 2/21/22 11:53, Hyeonggon Yoo wrote:
>> > SLAB's kfree() does not support freeing an object that is allocated from
>> > kmalloc_large(). Fix this as SLAB do not pass requests larger than
>> > KMALLOC_MAX_CACHE_SIZE directly to page allocator.
>> 
>> AFAICS this issue is limited to build-time constant sizes. Might be better
>> to make this a build error rather than build-time NULL?
> 
> Right. And sounds better. But what about another direction as Matthew said:
> passing large requests to page allocator like SLUB?

Sounds like a good idea, that would reduce the number of kmalloc caches with
SLAB, and I expect also simplify the common code further.

> I think it's better for maintenance. Any obstacles for this direction?
> 
> Thank you!
> 
>> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 

