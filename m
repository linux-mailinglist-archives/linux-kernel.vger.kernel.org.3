Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB795017FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355782AbiDNP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354665AbiDNPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20CC7DFDED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649949714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xrO22xcEliQqdlgNP22dh9mENDXbmI2r51Wf1LJDew=;
        b=UJxDmPaTkc3OgZ8UtllnzpiXqdoCNrXUmQ2Pd1hDb9xcGAPSD0ZeOLCE6Nk6fLxwRdVSZ0
        A4ka1HguV+5X5h4+R1+lI6TVi9GeZwWoykkKTDhDggjNqYpj1QOwJuozYBzXD325CE17OR
        /ht3FSFwIGrzjrl/B2MB3rLUVeXCcqg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-Vd3usRC8N7KogbdN2xiTfw-1; Thu, 14 Apr 2022 11:21:52 -0400
X-MC-Unique: Vd3usRC8N7KogbdN2xiTfw-1
Received: by mail-qk1-f197.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso3479810qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0xrO22xcEliQqdlgNP22dh9mENDXbmI2r51Wf1LJDew=;
        b=v93JUX6zdH/ZKyucoBEV9uXJrkinwVjISSkIoTpefuV1j7CKY2wg/2EBd9+EhnbuT0
         sKnzGsp9kzp3/wPT7UZpuFRSrAWHeG60rrLXyaiQtTiBp1Z9M7NKXv6sssCxO5Q68fa5
         9xHiTjIVfs0dg0gSeAQ5qbMeRUNKDLFW+SgSrBlGgudvIMJcFsKe8Oda+W5mttqm6tC2
         KjXNqoX8fAJZN/HHpDx9RdRJrdaRCJkPMOZImY7mWUHkXNL5HjIyjOQP9NohcRekZhpw
         T4WnYQW3FllWDXE462cHGV2LS4M7soQhdSgoRdI8x4ID2r/810kUivikvkZsTVpKFUW+
         n4Rw==
X-Gm-Message-State: AOAM532qF1ABULqUKJVxcr0ByTrLovVncQRpgTMsUmesPHvQU3XONQda
        2f82oiDkdw+8tscAFy1f6fbqzvMencZDTRXMCZzhu2cdnXNi0puEtF13jDXuAy44rQkXtjHCvWs
        lp3OwWJani5GGbwnnOpmVvKzh
X-Received: by 2002:ae9:f016:0:b0:69c:37ea:9b38 with SMTP id l22-20020ae9f016000000b0069c37ea9b38mr2217864qkg.335.1649949712350;
        Thu, 14 Apr 2022 08:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweSzbcy/dIffGHQ9QM27ZZD4L1/93JLoRe8P0dQu/q22EbhXISKZbPh8s20Tys7Q2guqR4eA==
X-Received: by 2002:ae9:f016:0:b0:69c:37ea:9b38 with SMTP id l22-20020ae9f016000000b0069c37ea9b38mr2217849qkg.335.1649949712127;
        Thu, 14 Apr 2022 08:21:52 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b002e1cd88645dsm1363000qtw.74.2022.04.14.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:21:51 -0700 (PDT)
Date:   Thu, 14 Apr 2022 08:21:48 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 02/18] objtool: Support data symbol printing
Message-ID: <20220414152148.cwdefx744kymqcut@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
 <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:05:47AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 13, 2022 at 04:19:37PM -0700, Josh Poimboeuf wrote:
> 
> > @@ -34,8 +37,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
> >  
> >  	str = malloc(strlen(name) + 20);
> >  
> > -	if (func)
> > -		sprintf(str, "%s()+0x%lx", name, name_off);
> > +	if (sym)
> > +		sprintf(str, "%s%s+0x%lx", name, is_text ? "()" : "", name_off);
> >  	else
> >  		sprintf(str, "%s+0x%lx", name, name_off);
> 
> So I like the patch, except that "()" thing is something where we differ
> from the kernel's %ps format and I've cursed it a number of times
> because I then have to manually edit (iow remove) things when pasting it
> in various scripts etc..

Oh, hm, that's true.  I can remove them if you prefer.

> That said, it totally makes sense to differentiate between a text and
> data symbol this way :/

Yes, but if we're keeping the "Add sec+offset to warnings" patch then
that distinction is already (kind of) being made by showing the data
section name.  And the data symbol warnings should be rare.

-- 
Josh

