Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73E5B2AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIIAP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIIAPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:15:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C270AE85E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:15:43 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-346cd4c3d7aso1848367b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=hqY5A7Q3sRIg+0suDoUYAY9ycBZxq0iP/o3p4lTPQtw=;
        b=oBDufWXfW+Av/lwxqv0a/EmqwgX3S9/bXbt6VPEO7NL873V6R8oQZDcLwtycRTOpXd
         ETEjULXGw4a08PRJMrQ0Nm5rozdANb4QWO+80W8Mflqxsz2iKlb84+RJB/TmEhy3p43o
         p4R41uJlGA49hCYO16U/nbK5AfKp/LocXCNl5xvBp0ILImSEpasSy1IvxO6+UJaGSIcl
         YLsP7TlWAHeAYCI4A+RRC+n1yvSdbLnsaNWmEhuIXbEMmMGUmPmSZZTRN+8g19QX4YyS
         aYOqOsPfivibr4WSH7pE+0/NSWF4MCgHB5gjaRwq/g7jkpOCAn94Vsh+Zd8qJFI5KMqh
         TLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hqY5A7Q3sRIg+0suDoUYAY9ycBZxq0iP/o3p4lTPQtw=;
        b=LxGCfobRfGpGUNTaMKA/Ng2onbOgbmStmT5I0oj2vsWiTi//g90o3gSGo2kMlIMQxg
         HqWmMFknxEOM67FabhGuqy06NG4+2dpGHO+Ez2stYLowBmaP7JcwSHZIlJ9x9OS4yTMy
         9v97uABVcfHW2jmFVBkXy0PUtHfVp+AoExUB/5de9USYw023Ahnd1deRddw7hFlGtOn3
         yPEh7pedNmwMmdWqtNVcsXWwpqdAALZmF7ssO4LIPVTXfmb+Zj9Djoq7go1z2aIv3cmP
         EzsV8IsmxS7cDCrA+KiMRQzpXnB9u72oEQrkkwvPaQTY52LocjDXWvdokMOqVWfAgLI0
         o9bw==
X-Gm-Message-State: ACgBeo011JbQ21UkZqsu8mtOdSib0hLpRz9DtMcpP/GwqO7C3mxhMah9
        bwEk9ZFe5zv9cMKD4a2u2HYFheUnQKy+728PJQup3w==
X-Google-Smtp-Source: AA6agR62K1l39S/fz8ik5C68GuNknlfDBZR1zBzGcquAcYVnBiWDcbx92wi2JBC2nOolf2zZJxL60pxpYTaDIxhQc9o=
X-Received: by 2002:a81:a002:0:b0:345:55c5:9c6e with SMTP id
 x2-20020a81a002000000b0034555c59c6emr9844670ywg.218.1662682542238; Thu, 08
 Sep 2022 17:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-9-surenb@google.com>
 <dcefc6dd-f8eb-945e-37ab-3c0c4e4e20f2@linux.ibm.com>
In-Reply-To: <dcefc6dd-f8eb-945e-37ab-3c0c4e4e20f2@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 8 Sep 2022 17:15:31 -0700
Message-ID: <CAJuCfpHSVS1O=V5+gjm8bboG0FJzZtxo1UYrjoU0+r57o-4zYg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 08/28] mm/khugepaged: mark VMA as locked while
 collapsing a hugepage
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Sep 6, 2022 at 7:43 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:34, Suren Baghdasaryan a =C3=A9crit :
> > Protect VMA from concurrent page fault handler while modifying it in
> > collapse_huge_page.
>
> Is the goal to protect changes in the anon_vma structure?
>
> AFAICS, the vma it self is not impacted here, only the anon_vma and the
> PMD/PTE are touched, and they have their own protection mechanism, isn't =
it?

Yes, I think you are right about not needing to lock VMA here as all
modified components are already protected. Thanks!

>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/khugepaged.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 01f71786d530..030680633989 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1072,6 +1072,7 @@ static void collapse_huge_page(struct mm_struct *=
mm,
> >       if (mm_find_pmd(mm, address) !=3D pmd)
> >               goto out_up_write;
> >
> > +     vma_mark_locked(vma);
> >       anon_vma_lock_write(vma->anon_vma);
> >
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
>
