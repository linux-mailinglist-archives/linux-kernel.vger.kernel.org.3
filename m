Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF350205F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348628AbiDOCV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiDOCV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB61B0A6C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649989139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZ3R/LPgwuNF2ES1WoiEgSoPV3wZKDu+wRahlf5rASE=;
        b=hLtaCD/o2Sz/tEQvTQgtctR3NwM0f9lzCgdRR5GGxHUSXoznXQWXy2F5W1e5K0H83ODAs7
        6D2XEl/WsSMo3HnrNnmibG94ddh33b5gB1486/05xp9w+dBCivkZjbsqBKnpLX2/43wEny
        +ledwE7MNhh04Cwe+AgDe2po6EDSTmM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-wYva__1VOdOdEarm5rJ-CQ-1; Thu, 14 Apr 2022 22:18:58 -0400
X-MC-Unique: wYva__1VOdOdEarm5rJ-CQ-1
Received: by mail-qt1-f200.google.com with SMTP id o17-20020ac872d1000000b002edcca4ce06so4461738qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UZ3R/LPgwuNF2ES1WoiEgSoPV3wZKDu+wRahlf5rASE=;
        b=kgBg4js+LXncjzdZxM6RgO34yK8OrD3stPYzUs6PvXwTleJi2GDBKI66WSpU9dghCZ
         FT2ANyaHTvZ5iFrsN9GW37PSTZHUe/N551ZQbP3BmpzkH05bydJgKXkC6paXOe53EEM4
         RM7GX8mqzm0rKH65OUhXHOpKcidm5T4gDjwPSVgI+XTMMbUK249BUWCTlV8C1xGoyx/M
         2uPB/BE82FfuNOhzykpaxf3vo+XmcfZJZC0yni8EKuVPzEgVaPA1nZrzK+n1zKxxcXdE
         eLOdWyhRVVR5GvWfXuLjj3pfCm4bpbD/gnnxcAswOt1OQAj9f+vt3qC+ghsQzcMcF9cP
         PF3A==
X-Gm-Message-State: AOAM5310TOixIt+e+jHSCd2t6x1I95uDy8vQxPbWT5O7JgJ8ao1y5nrV
        dpq8st8Lg1SrUBuYw5IYAJBBk60XQesLkU9MXZAinXR2Z2gLWxjrOWjpspIpevK0dw1EUS/UvZ9
        7V1wFzEkHpeFsPcUwCD3HIso2
X-Received: by 2002:a05:622a:1055:b0:2e1:fe6b:3781 with SMTP id f21-20020a05622a105500b002e1fe6b3781mr4026544qte.441.1649989137599;
        Thu, 14 Apr 2022 19:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrUaBCQoVG/jq122688UnhsiG9jjWGL3qxYkbXZGZ0vwWMP8jj+0NBXd0C/JX8w/VdkFUIKA==
X-Received: by 2002:a05:622a:1055:b0:2e1:fe6b:3781 with SMTP id f21-20020a05622a105500b002e1fe6b3781mr4026536qte.441.1649989137372;
        Thu, 14 Apr 2022 19:18:57 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a09cf00b0069c80404de6sm1169334qky.31.2022.04.14.19.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:18:56 -0700 (PDT)
Date:   Thu, 14 Apr 2022 19:18:53 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 17/18] objtool: Remove --lto and --vmlinux
Message-ID: <20220415021853.vnavjq6u6ibgva2l@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <b64b57896eaedf69f53d54c7d9ea373834aef069.1649891421.git.jpoimboe@redhat.com>
 <YlfXvlvNmCYFIq0w@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlfXvlvNmCYFIq0w@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:13:50AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 13, 2022 at 04:19:52PM -0700, Josh Poimboeuf wrote:
> 
> > @@ -131,6 +131,12 @@ static inline u32 reloc_hash(struct reloc *reloc)
> >  	return sec_offset_hash(reloc->sec, reloc->offset);
> >  }
> >  
> > +/* is it a whole archive (vmlinux.o or module)? */
> > +static inline bool is_linked_object(struct elf *elf)
> > +{
> > +	return elf->num_files > 1;
> > +}
> > +
> >  struct elf *elf_open_read(const char *name, int flags);
> >  struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
> 
> Ooh, nice... yes, that was the entire point of --lto.

Urgh, some kernel modules only have a single source file, which
obviously breaks this.

We might need an explicit --link option after all.  But with different
semantics from --lto.  It would just mean "is a linked object".

-- 
Josh

