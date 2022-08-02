Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A15882BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiHBTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBTn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:43:26 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15650712
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:43:25 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so18329268fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZujhYrVvvAmnwjraE3ShnaLiZzxSjfKysRrz6y6PpA=;
        b=ZSPJfxkVJtHKhnn6H5pieCDozzVCYNcABXzvLcAE9csfr57RgROVrF3BA/baeJeZZ/
         oQXwTvhG/F7lfTn4I0219O547Ud2OtEn5f+sTcNPJ0ItaauVo/leAMOHy2tUIcw4WaTe
         rka8BSFHq09cVAj/UQPnh+BDtMko299AVBX3Wg1ZiiWF2lOXvBZZdFdFuBphXz9WrG29
         v2FHor9/kYhbWK43j72XraVMG9RBiUm/zfBPBZC2tZG0PAmiwlbxo635QWX0HrXlNW9E
         IcxI6Dpti0lOmDOhpH8G9cZNNlwkH99gV7diguECiQNNQjWSJ+atsznDNssY9kUHn0qa
         fRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZujhYrVvvAmnwjraE3ShnaLiZzxSjfKysRrz6y6PpA=;
        b=JHoj0xw3shkCkp88tH4k4hEAX2vvA/zT8cN/NONT3ODUNFVrEHOdMtId2rFyMrIMft
         I2pD+34IgHYLKCERHOLsTylVMriy5K56hJ3GKCoEQAGNv1othDguMyyH0cfMpabhJTy9
         K4dZWAFAQKaUsXGXzeyx1FOhTlabLyk+fqyfmabrELOm+z+dppXK2ej4G11Mj8H+GAvC
         IUdU4RTNarVcOpBB/oMdg/n6kOchtdCj75pzJVd9EXkHcnCheNznjmtZhA6fhdKth/tV
         fA2mv8wISRs2uDHDNn0pqPjPvannGDMi9IlmQAQElzD8CRBY+1h/HtsuxwoSWaQra/fI
         AjcQ==
X-Gm-Message-State: ACgBeo37H0m8KyfXL/oh9QbMNOPOK1UsF2VP9tb58hDS9off/MEpGiZS
        CLLTsihwiyOVoeDlmw6SLROECwQ2v9FaLsf8eJ8gPA==
X-Google-Smtp-Source: AA6agR7yMFNZuea36Auv9bhp/MY6EQ4zBLvwrr6zBdwaahXs41PVfFBBbnF9DeonuwCyq/+nSdm9TBmXBeQiZbplKk4=
X-Received: by 2002:a05:6870:a91d:b0:10c:55e:3f64 with SMTP id
 eq29-20020a056870a91d00b0010c055e3f64mr426579oab.123.1659469404221; Tue, 02
 Aug 2022 12:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220801210946.3069083-1-zokeefe@google.com> <YujpzGKImMQsn8SM@dhcp22.suse.cz>
 <CAAa6QmS=VbsdvHgvFQCceV+pYHwSSj1pjhX3_voz12T4rJ-EBQ@mail.gmail.com> <YukSvpPRuus2bHOu@dhcp22.suse.cz>
In-Reply-To: <YukSvpPRuus2bHOu@dhcp22.suse.cz>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Tue, 2 Aug 2022 12:42:48 -0700
Message-ID: <CAAa6QmS2aAtJyWPFi1to99o=vHWFmiQRW72+3HdZ-4qGk2FT5Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/madvise: remove CAP_SYS_ADMIN requirement
 for process_madvise(MADV_COLLAPSE)
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 5:04 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 02-08-22 02:48:33, Zach O'Keefe wrote:
> [...]
> > "mm/madvise: add MADV_COLLAPSE to process_madvise()" in the v7 series
> > ended with me mentioning a couple options, but ultimately I didn't
> > present a solution, and no consensus was reached[1]. After taking a
> > closer look, this is my proposal for what I believe to be the best
> > path forward. It should be squashed into the original patch. What do you think?
>
> If it is agreed that the CAP_SYS_ADMIN is too strict of a requirement
> then yes, this should be squashed into the original patch. There is no
> real reason to create a potential bisection headache by changing the
> permission model in a later patch.

Sorry about the confusion here. Assumed (incorrectly) that Andrew
would kindly squash this in mm-unstable since I added the Fixes: tag.
Next time I'll add some explicit verbiage saying it should be
squashed.

> From my POV, I would agree that CAP_SYS_ADMIN is just too strict of a
> requirement.
>
> I didn't really have time to follow recent discussions but I would argue
> that the operation is not really destructive or seriously harmful. All
> applications can already have their memory (almost) equally THP
> collapsed by khupaged with the proposed process_madvise semantic.
>
> NOHUGEMEM and prctl opt out from THP are both honored AFAIU and the only
> difference is the global THP killswitch behavior which I do not think
> warrants the strongest CAP_SYS_ADMIN capability (especially because it
> doesn't really control all kinds of THPs).

Ya. In fact, I don't think the ignoring the THP sysfs controls
warrants any additional capability (set alone CAPS_SYS_ADMIN), since a
malicious program can't really inflict any more damage than they would
with CAP_SYS_NICE and PTRACE_MODE_READ.

> If there is a userspace agent collapsing memory and causing problems
> then it can be easily fixed in the userspace. And I find that easier
> to do than putting the bar so high that userspace agents would be
> unfeasible because of CAP_SYS_ADMIN (which is nono in many cases as it
> would allow essentially full control of other stuff). So from practical
> POV, risking an extended RSS is really a negligible risk to lose a
> potentially useful feature for all others.
>

Agreed.

Thanks for taking the time, Michal!
Zach


> Just my 2c
>
> > Thanks again,
> > Zach
> >
> > [1] https://lore.kernel.org/linux-mm/Ys4aTRqWIbjNs1mI@google.com/
>
> --
> Michal Hocko
> SUSE Labs
