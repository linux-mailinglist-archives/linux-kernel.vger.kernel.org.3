Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87714C783E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiB1SoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbiB1Sm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:42:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8C752A72C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646073560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSruaDQ91wZiQ3U2vHdYAu7XWiXrgGYVxBWMGax8neQ=;
        b=WoUrQA4vQOboOGY7klUXWwg9X2RS41zrDOQwJAmbThfVwLmPVX1jwKmRalzi5UvXJ5jpc7
        /qBbzOX3UQf50a5u/9Hn0OQTmVykWW6sa0x/6qMDeJLVWwN8Z4BSviG7DOcql4i6jUJzOu
        sMuSycj8i7frVVUXBUDSHHobPGkDNbc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-XmHspIYJPIycQMx7vkc36A-1; Mon, 28 Feb 2022 13:39:17 -0500
X-MC-Unique: XmHspIYJPIycQMx7vkc36A-1
Received: by mail-qv1-f70.google.com with SMTP id q14-20020a0cf5ce000000b004326eec23acso12942648qvm.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSruaDQ91wZiQ3U2vHdYAu7XWiXrgGYVxBWMGax8neQ=;
        b=68M7ix74r0P+8FjaPVA+op7MEnSEM4/uWhwmUa6ceqZKeuGXgT7WmSuY5MNYsjJqFb
         ER9PXwisWTZzeWEkeE6z1yNuXCwIBWqxGVku+hmvaf/bVVmYjZlmNjRcHuV+dDzyHoBf
         ntHmSe0ADfs1uo7cZYG9nfx0Akl+Ea2PFX3NKAIUg6vfvEqcyDjpbgeqxr2Fky574CtC
         8vgTnpyawC8dMyDBE6dNNzpHrA/g8I4dPpYoCyXxGM4jLfnvRVlhYbcnYKYlURBfYYVn
         03e4jCZ66Q91tgmM078SvhDP/6BOWbQrkWFqUTdWR+HD8fEugHSXIBUwe5tGgAXVOzbA
         Yaag==
X-Gm-Message-State: AOAM533hP+gJNG6+f9yYJBUN5L3lsZngyERN6WMw3OwZNi2f6h7SJF/l
        msWkFjy1rHoDI7rHxNiP8wqGlH+YSE/dbsn35s0ILpJjqLad9uXFL/GJGiloMUuyRvT00af4jkG
        l1zBBuQor+HE1nxPNjwRWwTWd
X-Received: by 2002:a05:620a:11a7:b0:60d:df4a:f732 with SMTP id c7-20020a05620a11a700b0060ddf4af732mr12000627qkk.244.1646073557283;
        Mon, 28 Feb 2022 10:39:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcL8pMH3E+RJrfw9BoEiPtQxOCruPFhp0i4BURaGugdQ+SIj2be00F+d9qP6Iss18tG2jXfg==
X-Received: by 2002:a05:620a:11a7:b0:60d:df4a:f732 with SMTP id c7-20020a05620a11a700b0060ddf4af732mr12000606qkk.244.1646073557025;
        Mon, 28 Feb 2022 10:39:17 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id w140-20020a376292000000b00648e88c1f05sm5501550qkb.67.2022.02.28.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:39:16 -0800 (PST)
Date:   Mon, 28 Feb 2022 10:39:13 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <20220228183913.tg5qbisiqkbzm25n@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
 <20220227031348.drbmkcmoqur53aay@treble>
 <20220227170003.GE11184@worktop.programming.kicks-ass.net>
 <YhyVL9SbeC2bd942@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhyVL9SbeC2bd942@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:26:07AM +0100, Peter Zijlstra wrote:
> On Sun, Feb 27, 2022 at 06:00:03PM +0100, Peter Zijlstra wrote:
> > On Sat, Feb 26, 2022 at 07:13:48PM -0800, Josh Poimboeuf wrote:
> > > > +static struct instruction *
> > > > +validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> > > > +{
> > > > +	struct instruction *dest;
> > > > +	struct section *sec;
> > > > +	unsigned long off;
> > > > +
> > > > +	sec = reloc->sym->sec;
> > > > +	off = reloc->sym->offset + reloc->addend;
> > > 
> > > This math assumes non-PC-relative.  If it's R_X86_64_PC32 or
> > > R_X86_64_PLT32 then it needs +4 added.
> > 
> > Right; so I actually had that PC32 thing in there for a while, but ran
> > into other trouble. I'll go try and figure it out.
> 
> Things like .rela.initcall*.init use PC32 but don't need the +4. If we
> get that wrong it'll seal all the initcall and boot doesn't get very
> far at all :-)

Ah...

> How do you feel about something like:
> 
> 	sec = reloc->sym->sec;
> 	off = reloc->sym->offset;
> 
> 	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
> 	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
> 		off += arch_dest_reloc_offset(reloc->addend);
> 	else
> 		off += reloc->addend;
> 
> 
> hmm ?

Looks good to me.

-- 
Josh

