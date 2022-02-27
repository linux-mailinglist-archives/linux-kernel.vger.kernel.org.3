Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6E4C5F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiB0WDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiB0WDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19C612AF5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645999346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDmlUXCLeYirmZ8DQL7ITFuWViExLnwWTarTV+UXvEs=;
        b=cHmDYSM2pj2GM56bIogCULCl9ER2U9echJWo3mIBHhC5WUrLgDwIGwwDnBNls3EB4VuGyO
        R3ETcrGdC8bqeyUmviyr1SSbQOg3tJb9AKoYHuaIrKHRXT9Bj+ThMG73Lr4GsgR48GbKxO
        sYr6tDR7O4ZCMq2jBbHnJTeCAhDlU34=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-5uoOC634NfmaimCNB1IyiQ-1; Sun, 27 Feb 2022 17:02:24 -0500
X-MC-Unique: 5uoOC634NfmaimCNB1IyiQ-1
Received: by mail-qt1-f197.google.com with SMTP id j7-20020ac84407000000b002de72c633b2so5116338qtn.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LDmlUXCLeYirmZ8DQL7ITFuWViExLnwWTarTV+UXvEs=;
        b=2tpbjbVYRJXWkaxj1WRYE6bIu5186bdAMYtgNt0l3OhODAlTbpMRmpXpkBas2FZz0u
         ddDz+FHIqYxPpKgPR/wRkrqKtMIUeMfYNHHFOnRoYuTlwzHKC7djUXkDfMUwdLlcfrQI
         DPKhlDeflDskzlxrnqvr9ZpD4E64HiNE3hz3X7D5a57Z2liS7ZDl8KvsmbINp4F/L19v
         xOoz/NKxs78hjvQReNUIllEOyfBtsVJps2HzDBqWa6gLTMbOfLmqrWFqKIFRfB+2ChYe
         3SlxyjXoT+r1FsR7wj6SPfq4YCIgufBGwpelFsBXFTCSyLVjQZKoU/H7+NSgHL17rljL
         XVQw==
X-Gm-Message-State: AOAM532Jx4uCvuTIGiIwz8keTIi3M04JJHl0yMlAZh8VA8pSO20Ch6Ln
        8ROJWUCE4QKcedSTSlNxtuv00OJ6QAjwueMQIZmeFJzy5bCM1UBSCsUQC+R5qPnnFZIB37DSRIq
        gHCyH73li8jhI/I1n843hYH0w
X-Received: by 2002:a05:622a:1a82:b0:2dd:2c62:a51b with SMTP id s2-20020a05622a1a8200b002dd2c62a51bmr14445339qtc.328.1645999344171;
        Sun, 27 Feb 2022 14:02:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzc3vfjhJ9g3oiU3TmVYmPkE+487smJlRgCJ6crimQrbxEZKmRqDB0C2O8FeV8fi4pYdlccCQ==
X-Received: by 2002:a05:622a:1a82:b0:2dd:2c62:a51b with SMTP id s2-20020a05622a1a8200b002dd2c62a51bmr14445308qtc.328.1645999343947;
        Sun, 27 Feb 2022 14:02:23 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id q12-20020a05622a04cc00b002de06a6604asm5921799qtx.16.2022.02.27.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:02:23 -0800 (PST)
Date:   Sun, 27 Feb 2022 14:02:19 -0800
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 15/30] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220227220219.6myd32n6oojwbnyh@treble>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-16-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224155630.52734-16-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 06:56:15PM +0300, Kirill A. Shutemov wrote:
> Port I/O instructions trigger #VE in the TDX environment. In response to
> the exception, kernel emulates these instructions using hypercalls.
> 
> But during early boot, on the decompression stage, it is cumbersome to
> deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> handling.
> 
> Add a way to hook up alternative port I/O helpers in the boot stub.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I think you missed my comment from v3.  Repeating it here:

At least from reading the commit message it's not self-evident why #VE
handling would be worse, especially since there's already #VC support in
boot.  It would help to give more info about that in the commit message.

The current approach also seems fragile, doesn't it require all future
code to remember to not do i/o directly?  How do we make sure that
doesn't happen going forward?

How does it fail if some code accidentally does i/o directly?  Or
triggers #VE some other way?  Is the error understandable and
actionable?

-- 
Josh

