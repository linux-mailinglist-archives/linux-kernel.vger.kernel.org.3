Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503624C3A79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiBYArz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYArx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07A5E1768EA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645750042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9mslH3t0ZfojhoXb/Dko3+MbwMoPsJRewQCcDFHbwg=;
        b=ApJkVxNel1KQMYOHLU1cCwtLqa/mfAzdtoCQxXIOTnR5tS1mvvnxZwdRuii+iGuMG0g0a4
        +EZx+Yp0All5Z9yaq93WTYDTiPEYcaJG1Z8mKX8FraHpoTIuU5wfxqeFKG+oGAvlLXz02+
        OdBaM8kbKBspwm16W2PYKHyV5+I+ssI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-vBBUuA7TNG2tNZ8TBNy7sQ-1; Thu, 24 Feb 2022 19:47:20 -0500
X-MC-Unique: vBBUuA7TNG2tNZ8TBNy7sQ-1
Received: by mail-qt1-f197.google.com with SMTP id x26-20020ac84a1a000000b002ddcbd9e933so984343qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9mslH3t0ZfojhoXb/Dko3+MbwMoPsJRewQCcDFHbwg=;
        b=de1TVfgIk6O+3jMfHOoPYZhOnEZGvB8DMJLbL8PhWquteoDAh7/mez2pz+834gq3A3
         2A5lmSuvmu8ujSJJUXXVgLvcNRRySPtmkkfvn26pvf2sELPj7zWdl+bRsqteeRx8qdCJ
         rbAaxLRh6AxEu3bHvFyRN7bCleChWomousjj9+eo0V8JUjtPvzr1uvDps6jcKZOruemi
         VQUzf8ey/wpk5iQ8XlAnozhpgP/f2G4KOliXguSfsXlwWfxzvf/DpG0spYIw9WMhsqx4
         VPxT2m83Z75Cd/dtgI/DoI25X4DnCabszYAm82KCqcIYSo/DW/P7jYlN442Nfkl9Thkt
         NieQ==
X-Gm-Message-State: AOAM532FacFPh30GoabCmLXw9RFjsekvUuisD7Ve+vE+Wv8oavd1JhDI
        aMj8H4i8UQbO+GKp8yQsNQ/vh+sg2EMnrt93T7U1R7rPKBzuFvwnVpu9Lu1nXq2bEMlxG6/0PVP
        Iswc8krbVsYZEOEswq9dNf10Z
X-Received: by 2002:a37:a95:0:b0:648:e065:84c4 with SMTP id 143-20020a370a95000000b00648e06584c4mr3419434qkk.89.1645750040301;
        Thu, 24 Feb 2022 16:47:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWzTI8Vtl7asP9+3bFcf77Sick13M1qCzJITIkrnaRRuxoCVwmpUQyrZp/2HUkgyFf2w1wbQ==
X-Received: by 2002:a37:a95:0:b0:648:e065:84c4 with SMTP id 143-20020a370a95000000b00648e06584c4mr3419422qkk.89.1645750040076;
        Thu, 24 Feb 2022 16:47:20 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id e9-20020a05620a014900b005084ce66b44sm540367qkn.88.2022.02.24.16.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:47:19 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:47:16 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 21/39] x86/ibt: Annotate text references
Message-ID: <20220225004716.epyhpxi5lunphzi4@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.248523488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151323.248523488@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:59PM +0100, Peter Zijlstra wrote:
> @@ -563,12 +564,14 @@ SYM_CODE_END(\asmsym)
>  	.align 16
>  	.globl __irqentry_text_start
>  __irqentry_text_start:
> +	ANNOTATE_NOENDBR // unwinders

But the instruction here (first idt entry) actually does have an
endbr64...

Also I'm wondering if it would make sense to create an
'idt_entry_<vector>' symbol for each entry so objtool knows to validate
their ENDBRs.

> +++ b/arch/x86/lib/retpoline.S
> @@ -12,6 +12,8 @@
>  
>  	.section .text.__x86.indirect_thunk
>  
> +	ANNOTATE_NOENDBR // apply_retpolines

This should probably go after __x86_indirect_thunk_array?

-- 
Josh

