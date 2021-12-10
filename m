Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC404470083
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhLJMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:20:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36470 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhLJMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:20:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 52353210FE;
        Fri, 10 Dec 2021 12:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639138588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXViNCn7yJVykWYtlrySC1iUz2ohM572xw5pmZNK/Zo=;
        b=KHS6HoPtmwvNbVTJDyVxSLTyK4iJMi1Vz7OZuI+TTEjcq4lqTN1Rs/8qqLmCPlTLc500p6
        1+k1YxzkczfpZRO0XRyodUj8PJMOzE9g3EuGLSorulqF2ayryEFIxeo27CHCuYnQGX9Gsm
        oYv8KGE6yERhPgjaPgLrqYLY8EmOaG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639138588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXViNCn7yJVykWYtlrySC1iUz2ohM572xw5pmZNK/Zo=;
        b=jtw+kLQYq6BbhZc9IdkrJBiwzYicobAydkP6v/gFMUCSsk8fCrwNxD12DKT+2QI7jUjP6F
        QAB5tNbn6n8IpGDA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 27C00A3B85;
        Fri, 10 Dec 2021 12:16:28 +0000 (UTC)
Date:   Fri, 10 Dec 2021 13:16:28 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Heiko Carstens <hca@linux.ibm.com>
cc:     Jerome Marchand <jmarchan@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
In-Reply-To: <YbMyvJ6gz7LvoXgE@osiris>
Message-ID: <alpine.LSU.2.21.2112101310080.5704@pobox.suse.cz>
References: <20211210093827.1623286-1-jmarchan@redhat.com> <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz> <YbMyvJ6gz7LvoXgE@osiris>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021, Heiko Carstens wrote:

> On Fri, Dec 10, 2021 at 10:57:00AM +0100, Miroslav Benes wrote:
> > On Fri, 10 Dec 2021, Jerome Marchand wrote:
> > 
> > > On s390, recordmcount.pl is looking for "bcrl 0,<xxx>" instructions in
> > > the objdump -d outpout. However since binutils 2.37, objdump -d
> > > display "jgnop <xxx>" for the same instruction. Update the
> > > mcount_regex so that it accepts both.
> > > 
> > > Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> > 
> > Yes, we ran into exactly this issue too...
> > 
> > > ---
> > >  scripts/recordmcount.pl | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> > > index 7d631aaa0ae1..52a000b057a5 100755
> > > --- a/scripts/recordmcount.pl
> > > +++ b/scripts/recordmcount.pl
> > > @@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
> > >  
> > >  } elsif ($arch eq "s390" && $bits == 64) {
> > >      if ($cc =~ /-DCC_USING_HOTPATCH/) {
> > > -	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
> > > +	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
> > >  	$mcount_adjust = 0;
> > >      }
> > >      $alignment = 8;
> > 
> > ...and we have exactly the same fix in SLES. I haven't got to submit it 
> > to upstream yet :(, many thanks for doing it.
> > 
> > So at least
> > 
> > Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> 
> Just out of curiosity: am I right if I assume that both of you have
> kernel sources without upstream commit
> d983c89cc96a ("s390/ftrace: Add -mfentry and -mnop-mcount support")
> and the commits directly preceding that one?

Unfortunately, it was reported also on 5.3-based kernels which have the 
commits.
 
> Otherwise I would be surprised that this would make any difference.

How come? I mean, s390 does not define HAVE_C_RECORDMCOUNT which implies 
that recordmcount.pl is used (see scripts/Makefile.build and 
BUILD_C_RECORDMCOUNT definition in Makefile).

> Applied to s390 tree + added a stable tag.

Thanks.

Miroslav
