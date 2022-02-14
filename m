Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B64B5091
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353627AbiBNMsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:48:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBNMsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F86D63A5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644842889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MC+a4E5vHWoqeNe7xNwus8zL3QSv56UCI6HKMK1dOuA=;
        b=eE+xvsOijTcozbcFkNGIgiPX2xNqt21bK1yWygcafTtMdioHicIXIY54WSTFLCeFZZ7U/S
        L61EZbW6aJ0tFjd/nHaN39sLcZGExyzoUkGfHFBaGcDH4UJBbnRUEIERE3/et5HbxLYmRb
        v6KeyaTkH0cZVqAg3oRL6FOGeStZr6g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-_bdpWxksP8CKauE4xEiN4g-1; Mon, 14 Feb 2022 07:48:08 -0500
X-MC-Unique: _bdpWxksP8CKauE4xEiN4g-1
Received: by mail-qt1-f200.google.com with SMTP id a9-20020aed2789000000b002d78436cc47so12429576qtd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MC+a4E5vHWoqeNe7xNwus8zL3QSv56UCI6HKMK1dOuA=;
        b=PxqFS1E+VuJmbMDv0xZGzTXHWGIFVrdzlZJRdQpHOf9oUEyGSz9gbDa5YGvVkgTmy4
         jFBKgMwlyXWUTqJ4CHKiiZFwc0yVVtp9OLBBZe4JoBSDKaN0bxVwQfrn7ZwCB6HvMIVb
         ktlPWX03jh2BOnhYE/hVVeNnc1/S6jrkomyaZwujCQn7FukwNuAD7KEWUYLAUNYUOapO
         Q0n4YTFtsJZLLq4Se0xfVmPaKyP/2cbBc8IvmwYMltKG0uecNqDJWzWQAQq0tVoI7eN2
         suGF+8c4ueaEoxWgSMPa1qWdQK9KLWu4/bAEjDdbGyTv0CqUYQGAsolnGlQu/jAEH7LE
         H/Ww==
X-Gm-Message-State: AOAM532IdEnNezTP/oFXyKnsv1vIrpnkEKVKD7GpBai3vAgHsO0bwjYU
        WiviLqEIWsI0Lg3RUpNgiQ4gBPf6OS0+xn5gZSg5qUxtkT32U6gXaxT0XkD/5fMbWv5GfgiU78r
        TGsewGBee0LCKg13dH5o0RZqHHfOSvqvHycfToEJH
X-Received: by 2002:a05:622a:10f:: with SMTP id u15mr8988269qtw.339.1644842887923;
        Mon, 14 Feb 2022 04:48:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSAqPv73z8awPafmB3AtaUBWoo4/Bu3VNSyyIEKMSC9kDJgTFGhqlwjU0TEHUMNzFZCtOc+1wT0BFM71n+MNs=
X-Received: by 2002:a05:622a:10f:: with SMTP id u15mr8988260qtw.339.1644842887712;
 Mon, 14 Feb 2022 04:48:07 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <Ygnk6niBpaxF8rwr@zeniv-ca.linux.org.uk>
In-Reply-To: <Ygnk6niBpaxF8rwr@zeniv-ca.linux.org.uk>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 14 Feb 2022 07:47:56 -0500
Message-ID: <CAK-6q+jX6Aa79Ci3E7_+WxXCAh2BF5s67yVNRQze0-25iKjDOA@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 14, 2022 at 12:33 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Jan 22, 2022 at 01:28:20PM -0500, Alexander Aring wrote:
> > Hi,
> >
> > On Fri, Jan 21, 2022 at 9:45 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   9b57f458985742bd1c585f4c7f36d04634ce1143
> > > commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
> > > date:   3 months ago
> > > config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220122/202201221028.YKA8kSdm-lkp@intel.com/config)
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > reproduce:
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.4-dirty
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=658bd576f95ed597e519cdadf1c86ac87c17aea5
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 658bd576f95ed597e519cdadf1c86ac87c17aea5
> > >         # save the config file to linux build tree
> > >         mkdir build_dir
> > >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> >
> > I have it on my list but it isn't easy to make sparse happy here...
> > this is the second time the robot reported this issue. Is there a way
> > to turn the robot off in that case?
> >
> > Maybe some human who reads that knows the answer?
>
> Frankly, these "convert in place" functions (dlm_message_in(), etc.) are
> asking for trouble.  IOW, it's a genuinely fishy code.
>
> Saner approach is to keep them in little-endian through the entire thing,
> but it's quite a bit of massage.

Yes, I agree. That is also what "/net" does, "mark it stored" the way
as the wire handles it.

- Alex

