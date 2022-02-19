Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40F4BC590
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 06:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiBSFWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 00:22:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiBSFWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 00:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D658D3DA57
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 21:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645248142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9r+Bhfs5dDddqduzGiZYaJG4staNq0SxYzZYyrkYbI=;
        b=MTNLUZk2K2LteSWUtU1WLlQZ5MsvjQ+9XWCBLFB/dacKbbw5PsdcTrW4RhqpUnOyDC01qj
        +mG0I19X3kJnCV9V3WibWgi3/nCe7FPlXDaelxvRFL0G2pqYJVZPfnKXQy5fPz9NuyTik2
        rE5iQQ98PsN0fX9QOxNl6XKOPXhtdTo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-qj0T0RAKPrKo9YQHNE6J4A-1; Sat, 19 Feb 2022 00:22:21 -0500
X-MC-Unique: qj0T0RAKPrKo9YQHNE6J4A-1
Received: by mail-qv1-f71.google.com with SMTP id e9-20020a0cf749000000b0042bf697ff6bso11060837qvo.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 21:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9r+Bhfs5dDddqduzGiZYaJG4staNq0SxYzZYyrkYbI=;
        b=d/eg+DQvaqB4sIP2lZdX/fmo/JSl4Q0KKLa68R5O/gNFojs9BCS8pfRiGZIVQGFjlG
         eOGsfMGvjRiLfrqyAefzBxgXtIX6Mz+BRKTtr10eCvUI06cILK5QVjpBBxkwQIHJFEkN
         MkmP7J7ukVvVozroB1AOcMgtqmSyCxHKc7YULv+USPDFCJGWpzR8olnjPDDmshdKClc+
         OIh/Q+kmBD0O1BI3e7uIOeaQqW6c51pfh+Bcs47V3x/hQBYETmXq3aJmSZqaPjUC4CBu
         4FdSEFQ6XX+FGT5iT0Kq8z/4mVd0kt5YNd7Z+ueFxCjZnt77rOSudHvpxhtGrk4S83xX
         FG+w==
X-Gm-Message-State: AOAM533yf6o6qyb2CMJaE0yx3Ereq+chZhjwdWNFGjFiMZbeuM6tVcqO
        67CYlEKsItIOw10lz7v6YuScty4DKt2nsfS5Vq9QcmVknBPKPgeHsg4qgBD69sj2uBl+kEWslMC
        kV1ThZ/5zyTJUb9rvH2GqJ1Ak
X-Received: by 2002:a05:622a:13c6:b0:2d6:75cf:cc23 with SMTP id p6-20020a05622a13c600b002d675cfcc23mr9595842qtk.473.1645248140805;
        Fri, 18 Feb 2022 21:22:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHO9z5PxXHTDIIDy7QdEheDxE0SOBADu6a7I5ZgJcPDSSKo8J1gtoH6AnueqXtBdR+w0nTjA==
X-Received: by 2002:a05:622a:13c6:b0:2d6:75cf:cc23 with SMTP id p6-20020a05622a13c600b002d675cfcc23mr9595837qtk.473.1645248140580;
        Fri, 18 Feb 2022 21:22:20 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e3sm3473029qto.25.2022.02.18.21.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 21:22:20 -0800 (PST)
Date:   Fri, 18 Feb 2022 21:22:16 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 17/29] x86/ibt: Annotate text references
Message-ID: <20220219052216.7b5fx6qileqrdjbw@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.579455015@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171409.579455015@infradead.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:19PM +0100, Peter Zijlstra wrote:
> Annotate away some of the generic code references. This is things
> where we take the address of a symbol for exception handling or return
> addresses (eg. context switch).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The vast majority of these annotations can go away if objtool only
requires ENDBR for referenced *STT_FUNC* symbols.

Anything still needing ANNOTATE_NOENDBR after that, might arguably not
belong as STT_FUNC anyway and it might make sense to convert it to
non-function code (e.g. SYM_CODE{START,END}.

> @@ -564,12 +565,16 @@ SYM_CODE_END(\asmsym)
>  	.align 16
>  	.globl __irqentry_text_start
>  __irqentry_text_start:
> +	ANNOTATE_NOENDBR // unwinders
> +	ud2;
>  
>  #include <asm/idtentry.h>
>  
>  	.align 16
>  	.globl __irqentry_text_end
>  __irqentry_text_end:
> +	ANNOTATE_NOENDBR
> +	ud2;

Why ud2?  If no ud2 then the annotation shouldn't be needed since the
first idt entry has ENDBR.

-- 
Josh

