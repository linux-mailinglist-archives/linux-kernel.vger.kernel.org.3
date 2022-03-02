Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A114CB285
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiCBWrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCBWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:47:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436B63BFA;
        Wed,  2 Mar 2022 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=YpoXbNwGd74sARUBgU0icVwfVtOCrhnGXNM0uycbuX4=; b=VhacDt1WEv2jM0wnL7S8nhK0y/
        siBenRqh3Mh/ShtDsB2uOlU7qA98ylm1NkDyARwZnUe0BINy1amON1dndIip+u5y3uzNmlN1RWncH
        /PgdO5hmYWs496mlYymREKFgKFbZ+u9z6ccsT2kIQ+CWyjMcdhfaUG0pp6a7l/tfbul+sdXIJFnBm
        gn1y3CaRiOzYjt76elqG5nDH2rFBVP3x0GDfjGYFTEkVuz97xery2pBGYmSXgzbqlj7PhE2PirX/q
        NKaJgxV5q/ozQv8qAaJuxIJViF07dYcCrFWsXbRicDR+3QDYiref+Cwu0G/jk9Yim4y5tNLZ/HY5+
        s4PPpbxw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPXjv-004cD8-Q2; Wed, 02 Mar 2022 22:46:35 +0000
Date:   Wed, 2 Mar 2022 14:46:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <Yh/zy7FCcDmIdAn8@bombadil.infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:56:23PM +0000, Christophe Leroy wrote:
> 
> 
> Le 02/03/2022 à 21:31, Aaron Tomlin a écrit :
> > On Wed 2022-03-02 16:19 +0000, Daniel Thompson wrote:
> >> On Mon, Feb 28, 2022 at 11:43:21PM +0000, Aaron Tomlin wrote:
> >>> No functional change.
> >>>
> >>> This patch migrates kdb_modules list to core kdb code
> >>> since the list of added/or loaded modules is no longer
> >>> private.
> >>>
> >>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> >>> ---
> >>>   kernel/debug/kdb/kdb_main.c    | 5 +++++
> >>>   kernel/debug/kdb/kdb_private.h | 4 ----
> >>>   kernel/module/main.c           | 4 ----
> >>>   3 files changed, 5 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> >>> index 0852a537dad4..5369bf45c5d4 100644
> >>> --- a/kernel/debug/kdb/kdb_main.c
> >>> +++ b/kernel/debug/kdb/kdb_main.c
> >>> @@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
> >>>   int kdb_grep_leading;
> >>>   int kdb_grep_trailing;
> >>>   
> >>> +#ifdef CONFIG_MODULES
> >>> +extern struct list_head modules;
> >>> +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
> > 
> > Hi Daniel,
> > 
> >> If modules is no longer static then why do we kdb_modules at all?
> >> kdb_modules is used exactly once and it can now simply be replaced
> >> with &modules.
> > 
> > In my opinion, I would prefer to avoid an explicit include of "internal.h"
> > in kernel/module. By definition it should be reserved for internal use to
> > kernel/module only. Please keep to the above logic.
> > 
> > Christophe, Luis,
> > 
> > Thoughts?
> > 
> 
> Do we really want to hide the 'struct list_head modules' from external 
> world ?

> Otherwise we could declare it in include/linux/module.h ?

Since we are doing this to help with the cleaning this crap up
the natural thing to do is have the code be a helper which only
built-in code can use, so writing a helper starting with
list_for_each_entry() which prints the modules out. I'm
surprised we have no other users of this. There is nothing
kdb specific about the functionality in that code. So it should
just be moved.

Exposing just the list_head was a bad idea to begin with. So
let's do away with that. This can be a preamble change to the
series.

  Luis
