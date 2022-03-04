Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1DC4CDBC9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiCDSIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbiCDSIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2DEAE4D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646417247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIl6hHWLq9/85jV6z5GA+O7/2HZkQPuFq7ue7Qk2mQU=;
        b=fSg9sy4CimRhwhxYNYXHrLx4CoKP/GJSj9m7Mny0cBz3+Nw7fw+keH8tFJYb9F/msC2sOD
        4uSgPeaJ9uoMj5lmYNwTvc/CSzIOE0CBfy76PSgkeyNAumxpTyKHQTyoPeeJlN7bOzUfm6
        buhJq+YFsQgsSPg5ufTd4YFxxZNKXkc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-hFnMNQRwPJK2V-XG46-TLQ-1; Fri, 04 Mar 2022 13:07:24 -0500
X-MC-Unique: hFnMNQRwPJK2V-XG46-TLQ-1
Received: by mail-qv1-f70.google.com with SMTP id dj3-20020a056214090300b004354a9c60aaso2757433qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MIl6hHWLq9/85jV6z5GA+O7/2HZkQPuFq7ue7Qk2mQU=;
        b=3Y2wF/aLaCMW3QlTVXl2C+wl6d5LNCZ9Df+5L+em7UFqukijv0lA+LZX1WUW5nidcQ
         o/T7WitIQpqNjTw4qhA0RCObRsJ+5KNEWF3xqye0zCUzXFyscHHnudgOQ2kBxRtSSphJ
         1k06YD0gZqlaQXhkOHzrwcChnWXF9LVQRoci/0EPglEZ4MroVbTpGE3NrU5YTyiAxsUU
         O6GYpYw3GPLGHoAATkEw/han684vG/JccTjGugJpkihRaDPPjFawsHWPmeychr5IWKpB
         BQdh2rpN83T/M0Rcl0WxYoNRwRVhlRREtDUtY75kckOU6RiE92BPQ1P4VEzCgim1e9fr
         Ia7g==
X-Gm-Message-State: AOAM531iSG0+lOSBIui5A48zZi/GS/77LBVDIUZcc8WYYk2pDkh1CWj3
        1J5Eg3SoEGn6u+46kxvfLxKyyhZ5FdcTe5CvzGsTIVJFu+uKBaQgcYk4BuMNnfAFBmLGvud15m9
        KpxbJaEZcY2YFfJVtcJ+RHNLo
X-Received: by 2002:a37:e209:0:b0:648:b0eb:3bab with SMTP id g9-20020a37e209000000b00648b0eb3babmr3388627qki.229.1646417244262;
        Fri, 04 Mar 2022 10:07:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm6oML0mwcjXCBzHkCBzLJidsb+laQXKG6XHQBFtWfQDBNIlvMoeUTaL3ONVh1Rl1jSkHGRA==
X-Received: by 2002:a37:e209:0:b0:648:b0eb:3bab with SMTP id g9-20020a37e209000000b00648b0eb3babmr3388608qki.229.1646417244016;
        Fri, 04 Mar 2022 10:07:24 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id d15-20020a05622a15cf00b002de711a190bsm3817117qty.71.2022.03.04.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:07:23 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:07:20 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 22/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220304180720.qkvvjtsbbnfugxxy@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.299051388@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112826.299051388@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:43PM +0100, Peter Zijlstra wrote:
> @@ -310,6 +311,7 @@ void machine_kexec(struct kimage *image)
>  	/* Interrupts aren't acceptable while we reboot */
>  	local_irq_disable();
>  	hw_breakpoint_disable();
> +	cet_disable();
>  
>  	if (image->preserve_context) {
>  #ifdef CONFIG_X86_IO_APIC
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -115,6 +115,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
>  	pushq   %rdx
>  
>  	/*
> +	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
> +	 * below.
> +	 */
> +	movq	%cr4, %rax
> +	andq	$~(X86_CR4_CET), %rax
> +	movq	%rax, %cr4
> +
> +	/*
>  	 * Set cr0 to a known state:
>  	 *  - Paging enabled
>  	 *  - Alignment check disabled

This probably belongs in a separate patch...

-- 
Josh

