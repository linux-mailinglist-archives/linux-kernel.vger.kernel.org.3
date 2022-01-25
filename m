Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F167249BE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiAYWfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233933AbiAYWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643150136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k75gNnN2Y4rsFZzI0W9vLCBJnfGQeUey/CI75tOWNFw=;
        b=RMlDRizsLa05Ujqz/SWwQf2lo0yGNw6l0xH1wPEz3WMwu55FsXz1hwGA0HHDTvJgoH796B
        h7BYoORMFmfkfX40k74fxBGhaXSZwRrGmXfJOHtTSKkna+ZZNGrtn/BY912Jf7nvfl5hk3
        lj5HTnkS3Ft8s8RUusg+Xs0U0y/q6kM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-PqyxQ0DJNlOjaOvu_VpEqQ-1; Tue, 25 Jan 2022 17:35:35 -0500
X-MC-Unique: PqyxQ0DJNlOjaOvu_VpEqQ-1
Received: by mail-lj1-f197.google.com with SMTP id bd23-20020a05651c169700b0023bc6f845beso1606619ljb.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k75gNnN2Y4rsFZzI0W9vLCBJnfGQeUey/CI75tOWNFw=;
        b=7cmzmVWqiqVVWKzjhi1PNMNNZHAzVx4afotqmGuuRerDpq4khrmGBbqVg7huTkTgY3
         nKXjeabLU8erSbT2uy3a2u1f9A32xcJFrR3MvsKNQq+imcICC8iTuktXKjiD63nJsdYW
         DmIdTzPoJt2c/Nbbx8K8huRJGE/+cmPZLB751qfLyU+PgeOdkDgaRjT2Vv8cwvX8C2eu
         NgYcefL2iIF6HQi/gHraR5fWcZjKyFx83vWFhDpAPd+e43A26eMvvyN+rjgpAJgwj4Xh
         cg6sTPyIXJ24vdjzq0aaubmoEAsdfk3koX5a2DxEzPUSN3ROYKWFSQHhPMC2wuCBzSgC
         n2XA==
X-Gm-Message-State: AOAM532/KQkSvwoA+KMxtHwig70NN22LHQ6RAUc2YU2i6jJX0SN5Ykwh
        n+5FhOteIwEOavie9tO7WqwkFMQ8EiuDydnGks+1/RiWESjHffT1piq0nQzee8ibUMyX0R7jnza
        xbJfu9eocaRIVMspoFsuG5xdyhbe2xINYvyYnrk+v
X-Received: by 2002:a05:6512:3d03:: with SMTP id d3mr8952704lfv.379.1643150132387;
        Tue, 25 Jan 2022 14:35:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9fbIP0TOF/WUCcVN6pugV7F0H0bowPMTO+fLMT9bbADztVRjFSViN9p2AMb5vUvnVWT9NG78ueV8BTeNcdSs=
X-Received: by 2002:a05:6512:3d03:: with SMTP id d3mr8952690lfv.379.1643150132181;
 Tue, 25 Jan 2022 14:35:32 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
 <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com>
 <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1> <CAK-6q+gGx68Wx8mBJAdo0ygpBWPoHW+L+HD11U6UQSOjSXVP3w@mail.gmail.com>
 <20220124220628.GL4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220124220628.GL4285@paulmck-ThinkPad-P17-Gen-1>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 25 Jan 2022 17:35:20 -0500
Message-ID: <CAK-6q+j-3CWEvbFVqxd-_rc67VBZHBXPbGOo5QfGUb_KFEf_FA@mail.gmail.com>
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

On Mon, Jan 24, 2022 at 5:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 04:36:55PM -0500, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Jan 24, 2022 at 3:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Mon, Jan 24, 2022 at 12:41:04PM -0500, Alexander Aring wrote:
> > > > Hi,
> > > >
> > > > On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > > > >
> > > > > > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > > > > > >
> > > > > > > > I see also:
> > > > > > > >
> > > > > > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > > > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > > > > > >
> > > > > > >
> > > > > > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > > > > > >
> > > > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > > > index cb1f4351e8ba..a164089abec4 100644
> > > > > > > --- a/include/linux/srcutree.h
> > > > > > > +++ b/include/linux/srcutree.h
> > > > > > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > > > > > >  #ifdef MODULE
> > > > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > > > >         is_static struct srcu_struct name;                              \
> > > > > > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > > > > > >                 __section("___srcu_struct_ptrs") = &name
> > > > > > >  #else
> > > > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > > > >
> > > > > >
> > > > > > I tried it and yes it will fix the issue and introduce another one
> > > > > > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > > > > > unused ("-Wunused-const-variable").
> > > > > > I added a __maybe_unused after the introduced is_static and it seems
> > > > > > to fix the introduced issue, now it compiles and sparse is happy. I am
> > > > > > not sure if this is the right fix?
> > > > >
> > > > > it is obviously unused, but it has something to do with
> > > > > "__section("___srcu_struct_ptrs")" and during module loading it, I
> > > > > suppose, srcu tries to access it to find whatever needs to be
> > > > > registered?
> > > >
> > > > Sorry, but if this is true then it can't be declared as static... and
> > > > we are at the beginning again.
> > >
> > > Welcome to my world!!!  ;-)
> > >
> > > More seriously, thank you for chasing this down.  But would it work to
> > > add a declaration just before?
> > >
> >
> > only if I add an "extern" in front of the declaration before, so it looks like:
> >
> > extern struct srcu_struct * const __srcu_struct_##name;
> >
> > (compile and sparse tested only)
>
> If that works for everyone, it seems worth persuing.
>
> One way to test this is as follows:
>
> 1.      Build a kernel with CONFIG_RCU_TORTURE_TEST=m.  Boot this and
>         type "modprobe rcutorture torture_type=srcu".
>
>         If you want to stop the torture test, type "rmmod rcutorture".
>
>         This will test DEFINE_SRCU() for the module case.
>

I tested this case, I still need to do the 2. case. Sorry I am quite
busy with something else, but I am still working on it.

Thanks.

- Alex

