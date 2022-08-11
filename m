Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD158F585
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiHKBPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKBPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:15:45 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C45005E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:15:42 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id c3so16914687vsc.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ra3ydByKKM5WStToQCHjdG6o8mmaoU8fttyOCtEBbrY=;
        b=J5TW9q0DopUBP+vAlcG1ZUarFhkG5jZK+dtQw7muCjY0kiL3Bsa5ko9Ua3xMtiY0SS
         m60Vy/KuCLBMDsdcDgxlEgfexk8SjERDglyifjQsPg6Y/EwzxFuOZbAdhyifMIMI6EKO
         9SlUuyWf2gJFiLXjay61AtRymbiwVKy6iKT2J1GbRc2BzupnqWYOhU8/dqv46DchAFg6
         8ZEjBXzPgWqiscSfGxf9OtUuVaxY76JbdepF+GWdcu90AD+BTNR3lmq7wHgCj6PVeRpX
         7HgJ1xWhREVNsYktLm4/8j4Rh7SiYNjJobEHnRajsabVe01247vwiim20AxwLnadYKtY
         atHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ra3ydByKKM5WStToQCHjdG6o8mmaoU8fttyOCtEBbrY=;
        b=WYY5JmfiM7JgTwjtZGVe57vG1QPt+7Xtmy/J2uK7mpvGxIeW/vLvc22iTU9nt2zKn0
         elB8N1U9NYFm8TcyN6XWwJQkBDwiM1S9TUV1gQNYxVvm2UQQBHascRGSzADzANjjRzC3
         g29j+ujGGWPHyv4gPq7K3e2N+xAJMc6QAeINCAGat6QB4U6R7E5MsH70dvC0iMnMg22+
         PUVy/4ncq1yQ/EX0YE/pP2ndtNS8nj0fM26UWnDXzhEZevaaG361ndbsGtVqY6Pg67a6
         1CaOx5P1J0jI+pd4ohf3V+P+GGh5N3ERq0IW/zFpkE7FWFDh9/As2yw3m30lN3kMlpVo
         BaqQ==
X-Gm-Message-State: ACgBeo3C/9R7/MOiBLytPwZQV8HAyiloi+tAOMdG73NqxlOxJuOrAoiC
        kD7qMcbtlQEVgI9YlUivKebwi1ZXKL6cAsQhBxINyg==
X-Google-Smtp-Source: AA6agR5NZVsfTZXVbF4v2rKLDBrmBJSVxbyxN91rJJd5rLLglxWWasdNwM7hzebsZgDrW820ETMkLT1ire9ko9kgVzQ=
X-Received: by 2002:a05:6102:5094:b0:388:6903:5f09 with SMTP id
 bl20-20020a056102509400b0038869035f09mr12494985vsb.46.1660180541484; Wed, 10
 Aug 2022 18:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com> <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com> <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com> <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
 <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com>
In-Reply-To: <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 10 Aug 2022 19:15:05 -0600
Message-ID: <CAOUHufbD-9PpQ+kuD=-8z-ptsrprjyThpkFe+4_NtFnzAjDG9g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>
Cc:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
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

On Wed, Aug 10, 2022 at 6:00 PM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote:
>
>
> > Which series are you talking about? I listed two series and they are
> > very different on the code level.
> >
>
> I was referring to the second patch: https://lore.kernel.org/all/16354222=
15-99394-1-git-send-email-ningzhang@linux.alibaba.com/.

You mean the second patch*set* or series, the link doesn't point to a
single patch :)  "the second patch" could mean the second patch in
that series.

> This patchset adds the THP shrinking as part of shrink_lruvec in mm/vmsca=
n.c. We create a new shrinker that shrinks THPs based off the results
> of the scanning implemented in this thp_utilization patch. We also do not=
 have any of the additional knobs for controlling THP reclaim that the patc=
hset above has. That seems unnecessary in the initial patch as shrinking TH=
Ps that are almost entirely zero pages should only improve performance.
>
> I believe the resulting implementation we have is simpler and easier to u=
nderstand than the above patchset. By identifying and freeing underutilized=
 THPs we hope to eventually deprecate madvise entirely and have THP always =
enabled.
>
> > The 2nd patch from the first series does exactly this.
> >
> >> but it=E2=80=99s worth discussing whether to free zero pages immediate=
ly or to add to lruvec to free eventually.
> >
> > And that patch can be omitted if the third link (a single patch, not a
> > series) is used, which makes the workflow "add to lruvec to free
> > eventually".
> >
> >> I believe the split_huge_page() changes could be valuable by as a patc=
h by itself though. Will send that out shortly.
>
> Referring to this patch: https://lore.kernel.org/r/20210731063938.1391602=
-1-yuzhao@google.com/.
>
> We do indeed do something similar to patches 1 and 3. We may be able to m=
ake use of this instead, I=E2=80=99ll take a closer look.

Please do.

Based on what you said ("chose to free within split_huge_page()"), I
very much suspect you do something similar to patch 2 as well. IIRC,
that location is the best location to free subpages that only contain
zeros because it covers multiple scenarios.
