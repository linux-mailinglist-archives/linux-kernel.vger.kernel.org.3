Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E809468474
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377700AbhLDL1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354802AbhLDL07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:26:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B2C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:23:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x6so22074295edr.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gGSo1LXPHpju9mGduVyFWFR7QGPg34g4rnjIdR8CaEg=;
        b=KeZukj81ITr50PNyXY17158kVJ0rzenC2m/j5zybDdxm1YdykdyCQGZmOb++2v287S
         ZrMQwxwO5GZpVSRfghV59buygKimQQa6sS7xtDMgt3ZTT0GyWfwSWdr7KPLNuGbtDULZ
         6w8gGjPJj1ov4Ox925Jkf77SYgaB0rgBDlX9QAOke5rm61munzE7OiQ5J1FhGWyPsjnP
         z2CVPyGIT/tgF54btVKE/umCirX7+oVZxFwIh1eQ5QArtU5bhcsHYgI8opLPcyBV87aT
         h1dG8lQFOKhR0NKmhkkkm7BoRud+zGXs+q4yl3Vmvhy8DzApo4Y4b2mzeKykrEwE4hiM
         D5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gGSo1LXPHpju9mGduVyFWFR7QGPg34g4rnjIdR8CaEg=;
        b=nPZDEn9mDEUjKmaxm5lt0V8aqqb1RH99DFA9bWpohhp4inwOHMiBNRou5/2IOtAVUV
         y/QlSeN7mESGBO60SV0Y4z7mPYJkhruO/9JMpTg5uMpha9Dn+BwKgH37ammULj3RVteM
         1c2FQqeerSHPYa4MpSC2+ZH+rUpmw8a3FDWTsrlMdQB+2U0KlhAKHhbyRUNdUzr+74E+
         lg7f4HMbRJ1E3LgT2gssV/m5zSo2i4fLoe0V8bju7w90cGIADjRRYUP6B9k/LiT8LtxS
         YWryv1mbbGMNMeed+IFdw6pmgtftVxevR64weeOBe6dC8uBkC7/Q5/egVHRaPNlAjTmG
         GJQA==
X-Gm-Message-State: AOAM531QGT/cNXrfXCpFexCK+vHqUTHU5dnDXJCkgNGxjHqvHX5mdUP2
        m8VgzU2oL1pVBJojT8dGgtEZhO1VoTc6/24KOiZfrIN6wk33nV60SkB7Dw==
X-Google-Smtp-Source: ABdhPJybjaP7D4zHj5WzphQRkSKxfM/gUVpH0MmUE2kGOLg6T84b205jfAO6Xc9/v9m0DMVLVXgF6r40C4FNMN3871o=
X-Received: by 2002:a05:6402:14f:: with SMTP id s15mr34718768edu.118.1638617012975;
 Sat, 04 Dec 2021 03:23:32 -0800 (PST)
MIME-Version: 1.0
References: <1638542272-15187-1-git-send-email-wang.yong12@zte.com.cn> <20211203130210.f34079f175f28bd1c5c26541@linux-foundation.org>
In-Reply-To: <20211203130210.f34079f175f28bd1c5c26541@linux-foundation.org>
From:   yong w <yongw.pur@gmail.com>
Date:   Sat, 4 Dec 2021 19:23:20 +0800
Message-ID: <CAOH5QeDZH4vsjN_hHXfe48XYA02ekf4XvynOQ=GzbtgD9cVzgw@mail.gmail.com>
Subject: Re: [PATCH linux-next] delayacct: track delays from memory compact
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     bsingharora@gmail.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the patch has something wrong.
I'll resend the patch later.

Thanks!

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2021=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E5=91=A8=E5=85=AD 05:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri,  3 Dec 2021 06:37:52 -0800 yongw.pur@gmail.com wrote:
>
> > From: wangyong <wang.yong12@zte.com.cn>
> >
> > Delay accounting does not track the delay of memory compact.
> > When there is not enough free memory, tasks can spend
> > a amount of their time waiting for memory compact.
> >
> > To get the impact of tasks in direct memory compact, measure
> > the delay when allocating memory through memory compact.
> >
> > ...
> >
> > --- a/include/linux/delayacct.h
> > +++ b/include/linux/delayacct.h
> > @@ -42,8 +42,13 @@ struct task_delay_info {
> >       u64 thrashing_start;
> >       u64 thrashing_delay;    /* wait for thrashing page */
> >
> > +     u64 compact_start;
> > +     u64 compact_delay;      /* wait for memory compact */
> > +
> > +     u64 freepages_start;
>
> task_delay_info already has a freepages_start, so it fails to compile.
>
> Did you send the correct version?
>
