Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155594F7C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiDGJu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiDGJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:50:54 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061DA42EFD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:48:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2eafabbc80aso55043057b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZbNz+SpGjPMORTCOnUHEEDjbgkpN3TzZ8t3nm7Vc+A=;
        b=fJfbpG72F15dzw6yJPdCMqtaaVUiPKONl/VQIBClr4m5Z7qF+ov7M6ksi8z80qWLIp
         aJFiZ9G7SpNwwB8tTNpeNZ9BnGK1uOpeJALMiNdQyn1NWSygi8d4SHj0ufg+WM0Z/eFI
         lzIMu4YP+OKwBUAQ5GMiWreq61vF6Ti81I9H2UgblPQnSqCp8JgepZ0jV4BLuKS+74kS
         sXWwX8cepfr0aPgqGvclG1m1o93On+ITCtZsMiZ6vO+toWKOrPqMcS3HONbihefKFvnS
         +L/4wOvQZG6SyjQVsUBTlJNa1NfhwFpV55wN+Y5a6eYKRggLsmKH+nEWasaQt17tAVjy
         666w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZbNz+SpGjPMORTCOnUHEEDjbgkpN3TzZ8t3nm7Vc+A=;
        b=woj8Wm/srfpBbuKSWSLCM4Sk8+bTUYqQsDTnBLqZ7Q9jXpuEF4leB4YAqc/QV0K3P1
         XeT54bUZg6Tz+BukZqqVDs6ZIj0sZPKjKErQpWxfzYXpP4lzJoCFRPPAW2+xyuIEFeHZ
         L5Vz3s2Qiomn0uop8FbuykThcgakPGnZfIaqVrRDvBER9hnSDpn5NyganpyrS5R9QI4Q
         eeaT0pbJb7+XXBHr8YP90OBlZYBqJOvOo8quLgpPjP/I3kPG4Y28/YZ1LjDWJQ2VcH85
         A7UMnV0Th4OPOXZhFQH7SWq93hQlMJBHqbbB56wtG8RpUTIHPZ78S0ZYVJ0lnIXulpMz
         wC5w==
X-Gm-Message-State: AOAM530knFNFNFri5Tn7JyfC0XQjq/mUVXTaTdwDcN0g4NaoqmOHd+wp
        QaIgpkt9WRAUT9hk/aYvFoaesc4z08KII9PGdaderg==
X-Google-Smtp-Source: ABdhPJwRwYaeYGw4ImLQSlQVlGj4Lgux/eZhTZEthnfJccgUmtDEEr4gywZL4rNhwbkSNiGlHyomepDkDH8pGxwLaj8=
X-Received: by 2002:a0d:c306:0:b0:2e5:96ab:592e with SMTP id
 f6-20020a0dc306000000b002e596ab592emr10782019ywd.316.1649324933050; Thu, 07
 Apr 2022 02:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220406131558.3558585-1-elver@google.com> <4b592848-ef06-ea8a-180a-3efc22b1bb0e@suse.cz>
In-Reply-To: <4b592848-ef06-ea8a-180a-3efc22b1bb0e@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 Apr 2022 11:48:16 +0200
Message-ID: <CANpmjNP-XtRB3zTOymH_PCKbDMHoJVYx6UQd_xoM-s33bXJk2w@mail.gmail.com>
Subject: Re: [PATCH] mm, kfence: support kmem_dump_obj() for KFENCE objects
To:     Vlastimil Babka <vbabka@suse.cz>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 11:43, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/6/22 15:15, Marco Elver wrote:
> > Calling kmem_obj_info() via kmem_dump_obj() on KFENCE objects has been
> > producing garbage data due to the object not actually being maintained
> > by SLAB or SLUB.
> >
> > Fix this by implementing __kfence_obj_info() that copies relevant
> > information to struct kmem_obj_info when the object was allocated by
> > KFENCE; this is called by a common kmem_obj_info(), which also calls the
> > slab/slub/slob specific variant now called __kmem_obj_info().
> >
> > For completeness, kmem_dump_obj() now displays if the object was
> > allocated by KFENCE.
> >
> > Link: https://lore.kernel.org/all/20220323090520.GG16885@xsang-OptiPlex-9020/
> > Fixes: b89fb5ef0ce6 ("mm, kfence: insert KFENCE hooks for SLUB")
> > Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
> Thanks.
> Given the impact on slab, and my series exposing the bug, I will add this to
> slab tree.

It's already in Andrew's tree:
https://lore.kernel.org/all/20220406192351.2E115C385A5@smtp.kernel.org/T/#u

Does your series and this patch merge cleanly? If so, maybe leaving in
-mm is fine. Of course I don't mind either way and it's up to you and
Andrew.

Thanks,
-- Marco
