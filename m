Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976B50184B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbiDNQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353488AbiDNP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39938B1A97
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649951099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMP8U6acyvSo2AqnmSO46KNXbyqLZPh6bqWCcn4O7oU=;
        b=XU42JXJ8t+wyiT0tC004u3r3fUuG9hcggjwlMCeTV4Vt3TD7yChgsYde969MJIsKYmmnLu
        S6lHrBIMKPM0rutvy1QPhNUK35UELHHmFvkK/h0kYitH4+K1SdTKotlpQRcT3DFWwI9jxB
        aK1nrEHcTvuOGElrBe8xVnqDjPRP/10=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-wBoLS_3PMKq8B-834IHxxQ-1; Thu, 14 Apr 2022 11:44:58 -0400
X-MC-Unique: wBoLS_3PMKq8B-834IHxxQ-1
Received: by mail-qv1-f70.google.com with SMTP id a3-20020a056214062300b00443cd6175c8so4699829qvx.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vMP8U6acyvSo2AqnmSO46KNXbyqLZPh6bqWCcn4O7oU=;
        b=mDUw3QG2pixE9cwPd0eafYgn3a0BEMRLqJGgt6tnyxaLxH8BZIBDngHqssN9+gQviu
         lOnhmh1jQ5zpIPg+D4SG/qBfvUGRcFdg4zM6x4Dw571847Z7e0prnqJItzKAaOGYS7Dz
         nuNhtkmIpfpsuJm0FtHB/nB8JMshfoAV+fuaWKWr88MGxA42IZBxPTAxFj4GzHYp0BUr
         lVy7Av4XEipPG2e51chx1yMIaJ3fMNeQ+x8Y/nKUUjWVy/SDsu/9QhCJ4ixW5biHMo3R
         BXlmnFNqt5mCYsjQxwThp9rCmmoB4L9vfYw4xcDchE8LzsVDEttZpTplrpPOQIhgJSqU
         rSXQ==
X-Gm-Message-State: AOAM533pLosnsoeTTNPn1/xGcr5WAAA38U1Eb5C9BXSZGFgaT6XjPNng
        aiY/7RrOdJhl1bl++uZodUqTb0dMfJFK6svK56sAc8DrEPxCfcK6300cWtbY2/MrF0jWQH46rEs
        Tejeu0/YhcKg9i0GPR5pRYnbW
X-Received: by 2002:a05:6214:411e:b0:443:d734:df45 with SMTP id kc30-20020a056214411e00b00443d734df45mr3910219qvb.46.1649951097781;
        Thu, 14 Apr 2022 08:44:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPSl5UqbvmN3OXkngc7R14B74QLECDPhbZ8cySPu52TnrkaPQ73bXHMsvsyjiUI2Vd/nm8MQ==
X-Received: by 2002:a05:6214:411e:b0:443:d734:df45 with SMTP id kc30-20020a056214411e00b00443d734df45mr3910199qvb.46.1649951097508;
        Thu, 14 Apr 2022 08:44:57 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm1360462qtw.67.2022.04.14.08.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:44:56 -0700 (PDT)
Date:   Thu, 14 Apr 2022 08:44:49 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <20220414154449.5moa7xsczwybbqhd@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
 <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:53:18AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 13, 2022 at 04:19:45PM -0700, Josh Poimboeuf wrote:
> > Extricate ibt from validate_branch() in preparation for making stack
> > validation optional.
> 
> It does a bit more..

Indeed.

> > -		/* already done in validate_branch() */
> > -		if (sec->sh.sh_flags & SHF_EXECINSTR)
> > -			continue;
> >  
> > -		if (!sec->reloc)
> >  			continue;
> >  
> > -		if (!strncmp(sec->name, ".orc", 4))
> > -			continue;
> >  
> > -		if (!strncmp(sec->name, ".discard", 8))
> >  			continue;
> >  
> > -		if (!strncmp(sec->name, ".debug", 6))
> >  			continue;
> >  
> > -		if (!strcmp(sec->name, "_error_injection_whitelist"))
> >  			continue;
> >  
> > -		if (!strcmp(sec->name, "_kprobe_blacklist"))
> >  			continue;
> >  
> > -		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
> >  
> > -		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
> > -			struct instruction *dest;
> >  
> > -			dest = validate_ibt_reloc(file, reloc);
> > -			if (is_data && dest && !dest->noendbr)
> > -				warn_noendbr("data ", sec, reloc->offset, dest);
> > -		}
> 
> So this iterates all sections and excludes a bunch, and only reports
> fail for .data/.rodata.

Oops.

> > +static int validate_ibt(struct objtool_file *file)
> > +{
> > +	struct section *sec;
> > +	struct reloc *reloc;
> > +	struct instruction *insn;
> > +	int warnings = 0;
> > +
> > +	for_each_insn(file, insn)
> > +		warnings += validate_ibt_insn(file, insn);
> 
> So I specifically didn't do this because I wanted to reduce the amount
> of loops we do over those instructions. But yeah, if you really want to
> allow --ibt without --stack-validate (but why?) then I suppose so.
> 
> Esp. for the vmlinux.o case, iterating all insn can quickly add up to
> significant time.

I didn't look at the performance, but if it's a problem then we can
eventually look at combining several of the for_each_insn() features
into a single loop: retpolines, ibt, reachability check, maybe even some
of decode_sections().

> 
> > +	for_each_sec(file, sec) {
> > +
> > +		if (!strstr(sec->name, ".data") && !strstr(sec->name, ".rodata"))
> > +			continue;
> 
> But this only iterates .data/.rodata.
> 
> That's not the same, specifically, it'll not iterate stuff like ksymtab
> that contains the EXPORT_SYMBOL* crud. The result being that we can now
> seal EXPORT'ed symbols, which will make modules really sad.
> 
> There's also the .initcall sections, sealing initcalls typcally ends really
> badly.
> 
> And there might be a few others I forgot about.

Ok.  That was subtle, it needs a comment or two.  I had the distinct
feeling I was introducing a bug, then I got distracted ;-)

Doesn't the compiler give those special cases ENDBR anyway?  Just
wondering why we avoid the warning for those.

-- 
Josh

