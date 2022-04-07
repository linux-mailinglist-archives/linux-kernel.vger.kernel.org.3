Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271A4F7C39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiDGJ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiDGJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:59:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C5164E1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:57:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C32D121118;
        Thu,  7 Apr 2022 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649325462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nI9oyUvHFM5eGetZ+O4IuNGMmysnPBQecOrPZDio/k=;
        b=CNJ7geQJSlcG/RhHpa1tjottVeZqYpQT0Mw42RTwmO1M5FPxDSdiO8SnH+xXhB1p8Q0BdK
        aovdAVkYlUvQ/Uze/MDUfWR2fJAGM+2oBLs/Mm9axNiNGztzwLkho45nhuFRcuiWvbvDRb
        bdnMPSjLgagVrzhmy9e8Za9gxf4pgA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649325462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nI9oyUvHFM5eGetZ+O4IuNGMmysnPBQecOrPZDio/k=;
        b=/V2x1NPw0ZVL6unKqEvrg10FqFRoxtfHvMrNkYMYnJc9ovOs4ozktsQub9dj0WecH/QxMI
        eElJvePzfLtUNGBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EB3513485;
        Thu,  7 Apr 2022 09:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0741Ipa1TmLtOwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Apr 2022 09:57:42 +0000
Message-ID: <d179e539-1da6-c489-b2b4-ad97367bd73a@suse.cz>
Date:   Thu, 7 Apr 2022 11:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm, kfence: support kmem_dump_obj() for KFENCE objects
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
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
 <4b592848-ef06-ea8a-180a-3efc22b1bb0e@suse.cz>
 <CANpmjNP-XtRB3zTOymH_PCKbDMHoJVYx6UQd_xoM-s33bXJk2w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNP-XtRB3zTOymH_PCKbDMHoJVYx6UQd_xoM-s33bXJk2w@mail.gmail.com>
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

On 4/7/22 11:48, Marco Elver wrote:
> On Thu, 7 Apr 2022 at 11:43, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 4/6/22 15:15, Marco Elver wrote:
>> > Calling kmem_obj_info() via kmem_dump_obj() on KFENCE objects has been
>> > producing garbage data due to the object not actually being maintained
>> > by SLAB or SLUB.
>> >
>> > Fix this by implementing __kfence_obj_info() that copies relevant
>> > information to struct kmem_obj_info when the object was allocated by
>> > KFENCE; this is called by a common kmem_obj_info(), which also calls the
>> > slab/slub/slob specific variant now called __kmem_obj_info().
>> >
>> > For completeness, kmem_dump_obj() now displays if the object was
>> > allocated by KFENCE.
>> >
>> > Link: https://lore.kernel.org/all/20220323090520.GG16885@xsang-OptiPlex-9020/
>> > Fixes: b89fb5ef0ce6 ("mm, kfence: insert KFENCE hooks for SLUB")
>> > Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
>> > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > Signed-off-by: Marco Elver <elver@google.com>
>> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> Thanks.
>> Given the impact on slab, and my series exposing the bug, I will add this to
>> slab tree.
> 
> It's already in Andrew's tree:
> https://lore.kernel.org/all/20220406192351.2E115C385A5@smtp.kernel.org/T/#u

Ah, missed that.

> Does your series and this patch merge cleanly?

Yeah the dependency is not on the code level.

> If so, maybe leaving in
> -mm is fine. Of course I don't mind either way and it's up to you and
> Andrew.

Yeah should be fine as linux-next will be safe with both trees merged. Thanks.

> Thanks,
> -- Marco

