Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBF4C585D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiBZVss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiBZVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EACA9148908
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645912088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awJP+ekZi3kvsHwoRq6lQhUqaE+35ZAep6ya9KOZrMU=;
        b=hvxPpKsPHKuztQmQ22o7BPQZKKxxtdWd13gGEcchptue96MWSAqHTexquaC98uc1pC3QTb
        0NRgx+JlL2kyvrh1SIz6j6chtMPwRP/NC7hFKXRAqRFpHkaNgnLGhXkXe5rbk5WdpKdZaX
        WZIYw/iZDDvH7lKaE6lszfYUtkGnTH4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-1ufPMk5UOUWWAtfY9O_PeQ-1; Sat, 26 Feb 2022 16:48:07 -0500
X-MC-Unique: 1ufPMk5UOUWWAtfY9O_PeQ-1
Received: by mail-qk1-f197.google.com with SMTP id 199-20020a3703d0000000b005f17c5b0356so7995046qkd.16
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=awJP+ekZi3kvsHwoRq6lQhUqaE+35ZAep6ya9KOZrMU=;
        b=gaQEDA/yc2nzM5Ju/kdIK0i2fPKNI7Gp7zWwPNt/VnT70lT/ZXMrcUtZpBLOCi4Sfu
         OCUtarNLU+mNHnZT1Ht/YkwAmK5WsO/PHGjr50tDf4fsdCB3xn1VEAX1cV4/IMkSnAwo
         16qCJWtMA+/Aff0/fQvaTroZ8GknSnlrDJKUIRymZGrnrd3KMzbjFNSbWJedHGShSYYP
         QRnqLtZopspRIcTc7brpy8IRnqGSY4wBiFPzOqqJGZU0DUFaywN5/ktV7ZFqi59TMWtz
         y1zcX/BaMHWJAg5Ku1+EOY1GWCRBBfVDdmKG6ua27kBdlfkId7v+nGi5V1wTJJ+s5VdY
         CXLw==
X-Gm-Message-State: AOAM532bl42GwoZvHrj//EhGUBsOpa7gYEecKttUD5VOi07XXT1x6agW
        U8g9uhhYck3xAXq+ltMl7a7cXaBCe18vAaetjWIN2DqB589Epst2oh/2stAe3AAyjWEwKG5wj8J
        EUnh8HlPABetxYanzCRwoyr6D
X-Received: by 2002:ac8:57d4:0:b0:2de:6f5c:4214 with SMTP id w20-20020ac857d4000000b002de6f5c4214mr11627313qta.200.1645912086824;
        Sat, 26 Feb 2022 13:48:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEbFVZpVlKrJPXwTcDFZBg1/jpbgVJA8qfROWJtusqnrMxmidfBpj7NIzoHLf7ToC3PUmMnw==
X-Received: by 2002:ac8:57d4:0:b0:2de:6f5c:4214 with SMTP id w20-20020ac857d4000000b002de6f5c4214mr11627295qta.200.1645912086576;
        Sat, 26 Feb 2022 13:48:06 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id y16-20020a05622a121000b002deaa0af9e2sm3969903qtx.49.2022.02.26.13.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 13:48:06 -0800 (PST)
Date:   Sat, 26 Feb 2022 13:48:02 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 21/29] objtool: Rename --duplicate to --lto
Message-ID: <20220226214802.4chmsrtstlerefmu@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.814392411@infradead.org>
 <20220226194209.bvv3t65hhtnwltmk@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220226194209.bvv3t65hhtnwltmk@treble>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 11:42:13AM -0800, Josh Poimboeuf wrote:
> > +	OPT_BOOLEAN(0, "lto", &lto, "whole-archive like runs"),
> 
> "--lto" is a confusing name, since this "feature" isn't specific to LTO.
> 
> Also, it gives no indication of what it actually does.
> 
> What it does is, run objtool on vmlinux or module just like it's a
> normal object, and *don't* do noinstr validation.  Right?
> 
> It's weird for the noinstr-only-mode to be the default.
> 
> BTW "--duplicate" had similar problems...
> 
> So how about:
> 
> - Default to normal mode on vmlinux/module, i.e. validate and/or
>   generate ORC like any other object.  This default is more logically
>   consistent and makes sense for the future once we get around to
>   parallelizing objtool.
> 
> - Have "--noinstr", which does noinstr validation, in addition to all
>   the other objtool validation/generation.  So it's additive, like any
>   other cmdline option.  (Maybe this option isn't necessarily needed for
>   now.)

It just dawned on me that "--noinstr" already exists.  But I'm
scratching my head trying to figure out the difference between
"--noinstr" and omitting "--lto".

> - Have "--noinstr-only" which only does noinstr validation and nothing
>   else.  (Alternatively, "--noinstr --dry-run")
> 
> ?

-- 
Josh

