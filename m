Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C385C525485
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357511AbiELSOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357502AbiELSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:14:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B67220D577
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:14:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o69so5936988pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cCpgnlokOHjQ6j/qE23MNlKmH4my80Kr9jmbJvKV6HA=;
        b=a5qdERIG3ORuZdfETXwIMPFBHpvOIL5Zpnqr3dOXvb9bLbOavghwaJ6qOIiYiWjAXV
         ue7uaM0I7TyWBRAbO+bUzlbtmKi66hmLnqzt1V030GlW1Dm9plw9nb5HqXvqw/FY+LAh
         7k7FVMeeyV6HWAKZlM7wZPLLY9JFSPoHKI0xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cCpgnlokOHjQ6j/qE23MNlKmH4my80Kr9jmbJvKV6HA=;
        b=Fvj2h1yy5gV7sP4YTbehqL9XH9tSyd+/yxcBir5dsLajFfhk42c7Im+mLgMBHQrs5Q
         ITYq04rAAI2tlXhnWgmkZzIEJ28jzi5hw71CzwzcYEoqhvjGfZimyS0zlfrHKX4cM1Ys
         JV1KsL0lUSw3Jcc8Asd5s3U4paOHu+rE2lAQXKCROirUdoVukfuMszdIExe2bYg6E/is
         nMqwrorqbQDT5po2Dj4De6sLJIjqME/hlVrzaTSdCa/hHEFsAZIJS9mQZrzFuCwtudYM
         do7MgdlyjrlMfy7uUYQqyQQWO+EuSSheaLN58vG7pCeRQWdnTOnx1TB1jBtyK/3ZNrwq
         s8eg==
X-Gm-Message-State: AOAM531w6zLLmbW/UFcxsim5tzItugehxwlSffLAGljkIquzSo4h5tMI
        yXxDvlUmf+MW/qX4M/op1OGMiQ==
X-Google-Smtp-Source: ABdhPJypRHjtT0PbhvqQRFPkQZb/fkg7qH35ifjYftEZ78Yyu2okd3YzjQ1tU40i7giF8J8ikKLpqA==
X-Received: by 2002:a17:90b:4a4a:b0:1dc:4731:31a4 with SMTP id lb10-20020a17090b4a4a00b001dc473131a4mr791436pjb.19.1652379281590;
        Thu, 12 May 2022 11:14:41 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4060:29b:ac8a:c726])
        by smtp.gmail.com with UTF8SMTPSA id l66-20020a633e45000000b003c14af505f3sm46212pga.11.2022.05.12.11.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 11:14:40 -0700 (PDT)
Date:   Thu, 12 May 2022 11:14:39 -0700
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
Message-ID: <Yn1Oj5aneik2hNZy@google.com>
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

Hi Mike,

On Thu, May 12, 2022 at 01:19:12PM -0400, Mike Snitzer wrote:
> On Wed, May 11 2022 at  4:54P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Alasdar/Mike, I'd be interested in your take on adding these functions
> > to verity/DM, to get an idea whether this series has a path forward to
> > landing upstream.
> 
> I'll be reviewing your patchset now. Comments inlined below.

Thanks for the review!

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
> 
> > >  ifeq ($(CONFIG_DM_VERITY_FEC),y)
> > >  dm-verity-objs			+= dm-verity-fec.o
> > >  endif
> > > diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> > > new file mode 100644
> > > index 000000000000..972ca93a2231
> > > --- /dev/null
> > > +++ b/drivers/md/dm-verity-loadpin.c
> > > @@ -0,0 +1,80 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include <linux/list.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/dm-verity-loadpin.h>
> > > +
> > > +#include "dm.h"
> > > +#include "dm-verity.h"
> > > +
> > > +static struct list_head *trusted_root_digests;
> > > +
> > > +/*
> > > + * Sets the root digests of verity devices which LoadPin considers as trusted.
> > > + *
> > > + * This function must only be called once.
> > > + */
> > > +void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests)
> > > +{
> > > +	if (!trusted_root_digests)
> > > +		trusted_root_digests = digests;
> > > +	else
> > > +		pr_warn("verity root digests trusted by LoadPin are already set!!!\n");
> > > +}
> 
> Would prefer you set a DM_MSG_PREFIX and use DMWARN() instead.

Sure, I'll change it to DMWARN().

> You never explicitly initialize trusted_root_digests to NULL.

That's what I had initially, however checkpatch didn't like it:

ERROR: do not initialise statics to NULL
#70: FILE: drivers/md/dm-verity-loadpin.c:10:
+static struct list_head *trusted_root_digests = NULL;

So I removed it.

> Also, I'll have to look at the caller(s), but without locking this
> branching is racey.

The list of trusted root digests can only be set once and is never
cleared. So if it is not set there is nothing to do, and if it is
set the list is immutable. We are trusting the caller to adhere to
that 'contract' and partially enforce it in dm_verity_loadpin_set_trusted_root_digests()
With that do you still think locking is needed?

> > > +
> > > +static bool is_trusted_verity_target(struct dm_target *ti)
> > > +{
> > > +	u8 *root_digest;
> > > +	unsigned int digest_size;
> > > +	struct trusted_root_digest *trd;
> > > +	bool trusted = false;
> > > +
> > > +	if (!dm_is_verity_target(ti))
> > > +		return false;
> > > +
> > > +	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
> > > +		return false;
> > > +
> > > +	list_for_each_entry(trd, trusted_root_digests, node) {
> > > +		if ((trd->len == digest_size) &&
> > > +		    !memcmp(trd->data, root_digest, digest_size)) {
> > > +			trusted = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	kfree(root_digest);
> > > +
> > > +	return trusted;
> > > +}
> > > +
> > > +/*
> > > + * Determines whether a mapped device is a verity device that is trusted
> > > + * by LoadPin.
> > > + */
> > > +bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
> > > +{
> > > +	int srcu_idx;
> > > +	struct dm_table *table;
> > > +	unsigned int num_targets;
> > > +	bool trusted = false;
> > > +	int i;
> > > +
> > > +	if (!trusted_root_digests || list_empty(trusted_root_digests))
> > > +		return false;
> 
> Again, where is the locking to protect trusted_root_digests?

See above
