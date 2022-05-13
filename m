Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD65267A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382549AbiEMQyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382704AbiEMQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:54:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7000E56C2E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:53:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x8so4604500pgr.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AUV1xEazjWXY63tfW7HNmR3TtmSUkdVdBcreZvOq/Dw=;
        b=SU1Y5UeYFEIiSvMSa7oSYvsdj5jyUJnf3NY38OUjCQASpT4Z3aAcq4PZ7LFqBQnkRB
         CbpHiDuaHHvIYSCP0vwq6hA/6Qed4I0YURCe/v7MGM8BQsLY3GvqZVKXKPjQZojDMPYO
         GkPZFbbIrrnEWxUlgs3VrCrFMozz6U62PUshY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUV1xEazjWXY63tfW7HNmR3TtmSUkdVdBcreZvOq/Dw=;
        b=bPbg9IXLVor/ygIHRQ+QrmEcG9lswfoiTrlt27Y2SpQXPclIAsehXS1DHTwtXMZY6U
         Qtywj1FEa6x+YsmKWBXkptltTsdmyLI2LOD+MlnHXqcbZHnnNchewOIR0UmEDzkUU35e
         1Szl7doKKXrpRH7ekoXTOiZeyP8hLUdFA+X/sfXhh3tYU8orzo4yVCSWqTut3jQArdy9
         EvG72CJVQ/QvcqLDR3AtXiAqU5Cj2lgIW3VVEemgntirgJAFp/KosLT9tEf5sd5g0AFp
         r0VvoxE/fwEmqWhgtaUzIRDWzEEwEs2r4S1gtgJKQPD6bv5NAHXz9yej9cEfVXQ4/Ia/
         VpZg==
X-Gm-Message-State: AOAM533zFJG0qm4FLEAa87hJ1nQ/6uLmIc6nixh1YqRnooMb/WHmihvn
        OJ9KUCpaK8hXpFYNGDAntGwpKQ==
X-Google-Smtp-Source: ABdhPJzNdBdAfqwQ5UdhSPodIDV1E0fccuYbI5UfXF8BRC6dSRC9hAykOcqhvA29DbkdaPcpIwrsyQ==
X-Received: by 2002:a63:5513:0:b0:3c3:7bfa:c3ea with SMTP id j19-20020a635513000000b003c37bfac3eamr4648709pgb.243.1652460786017;
        Fri, 13 May 2022 09:53:06 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bc87:9632:bcce:8e17])
        by smtp.gmail.com with UTF8SMTPSA id u14-20020a170902714e00b00160c970eeb7sm1861475plm.234.2022.05.13.09.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 09:53:05 -0700 (PDT)
Date:   Fri, 13 May 2022 09:53:04 -0700
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
Message-ID: <Yn6M8J1lfBpH8rW0@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <YnwioaRiVmYevo8i@google.com>
 <Yn1BkO4t+CXR0nzk@redhat.com>
 <Yn1xyVmPJGQz31lN@google.com>
 <Yn6HaVbfBxmmWkvI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn6HaVbfBxmmWkvI@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:29:29PM -0400, Mike Snitzer wrote:
> On Thu, May 12 2022 at  4:44P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > On Thu, May 12, 2022 at 01:19:12PM -0400, Mike Snitzer wrote:
> > > On Wed, May 11 2022 at  4:54P -0400,
> > > Matthias Kaehlcke <mka@chromium.org> wrote:
> > > 
> > > > Alasdar/Mike, I'd be interested in your take on adding these functions
> > > > to verity/DM, to get an idea whether this series has a path forward to
> > > > landing upstream.
> > > 
> > > I'll be reviewing your patchset now. Comments inlined below.
> > > 
> > > > On Wed, May 04, 2022 at 12:54:17PM -0700, Matthias Kaehlcke wrote:
> > > > > LoadPin limits loading of kernel modules, firmware and certain
> > > > > other files to a 'pinned' file system (typically a read-only
> > > > > rootfs). To provide more flexibility LoadPin is being extended
> > > > > to also allow loading these files from trusted dm-verity
> > > > > devices. For that purpose LoadPin can be provided with a list
> > > > > of verity root digests that it should consider as trusted.
> > > > > 
> > > > > Add a bunch of helpers to allow LoadPin to check whether a DM
> > > > > device is a trusted verity device. The new functions broadly
> > > > > fall in two categories: those that need access to verity
> > > > > internals (like the root digest), and the 'glue' between
> > > > > LoadPin and verity. The new file dm-verity-loadpin.c contains
> > > > > the glue functions.
> > > > > 
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > ---
> > > > > 
> > > > > Changes in v3:
> > > > > - none
> > > > > 
> > > > > Changes in v2:
> > > > > - none
> > > > > 
> > > > >  drivers/md/Makefile               |  6 +++
> > > > >  drivers/md/dm-verity-loadpin.c    | 80 +++++++++++++++++++++++++++++++
> > > > >  drivers/md/dm-verity-target.c     | 33 +++++++++++++
> > > > >  drivers/md/dm-verity.h            |  4 ++
> > > > >  include/linux/dm-verity-loadpin.h | 27 +++++++++++
> > > > >  5 files changed, 150 insertions(+)
> > > > >  create mode 100644 drivers/md/dm-verity-loadpin.c
> > > > >  create mode 100644 include/linux/dm-verity-loadpin.h
> > > > > 
> > > > > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > > > > index 0454b0885b01..e12cd004d375 100644
> > > > > --- a/drivers/md/Makefile
> > > > > +++ b/drivers/md/Makefile
> > > > > @@ -100,6 +100,12 @@ ifeq ($(CONFIG_IMA),y)
> > > > >  dm-mod-objs			+= dm-ima.o
> > > > >  endif
> > > > >  
> > > > > +ifeq ($(CONFIG_DM_VERITY),y)
> > > > > +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> > > > > +dm-mod-objs			+= dm-verity-loadpin.o
> > > > > +endif
> > > > > +endif
> > > > > +
> > > 
> > > Why are you extending dm-mod-objs?  Why not dm-verity-objs?
> > 
> > Sorry, I missed to address this comment in my earlier reply.
> > 
> > I don't recall why I chose dm-mod-objs initially, agreed that
> > dm-verity-objs seems a better fit.
> 
> Yes, should be fixed even though the 3rd patch removes this change.

Sure

> BTW, looking at the 2nd patch's loadpin_is_fs_trusted().  Seems to me
> you'd do well to pass a 'struct block_device *' to a DM helper rather
> than force security/loadpin/loadpin.c to mess around with DM device
> refcounting, etc.

Sounds good to me. Thanks for the suggestion!
