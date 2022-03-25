Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A14E789B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359796AbiCYQFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiCYQFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:05:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3BDA76E1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:04:18 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A74291F7AC;
        Fri, 25 Mar 2022 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648224256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ai5cculYaBCNGgkNRTrUS8pZjDUPLZBEnhlK8ay5zH4=;
        b=XkAcMTAQrWZS6pKxT4yxgBKsP1lWNb8/BjqiHUZIvMe/LrfG4liVmm1/Ez2ES/8C6Cyraq
        PHoS+LYh9WKPFGEYqw+nQRv5wU5CiTXrkwBHOw26xu6pB6/syYfSYJjoJUA6Og6IreoNub
        Ta60PqnofHCaHB+urQfxh4gJR3DTciM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648224256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ai5cculYaBCNGgkNRTrUS8pZjDUPLZBEnhlK8ay5zH4=;
        b=6LQc1v/PdRk3Gnnxf6oLcDFDPyoG88ZdvGtMv8bXKyXzx8gT9KWTfb2zIsxowYoF2DqrmH
        aKsFMt6j2hLFhFAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5762B1339C;
        Fri, 25 Mar 2022 16:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gIdWEgDoPWLLLQAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 16:04:16 +0000
Date:   Fri, 25 Mar 2022 17:04:13 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Alexey Gladkov <legion@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] ns: Move MAX_PID_NS_LEVEL to ns_common.h, reuse it
Message-ID: <Yj3n/XdMvufIw0uZ@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220325112127.18026-1-pvorel@suse.cz>
 <87o81u88ju.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o81u88ju.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Petr Vorel <pvorel@suse.cz> writes:

> > Move MAX_PID_NS_LEVEL to ns_common.h and reuse it in check in
> > user_namespace.c.

> What is the motivation for this change?

> Is it just that there is a bare number in create_user_ns and that is a
> little ugly?  Or is there something more motivating this?

Well, nothing more than to have constant which gives some description.

Kind regards,
Petr

> Eric


> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Christian, all,

> > I don't see putting MAX_PID_NS_LEVEL into ns_common.h as an elegant
> > solution but IMHO better than use a hardwired number or redefinition in
> > user_namespace.h.

> > Kind regards,
> > Petr

> >  include/linux/ns_common.h     | 3 +++
> >  include/linux/pid_namespace.h | 3 ---
> >  kernel/user_namespace.c       | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)

> > diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> > index 0f1d024bd958..173fab9dadf7 100644
> > --- a/include/linux/ns_common.h
> > +++ b/include/linux/ns_common.h
> > @@ -4,6 +4,9 @@

> >  #include <linux/refcount.h>

> > +/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
> > +#define MAX_PID_NS_LEVEL 32
> > +
> >  struct proc_ns_operations;

> >  struct ns_common {
> > diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> > index 07481bb87d4e..f814068012d0 100644
> > --- a/include/linux/pid_namespace.h
> > +++ b/include/linux/pid_namespace.h
> > @@ -11,9 +11,6 @@
> >  #include <linux/ns_common.h>
> >  #include <linux/idr.h>

> > -/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
> > -#define MAX_PID_NS_LEVEL 32
> > -
> >  struct fs_pin;

> >  struct pid_namespace {
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 5481ba44a8d6..6ea6e263403d 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -87,7 +87,7 @@ int create_user_ns(struct cred *new)
> >  	int ret, i;

> >  	ret = -ENOSPC;
> > -	if (parent_ns->level > 32)
> > +	if (parent_ns->level > MAX_PID_NS_LEVEL)
> >  		goto fail;

> >  	ucounts = inc_user_namespaces(parent_ns, owner);
