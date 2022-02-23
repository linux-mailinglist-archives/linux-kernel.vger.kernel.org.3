Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6EF4C1526
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiBWOLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiBWOLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:11:35 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA0FB0D2C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:11:06 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id p19so48212238ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phABIdj2nervTu7AKA4uorje6NMaTJX6SO98p2WDatg=;
        b=FLAcdNcu3lRYnXTtjQo0vbyH9BDZt7GVCVkkTL7wCR1Z4/DsS08KFSY1glY1Gm7Km/
         gcUFXoB/L7c6U1th++WkDi++GQDwuWXCb+xtzi3OHr4VxfCx7YfWRCDIi9oww3KEGdlf
         eIg/BmLbZedkBaLmmXYtdMJu3EYAg6+R7Qcvu4hJUZ1qgGFAoowi70GpAvC/KvBnJ0oU
         tnN+CTLsFKPuevSEq/7bYfilakJZGmdhG2Nk3PIM7eECYZq6az9F5aRAmKzd5K0A8stq
         Od1ZGYOHki0sbhjiaroJxhB0Qb/o4mmJtGSwU5M6tpOZawrt88IaNyOlLXG7C2aWVSGU
         eGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phABIdj2nervTu7AKA4uorje6NMaTJX6SO98p2WDatg=;
        b=jaMSDGDzFqjAUbwi37igM1wmv5vs5GpUe+8pkyaQh6Q5RI4w/FZm9QtAueqh31OxHD
         2mfYn8bizHis+07bPtYdS9cN9J9KpudAK/2c/M/MJXb5PfHPyvLIk0q0Te3IPR/OXN74
         ZumxBPKYJI00Xn+gj76YvherWHyk0FKAXWGNCyY2cJmLYIFx9w9bt5RsaGKjc2o9p8OC
         Bf1h2YyneMWQMQcETRv/lyqUOKRh3yFj4GuvrleBBkwyLWTCvD9xelidbmIJns1lAfVO
         pGCuQFYr/zgl0GDvnEG8/qeVKnxq5KyXjyiUcHYRt9zmhatJ+i/vWqRmBTAIzp85qTm+
         42ag==
X-Gm-Message-State: AOAM530S1GYOHz3txHMlcDaKr0neYATnYWiAVylNfit06vT/EFWmc77e
        b9++zyfymsB1MKydGdqS5+iakAK0bgD6fjFYhNIPFw==
X-Google-Smtp-Source: ABdhPJwAE//TeIHCNAZd6BTSXuk8mA8WkjX54Q3b/grjIh0CSztjHeGcURhId1sRso3Hl74i70Fu2PWN9ILT5DO0Xp4=
X-Received: by 2002:a25:2693:0:b0:624:50a8:fee9 with SMTP id
 m141-20020a252693000000b0062450a8fee9mr21007552ybm.348.1645625465753; Wed, 23
 Feb 2022 06:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com> <20220222054025.3412898-3-surenb@google.com>
 <YhSZhzUYlW6IAQT9@dhcp22.suse.cz> <CAJuCfpELxJ=7uuurKL9oRn1E_=rfL3aN8Duhqvi4Z2c1xHAT2w@mail.gmail.com>
 <YhX2mkb327KkZR2/@dhcp22.suse.cz>
In-Reply-To: <YhX2mkb327KkZR2/@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 23 Feb 2022 06:10:54 -0800
Message-ID: <CAJuCfpE+dpCmA6sRQJBanRP2uJiQHGdoGGjvkhL_GqxRdY9aCg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Wed, Feb 23, 2022 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 22-02-22 07:43:40, Suren Baghdasaryan wrote:
> > On Tue, Feb 22, 2022 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 21-02-22 21:40:25, Suren Baghdasaryan wrote:
> > > > When adjacent vmas are being merged it can result in the vma that was
> > > > originally passed to madvise_update_vma being destroyed.  In the current
> > > > implementation, the name parameter passed to madvise_update_vma points
> > > > directly to vma->anon_name->name and it is used after the call to
> > > > vma_merge.  In the cases when vma_merge merges the original vma and
> > > > destroys it, this will result in use-after-free bug as shown below:
> > > >
> > > > madvise_vma_behavior << passes vma->anon_name->name as name param
> > > >   madvise_update_vma(name)
> > > >     vma_merge
> > > >       __vma_adjust
> > > >         vm_area_free <-- frees the vma
> > > >     replace_vma_anon_name(name) <-- UAF
> > >
> > > This seems to be stale because bare const char pointer is not passed in
> > > the call chain. In fact I am not even sure there is any actual UAF here
> > > after the rework.
> > > Could you be more specific in describing the scenario?
> >
> > Yes, sorry, I need to update the part of the description talking about
> > passing vma->anon_name->name directly.
> > I think UAF is still there, it's just harder to reproduce (admittedly
> > I could not reproduce it with the previous reproducer). The scenario
> > would be when a vma with vma->anon_name->kref == 1 is being merged
> > with another one and freed in the process:
> >
> > madvise_vma_behavior
> >    anon_name = vma_anon_name(vma) <-- does not increase refcount
> >    madvise_update_vma(anon_name)
> >      *prev = vma_merge <-- returns another vma
> >        __vma_adjust
> >          vm_area_free(vma)
> >            free_vma_anon_name
> >              anon_vma_name_put
> >                vma_anon_name_free <-- frees the vma->anon_name
> >      vma = *prev <-- original vma was freed
>
> How come this is not a UAF in the first place?

Sorry, I got you confused. The original vma that was passed as a
parameter to vma_merge(vma) was freed and vma_merge() returns the area
it was merged with:

    *prev = vma_merge(vma_a) <-- vma_a is merged with adjacent vma_b,
vma_a is freed and vma_b is returned
    vma = *prev <-- "vma" now points to vma_b

>
> >      replace_vma_anon_name(vma, >>anon_name<<) <-- UAF
> >
> > Does this make sense or did I miss something?
>
> Sorry for being dense but I still do not see it. If *prev has been freed
> then we already have a different UAF. Admittedly, I am not really fluent
> at vma_merge code path so I am not really sure your chain above is
> really possible. I will try to double check later.
> --
> Michal Hocko
> SUSE Labs
