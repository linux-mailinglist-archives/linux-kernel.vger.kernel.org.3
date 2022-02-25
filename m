Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B434C4C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiBYR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiBYR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD91322D650
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645810010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7iDgyH7zvbk5G21Fe1v72evbUxvbyJHGswITdvg6rw=;
        b=Twszzt/zLHLTUUTjLYxfMd14wQvnJ2KabeU9Q1YDmZezWXCWWb5aO8VZ1LhO8LoaQRte56
        R4A+SiIQ/TJ8Z2abu98CPRKAKLNiW+J1GGbC9saxlbe5bxJ89n/mJoiWp0OJPdxZuFNNkT
        MuyUQA+Yq0cQgSIHbJWo+5hbEghpNUE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-JLOUwVO5PD6PPd01ucTbow-1; Fri, 25 Feb 2022 12:26:49 -0500
X-MC-Unique: JLOUwVO5PD6PPd01ucTbow-1
Received: by mail-ot1-f70.google.com with SMTP id 38-20020a9d0829000000b005afe328b01dso108095oty.16
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7iDgyH7zvbk5G21Fe1v72evbUxvbyJHGswITdvg6rw=;
        b=3m19b/u6vquycfONQyfmWLKwknGsMCC9yucsWqvp+0ihrNZmUZT35f9kJqeWG08kx2
         84suMEKupGNs5MGZJxmJB6Obxh2Zm/mWhQLwIhNNpZDwdhId7XmXW8H8RljaBpceq8dj
         TkFU/jLaqXZqAIUcdR/egLig5UEBlu59VX9oIuBfIh3fJlz2FSdDYWVc0quGYiE1cp0/
         0gdc47OYW9X6oOZTlD0S+keJdrzeFCiPALKzk3SBNcbxFnHoQ+m0+7bd64u9AVF7S9Qg
         7I+UTTy7Pbg8EJsZDqL+pEEd5ZXnlT/pa5lblZgRtQYVNwSfOvhi4tMtQ59vCTZAcCue
         rtRQ==
X-Gm-Message-State: AOAM532pCU4XDvd179Jzo0o3cB0EGf9eGua8dAmeYZqC3MEanT7UiCTG
        n/9V78FtJamsZyPjgtBdukIct7pTJp0kYIEPi3/vhhcWzZPerEbdvZOyQOidcgO2PQGY1l9++uz
        fhRIX/mwkEJ5QiuYEj0uGFkHK
X-Received: by 2002:a05:6808:21a3:b0:2d4:68b6:e727 with SMTP id be35-20020a05680821a300b002d468b6e727mr2382849oib.112.1645810008790;
        Fri, 25 Feb 2022 09:26:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxavgml8Ci3ATN5EgsD6z0NaQKeXXqvJw/Uydc6WYA4CBnf5U+eUXJQBnLMIsfOD/Cx8Gucsw==
X-Received: by 2002:a05:6808:21a3:b0:2d4:68b6:e727 with SMTP id be35-20020a05680821a300b002d468b6e727mr2382829oib.112.1645810008542;
        Fri, 25 Feb 2022 09:26:48 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id 62-20020a4a1d41000000b0031bf4df25a8sm1331424oog.8.2022.02.25.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:26:47 -0800 (PST)
Date:   Fri, 25 Feb 2022 09:26:44 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <20220225172644.76fyxjximjrcdbzt@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224202602.3gvz5tnxvwb4maod@treble>
 <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
 <Yhj5GKLfyxbNCGua@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yhj5GKLfyxbNCGua@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 04:43:20PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 25, 2022 at 04:28:32PM +0100, Peter Zijlstra wrote:
> > +void *skip_endbr(void *addr)
> > +{
> > +	unsigned long size, offset;
> > +
> > +	if (is_endbr(*(unsigned int *)addr) &&
> > +	    kallsyms_lookup_size_offset((unsigned long)addr, &size, &offset) &&
> > +	    !offset)
> > +		addr += 4;
> > +
> > +	return addr;
> > +}
> 
> Damn, I just realized this makes KERNEL_IBT hard depend on KALLSYMS :-(

Why should the jump label patching code even care whether there's an
ENDBR at the jump target?  It should never jump to the beginning of a
function anyway, right?  And objtool presumably doesn't patch out ENDBRs
in the middle of a function.

-- 
Josh

