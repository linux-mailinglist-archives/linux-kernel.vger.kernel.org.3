Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F714CBE39
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiCCM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCCM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:56:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9810F542F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:55:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q20so756212wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H4ymItM9GAkw2uO8ImByzVhFsH40NnmGZAruMPJduOY=;
        b=WDKotuLWG/w09qDE5vlL55XvvZ0KmX8UKowJJhxX/G1ulTptpEz/BptHaOpDdrqCzo
         YZJBSF7iz372E6TzNJT50z6yfr2JapWba6n07jA0oNHeUBqmnPEoIUvSG4pbh5w2Gpum
         VGgSVKCdeUdtA04qpbOwvaCOxVLfK348u8qCs9oQp47uLZpkGRrRUVywW7lA/ORHLnQy
         v5OPyc4yZi8Sg1GSjOT4uyFQ/OTkxvYoCX4YZamlo3NmehV3m5JpSUHjD8XY0lC9Ru+a
         xyX0Ac94MCMNBc559qOuDJWpwZxFzHVYQGb0ZjvxlxMVJ8ws2Pg5wau063VBDBQOsev/
         xbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H4ymItM9GAkw2uO8ImByzVhFsH40NnmGZAruMPJduOY=;
        b=VAnLqVMXRt5+oTnXIiKacDf8BJBe2uHod+MwdJqTvsp7LCGAOrjIVKGok7GF5Y8kIv
         weFEYw9gfoDeVx9t2yjUhFFcjZucYF8o2TN/a33yzy9RfCOe989klWin6YsP9N5NNBPG
         0zTCnKK2jQhJqdwSzTAoFs3OefzcaaVAe3Q5uKi7nX/onjfstg8FK2hh78uQu+3hW8C5
         /P1U2VzXkULXm8fUwAMjglfB1HWrnQpxv6iTxGvDLjlwh0n2/E7XvdM066qTZwVW5SVX
         UZsGpx2dahjOeMWKvasO+L8sJsulvee96cjK+8MJMm2CuZE5IgbHPD6ZO9BjR1wnRwwM
         FlXA==
X-Gm-Message-State: AOAM5321ZYLNFrRbhW9Qi5DU8KvzrQnkwEzsMuLgQKyb1S7UvENfuGTZ
        HUWUPPq1lhphNJpK4g/TADBJuA==
X-Google-Smtp-Source: ABdhPJwO3KU2LifTRIz4uG1CGsqAyXsKWgkUpr3yx16G+UmhFjLMjuYyGmzT2fDC8dBb+ikord0xlA==
X-Received: by 2002:a1c:5404:0:b0:381:6599:4620 with SMTP id i4-20020a1c5404000000b0038165994620mr3704162wmb.56.1646312147291;
        Thu, 03 Mar 2022 04:55:47 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm15017961wmk.9.2022.03.03.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 04:55:46 -0800 (PST)
Date:   Thu, 3 Mar 2022 12:55:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220303125544.wigrv5ul47ftggwu@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:31:53PM +0000, Aaron Tomlin wrote:
> On Wed 2022-03-02 16:19 +0000, Daniel Thompson wrote:
> > On Mon, Feb 28, 2022 at 11:43:21PM +0000, Aaron Tomlin wrote:
> > > No functional change.
> > > 
> > > This patch migrates kdb_modules list to core kdb code
> > > since the list of added/or loaded modules is no longer
> > > private.
> > > 
> > > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > > ---
> > >  kernel/debug/kdb/kdb_main.c    | 5 +++++
> > >  kernel/debug/kdb/kdb_private.h | 4 ----
> > >  kernel/module/main.c           | 4 ----
> > >  3 files changed, 5 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > > index 0852a537dad4..5369bf45c5d4 100644
> > > --- a/kernel/debug/kdb/kdb_main.c
> > > +++ b/kernel/debug/kdb/kdb_main.c
> > > @@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
> > >  int kdb_grep_leading;
> > >  int kdb_grep_trailing;
> > >  
> > > +#ifdef CONFIG_MODULES
> > > +extern struct list_head modules;
> > > +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
> 
> Hi Daniel,
> 
> > If modules is no longer static then why do we kdb_modules at all?
> > kdb_modules is used exactly once and it can now simply be replaced
> > with &modules.
> 
> In my opinion, I would prefer to avoid an explicit include of "internal.h"
> in kernel/module. By definition it should be reserved for internal use to
> kernel/module only. Please keep to the above logic.

Are you sure you are replying the right e-mail here? The quoted text
doesn't propose what you are replying to (although my other e-mail did).

To be clear there are two bits of feedback here and I don't think
"please keep to the above logic" is a sufficient answer.

If I remove the proposal on how to fix the second issue get get:

1. Remove kdb_modules because it is pointless (kdb_main.c can just use
   &modules directly lower down the file).
2. Having an extern in a kdb C file that duplicatively declares
   something from an alien header file is gross ;-) .


Daniel.
