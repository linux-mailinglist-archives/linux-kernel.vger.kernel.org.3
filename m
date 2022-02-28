Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F954C71D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiB1Qk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiB1Qk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93E97811AD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646066415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVHqe2Rl4ckESyri6fM5aL5b86W/vuj/KYSXZXZ7fFE=;
        b=iaj4voUo5sc+H9lrCriGGwiO0UDlRSfwxjqZ1SJeO2X4ZdK79SQwLlPjlFWdulhH4XbVJo
        nsZm0w0otnhTi3AQyzqYLa/x0DQPBZPXwnWyo1xHbMyT3peMJb8SYMcb4/sUC5pbqmozx1
        QSpCifi8be0801iU2Cvqn7uagO7eoeM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-B_1wxtUdOgSwqe0HRGA7Vg-1; Mon, 28 Feb 2022 11:40:13 -0500
X-MC-Unique: B_1wxtUdOgSwqe0HRGA7Vg-1
Received: by mail-qv1-f70.google.com with SMTP id z8-20020a0cda88000000b00432946b4c84so11701729qvj.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVHqe2Rl4ckESyri6fM5aL5b86W/vuj/KYSXZXZ7fFE=;
        b=G12qMlYOysNJH8VqLv61hx5FnXQjUcHH5nbdkqMGSRPocOckIsKujjlblm8IES+TI8
         xcoN9dMH9gXLlBppd5U5iAjGxFSY7F3cmK9B1lQO8iBMM7hhvWuE8IDK6gsmn2bTLSLO
         hGH5SvR3iwrGzfSpoHtBG9u0gMXB+1k5SwbFVeAOfkdRHWLbRf9wLmixy6V5vMg3f04I
         inmsAj4H8+iFavheqtIfPgLppQPwpVgEZAarkR6ljbanMclbjxJTg63a45PzFfW5EwpT
         X/O1JQuYTGrhOqoPJj1hqLFnT4ZlrXVfStFNUqujtnIjZBtJRpSf+2B67//K8bBU7Bno
         8iGw==
X-Gm-Message-State: AOAM531q0M8A+ulAj3o6IAOOYj65/9SxTsd6cs0zIYYjXNeUb30UtuwW
        grtGiepUNIw/80oZX8xxJAqMW0sx6d4588cWjIViwjltf0f95kVGIdDAyFWVUErMm5qw3LuMsk+
        quoZBPjLwk0m4CdjRHZYGkJkw
X-Received: by 2002:a37:4c3:0:b0:649:714a:54b5 with SMTP id 186-20020a3704c3000000b00649714a54b5mr10879790qke.386.1646066413151;
        Mon, 28 Feb 2022 08:40:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPM3UwqEK7pbmAUbuMH0uT7fW30UXnkQrEEWyAFsc9g1GKfpQq0EkkcRM2OxFNP3f99Dtc+w==
X-Received: by 2002:a37:4c3:0:b0:649:714a:54b5 with SMTP id 186-20020a3704c3000000b00649714a54b5mr10879768qke.386.1646066412871;
        Mon, 28 Feb 2022 08:40:12 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id 10-20020ac8594a000000b002de6f5c4a7csm7306148qtz.92.2022.02.28.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:40:12 -0800 (PST)
Date:   Mon, 28 Feb 2022 08:40:07 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [PATCHv4 01/30] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
Message-ID: <20220228164007.nfrg7xvrl4blzzrm@treble>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
 <20220227220130.23yjme7jucxo266l@treble>
 <20220228162056.gul22bjr4w6zjslq@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228162056.gul22bjr4w6zjslq@black.fi.intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:20:56PM +0300, Kirill A. Shutemov wrote:
> On Sun, Feb 27, 2022 at 02:01:30PM -0800, Josh Poimboeuf wrote:
> > On Thu, Feb 24, 2022 at 06:56:01PM +0300, Kirill A. Shutemov wrote:
> > > So far, AMD_MEM_ENCRYPT is the only user of X86_MEM_ENCRYPT. TDX will be
> > > the second. It will make mem_encrypt.c build without AMD_MEM_ENCRYPT,
> > > which triggers a warning:
> > > 
> > > arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for
> > > 	function 'mem_encrypt_init' [-Wmissing-prototypes]
> > > 
> > > Fix it by moving mem_encrypt_init() declaration outside of #ifdef
> > > CONFIG_AMD_MEM_ENCRYPT.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Fixes: 20f07a044a76 ("x86/sev: Move common memory encryption code to mem_encrypt.c")
> > > Acked-by: David Rientjes <rientjes@google.com>
> > 
> > The patch title, warning, and "Fixes" tag tend to give the impression
> > this is fixing a real user-visible bug.  But the bug is theoretical, as
> > it's not possible to enable X86_MEM_ENCRYPT without AMD_MEM_ENCRYPT,
> > until patch 27.
> > 
> > IMO it would be preferable to just squash this change with patch 27.
> > 
> > Having it as a separate patch is also fine, but it shouldn't be
> > described as a fix or use the Fixes tag.  It's more of a preparatory
> > patch.
> 
> maintainer-tip.rst seems disagree with you:
> 
>    A Fixes tag should be added even for changes which do not need to be
>    backported to stable kernels, i.e. when addressing a recently introduced
>    issue which only affects tip or the current head of mainline.
> 
> I will leave it as is.

How does that disagree with me?

The "Fixes" tag is for bug fixes.  If it's not possible to trigger the
warning and there's no user impact, it's not a bug.

-- 
Josh

