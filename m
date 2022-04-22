Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05750BB88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449375AbiDVPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449369AbiDVPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B29E5DA1C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650640636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljPEk7R5J71TOPgAVvKcjJgou60F7BhP3VQzvXf9g5M=;
        b=Fm51J934HbsC2zV5OhetooUZNS0e8AsQ6LQyY2QTy+jTqt0APQZJAA2fYThDGNuqTWeJVo
        n+CK3/S7uJexu5LwqQANbflP88o6gFPfN9ddGIEW+eyvmI9iRnJMq6g6u2AQSgGgAftxwY
        zVh+eaixPGF8lYqzoaJ0pvssb6u7G1o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-oBvGebEzOTiR45sw89DSlg-1; Fri, 22 Apr 2022 11:17:14 -0400
X-MC-Unique: oBvGebEzOTiR45sw89DSlg-1
Received: by mail-qv1-f69.google.com with SMTP id u7-20020a0cb407000000b00446687f0b1bso6852471qve.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljPEk7R5J71TOPgAVvKcjJgou60F7BhP3VQzvXf9g5M=;
        b=fx9MH0Cn+YREBzMIwTNPgLOC+g/8XpPUjpMgsla7iLcuMTUJJXNzKaImlKr+u7r9Z2
         iQxpIkTDBErYiqR353Kr/PISZ/eSFAtKichwRBqnK4vIE1zvg4XVu/XsNI3s+b65AIqc
         udJf2520Ehrypw8d/pkXuqr+hOP45OAdAY6bhGHPduRuEzN/Lt/JX3gGEkeoyH/GjY3s
         5ndhUY4CAKgeNPo95sB9I/gWqG7N/WMm3zv/RHHN83/JWmdfQfqJM2mJFj2TVfXJfOsA
         JsgLxPDTYr691q6u0qOdro50YdLz+bV2F/Ym2zgEuMz513I8cIKoGcIvavc1yV6SSp14
         ACAw==
X-Gm-Message-State: AOAM533s6LrXGo5oRPdByGJKXj376FrDCS+gKjdls7vF2v4d4S7lcP2H
        7azQG1fNRyAO5tdqZUIiooL4Z3548uc4Vqy7dDvHuLcRJJKDXa2hwjvjLWe6kroDqhxHNROcetB
        WqmPIkDhjtbJstTC7p0nyaZVu
X-Received: by 2002:a05:6214:2389:b0:435:ba04:8f18 with SMTP id fw9-20020a056214238900b00435ba048f18mr4107310qvb.4.1650640634101;
        Fri, 22 Apr 2022 08:17:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjMrEgs4qWwrfRJ+/YrbFr8Z4BJtENFj05qIosgsYOz+0gq0PHGNWoZHjHiTvQUr8E5s3g/w==
X-Received: by 2002:a05:6214:2389:b0:435:ba04:8f18 with SMTP id fw9-20020a056214238900b00435ba048f18mr4107289qvb.4.1650640633896;
        Fri, 22 Apr 2022 08:17:13 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id k189-20020a3788c6000000b0069c10860b10sm1020921qkd.107.2022.04.22.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:17:13 -0700 (PDT)
Date:   Fri, 22 Apr 2022 08:17:10 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/25] objtool: Rework ibt and extricate from stack
 validation
Message-ID: <20220422151710.kxf2iywniedb4trk@treble>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2204201755580.1205@pobox.suse.cz>
 <20220422105037.GV2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422105037.GV2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:50:37PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 20, 2022 at 07:25:16PM +0200, Miroslav Benes wrote:
> > A nit and it was there even before this patch...
> > 
> > > -static struct instruction *
> > > -validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> > > -{
> > > -	struct instruction *dest;
> > > -	struct section *sec;
> > > -	unsigned long off;
> > > -
> > > -	sec = reloc->sym->sec;
> > > -	off = reloc->sym->offset;
> > > -
> > > -	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
> > > -	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
> > > -		off += arch_dest_reloc_offset(reloc->addend);
> > 
> > here...
> > 
> > > +static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
> > > +{
> > 
> > ...
> > > +		off = reloc->sym->offset;
> > > +		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> > > +			off += arch_dest_reloc_offset(reloc->addend);
> > > +		else
> > > +			off += reloc->addend;
> > 
> > it looks kind of strange to have arch_dest_reloc_offset() and still 
> > reference arch-specific relocation types here. On the other hand it seems 
> > difficult to achieve complete arch-agnostic code, so take it just as a 
> > note and maybe someone porting objtool to a different architecture will 
> > split the code, make it all arch-independent and all will be nice and 
> > shiny.
> 
> Something like so perhaps? Seems to build and boot x86_64-defconfig.

Looks good...

-- 
Josh

