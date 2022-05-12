Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740A525680
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358422AbiELUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355122AbiELUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:45:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FCB22EA40
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:45:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so5938823pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mfDd2mUqrFJnPjYIAGb7iTHqp7/V/kqIzmO4Ik5ICtE=;
        b=VSL2P1g6oKCepZ9gpAuZb3IJYGYlROev7evIcpI2bAO4ymJpGTpTPWg28w7aZ74nqu
         +4hkrxBXxozmtUkznxUeB16mVvTNuWjlKl3GvgorQtDgqz1Nl+vcsah0mU6P4adNEl8I
         hzSvp6YfypuLT0514UmzVGtZJ2H2UTxby3128=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfDd2mUqrFJnPjYIAGb7iTHqp7/V/kqIzmO4Ik5ICtE=;
        b=5M6dyzTFKZ03aEXJsc8rNOrahZk+IyBkhEWz0iXCKExL7OMvuMVJvd2TdeNVQn7g7H
         IhTgxXL3VwJIlE5sqOU40M5Vm1HI8qmk+Xfo/K++P0RqcYexlg1toYWCTL6oaXKuXOAJ
         VbN0TFGMZG2vHsEjG0LBUdrMtw8BNW1eBhN7KwJ+/QLIVKq/149hogFFfZ59FIlJT+TS
         fbo9K3C3KKNF6d4IHkgQYFb1ObG601f9sPpmci1xbKpj/zUXjtHdLkICs3Wm5+DIVAR6
         wCJMeY2YORJ1jtqVwLzcUl7NOsXGTsyV0Hfo7cixbDxCFypjtlSUXSZ9puar7IaYoO8+
         aqIA==
X-Gm-Message-State: AOAM531MlFDpR3TfmA4RBFJ2ZwsSCzK97dg/q/qXaSccASG2I4TIYFGX
        xqMc3s08+BDYhz3Zgtg0TiD9mA==
X-Google-Smtp-Source: ABdhPJweC1XGidiP3A3Cg1L4P+c7vLixuIQHOEhEEVMPX3OSorgSxCxtYRx8oqG/gfH5ctvhV02/CQ==
X-Received: by 2002:a17:902:ed52:b0:15e:c71f:72c8 with SMTP id y18-20020a170902ed5200b0015ec71f72c8mr1599550plb.38.1652388299601;
        Thu, 12 May 2022 13:44:59 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4060:29b:ac8a:c726])
        by smtp.gmail.com with UTF8SMTPSA id i9-20020aa79089000000b0050dc76281e4sm223297pfa.190.2022.05.12.13.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 13:44:59 -0700 (PDT)
Date:   Thu, 12 May 2022 13:44:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dm: Add verity helpers for LoadPin
Message-ID: <Yn1xyVmPJGQz31lN@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <YnwioaRiVmYevo8i@google.com>
 <Yn1BkO4t+CXR0nzk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn1BkO4t+CXR0nzk@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:19:12PM -0400, Mike Snitzer wrote:
> On Wed, May 11 2022 at  4:54P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Alasdar/Mike, I'd be interested in your take on adding these functions
> > to verity/DM, to get an idea whether this series has a path forward to
> > landing upstream.
> 
> I'll be reviewing your patchset now. Comments inlined below.
> 
> > On Wed, May 04, 2022 at 12:54:17PM -0700, Matthias Kaehlcke wrote:
> > > LoadPin limits loading of kernel modules, firmware and certain
> > > other files to a 'pinned' file system (typically a read-only
> > > rootfs). To provide more flexibility LoadPin is being extended
> > > to also allow loading these files from trusted dm-verity
> > > devices. For that purpose LoadPin can be provided with a list
> > > of verity root digests that it should consider as trusted.
> > > 
> > > Add a bunch of helpers to allow LoadPin to check whether a DM
> > > device is a trusted verity device. The new functions broadly
> > > fall in two categories: those that need access to verity
> > > internals (like the root digest), and the 'glue' between
> > > LoadPin and verity. The new file dm-verity-loadpin.c contains
> > > the glue functions.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > 
> > > Changes in v3:
> > > - none
> > > 
> > > Changes in v2:
> > > - none
> > > 
> > >  drivers/md/Makefile               |  6 +++
> > >  drivers/md/dm-verity-loadpin.c    | 80 +++++++++++++++++++++++++++++++
> > >  drivers/md/dm-verity-target.c     | 33 +++++++++++++
> > >  drivers/md/dm-verity.h            |  4 ++
> > >  include/linux/dm-verity-loadpin.h | 27 +++++++++++
> > >  5 files changed, 150 insertions(+)
> > >  create mode 100644 drivers/md/dm-verity-loadpin.c
> > >  create mode 100644 include/linux/dm-verity-loadpin.h
> > > 
> > > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > > index 0454b0885b01..e12cd004d375 100644
> > > --- a/drivers/md/Makefile
> > > +++ b/drivers/md/Makefile
> > > @@ -100,6 +100,12 @@ ifeq ($(CONFIG_IMA),y)
> > >  dm-mod-objs			+= dm-ima.o
> > >  endif
> > >  
> > > +ifeq ($(CONFIG_DM_VERITY),y)
> > > +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> > > +dm-mod-objs			+= dm-verity-loadpin.o
> > > +endif
> > > +endif
> > > +
> 
> Why are you extending dm-mod-objs?  Why not dm-verity-objs?

Sorry, I missed to address this comment in my earlier reply.

I don't recall why I chose dm-mod-objs initially, agreed that
dm-verity-objs seems a better fit.
