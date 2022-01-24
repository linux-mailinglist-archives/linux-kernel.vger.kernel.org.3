Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7A49871F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiAXRlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244683AbiAXRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643046076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLmnh7F+9qnrIKW2UFS2DJy4bOHo/tjVCSEI8rXwkN0=;
        b=KUj3Ye52w/EyCg8CoDKt5xipQYmwbSPg8uTzWgk4r+ssEJQWKd3fMo/QxziVRoy6dQ7BOI
        96ImPMkErurODfyIGT5K2R662csC+VrYVTjBhq+qOEGG0TJC3FMEohUvcAXymJMQLrNCQ1
        jo9WycFYVLt5JG71ruvJkt3l8tIgySc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-cQUZn3SHPMW2XMG_NYV9Ew-1; Mon, 24 Jan 2022 12:41:15 -0500
X-MC-Unique: cQUZn3SHPMW2XMG_NYV9Ew-1
Received: by mail-qk1-f199.google.com with SMTP id b13-20020a05620a270d00b0047ba5ddde8dso12875617qkp.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLmnh7F+9qnrIKW2UFS2DJy4bOHo/tjVCSEI8rXwkN0=;
        b=ysZrrRAZ5XzQqVLHfo3DSdqq30gcoWo/3JNxNry/lyBEDmGT4Brruy9s9x54Kw4XJS
         Q60Ay1HTy3tBWowAYk1rEDe8tFt0KxFEMzYGkuiW/jSKv+AhOK2Ef0+oETm4GPErIyFT
         K04z1CJ3LcwYfgDMhZVLAlfGHCNg041YvdKi7SWxoPF29/OlRrxkOwq7c1z/17iaL2S2
         /rzouZ0KdjvLRZPAGQmwGKDeNpTms62YquwuAhVZ6VkUAl9Cr7JR7FWL89B/AE7Ka5cj
         PXbH2VAy20CAl8nfseraEcOIcTRnHsPvoWFbrJCLhqmjv6Vjkr7zA66r/icmCZ/4B8SP
         XDtw==
X-Gm-Message-State: AOAM533eVPYpc+n+sHWlgLmBmlIGbosQQWpzieAOceKc4VH3oPXOJa7J
        m6g8LoZAxlPZ2DTWz0MjzRIswFAR602dDB8HmcXCwHROTOZQHPD1qfSLRF+q5SUATKsdbJAC+VE
        8dP7wGwdFWA+ok6GXny0cFcmiYdVDzjH39A2LvyIy
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr5880994qvc.59.1643046075041;
        Mon, 24 Jan 2022 09:41:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmZ0zoLxqMaj4sgRawFKfYQmeh7BxLZQUfotyGdGqOmghwyprTfohZ9jYN68ECfTUFCiv5VLMuukYTQwYO+9A=
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr5880983qvc.59.1643046074838;
 Mon, 24 Jan 2022 09:41:14 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
In-Reply-To: <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 24 Jan 2022 12:41:04 -0500
Message-ID: <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
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

On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > Hi,
> >
> > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > >
> > > > I see also:
> > > >
> > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > >
> > >
> > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > >
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index cb1f4351e8ba..a164089abec4 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > >  #ifdef MODULE
> > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > >         is_static struct srcu_struct name;                              \
> > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > >                 __section("___srcu_struct_ptrs") = &name
> > >  #else
> > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > >
> >
> > I tried it and yes it will fix the issue and introduce another one
> > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > unused ("-Wunused-const-variable").
> > I added a __maybe_unused after the introduced is_static and it seems
> > to fix the introduced issue, now it compiles and sparse is happy. I am
> > not sure if this is the right fix?
>
> it is obviously unused, but it has something to do with
> "__section("___srcu_struct_ptrs")" and during module loading it, I
> suppose, srcu tries to access it to find whatever needs to be
> registered?

Sorry, but if this is true then it can't be declared as static... and
we are at the beginning again.

- Alex

