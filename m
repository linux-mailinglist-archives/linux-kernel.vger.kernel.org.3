Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19B4C38D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiBXWiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiBXWiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 021811470EF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645742255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cocWRBUsDVybCinHIcmXN5TQyz6k/B4wu/U68zqDoGQ=;
        b=Tp9nlGD7mgCBOnsloBzabJiymsYNLSkTalDbzSmB8WfFgDpBIo17Vru9urwoR6+hQ4/H6j
        C0dEpdaek9tvijRwakp+rYldWnlWRZvo9QDpzoYiGEUy56qZDwGHOE7hkF+qTgVZnigbOA
        sg3RtAbOausjpGGDalBNwlU/qgwMO5o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-c_BCsqqpOaCE06eMT6dpPw-1; Thu, 24 Feb 2022 17:37:33 -0500
X-MC-Unique: c_BCsqqpOaCE06eMT6dpPw-1
Received: by mail-qk1-f200.google.com with SMTP id c19-20020a05620a11b300b00648cdeae21aso4011084qkk.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cocWRBUsDVybCinHIcmXN5TQyz6k/B4wu/U68zqDoGQ=;
        b=FFkGwrmfyod+Uz+2rWTRb1AZHDgw55R/7Z+8eI98cudAoBPYQjY47hnE01fItGuB8t
         eDmxPv55091a+VBQ5KZC8fgmU9tkt9L8QWDTtWyFH4IQpBermM45sXCJwEN+uiucnrvd
         By6/DYApzJhrPvGOlROzk2pR6yxPq5Wt9syx2PLnhwZORzUzbR0T9F6G1ZYtrDmql5Sy
         j8SO2sHiy77WkQ8TsxGOKyvGlnGnqtfLDVq5iACj3kbd/nr57bQio3VbfakxLhxEhfOL
         HKMKkFcT6h7V638mmuu8wgKwz54WtHKFnQ2PyiWjyLQWSmUwpn/0R2Xw64ekHjceaK8K
         6EJw==
X-Gm-Message-State: AOAM53126Vrv5UHSsvbN0Nw3xDYTa2SQrIvkO+BOwuOQ4SObacUmls4i
        4O8SfqICWJx+ImTVQYLAWNuL0hTN4KQ4xmH7jJdm43I8wTytUA1JE+8Jxt1KErXAvZr6tZ4D7Bm
        RHk842fD05R85XY5KBslrtZ+T
X-Received: by 2002:ac8:594d:0:b0:2dd:ff9c:f26 with SMTP id 13-20020ac8594d000000b002ddff9c0f26mr4531274qtz.242.1645742253464;
        Thu, 24 Feb 2022 14:37:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyG0iW04Fx1zW0sIzoJ9G20h8mEwWDiJHdELGfUisr1/RQDVOJ9S+gglwGPJlFFGmDVuSD75g==
X-Received: by 2002:ac8:594d:0:b0:2dd:ff9c:f26 with SMTP id 13-20020ac8594d000000b002ddff9c0f26mr4531258qtz.242.1645742253232;
        Thu, 24 Feb 2022 14:37:33 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002dd2647f223sm414834qtv.42.2022.02.24.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:37:32 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:37:28 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 07/39] x86/entry: Sprinkle ENDBR dust
Message-ID: <20220224223728.fqko5ex7wbm2a5xn@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.423131356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151322.423131356@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:45PM +0100, Peter Zijlstra wrote:
> Kernel entry points should be having ENDBR on for IBT configs.
> 
> The SYSCALL entry points are found through taking their respective
> address in order to program them in the MSRs, while the exception
> entry points are found through UNWIND_HINT_IRET_REGS.
> 
> The rule is that any UNWIND_HINT_IRET_REGS at sym+0 should have an
> ENDBR, see the later objtool ibt validation patch.

Could the "rule" be changed to only check global syms?  It seems
unlikely a local symbol would need ENDBR.

Then you wouldn't need this annotation:

>  SYM_CODE_START_LOCAL(early_idt_handler_common)
> +	UNWIND_HINT_IRET_REGS offset=16
> +	ANNOTATE_NOENDBR
>  	/*
>  	 * The stack is the hardware frame, an error code or zero, and the
>  	 * vector number.

-- 
Josh

