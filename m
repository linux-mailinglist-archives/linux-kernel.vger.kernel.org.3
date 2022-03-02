Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7E4CAA1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbiCBQ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbiCBQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:27:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FA9E9E6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:26:26 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ay10so3628615wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lZEInqzBQdxmom04rLGOTBOINe87ZHTNK8A1MHNUYM=;
        b=zNY/A3DvXSSHSOLKYTxwjW4mjiSxKTe2DFTa9drWsknJ9Gobo/rAHMhdkBLLnUF8it
         qObkZaPUtzMcW0vv80UyqbGn/5SqEJm5CWtnqtNf416LbLOH03IHCDcalJaCaNnQqmxa
         n7JOmOog5D44bHsXOE9UR4UELZJ0fyDRKRw2sg464T2pSOZ/8YSImYpJ3+7w/18AZrm/
         QVjeS2JlyxOhcZTWDhqbC0p+x8FcyzIDVLtpp9OSPqij50FzVjYaVMJ8SxAgdZHfT7RG
         faSL3/PPKB61LMyU9PIhxtaqQqPnmwi8mqwaM9f4L8E7gFTt3Hft0K5TWhEtuzuGZbds
         unrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lZEInqzBQdxmom04rLGOTBOINe87ZHTNK8A1MHNUYM=;
        b=dvic50vgM3kGDC2TAkQbf2LCK343TQ4Yzc3uusScqWBhjMppZ3O09he1ZTa2KrzzTK
         buKalzgDLkjGhTmjriYutFoEeUajASx8mT8o01KDMzKPSzJuYHzYWDLCNE6ECbPYIy7I
         2yI3oKy0ceAK+Qy0VAItRZ171q1F6yQbH1NbVuIaoH/sjfjiLf2Q9CYuWcECWkdFxS4F
         VL/eJcS9VNDf1rmsjdlMeKzSK9j3aCdkT9BntVk3wT2evWa6ng1K0HUOe2VR8W8sDFpC
         b+ZrwTgamAo+dsOGDTF9trUaVgIk2Pun06IBF3DaNL0mMugwaFG1eOHp8Jcyr5EgaKo4
         dy4A==
X-Gm-Message-State: AOAM5330UsDwhUbJOH9Am/vW7plzuXRgo+2qMl3dkhSqoA19VShCrKq5
        TFgOZ7FPcJ9dpL5mKY/WQ4NtKw==
X-Google-Smtp-Source: ABdhPJxbCsWQrJHmYbdS8sJGQSK+IN5/SW7XDx1ANefT8UUiw7YoiSlpX6p5XW4Wc6Ducn8hIA0qbA==
X-Received: by 2002:a5d:52d2:0:b0:1ef:e22d:18ba with SMTP id r18-20020a5d52d2000000b001efe22d18bamr10036216wrv.30.1646238385454;
        Wed, 02 Mar 2022 08:26:25 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g22-20020a1c4e16000000b003817614d4adsm6068399wmh.12.2022.03.02.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:26:24 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:26:22 +0000
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
Message-ID: <20220302162622.z5wxbdmxh2pqh6cb@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302161917.gx5icfszakoye4uh@maple.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:19:17PM +0000, Daniel Thompson wrote:
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

Actually thinking a bit harder and trying
`git grep '#include .*[.][.]' kernel/` (which finds some prior art) I
wonder if we even want the extern or whether
`#include "../../module/internal.h"` would be more robust.


Daniel.


> > +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
> 
> If modules is no longer static then why do we kdb_modules at all?
> kdb_modules is used exactly once and it can now simply be replaced
> with &modules.
> 
> 
> Daniel.
