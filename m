Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36464F7C41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbiDGKAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244074AbiDGKAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:00:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE51680BE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:58:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE2EC21122;
        Thu,  7 Apr 2022 09:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649325510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE+cv28KYN3xiXPbIjU3dnkz8QDJL3R+xVJOvX+X4/g=;
        b=usFCJscTWN2SfrsQ84iLxhEPG2OavgNyZNJV7NdudYw/GtavGFr1T1C+3WeldTG64K680f
        EzLhci/hRhJWAS0byAWmEwcfmukHCSOiJdHXVLb7NiBth6bmHZ6oft9a2E1XNkAT/VXmzW
        kOcIdIS52oX4xv051mg5mCCZ3OC2U2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649325510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE+cv28KYN3xiXPbIjU3dnkz8QDJL3R+xVJOvX+X4/g=;
        b=9Q5u38Fp1ioBxblwrgxxGy8fqpiceX46wBETnDXJJGUvUuVWIvVEsQzXLIuxRvCaJqls4x
        f9eLGfICUlJY/VBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 879AB13485;
        Thu,  7 Apr 2022 09:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vzlqIMa1TmJYPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Apr 2022 09:58:30 +0000
Message-ID: <6bf9acf2-4e89-0767-63a5-2231291c30da@suse.cz>
Date:   Thu, 7 Apr 2022 11:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm, kfence: support kmem_dump_obj() for KFENCE objects
Content-Language: en-US
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel test robot <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220406131558.3558585-1-elver@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220406131558.3558585-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 15:15, Marco Elver wrote:
> Calling kmem_obj_info() via kmem_dump_obj() on KFENCE objects has been
> producing garbage data due to the object not actually being maintained
> by SLAB or SLUB.
> 
> Fix this by implementing __kfence_obj_info() that copies relevant
> information to struct kmem_obj_info when the object was allocated by
> KFENCE; this is called by a common kmem_obj_info(), which also calls the
> slab/slub/slob specific variant now called __kmem_obj_info().
> 
> For completeness, kmem_dump_obj() now displays if the object was
> allocated by KFENCE.
> 
> Link: https://lore.kernel.org/all/20220323090520.GG16885@xsang-OptiPlex-9020/
> Fixes: b89fb5ef0ce6 ("mm, kfence: insert KFENCE hooks for SLUB")
> Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

For the slab parts:
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/kfence.h | 24 +++++++++++++++++++++
>  mm/kfence/core.c       | 21 -------------------
>  mm/kfence/kfence.h     | 21 +++++++++++++++++++
>  mm/kfence/report.c     | 47 ++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.c              |  2 +-
>  mm/slab.h              |  2 +-
>  mm/slab_common.c       |  9 ++++++++
>  mm/slob.c              |  2 +-
>  mm/slub.c              |  2 +-
>  9 files changed, 105 insertions(+), 25 deletions(-)
> 
