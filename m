Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1C4DB61F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353413AbiCPQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiCPQ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:28:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC26C1C2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:27:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so2891145pjp.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LOz30deJcjhjIyXrEXiDnvgZ+SlnXxBb7kUkmufCFCs=;
        b=euiuCzfqGkYwgdoQmNRDghuuPrAiXcUV401r/vjPV6N4ydFbIk4O/ZZos55iCYihiJ
         1B2Rdtk2zITgdDZnW4fAcsQkznCDbtClCUyNsp3+wGQqZhtsZcavfxaZO4uc39FbFK5c
         DPNGY6oCGwYL2dtnywRcf3II37L/WfRmydceUYcMRp7yEXaaDpJwqw0cdTtA7oUmf99K
         L3r2N2Ro8VNPJE16xuaG4MaBJbyvbNiaNwRSY0Eyjwppc6RxiTgg9+8s5wDbscVHjrjn
         S/F6K4GdPfbGbLMp3h+Y+rNlIC4IvgqTUFpV8l+loRNejQDA4QjoTkD9Bx4o+eQmBScb
         t/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LOz30deJcjhjIyXrEXiDnvgZ+SlnXxBb7kUkmufCFCs=;
        b=XQcR3UXmGXQdWOlkx/UWyLBRUbWkxUqmtOy7F50WJ4wjwQ5U5hEuH0W7rk2ho5WkqK
         hGG2fTXZH6TNhzQ9vznqWuL+7N6A+Dx1dnV0JIMxQDPeXR+cWrZgdiXHD9fa9Nch4Jok
         6pbx+l/BKPeUhUZaqNO27pHRocxluJ+SwPkX7l0IMJNrNdHnpN5ui/pEFQtOmGpWGjev
         OXQIf31wk+JZA/C/R0w+ULFnqSmIdXhzHqSIJkyla5dwpnUHO4JaDgvUB1wSjYyfkHya
         ekStRTCS07Z25CJCBT2aJOQJmVwX7PDJP6WvGqzYcWbqxiopWwM9KFcu4kIj7qyPMmNN
         UXog==
X-Gm-Message-State: AOAM531yJimsEO+0/a+tb/1ysm5hfEimdwn/krLBn0iDTQ98ZgaBWZLt
        fSRLdvdha5AHovMuhO/sJ/8Xk+FuebJnRQtza2Uk9g==
X-Google-Smtp-Source: ABdhPJytOF5H+Jf3tnI4511+heBxknFBPUzXrfadFH/aaaKAfnciI9nJzGVZMoY9Fe2031uuscVswxuuo1OcklRO2DE=
X-Received: by 2002:a17:902:e745:b0:151:5474:d3ed with SMTP id
 p5-20020a170902e74500b001515474d3edmr319937plf.106.1647448026684; Wed, 16 Mar
 2022 09:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220304184040.1304781-1-shakeelb@google.com> <20220311160051.GA24796@blackbody.suse.cz>
 <20220312190715.cx4aznnzf6zdp7wv@google.com> <20220314125709.GA12347@blackbody.suse.cz>
In-Reply-To: <20220314125709.GA12347@blackbody.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Mar 2022 09:26:55 -0700
Message-ID: <CALvZod4Mfcqt4DvYzSxSX=C9sVWfrMpva9rrMc91_DQ_jReXbA@mail.gmail.com>
Subject: Re: [PATCH] memcg: sync flush only if periodic flush is delayed
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        Frank Hofmann <fhofmann@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 14, 2022 at 5:57 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Hi 2.
>
> On Sat, Mar 12, 2022 at 07:07:15PM +0000, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > It is (b) that I am aiming for in this patch. At least (a) was not
> > happening in the cloudflare experiments. Are you suggesting having a
> > dedicated high priority wq would solve both (a) and (b)?
> > [...]
> > > We can't argue what's the effect of periodic only flushing so this
> > > newly introduced factor would inherit that too. I find it superfluous=
.
> >
> >
> > Sorry I didn't get your point. What is superfluous?
>
> Let me retell my understanding.
> The current implementation flushes based on cumulated error and time.
> Your patch proposes conditioning the former with another time-based
> flushing, whose duration can be up to 2 times longer than the existing
> periodic flush.
>
> Assuming the periodic flush is working, the reader won't see data older
> than 2 seconds, so the additional sync-flush after (possible) 4 seconds
> seems superfluous.
>
> (In the case of periodic flush being stuck, I thought the factor 2=3D4s/2=
s
> was superfluous, another magic parameter.)
>
> I'm comparing here your proposal vs no synchronous flushing in
> workingset_refault().
>
> > Do you have any strong concerns with the currect patch?
>
> Does that clarify?
>
> (I agree with your initial thesis this can be iterated before it evolves
> to everyone's satisfaction.)
>

Thanks Michal for the explanation. For the long term, I think all
these batching can be made part of core rstat infrastructure and as
generic as you have described. Also there is interest in using rstat
from BPF, so generic batching would be needed there as well.
