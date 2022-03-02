Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA14CAFE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbiCBUc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbiCBUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65804D0042
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646253117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OP/2uKx8aEk4QRV1/mS4vizgIt0EsBCCmcOClKYRNA=;
        b=GZvlfO+P9yboro0CT4D/4zqFItFX0P+mN96Zdv5sr7FMzaSQmWOJdPS4Vm+BempUoHcqin
        Cwme/otErUk5lxm//lum7+nHSCanpwJirGPe++S9fkcWggu4RdfISxtAMDZvf4lHXFDEsm
        Ol2nCDYvTJ3rPXWeGvEX9rpd5HtrCGg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-lj1GPk1TPpuiTBkDXJobYA-1; Wed, 02 Mar 2022 15:31:56 -0500
X-MC-Unique: lj1GPk1TPpuiTBkDXJobYA-1
Received: by mail-wr1-f71.google.com with SMTP id ba15-20020a0560001c0f00b001f01822f821so1056534wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1OP/2uKx8aEk4QRV1/mS4vizgIt0EsBCCmcOClKYRNA=;
        b=XfQInaVinfmHRCmPmVB3AE5+onMARjVC1yllvzIX9CDm2nsi2cmyQUJ+SiW4aurH2d
         nJ6bBPFr2/AQjjmqcXMeMbqT9rvk7xUJ+R2v+p70LIiTO44/Aq0FnMOd4sT09KicWSwK
         ALQq6TBon689h++Zm3jdEwJlp5VLOs17fQAXTjMM6ZbFE/qFQROPBVyS6KhFhB5kCslq
         Mg9+uJzWvnlbpbuCx5CIRq8U6desF8t8wmUqE4oO9r2nBbaM/HfB/+Kz+mbI++UTly36
         82jdCSxqvPJJbqye2COlchLO5BZB9fP3aCrP5yzoh9bQfzbUKZVdX5PulzbCFGkBlXMJ
         MU2w==
X-Gm-Message-State: AOAM533RXmcKvXIE26kLCH92KpY10eirs1a3nPFc+5isuO3sqWwNb3Y6
        hfsAwBp1RGRgXRIwo2VwU5XvqMLJPSw4GZAk7bA1tn62+ptITAHWWref4jHVDeZ17XsB/Tmn180
        KrPg1fOKY1yvAIYQc7Yjz35M=
X-Received: by 2002:a1c:5410:0:b0:380:b8bb:9d22 with SMTP id i16-20020a1c5410000000b00380b8bb9d22mr1260564wmb.29.1646253115406;
        Wed, 02 Mar 2022 12:31:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFWBKJG8eQpQiJzTkTDgjatLYV6yxzNWz1goIG7XaShVpZwHqsqnvMh53pcIgZ0494L6cA4w==
X-Received: by 2002:a1c:5410:0:b0:380:b8bb:9d22 with SMTP id i16-20020a1c5410000000b00380b8bb9d22mr1260551wmb.29.1646253115198;
        Wed, 02 Mar 2022 12:31:55 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b001ef57f562ccsm37971wrn.51.2022.03.02.12.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:31:54 -0800 (PST)
Date:   Wed, 2 Mar 2022 20:31:53 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220302161917.gx5icfszakoye4uh@maple.lan>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 16:19 +0000, Daniel Thompson wrote:
> On Mon, Feb 28, 2022 at 11:43:21PM +0000, Aaron Tomlin wrote:
> > No functional change.
> > 
> > This patch migrates kdb_modules list to core kdb code
> > since the list of added/or loaded modules is no longer
> > private.
> > 
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >  kernel/debug/kdb/kdb_main.c    | 5 +++++
> >  kernel/debug/kdb/kdb_private.h | 4 ----
> >  kernel/module/main.c           | 4 ----
> >  3 files changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 0852a537dad4..5369bf45c5d4 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
> >  int kdb_grep_leading;
> >  int kdb_grep_trailing;
> >  
> > +#ifdef CONFIG_MODULES
> > +extern struct list_head modules;
> > +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */

Hi Daniel,

> If modules is no longer static then why do we kdb_modules at all?
> kdb_modules is used exactly once and it can now simply be replaced
> with &modules.

In my opinion, I would prefer to avoid an explicit include of "internal.h"
in kernel/module. By definition it should be reserved for internal use to
kernel/module only. Please keep to the above logic.

Christophe, Luis,

Thoughts?


Kind regards,

-- 
Aaron Tomlin

