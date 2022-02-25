Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F724C3A94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiBYAzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiBYAzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A6D314CCA9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645750486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZZC/VJ0/U6Alzt/tPjFfBFIWup+/Y72n0Vs/ZXQ44w=;
        b=MuOP9QYasqSulAxj5SS5zkR3kgtR9IleOiSFMC/y7bMuvpuS2UlRploP6AwQw0/uFKD9Hq
        f87rBbFAiCtQ7kKFB+jwrZ5M+jR5prh7YrdUiafbkO8mr2I2vafH5MgohdtKPjQHe8FWnE
        /v//lg4Zdn4l/4SCl5gLBSmLXBVU7mI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-rXuppIh8Pp-_OHdq8npOOA-1; Thu, 24 Feb 2022 19:54:45 -0500
X-MC-Unique: rXuppIh8Pp-_OHdq8npOOA-1
Received: by mail-qv1-f71.google.com with SMTP id hu9-20020a056214234900b0042c4017aeb3so4523141qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HZZC/VJ0/U6Alzt/tPjFfBFIWup+/Y72n0Vs/ZXQ44w=;
        b=aT9fGzAX/yYc8IxVZAdnRgkx0Nq1m383LrhHw3AlN3bxmJpyk1AMkBFscNTazKvwXK
         m9u11H7aCHb2taU5LLZINxC0x6grA52Ft0wnXn0A92VhzdTy2SycFCmHkwiqLUIl7Jbg
         48HjsTm8tGpXzJSJYREA7aQTeKAmPRdqNJcu9N+pHQwk4HinBuO8ZzogOPY1COqPws3B
         V/l1JT6UPmvW1f5uhkpkh96CL3/21W9QNH0I1yZTxac2XG6kJdNHnTpbQBMqhDjUNoHZ
         4agG8XlChyHuGP9UR2y7sHMcMzBjlOlDlW4f25t3k+a/FgLAI3MKXt5d9CoL+oBU+iW+
         ngoQ==
X-Gm-Message-State: AOAM532suXRP/Km+JFjznCfA/8oCmK0LjpMrW6ScHl5IW98sM+Fw12ux
        tGRljqjwKiW4lKnm3zzfzTWdiBLC+D2uL4YgUtii00VVqctDjCyGgLhPAE62/gJdQa8izKsFp19
        H/ScAjbtQKAc58A/YDIt+ylFw
X-Received: by 2002:ac8:5e06:0:b0:2de:8f67:b390 with SMTP id h6-20020ac85e06000000b002de8f67b390mr5056239qtx.72.1645750485150;
        Thu, 24 Feb 2022 16:54:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHL5ypnpOBdbKlEadNj3NpV0V0yxHI7NQmDYM/M5NzZzcb0yZBe5/IypYIbkAxN+rYIGredA==
X-Received: by 2002:ac8:5e06:0:b0:2de:8f67:b390 with SMTP id h6-20020ac85e06000000b002de8f67b390mr5056216qtx.72.1645750484939;
        Thu, 24 Feb 2022 16:54:44 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id x26-20020ae9f81a000000b005f1916fc61fsm522101qkh.106.2022.02.24.16.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:54:44 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:54:40 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 28/39] x86/ibt,xen: Sprinkle the ENDBR
Message-ID: <20220225005440.mvz4jtxwq5ttcu77@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.661210297@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151323.661210297@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:52:06PM +0100, Peter Zijlstra wrote:
> +++ b/arch/x86/xen/xen-head.S
> @@ -25,8 +25,11 @@
>  SYM_CODE_START(hypercall_page)
>  	.rept (PAGE_SIZE / 32)
>  		UNWIND_HINT_FUNC
> -		.skip 31, 0x90
> -		RET
> +		ANNOTATE_NOENDBR
> +		/*
> +		 * Xen will write the hypercall page, and sort out ENDBR.
> +		 */
> +		.skip 32, 0xcc

I seem to remember this UNWIND_HINT_FUNC was only there to silence
warnings because of the ret.  With the ret gone, maybe the hint can be
dropped as well.

-- 
Josh

