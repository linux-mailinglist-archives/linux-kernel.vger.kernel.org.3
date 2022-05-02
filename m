Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A73517633
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbiEBSDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEBSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9DDCDE6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651514367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=52m/RMJe9vQWruEJqEyw+MPMfE0VFlYZPqLbzzwAEvg=;
        b=Eu2R+zsIpl14ZUFfEXpqyy9yd5k+ilfe6Ss9G9roymQ1WLGlcwjNxQZ45DR6AGUduL/b2j
        /E9Fm6QmP1hH2pf47GvkSXG4UFKHOS1PBmg+iQgEF8S5X9NCIn9liWRDOY5vEVSz15Dtcm
        TCg/ITTx1zJ3Ulga8jct9FrMLDb4OuA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-ocWIqvWZNZ2snWcMPjj7rg-1; Mon, 02 May 2022 13:59:26 -0400
X-MC-Unique: ocWIqvWZNZ2snWcMPjj7rg-1
Received: by mail-qk1-f198.google.com with SMTP id c84-20020a379a57000000b0069fcf83c373so3463942qke.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=52m/RMJe9vQWruEJqEyw+MPMfE0VFlYZPqLbzzwAEvg=;
        b=U9OWdp6S264AP1fFoqXuSt81Tk6uy6dugxvnJ9xiU0hGnj54I4nwLxQN1d5nnQJIJv
         P1nhGFWfpullmD3bXSl3ilgigKYN3oo8ytI98MvaKl3gT7aq9RsoUwDipZHEOwNNaZoM
         xIH1aXNdDbdrUASLHWeYm1V+mrICCJxZinpAMk6oub5p1cOuU+jPf6Hjv0g8at0CWIet
         lsEbTbXWeknkCyE0OC0fYrJcIP8DEjgI2/RB1pkIypLYnYOvk87G+K4yXVLeRVKOT7ib
         bOHsVL+ut2jUrRiuBfsOnDaZGU9knDzyMkA5hcoJ+YjTJoQRcHVBn3tLvTUZhsUTCVbQ
         qhtw==
X-Gm-Message-State: AOAM532axS0ocRvOlFJDnoetRcMWU+XIaruQ4dYqcNN/MZBXnr4oM5Gu
        8uXiLaac5jOQgGOFH8s+TbhvOlFpTI6JwF3vAX2p10BhHsobpNLGDAtcE2/pQf5AhtpherULXvo
        jYwwtNDmTMF9Vi90ow+ckqyJU
X-Received: by 2002:a05:6214:445:b0:456:4d9e:db71 with SMTP id cc5-20020a056214044500b004564d9edb71mr10428886qvb.93.1651514365466;
        Mon, 02 May 2022 10:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7rkjG3ZO067xLuanXZqyfDsInyWmL9p+DIIRyNJDZ72hWMgjJoOKZRjJwM12mgIEO+ieSOw==
X-Received: by 2002:a05:6214:445:b0:456:4d9e:db71 with SMTP id cc5-20020a056214044500b004564d9edb71mr10428870qvb.93.1651514365173;
        Mon, 02 May 2022 10:59:25 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id g19-20020ac842d3000000b002f1f934bedfsm4850258qtm.3.2022.05.02.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:59:24 -0700 (PDT)
Date:   Mon, 2 May 2022 10:59:21 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <20220502175921.oruktb6dleabvdyx@treble>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
 <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
 <20220429225636.6qm2orq4uwnl33ii@treble>
 <Ym0hAA66vijBo7iF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym0hAA66vijBo7iF@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 01:44:00PM +0200, Peter Zijlstra wrote:
> > > I also don't see any kprobe/optprobe hooks in unwind.h, so what happens
> > > if we hit an optprobe?
> > 
> > Same as for any other generated code, the unwinder will try to fall back
> > to frame pointers, and if that doesn't work, the unwind stops.
> > 
> > That commit didn't change anything since it was already not being
> > directly executed anyway, but rather used to generate code on the fly.
> > 
> > And before that commit it was being ignored by ORC anyway, thanks to
> > STACK_FRAME_NON_STANDARD.  Which can now be removed since this code is
> > now data and objtool will no longer try to understand it.
> 
> Right; but I suppose I'm wondering if we should fix this. It seems a
> rather sub-optimal state of affairs.

Masami recently fixed some kprobes ORC issues but I don't know if this
one was fixed.

As to the whether it's worth fixing, I dunno.  There are trade offs.

Depends on how common the stack trace is -- I'm guessing not very, since
I've never seen a bug report -- and how important it is to get to full
ORC coverage.  If our goal is full coverage, we'd need a way for
generated code to add/remove ORC entries.

-- 
Josh

