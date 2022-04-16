Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1F503742
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiDPPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiDPPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7AFF2BD7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650121419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZvPiHkSsybJKbaICRFimMUslIagGag6L8MG9t53Sk5c=;
        b=B7MFi3I1u0L+F+GHzyK6gEdp3RuC6cU9LcktZRcs3vfUmND9PFD8OSHbB3jhviylXeeYL8
        RobXuCruU9qEfrRD64c92kWpwUxYtb+3cxnuTz40iWj0tIDpEQnGp7HDkOmpreeZwlado+
        BuHoD4Chj0Z8jUyY+zGNkZ8nKHIYUMc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-mgMR-a0oNI6QjHK3UQtzeA-1; Sat, 16 Apr 2022 11:03:38 -0400
X-MC-Unique: mgMR-a0oNI6QjHK3UQtzeA-1
Received: by mail-qk1-f200.google.com with SMTP id bp31-20020a05620a459f00b00699fabcc554so7326890qkb.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZvPiHkSsybJKbaICRFimMUslIagGag6L8MG9t53Sk5c=;
        b=ddmVSU82rmdKwpardmPVNpaa8KdGPHha/1zpJ5ooRBZvBIayFZQO3IoSPbbvOlq3DX
         1HoLIIQHAbFrPRDIspTYo1OXsKKYM+/1fbfq+K7ROd6nq475G9zLOqzPx+q2zsdAqdZF
         BlOoBQ56V2I+WOZZPcxscOI7b0CdlDZijc7r1N8l+vyYndYeWQmPcKSD6U4aBt89Xc0g
         P2BS/475z/xXCru/zTz+EdRUOJOrR9fD6Z1mSo/p2SP08MAeXU5B53pWzFCuDB/FhDGi
         iUnG8Wfr6ZA5dyR1GRjDtRvjzGZKGgxbsPkE/a5PhsH2+RSAgQEMcxTNsozDKUbH1ifW
         e5mQ==
X-Gm-Message-State: AOAM531gpmapLbvmeNNbgGXmMHsvzF7h57CYbjTGJ+ql2icEOPJHHlUj
        bf6aD1U+IhAeqlcePerW/NUWaXiJjHkOd9Bm5gB1djpZey6NFLduimdG+0s+wtOkCMfJJlTEu0l
        BxQI7xY/Up9zUkefZ0sOEFQJQ
X-Received: by 2002:a37:96c7:0:b0:69e:6e80:c6e0 with SMTP id y190-20020a3796c7000000b0069e6e80c6e0mr2071109qkd.231.1650121417624;
        Sat, 16 Apr 2022 08:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ7ud81zt0HcXyrzMQSRd3pdTbe4rmk0vT7vW7uSmkoSngybtu2CHbkKFUx/9v5XnmVKQ6KQ==
X-Received: by 2002:a37:96c7:0:b0:69e:6e80:c6e0 with SMTP id y190-20020a3796c7000000b0069e6e80c6e0mr2071070qkd.231.1650121417042;
        Sat, 16 Apr 2022 08:03:37 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm4826920qtx.58.2022.04.16.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 08:03:36 -0700 (PDT)
Date:   Sat, 16 Apr 2022 08:03:33 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Add x86 unwinders entry
Message-ID: <20220416150333.57xbzdbxe74v5hku@treble>
References: <7b9eb43c029d20676d9173ec5b2c675b43e2a99c.1650068519.git.jpoimboe@redhat.com>
 <5ee2984b7c0130df1ddbe8b8fc72b66331b214b0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ee2984b7c0130df1ddbe8b8fc72b66331b214b0.camel@perches.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 06:46:33PM -0700, Joe Perches wrote:
> On Fri, 2022-04-15 at 17:22 -0700, Josh Poimboeuf wrote:
> > Create a new section for x86 unwinder maintenance.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -21434,6 +21434,15 @@ F:	arch/x86/include/asm/uv/
> >  F:	arch/x86/kernel/apic/x2apic_uv_x.c
> >  F:	arch/x86/platform/uv/
> >  
> > +X86 UNWINDERS
> > +M:	Josh Poimboeuf <jpoimboe@redhat.com>
> > +M:	Peter Zijlstra <peterz@infradead.org>
> > +S:	Supported
> > +F:	arch/x86/include/asm/unwind*.h
> > +F:	arch/x86/kernel/dumpstack.c
> > +F:	arch/x86/kernel/stacktrace.c
> > +F:	arch/x86/kernel/unwind_*,c
> 
> Should be a period not a comma.
> 
> F:	arch/x86/kernel/unwind_*.c

Argh, sorry.

-- 
Josh

