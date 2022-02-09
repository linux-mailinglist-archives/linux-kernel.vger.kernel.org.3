Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA274AE87A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiBIEMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbiBIEFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:05:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CFBC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 20:05:48 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c3so1141268pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 20:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/7E7Mp6XNXqXhtlqv1x1MYPkswrBrA6+UdeF1obBS4=;
        b=LhhMh/QKAlG2POJv0ZfzUP5W8E7pnK30Hb6+s1H0+gZroVOfdcD2dWyMTlhY2fBoKm
         CE6I3mJt2iEmtOfdFnpJWyj95G8qFPl+SpqKrpwMbNdgSz8CXcqy514uSwRdO/lGjisG
         caDa9FzfI0KVEqNqIgwAy/ImzqZpuPIRBIJ0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/7E7Mp6XNXqXhtlqv1x1MYPkswrBrA6+UdeF1obBS4=;
        b=RENCq1ghh+olu5pDTn1wHOD43ASogYzPURauseosTzjHoz49L4X37fSH+JbsSeyypE
         qiGzBlSgmGAlYdV8cGDuwB8ILqxxUZ++gqqVKDNrQhUEMWIt3UrZTqjyQCH2resV0UDM
         +gLLMasyiPCjgDjCnkegxCBVxfDqpE5iASIRbRRPpql2qXA0w01CRb6rxVwprLEI19dF
         ko+kBAsm4JVdRKvn18w2iNaBVe/hRSEkmDIeI+N2ymzFDEhRJ81PDdqdrtdPPANqk0Ir
         yhYcwgr5sJs9lOsikWKurGNZNLu06Iuf0nkFs03ogG4KSp30MMdt4YgE7/mz47APzSQP
         vPxg==
X-Gm-Message-State: AOAM532lHRg/e9xoprv9zayvCOCm1AwSdB+5+lN6Iguq21pEft5UfEZK
        hPvsYJNioBf9gsUZLUGE8vaWEQ==
X-Google-Smtp-Source: ABdhPJzebAbGu7EAY4nH4ZIhdg023f0jz9MjXa8a8latUIqwacPOTeECC7leOgrcuGUHh/BtCMYo0w==
X-Received: by 2002:a17:902:ce8a:: with SMTP id f10mr328461plg.35.1644379547675;
        Tue, 08 Feb 2022 20:05:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10sm18098462pfu.186.2022.02.08.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 20:05:47 -0800 (PST)
Date:   Tue, 8 Feb 2022 20:05:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <202202082003.FA77867@keescook>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:21:16PM -0800, Joao Moreira wrote:
> > > Note: This feature was already submitted for upstreaming with the
> > > llvm-project: https://reviews.llvm.org/D116070
> > 
> > Ah nice; I see this has been committed now.
> 
> Yes, but then some front-end changes also required this fix
> https://reviews.llvm.org/D118052, which is currently under review (posting
> this here in case someone is trying this out).
> 
> > 
> > Given that IBT will need to work with both Clang and gcc, I suspect the
> > objtool approach will still end up needing to do all the verification.
> > 
> > (And as you say, it has limited visibility into assembly.)
> 
> Agreed that at this point objtool provides more coverage. Yet, besides being
> an attempt to relief objtool and improve a bit the compiler support as
> mentioned in the series cover letter, it is still nice to reduce the
> left-over nops and fixups which end-up scattered all around.
> 
> FWIIW, https://reviews.llvm.org/D118438 and https://reviews.llvm.org/D118355
> are also being cooked. Comments and ideas for new approaches or improvements
> in the compiler support for this are very welcome :)

Ah, excellent, thanks for the pointers. There's also this in the works:
https://reviews.llvm.org/D119296 (a new CFI mode, designed to play nice
to objtool, IBT, etc.)

-- 
Kees Cook
