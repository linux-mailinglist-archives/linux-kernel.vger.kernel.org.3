Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2C2510229
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352529AbiDZPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348927AbiDZPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:52:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A91353B8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:49:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B51F1F38D;
        Tue, 26 Apr 2022 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650988149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wMRNEkRXBcwjzWPrzRFYMfY+IW7Tel+Il+dGf7fXs8=;
        b=DknrYBFWIY1jQuF+BTp/oNZkmwnJC5H5Os2A5VpXk0TRor8m4ey41YtnaDEhqCxkWkCHD9
        +AjW5TQm265xVSU5vWVuC03NTA1EtDuc7wn7McHG1NKUNX/kRvWxR/deIme0jMdMpKkdG2
        ZtjQhzYiiweHOcjODqXIegU6zkmiBpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650988149;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wMRNEkRXBcwjzWPrzRFYMfY+IW7Tel+Il+dGf7fXs8=;
        b=etdjeOWkhdYJtzAhO6Rwnz9kba5tpfQKl62Z29KYv/hzEq+KcZ2QFaCtLhS3+LAg4j7jKD
        33iNNRvSyk1gLUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7CD313AD5;
        Tue, 26 Apr 2022 15:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tAoPNHQUaGJKcAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 15:49:08 +0000
Message-ID: <a85a0358-fd42-a269-9bde-216a9b0520c5@suse.cz>
Date:   Tue, 26 Apr 2022 17:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 04/23] mm/slab_common: cleanup kmalloc_track_caller()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-5-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-5-42.hyeyoo@gmail.com>
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

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> Make kmalloc_track_caller() wrapper of kmalloc_node_track_caller().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  include/linux/slab.h | 17 ++++++++---------
>  mm/slab.c            |  6 ------
>  mm/slob.c            |  6 ------
>  mm/slub.c            | 22 ----------------------
>  4 files changed, 8 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index a3b9d4c20d7e..acdb4b7428f9 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -639,6 +639,12 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
>  	return kmalloc_array(n, size, flags | __GFP_ZERO);
>  }
>  
> +extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
> +					 unsigned long caller) __alloc_size(1);

Update: in v3 remove the extern, it's not necessary and the kernel is slowly
getting rid of them.
