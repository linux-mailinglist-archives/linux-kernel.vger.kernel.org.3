Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817605735EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiGMMAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiGMMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:00:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B0F511C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:00:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b11so19403854eju.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S13/SU3IUJGnyuzsBjh7e0r6GzQZXWYfkzzPX6SBB7Q=;
        b=S3i1h6WO9y0XqlLGrWSTGQBsgFmVfiiYuXEXYU58iuJa+0qNG1BmVEPwYB81KOrj91
         utvjQ2PmONGFYeb9gDsAkAG3cs6s+UxxRwP0BLPsppU+Hkyidqj5UebDUxau27KPUQC+
         +qn0kBInqM8hBrZ6IGW++88JGXtOekCOr4jqq4eMzzovCrslMD8cPyG/jKAihWQF/seU
         ArTtMmt8MDOaNlH9+20slMp6WjZiewQ/Dpbe+070LPiuiIMfVzVS0ctkoNBKHWtdjPh9
         nBMtrSN9vCwATAxFm4j+iwJ9YNCWiV2ZWMjlnz6LUkFGRFBJeObeblhtbY6Yt9s8b+s+
         onVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S13/SU3IUJGnyuzsBjh7e0r6GzQZXWYfkzzPX6SBB7Q=;
        b=xMN4+V4i0oZtyE9YjWeY3fTfQflWRebhv+MBAeCC72klkjnboHzJ0Qos3/MqNACnKN
         U77QH6BC5ipGNciv7Jek6wSaK+9rz0joWYCQJP6LaPykbVm6dbZG36M8dTZDg8EDgA3s
         BUlOKQRO88UkUCdkI6hY4LHZByMrxidEQAVMALxqKShXMR3+1hn2RtnAeRybyNLgNqOX
         QRHsBEbUWrPuAQdQVjbTL1cpx3Ozm9GfmPKiymJbqR8MAkDNzavk/5hHftaSfQaMtHat
         wC0c2PDUHVi35LbaOHNvXMo23fEiy2ISGN2z3/GRVRhvAe3VbjPDRG87KfsGfq4bj9vX
         yWpw==
X-Gm-Message-State: AJIora9kMZAkIxiaQbEUB0TEeGNCSBrpP5UEkM44bZq3vuBQyaRAWH6b
        ArqiIqfSCxQ960cRHDoP5kFElBE6Gs6PBz6f/Ag=
X-Google-Smtp-Source: AGRyM1v2OXdKVYrJJUHAdDn2KurrlT+MYAXHkC84x/mf/e6yQ5D48ydGa6HOv6lSsiMAigasz1tcUlhchd20wY+5MBg=
X-Received: by 2002:a17:907:9810:b0:722:f204:b409 with SMTP id
 ji16-20020a170907981000b00722f204b409mr3048532ejc.457.1657713647040; Wed, 13
 Jul 2022 05:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220712214301.809967-1-pauld@redhat.com> <CAGsJ_4xG0az1-g8DWL-mEv_cF3ZBMe6j87m_cxeL9abvxGNW=g@mail.gmail.com>
 <Ys6ud4JmMGjktAlL@lorien.usersys.redhat.com>
In-Reply-To: <Ys6ud4JmMGjktAlL@lorien.usersys.redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 14 Jul 2022 00:00:34 +1200
Message-ID: <CAGsJ_4ypcobo73M9brBD8c_Jc1KLfeY6SSiP=0kFKvHUcUaM=Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
To:     Phil Auld <pauld@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki : --cc=" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.

On Wed, Jul 13, 2022 at 11:37 PM Phil Auld <pauld@redhat.com> wrote:
>
> On Wed, Jul 13, 2022 at 11:18:59AM +1200 Barry Song wrote:
> > On Wed, Jul 13, 2022 at 9:58 AM Phil Auld <pauld@redhat.com> wrote:
> > >
> > > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > > This breaks userspace code that retrieves the size before reading the file. Rather
> > > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960.
> > > In order to get near that you'd need a system with every other CPU on one node or
> > > something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE
> > > to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.
> > >
> > > On an 80 cpu 4-node system (NR_CPUS == 8192)
> > >
> > > before:
> > >
> > > -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> > > -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
> >
> > it is a fundamental problem of bin_attr, isn't it? when we don't know the
> > exact size of an attribute, and this size might become more than one
> > PAGE_SIZE, we use bin_attr to break the limitation. but the fact is that
> > we really don't know or it is really hard to know the actual size of the
> > attribute.
> >
>
> But it broke userspace applications. I figured rather than revert it maybe
> we can find a max size to put in there and make it continue to work.
>
> > >
> > > after:
> > >
> > > -r--r--r--. 1 root root 40960 Jul 12 16:48 /sys/devices/system/node/node0/cpulist
> > > -r--r--r--. 1 root root  4096 Jul 12 15:50 /sys/devices/system/node/node0/cpumap
> >
> > if we finally set a size which might be improper, it seems we defeat the
> > purpose we start to move to bin_attr?
> >
> > >
> > > Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > ---
> > >  drivers/base/node.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > index 0ac6376ef7a1..291c69671f23 100644
> > > --- a/drivers/base/node.c
> > > +++ b/drivers/base/node.c
> > > @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
> > >         return n;
> > >  }
> > >
> > > -static BIN_ATTR_RO(cpumap, 0);
> > > +static BIN_ATTR_RO(cpumap, PAGE_SIZE);
> >
> > PAGE_SIZE is probably big enough, will we still calculate to get it rather than
> > hard coding?
>
> This one is actually wrong. I did not realize how big a NR_CPUS people were actually using.
> It should be something like (NR_CPUS/4 + NR_CPUS/32).
>
> >
> > >
> > >  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > >                                    struct bin_attribute *attr, char *buf,
> > > @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > >         return n;
> > >  }
> > >
> > > -static BIN_ATTR_RO(cpulist, 0);
> > > +static BIN_ATTR_RO(cpulist, (((NR_CPUS * 5) > PAGE_SIZE) ? NR_CPUS *5 : PAGE_SIZE));
> >
> > I am still not sure why it is NR_CPUS * 5. Is 5 bytes big enough to
> > describe the number
> > of cpu id? technically it seems not,  for example,  for cpuid=100000,
> > we need at least 6
> > bytes.
>
> Sure. As I said in the comment I wanted to do NR_CPUS * (ceil(log10(NR_CPUS)) + 1) but doing
> that math in the kernel was messy. So I used 5. Even that is probably way bigger than needed.
> Are there really 100000 cpus on one node with discontiguous cpuids? "0-99999" is only, what,
> 9 characters?
>
> We can put whatever number you want that is >= the size the read will return.

Thanks,
does it mean we can use something like -1UL?

>
> Thanks,
> Phil
>
> >
> > BTW, my silly question is that what if we set the size to MAXIMUM int?
> > Will it fix
> > the userspace fsstat?
> >
> > >
> > >  /**
> > >   * struct node_access_nodes - Access class device to hold user visible
> > > --
> > > 2.31.1
> > >
> >
> > Thanks
> > Barry
> >
>
> --
>
