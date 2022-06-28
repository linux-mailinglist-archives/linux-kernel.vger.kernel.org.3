Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222FD55F174
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiF1WeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiF1Wd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC8763A198
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656455635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bYK15YVdxP+HlFRILW4dcrjcjvcQxAk2DAaS0YwPQaE=;
        b=VnSlT20+luMi0uWAHiH3iqWjmbeUjxVjmeN4BCcfGssokRJpNrqZS2zyUFjogSO2XwBCfk
        4RzpGExLoVH2/mpphLOSMj2KUbg+Faa860jXIlJFTtqyd3A06815ZXmLZqWEsVQWzTKo9w
        xzQKXTTPEh/HrrDOoG4XwmsQOSnGzlg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-pr8qGLtCOtmdxTWIXW8Idw-1; Tue, 28 Jun 2022 18:33:54 -0400
X-MC-Unique: pr8qGLtCOtmdxTWIXW8Idw-1
Received: by mail-il1-f200.google.com with SMTP id j17-20020a056e02219100b002d955e89a54so8145966ila.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYK15YVdxP+HlFRILW4dcrjcjvcQxAk2DAaS0YwPQaE=;
        b=YIyMTeCFzCjQoBlcYiuz0LfTYrfuDBG0agCo4Vrce4GPN1kJv48l6qYUw9eHw6IqZp
         yOOdPAUiPwmnJVk8juG7SvfsCntjbOGZT6+s6ELFoBZxnDz2YkC9TQML5volyf38OXpb
         5C7U6bKDCTTabkdOF6LR59Gs+/4X+Nf/uTyqGETg9QwsM+JI8RU5M6Z0gLIh7vusizXx
         bQltU3oyZx4DLL/Q3/UaiEHRqM9D4PWcTHbrzEwmpWtG4RwmQ0iyyvpB/vBrvQmOZmtO
         LTj1VIm1MiHAlnk+7nrUxidceK3pAHbQVDmiP41UvTWimXCxPRspzWr80RTtWQoUgHNa
         aFpA==
X-Gm-Message-State: AJIora9ldodIMftzMcKFP+u46oz3qk6GrmWgq/v9NcCkhc6H0K3e86MP
        4fiJYc1CePGBpgubIMTf0E5E74JsVc22fN1xamgc/XC6YrCD6en/5VzNYiujXT4PXE+4UrdxXZD
        +pwpZAkz9OKcH8aU/uAazg49q
X-Received: by 2002:a02:a597:0:b0:339:e1ef:7de with SMTP id b23-20020a02a597000000b00339e1ef07demr215936jam.291.1656455633592;
        Tue, 28 Jun 2022 15:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tET+xoMBUzSfJNWaC0HczRlJeNGe/NWsP2TTp3pBKcwrNn51HeSZf5ws2xFlV8EW/B6YVdDg==
X-Received: by 2002:a02:a597:0:b0:339:e1ef:7de with SMTP id b23-20020a02a597000000b00339e1ef07demr215919jam.291.1656455633362;
        Tue, 28 Jun 2022 15:33:53 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id f10-20020a056638112a00b00339c55c1c43sm6565378jar.133.2022.06.28.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:33:52 -0700 (PDT)
Date:   Tue, 28 Jun 2022 18:33:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 1/4] mm/gup: Add FOLL_INTERRUPTIBLE
Message-ID: <YruBzuJf9s/Nmr6W@xz-m1.local>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-2-peterx@redhat.com>
 <c196a140-6ee4-850c-004a-9c9d1ff1faa6@nvidia.com>
 <YrtXGf20oa5eYgIU@xz-m1.local>
 <16c181d3-09ef-ace4-c910-0a13fc245e48@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16c181d3-09ef-ace4-c910-0a13fc245e48@nvidia.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:40:53PM -0700, John Hubbard wrote:
> On 6/28/22 12:31, Peter Xu wrote:
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index 551264407624..ad74b137d363 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -933,8 +933,17 @@ static int faultin_page(struct vm_area_struct *vma,
> > > >    		fault_flags |= FAULT_FLAG_WRITE;
> > > >    	if (*flags & FOLL_REMOTE)
> > > >    		fault_flags |= FAULT_FLAG_REMOTE;
> > > > -	if (locked)
> > > > +	if (locked) {
> > > >    		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> > > > +		/*
> > > > +		 * We should only grant FAULT_FLAG_INTERRUPTIBLE when we're
> > > > +		 * (at least) killable.  It also mostly means we're not
> > > > +		 * with NOWAIT.  Otherwise ignore FOLL_INTERRUPTIBLE since
> > > > +		 * it won't make a lot of sense to be used alone.
> > > > +		 */
> > > 
> > > This comment seems a little confusing due to its location. We've just
> > > checked "locked", but the comment is talking about other constraints.
> > > 
> > > Not sure what to suggest. Maybe move it somewhere else?
> > 
> > I put it here to be after FAULT_FLAG_KILLABLE we just set.
> > 
> > Only if we have "locked" will we set FAULT_FLAG_KILLABLE.  That's also the
> > key we grant "killable" attribute to this GUP.  So I thought it'll be good
> > to put here because I want to have FOLL_INTERRUPTIBLE dependent on "locked"
> > being set.
> > 
> 
> The key point is the connection between "locked" and killable. If the comment
> explained why "locked" means "killable", that would help clear this up. The
> NOWAIT sentence is also confusing to me, and adding "mostly NOWAIT" does not
> clear it up either... :)

Sorry to have a comment that makes it feels confusing.  I tried to
explicitly put the comment to be after setting FAULT_FLAG_KILLABLE but
obviously I didn't do my job well..

Maybe that NOWAIT thing adds more complexity but not even necessary.

Would below one more acceptable?

		/*
		 * We'll only be able to respond to signals when "locked !=
		 * NULL".  When with it, we'll always respond to SIGKILL
		 * (as implied by FAULT_FLAG_KILLABLE above), and we'll
		 * respond to non-fatal signals only if the GUP user has
		 * specified FOLL_INTERRUPTIBLE.
		 */

Thanks,

-- 
Peter Xu

