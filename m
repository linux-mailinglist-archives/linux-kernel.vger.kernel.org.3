Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2FA52C484
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbiERUfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbiERUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:35:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BAD22DA0C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:35:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so6715617pjp.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s00itn5NvBR8SqfO71jcdooofGWmlax4Aisj/z2cDTA=;
        b=GGmmLX7x8zK3D6+JP5kv/Qow7dHNLOWa7bbHSBmP2iu9pm8M7/Z6KSg0ZIdUW3H0fi
         X0KCV5CjkLXO4nhYw0hYSdMEG9l9aTSc/KKtX3OuWugEhPvGoFKyTnYFkXsbeeNNR11W
         Zi6ImRD7ajC/dQemrIQmifJDcfp1dE4Np+Om4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s00itn5NvBR8SqfO71jcdooofGWmlax4Aisj/z2cDTA=;
        b=aOSkv/d5TQx9shdHgs7q6N8TjwdhckB2EZHptJfCiDrqbrF3N+BeoLmMPMQBGVZrlq
         wC++tZKHiPRc+JcUdr7mDVZaCtFC1ChzWUXNs12XWpJYw0PsUw0uL0Y49t+X0SqcXAs3
         OQCPocW7/H9TZivfWFuz4soY3cZ82aOpL62z2qyxCPIBBIlYDmnT6uypye4uChZCZ8QX
         atvD2rjI6Hs5fSakKV5Zt6QBBWeWClb5iVxEMJRRRkJjBbWv5m9Ce0IgUddbgOZZTuxB
         C3bS2pudiYY2jXTRdnErZyDQeHhcLfvtP01wlhTmdHPf8eqYz8ny62uX7ymVGo79txWN
         9yOg==
X-Gm-Message-State: AOAM533AP/gBCcDOb4e+aelRCz9wwLxnJOf0psistyAAgQ9dNwn8/QSi
        G+OuQ8zlvWOOVVMzvbvDu2MrRg==
X-Google-Smtp-Source: ABdhPJzWsyakzD3BLxsN4vgv1ImwuP5KxbtbCan4rtC1ARwCTboGrDTLGgS1+SENNtXcN/mO8X3D1Q==
X-Received: by 2002:a17:90a:ec01:b0:1df:56aa:6b7b with SMTP id l1-20020a17090aec0100b001df56aa6b7bmr1258866pjy.230.1652906127604;
        Wed, 18 May 2022 13:35:27 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:a14:3166:4b67:b688])
        by smtp.gmail.com with UTF8SMTPSA id w2-20020a62c702000000b0050dc7628161sm2336979pfg.59.2022.05.18.13.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 13:35:27 -0700 (PDT)
Date:   Wed, 18 May 2022 13:35:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dm: Add verity helpers for LoadPin
Message-ID: <YoVYjgwrTdB2DvbW@google.com>
References: <20220517233457.1123309-1-mka@chromium.org>
 <20220517163437.v4.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <YoVOdYHJd/LbYIaE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoVOdYHJd/LbYIaE@redhat.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:52:21PM -0400, Mike Snitzer wrote:
