Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06574EA5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiC2DEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiC2DEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:04:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5D1FE55C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:02:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e203so20511215ybc.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJF2ROwWswfObVh+2bG7an1ccg+/dGsZVnoMIY0qAho=;
        b=gSJ30XwFfgCjoj7FODAJINpGCvebtxMjLRGGevotz+9ZlBRkCUMeU8L9h6Bnq4EbdD
         9mlPKz6SV+vXTltegjU1HzpHmPAcimoAChXTplAr29Yo3iT2YnWV8F1wvC2scvGK8NfH
         oox99sFrFwk6+yWK0lR5qBeAlnNKyjBsDOX5XwmMR8UH6piEfvXDOEkd/XJ1WNiyt+dS
         d5kTuz1eBV1QwXKxN67DbDIAoE122Q2X7jUNHB74UY4t51ikyj8aVEU1w4Rh9fJMFetX
         /QHNt0pSkoMhCW4VQJqY1Zo6idopu36g3Em7DYg1Ql5qdWkZpbMJC8vkBzbay9DbREp4
         rK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJF2ROwWswfObVh+2bG7an1ccg+/dGsZVnoMIY0qAho=;
        b=JbzF2kH0dn8NQkrAgpSlngaJ820KgwybPJ97o9OjsNOPSlfEe33LE2QgIJHu7gKBR4
         RYto2SKs+1Oc+4dqncMfGwBpB/3jjSvGvhYOnN5uvc7hofyfa/U8cKhF2D4FFeznUHIC
         CI72URa58QjJ1PxDidDxmPqmNg9qThioHEru9ZJPfYo0qz/LrLH2Xtg9eKWB6dazka2o
         ZDtml+YxgGhJUY0caw/Hqli750pL4TyakqpcBznVgpiRiLYNpToup45mKBvA7v7feRlw
         L9zmvPw5sdsiDOWrII9xSrIQK3p/3M2on5Fwp1G74gULnj2idmVatrx24Hma5kwrnR9p
         GTCw==
X-Gm-Message-State: AOAM530ayGDcbDl2H9oWxUND7xtseyoSTsPUh2kxmR499mE+dF+LT/iQ
        KFrgcP6z8K7xF03cyVHIbgl51LmHRXAB/vildP2gIw==
X-Google-Smtp-Source: ABdhPJw8uLz2f4kWeQOV9VmVcaiJBylPdGmsHXEuxkEvtSgsM3oqrwPYO0E6tmuL6ic+5M22rbQ6iH9E/dyLDCcKG1o=
X-Received: by 2002:a25:cdca:0:b0:633:c810:6ca with SMTP id
 d193-20020a25cdca000000b00633c81006camr26311135ybf.261.1648522944149; Mon, 28
 Mar 2022 20:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220328132843.16624-1-songmuchun@bytedance.com>
 <CANpmjNO=vMYhL_Uf3ewXvfWoan3q+cYjWV0jEze7toKSh2HRjg@mail.gmail.com>
 <CAMZfGtWfudKnm71uNQtS-=+3_m25nsfPDo8-vZYzrktQbxHUMA@mail.gmail.com>
 <CAMZfGtVkp+xCM3kgLHRNRFUs_fus0f3Ry_jFv8QaSWLfnkXREg@mail.gmail.com> <CANpmjNMszqqOF6TA1RmE93=xRU9pA5oc4RBoAtS+sBWwvS5y4w@mail.gmail.com>
In-Reply-To: <CANpmjNMszqqOF6TA1RmE93=xRU9pA5oc4RBoAtS+sBWwvS5y4w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 29 Mar 2022 11:01:45 +0800
Message-ID: <CAMZfGtXoMhji2TeF7gC13DMD4r3md72-CRXFc2BTfwmOx-K=xw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: kfence: fix objcgs vector allocation
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 2:58 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, 28 Mar 2022 at 17:54, Muchun Song <songmuchun@bytedance.com> wrote:
> [...]
> > > >
> > > > Btw, how did you test this?
> > > >
> >
> > I have tested it with syzkaller with the following configs.
> > And I didn't find any issues.
> >
> > CONFIG_KFENCE=y
> > CONFIG_KFENCE_SAMPLE_INTERVAL=10
> > CONFIG_KFENCE_NUM_OBJECTS=2550
> > CONFIG_KFENCE_DEFERRABLE=n
> > CONFIG_KFENCE_STATIC_KEYS=y
> > CONFIG_KFENCE_STRESS_TEST_FAULTS=0
>
> Hmm, I would have expected that you have some definitive test case
> that shows the issue, and with the patch the issue is gone. Were there
> issues triggered by syzkaller w/o this patch?
>

I have tested this patch with the following patch and without this patch.
Then we'll see the BUG_ON meaning both objcg vector and object are
allocated from kfence pool.

diff --git a/mm/slab.h b/mm/slab.h
index c7f2abc2b154..1d8d15522a2e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -519,6 +519,8 @@ static inline void
memcg_slab_post_alloc_hook(struct kmem_cache *s,
                                continue;
                        }

+                       BUG_ON(is_kfence_address(p[i]) &&
is_kfence_address(slab_objcgs(slab)));
+
                        off = obj_to_index(s, slab, p[i]);
                        obj_cgroup_get(objcg);
                        slab_objcgs(slab)[off] = objcg;
