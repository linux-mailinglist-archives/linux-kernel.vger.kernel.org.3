Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F6648C4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353572AbiALNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353538AbiALNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:23:14 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D340C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:23:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c6so6341265ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZvDWrOdsVL4BOKMYpdO/DNmNYh/wCYm8X3avXlAB3QI=;
        b=TH2+3tnzeR1GyZg1J16O9I9i7mV9b3PVye495KnEfWywjmr7Q/bqysBwsQADqi23Fs
         GEFJQbtX9+KILIkNCU5gsGR0e5d7GsiOBDPvAYwQIOXbE0qhsN654BLc8zgCiFG3mPjd
         aAdJV27ygEPpJfbuMzu/sADpS/SxQjywTR17duEyuN3vfFAXvGrcM5Ga5c8gre3Ow+/Q
         UqVt0EBh25e8NgEgXAoAarX7Yols3zbFpXGpV57tEGafhJjCDo0b4TedOOmYfeRjF+j8
         VP3RF675+P494CTjh+GmgbWBkQgD2ppZGbBQs4hnNhBoGz5jOR7zpkCo/Cv9tVohAtcQ
         O4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZvDWrOdsVL4BOKMYpdO/DNmNYh/wCYm8X3avXlAB3QI=;
        b=tQsnQ9XaxXe7YiIWL0G/u1ORLriEfj+QDTPDRhnU+hTr9g/O7CZZS2PCZSMObcYrDL
         VYWUzTJnXRjxAcrA/pSI6pJyBhzPJ9s1Y32bk13kWXiy+8sKkZOBytTpJxEyW+mq13OG
         vgsIzvSiGnh+qMEcndHLPrxAUVSndefkK6lfqTsmQF0HZZS2Xv9OF2bR6xXUYgjqb6kS
         b/MVByjyPY+LlXYcT33/RQvo+UIvp1dPj+MR92LYGkx9w0kR1AjPRfKwpiQ0nV1IXKE7
         7FmVGoihwbSLPrDoE0rljdhyZ9kX5x/1Oa+yej1h0PXLHqnVsLbVxTJ6QQRngbE7XZIn
         Hd9w==
X-Gm-Message-State: AOAM533DU+fBBtXeluLrmuqc1UczhakKZLX5XeilRWw9twjITW4hR8qL
        tUsiYITXgtYObtOY88Qmq5geALZUuxKENIN9dpcYsQ==
X-Google-Smtp-Source: ABdhPJzn6jkkLg1oD5rgWaN1+oUd7J+lgyPMPUiyJxuZXWEbG1a/3aIxBVbuAwx14gtjCubSA0jhhFLbb7lrqZhsDNQ=
X-Received: by 2002:a25:77cb:: with SMTP id s194mr274565ybc.485.1641993793293;
 Wed, 12 Jan 2022 05:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com> <20220106110051.GA470@blackbody.suse.cz>
In-Reply-To: <20220106110051.GA470@blackbody.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 12 Jan 2022 21:22:36 +0800
Message-ID: <CAMZfGtXZA+rLMUw5yLSW=eUncT0BjH++Dpi1EzKwXvV9zwqF1w@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] mm: list_lru: allocate list_lru_one only when needed
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 7:00 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Mon, Dec 20, 2021 at 04:56:43PM +0800, Muchun Song <songmuchun@bytedan=
ce.com> wrote:
> (Thanks for pointing me here.)
>
> > -void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_mem=
cg)
> > +void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgro=
up *dst)
> >  {
> > +     struct cgroup_subsys_state *css;
> >       struct list_lru *lru;
> > +     int src_idx =3D src->kmemcg_id;
> > +
> > +     /*
> > +      * Change kmemcg_id of this cgroup and all its descendants to the
> > +      * parent's id, and then move all entries from this cgroup's list=
_lrus
> > +      * to ones of the parent.
> > +      *
> > +      * After we have finished, all list_lrus corresponding to this cg=
roup
> > +      * are guaranteed to remain empty. So we can safely free this cgr=
oup's
> > +      * list lrus in memcg_list_lru_free().
> > +      *
> > +      * Changing ->kmemcg_id to the parent can prevent memcg_list_lru_=
alloc()
> > +      * from allocating list lrus for this cgroup after memcg_list_lru=
_free()
> > +      * call.
> > +      */
> > +     rcu_read_lock();
> > +     css_for_each_descendant_pre(css, &src->css) {
> > +             struct mem_cgroup *memcg;
> > +
> > +             memcg =3D mem_cgroup_from_css(css);
> > +             memcg->kmemcg_id =3D dst->kmemcg_id;
> > +     }
> > +     rcu_read_unlock();
>
> Do you envision using this function anywhere else beside offlining?
> If not, you shouldn't need traversing whole subtree because normally
> parents are offlined only after children (see cgroup_subsys_state.online_=
cnt).
>
> >
> >       mutex_lock(&list_lrus_mutex);
> >       list_for_each_entry(lru, &memcg_list_lrus, list)
> > -             memcg_drain_list_lru(lru, src_idx, dst_memcg);
> > +             memcg_drain_list_lru(lru, src_idx, dst);
> >       mutex_unlock(&list_lrus_mutex);
>
> If you do, then here you only drain list_lru of the subtree root but not
> the descendants anymore.
>
> So I do get that mem_cgroup.kmemcg_id refernces the "effective"
> kmemcg_id after offlining, so that proper list_lrus are used afterwards.
>
> I wonder -- is this necessary when objcgs are reparented too? IOW would
> anyone query the offlined child's kmemcg_id?
> (Maybe it's worth explaining better in the commit message, I think even
> current approach is OK (better safe than sorry).)
>

Sorry for the late reply.

Image a bunch of memcg as follows. C's parent is B, B's parent is A and
A's parent is root. The numbers in parentheses are their kmemcg_id
respectively.

  root(-1) -> A(0) -> B(1) -> C(2)

CPU0:                                   CPU1:
memcg_list_lru_alloc(C)
                                        memcg_drain_all_list_lrus(C)
                                        memcg_drain_all_list_lrus(B)
                                        // Now C and B are offline. The
                                        // kmemcg_id becomes the following =
if
                                        // we do not the kmemcg_id of its
                                        // descendants in
                                        // memcg_drain_all_list_lrus().
                                        //
                                        // root(-1) -> A(0) -> B(0) -> C(1)

  for (i =3D 0; memcg; memcg =3D parent_mem_cgroup(memcg), i++) {
      // allocate struct list_lru_per_memcg for memcg C
      table[i].mlru =3D memcg_init_list_lru_one(gfp);
  }

  spin_lock_irqsave(&lru->lock, flags);
  while (i--) {
      // here index =3D 1
      int index =3D table[i].memcg->kmemcg_id;

      struct list_lru_per_memcg *mlru =3D table[i].mlru;
      if (index < 0 || rcu_dereference_protected(mlrus->mlru[index], true))
          kfree(mlru);
      else
          // mlrus->mlru[index] will be assigned a new value regardless
          // memcg C is already offline.
          rcu_assign_pointer(mlrus->mlru[index], mlru);
  }
  spin_unlock_irqrestore(&lru->lock, flags);

So changing ->kmemcg_id of all its descendants can prevent
memcg_list_lru_alloc() from allocating list lrus for the offlined
cgroup after memcg_list_lru_free() calling.

Thanks.