> On Tue, May 17 2022 at  7:34P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > LoadPin limits loading of kernel modules, firmware and certain
> > other files to a 'pinned' file system (typically a read-only
> > rootfs). To provide more flexibility LoadPin is being extended
> > to also allow loading these files from trusted dm-verity
> > devices. For that purpose LoadPin can be provided with a list
> > of verity root digests that it should consider as trusted.
> > 
> > Add a bunch of helpers to allow LoadPin to check whether a DM
> > device is a trusted verity device. The new functions broadly
> > fall in two categories: those that need access to verity
> > internals (like the root digest), and the 'glue' between
> > LoadPin and verity. The new file dm-verity-loadpin.c contains
> > the glue functions.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v4:
> > - a trusted verity device must have a single target of
> >   type 'verity'
> > - share list of verity digests with loadpin, deleted
> >   dm_verity_loadpin_set_trusted_root_digests()
> > - dm_verity_loadpin_is_md_trusted() is now dm_verity_loadpin_is_sb_trusted(),
> >   it receives a super_block instead of mapped_device. Updated kernel doc.
> > - changed struct trusted_root_digest to have an unsized
> >   u8 array instead of a pointer
> > - extend 'dm-verity-objs' instead of 'dm-mod-objs'
> > 
> > Changes in v3:
> > - none
> > 
> > Changes in v2:
> > - none
> > 
> >  drivers/md/Makefile               |  6 +++
> >  drivers/md/dm-verity-loadpin.c    | 74 +++++++++++++++++++++++++++++++
> >  drivers/md/dm-verity-target.c     | 33 ++++++++++++++
> >  drivers/md/dm-verity.h            |  4 ++
> >  include/linux/dm-verity-loadpin.h | 27 +++++++++++
> >  5 files changed, 144 insertions(+)
> >  create mode 100644 drivers/md/dm-verity-loadpin.c
> >  create mode 100644 include/linux/dm-verity-loadpin.h
> > 
> > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > index 0454b0885b01..71771901c823 100644
> > --- a/drivers/md/Makefile
> > +++ b/drivers/md/Makefile
> > @@ -108,6 +108,12 @@ ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
> >  dm-verity-objs			+= dm-verity-verify-sig.o
> >  endif
> >  
> > +ifeq ($(CONFIG_DM_VERITY),y)
> > +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> > +dm-verity-objs			+= dm-verity-loadpin.o
> > +endif
> > +endif
> > +
> >  ifeq ($(CONFIG_DM_AUDIT),y)
> >  dm-mod-objs			+= dm-audit.o
> >  endif
> > diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> > new file mode 100644
> > index 000000000000..3226fbe4a1fe
> > --- /dev/null
> > +++ b/drivers/md/dm-verity-loadpin.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/list.h>
> > +#include <linux/kernel.h>
> > +#include <linux/dm-verity-loadpin.h>
> > +
> > +#include "dm.h"
> > +#include "dm-verity.h"
> > +
> > +#define DM_MSG_PREFIX	"verity-loadpin"
> > +
> > +LIST_HEAD(loadpin_trusted_verity_root_digests);
> > +
> > +static bool is_trusted_verity_target(struct dm_target *ti)
> > +{
> > +	u8 *root_digest;
> > +	unsigned int digest_size;
> > +	struct trusted_root_digest *trd;
> > +	bool trusted = false;
> > +
> > +	if (!dm_is_verity_target(ti))
> > +		return false;
> > +
> > +	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
> > +		return false;
> > +
> > +	list_for_each_entry(trd, &loadpin_trusted_verity_root_digests, node) {
> > +		if ((trd->len == digest_size) &&
> > +		    !memcmp(trd->data, root_digest, digest_size)) {
> > +			trusted = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	kfree(root_digest);
> > +
> > +	return trusted;
> > +}
> > +
> > +/*
> > + * Determines whether the file system of a superblock is located on
> > + * a verity device that is trusted by LoadPin.
> > + */
> > +bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb)
> > +{
> > +	struct mapped_device *md;
> > +	struct dm_table *table;
> > +	struct dm_target *ti;
> > +	int srcu_idx;
> > +	bool trusted = false;
> > +
> > +	if (list_empty(&loadpin_trusted_verity_root_digests))
> > +		return false;
> > +
> > +	md = dm_get_md(sb->s_bdev->bd_dev);
> > +	if (!md)
> > +		return false;
> > +
> > +	table = dm_get_live_table(md, &srcu_idx);
> > +
> > +	if (dm_table_get_num_targets(table) != 1)
> > +		goto out;
> > +
> > +	ti = dm_table_get_target(table, 0);
> > +
> > +	if (is_trusted_verity_target(ti))
> > +		trusted = true;
> > +
> > +out:
> > +	dm_put_live_table(md, srcu_idx);
> > +	dm_put(md);
> > +
> > +	return trusted;
> > +}
> 
> Not seeing why passing a super_block a block layer interface was
> chosen.
> 
> Please pass the super_block's block_device and rename to
> dm_verity_loadpin_is_bdev_trusted()

Agreed, passing a block_device is a better choice here, I'll
change it as suggested.
