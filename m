Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E559A4C1B11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbiBWSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbiBWSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:40:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2454AE09
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:40:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 883511F44C;
        Wed, 23 Feb 2022 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645641604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+EChzHy2LfrMCosgoSfL9AXBhGBFnadi6QAOtRob1E=;
        b=gtRhR/8czww0BMYYT26SJubp/Lrm9h0gw4vQI3C/rGHgM3VBYkRktamAPnNIDeYlPf2MUY
        ULjRwqrFCLUnJ0VHVPqL3offuGkwLLX/CsYyaORy2In+Nse2IiK0GfTEtzcoK0SljXFb25
        +/KoNz/RlSZ+n/gsgp4ohPKMxNBV/NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645641604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+EChzHy2LfrMCosgoSfL9AXBhGBFnadi6QAOtRob1E=;
        b=+SMNEJYtOWHMxVHc/vlOKkDuFaFbnuAgzhkRVCEvnzwueZkfiFUwl+EYBn0FBCnU5qqBFo
        5Ckzk4vGBQzNIyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D81713C98;
        Wed, 23 Feb 2022 18:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TPEMFoR/FmKBPgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Feb 2022 18:40:04 +0000
Message-ID: <18692a8a-00cf-67f5-e7bd-4eb82c64fdf1@suse.cz>
Date:   Wed, 23 Feb 2022 19:40:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/5] mm/sl[auo]b: Do not export __ksize()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-3-42.hyeyoo@gmail.com>
 <YhOzuUDZwVx5CO09@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YhOzuUDZwVx5CO09@casper.infradead.org>
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

On 2/21/22 16:46, Matthew Wilcox wrote:
> On Mon, Feb 21, 2022 at 10:53:33AM +0000, Hyeonggon Yoo wrote:
>> Do not export __ksize(). Only kasan calls __ksize() directly.
> 
> We should probably delete (most of) the kernel-doc comment on __ksize,
> leaving only the note that it's uninstrumented and only called by
> kasan.  Also, we should probably move the declaration of __ksize from
> include/linux/slab.h to mm/slab.h since we don't want to grow new callers.

Agreed, thanks.

