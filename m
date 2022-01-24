Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB8499EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838667AbiAXWrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:47:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350025AbiAXVhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643060228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7q48nDqJH52nwasKn4MU6PTMavVxq2H/SkUyJ4E2Gc=;
        b=Ve3W8+6Mzqn6Lq/rdu0AJT17g1Z5Wu6+RJaFH3Juv5K4sQhNCYiGVHoCmqy40DXUg7tx92
        NWgVHyFzamc7yhlOK+PlKaN9lekER+7neGH40ThKwD1jkGm3RFFIEwZ4aizlAiVySyfC3T
        JOLl0sK1jg8bAQSf9+Z0Bd3HMweHgrY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45--Hf91_CQOu27FqLOGF-BgQ-1; Mon, 24 Jan 2022 16:37:06 -0500
X-MC-Unique: -Hf91_CQOu27FqLOGF-BgQ-1
Received: by mail-qk1-f197.google.com with SMTP id k190-20020a37a1c7000000b0047d8a74b130so3631885qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7q48nDqJH52nwasKn4MU6PTMavVxq2H/SkUyJ4E2Gc=;
        b=TgBFO8taD39UdCBURnfFEqHU8NnQWvGV46ESPw94bUupvpFSiKdsLjIAVkp7JafBYL
         BkjZQilF9p5crH9C/XLrbvqfajZdDXjr3eB4Vm3jJLT0yawPimDxU1D4xX2SeQSkf5fT
         r/MQihoJ3CN/SHRbyOS2OIn93o3GT9gnoM8VU6J+pTRwX0wfKzQnRELCunoV3jbKFWxj
         mbrlSPOoc7hj2g7H/C8bTC2djM4rT7TGA7+CpbwHzfnY4OCyVzZ80Jru72VMAcaGCoL9
         kXg+p/xXYT9PsAdk1T2zISMJGwRuRdLEHUCbKXRTPM0DZs3tOGyQvu0vaIqQz318yXj+
         +nmw==
X-Gm-Message-State: AOAM530NNlwd09cx3V3RpGvBD+3x1cPKMm30DGLCFSSo05ugn7o2NJ2a
        iStyruVgEJvpifEjkqIJE107tZpodjE7aHb2MLRqZE1Uei04q+VAfQvf3abV/bSMZKN03YEPp7n
        a9zcy7XCCTS5tiBw31nRxvLkd8Hlwy9F3JblWegqn
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr160152qtx.470.1643060226384;
        Mon, 24 Jan 2022 13:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxENcHQBykB+R71peyKNCWZlQR8fLwfIUcwHCuHFtkiFmn2NGP2p8g1zWvx7XU2anZ1AcJ8P5lqh/+uhv6oDxE=
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr160117qtx.470.1643060225927;
 Mon, 24 Jan 2022 13:37:05 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
 <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com> <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 16:36:55 -0500
Message-ID: <CAK-6q+gGx68Wx8mBJAdo0ygpBWPoHW+L+HD11U6UQSOjSXVP3w@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     paulmck@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 3:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 12:41:04PM -0500, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > >
> > > > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > > > >
> > > > > > I see also:
> > > > > >
> > > > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > > > >
> > > > >
> > > > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > > > >
> > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > index cb1f4351e8ba..a164089abec4 100644
> > > > > --- a/include/linux/srcutree.h
> > > > > +++ b/include/linux/srcutree.h
> > > > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > > > >  #ifdef MODULE
> > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > >         is_static struct srcu_struct name;                              \
> > > > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > > > >                 __section("___srcu_struct_ptrs") = &name
> > > > >  #else
> > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > >
> > > >
> > > > I tried it and yes it will fix the issue and introduce another one
> > > > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > > > unused ("-Wunused-const-variable").
> > > > I added a __maybe_unused after the introduced is_static and it seems
> > > > to fix the introduced issue, now it compiles and sparse is happy. I am
> > > > not sure if this is the right fix?
> > >
> > > it is obviously unused, but it has something to do with
> > > "__section("___srcu_struct_ptrs")" and during module loading it, I
> > > suppose, srcu tries to access it to find whatever needs to be
> > > registered?
> >
> > Sorry, but if this is true then it can't be declared as static... and
> > we are at the beginning again.
>
> Welcome to my world!!!  ;-)
>
> More seriously, thank you for chasing this down.  But would it work to
> add a declaration just before?
>

only if I add an "extern" in front of the declaration before, so it looks like:

extern struct srcu_struct * const __srcu_struct_##name;

(compile and sparse tested only)

- Alex

