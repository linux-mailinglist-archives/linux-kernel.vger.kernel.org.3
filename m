Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8483A4E78BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376381AbiCYQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359500AbiCYQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:14:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA7A7740
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:12:29 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06050210E3;
        Fri, 25 Mar 2022 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648224748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RPCxz5N55QLXlN1/xRMNa6lO14yTPmb5CXnIV41+Nk=;
        b=KUnqXo1rsQXfALr0vSwRvuvtglvh11CZN8PNG7IF/HV2lq/lsuFNlol1h7gPJy30ED1Shl
        pwPhmn11c4+EHrkWgB0yTcjjRZP4z5JxmTNHuV016K5Bp2A5qadCtV7FWW+YLbPucD9Tqr
        2QJPclqfRiZuqOHZuNbZUv4vxZDlYUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648224748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RPCxz5N55QLXlN1/xRMNa6lO14yTPmb5CXnIV41+Nk=;
        b=91SzJp+0LTOeeEIqGniPhR2t3tS1V6GzkVkabYOj+NDmokLZci7hEYlokW6cfP4YQsmTj4
        BbQFnb/RTP3op0Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A632C1339C;
        Fri, 25 Mar 2022 16:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id njaWJuvpPWLfMAAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 16:12:27 +0000
Date:   Fri, 25 Mar 2022 17:12:25 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] ns: Move MAX_PID_NS_LEVEL to ns_common.h, reuse it
Message-ID: <Yj3p6etC9Wr/gvr5@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220325112127.18026-1-pvorel@suse.cz>
 <20220325153714.eau4ja6pcr2a34sh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325153714.eau4ja6pcr2a34sh@wittgenstein>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> On Fri, Mar 25, 2022 at 12:21:27PM +0100, Petr Vorel wrote:
> > Move MAX_PID_NS_LEVEL to ns_common.h and reuse it in check in
> > user_namespace.c.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Christian, all,

> > I don't see putting MAX_PID_NS_LEVEL into ns_common.h as an elegant
> > solution but IMHO better than use a hardwired number or redefinition in
> > user_namespace.h.

> Hey Petr,

> Weird I either deleted that message by accident or didn't get it.

Interesting. BTW I didn't get any bounce suggesting mail to you didn't arrive.

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

> The only two namespaces where this applies to have the same hard-coded
> limit. If you want to get rid of the raw number you should just
> introduce a generic define that expresses the limit for both pidns
> and userns. Using "MAX_PID_NS_LEVEL" in the userns case is very
> confusing. So if you wanted to do this introducing something like
> #define MAX_NS_LEVEL 32
> and using it in both places makes more sense.

Thanks a lot, I overlooked they aren't related.

I wonder if there should be just one constant for both (i.e. MAX_NS_LEVEL) as
you suggest, 2 constants, i.e keep MAX_PID_NS_LEVEL and add MAX_USER_NS_LEVEL
(which happen to be both 32).

Also understand if you prefer just to keep the raw number (MAX_PID_NS_LEVEL has
more use than just a single place, but user namespaces need it just on single
place).

Kind regards,
Petr

> Christian
