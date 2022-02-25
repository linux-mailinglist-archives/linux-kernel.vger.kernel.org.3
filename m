Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7144C3A84
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiBYAvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiBYAvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:51:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA61D6F48
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:50:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id l9so2947274pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n1vh1EcVrUWpGIeAPX3OzfgSOIRJYF7RWg+hWWkL8NI=;
        b=MhwcMToHtV8bbasQe02tQsQJQCngWiQNiKmBHE/wyZOikXNanNw9FlsQ+zfPtTYU1X
         7bZ22CMaDNRIYu2xrj58ASNsacJWdqzmeksvEmLDw8iwi1SGZNkebKBJi+VGoLZeU6sr
         NcR8gEt5567ph3FHE63Yk3xB4nUz+w6BUqs64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n1vh1EcVrUWpGIeAPX3OzfgSOIRJYF7RWg+hWWkL8NI=;
        b=c0pskcUCdXpMlHfZI+AWu7Z08Sf76VatlwfAP0UH8U7wX1vDXbADrqD8jo/AABMlNI
         5LIBrLkzN2g55XMYQUagpjGCDhDUkDEjnIgNe8ex/+xjD45Sn9jZyLIh2V7tx8uhLxem
         gAEVn9SD9jnoA09n+YR9cTHBNT0ae8MzxGMshGUEWMHMRPNpg5AltOOAxsCWlBw5DhDH
         QCIRalTnZH1mSaZ7EEI+TW4VtJGsBziyEiHI4vKdGU/vcElPQT9Bdb9dlmnN9rRn91SD
         kQoU7eRYmFmmZ0mXdIvGBquksDtO7Ym4/6hd1ya2Zkmg3+CA/DAR7fFHDuS++emclR5K
         Zz+g==
X-Gm-Message-State: AOAM533d/RwpN5aecbVwkIMtyzv62SIWccAHgOQNCwQce9t1HuED8hwU
        RHQsfPnUlb8Dbnv5OesR+6T8kQ==
X-Google-Smtp-Source: ABdhPJyQucIW7qlXLa+N0dPbANijXVp+HTcn816+kqxcmSw9DLHpfLF1YBgjuPHQzjq4ZEeZYZWV/g==
X-Received: by 2002:a17:90a:ab08:b0:1b9:c59:82c3 with SMTP id m8-20020a17090aab0800b001b90c5982c3mr669636pjq.95.1645750241437;
        Thu, 24 Feb 2022 16:50:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm652497pgp.15.2022.02.24.16.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:50:40 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:50:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 10/39] x86/ibt,crypto: Add ENDBR for the jump-table
 entries
Message-ID: <202202241648.C349B75@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.598835921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.598835921@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:48PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Can you put some details in the commit log here about why these are
needed? My eyes can't find the indirect users...

> ---
>  arch/x86/crypto/crc32c-pcl-intel-asm_64.S |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> +++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> @@ -195,6 +195,7 @@ SYM_FUNC_START(crc_pcl)
>  .altmacro
>  LABEL crc_ %i
>  .noaltmacro
> +	ENDBR
>  	crc32q   -i*8(block_0), crc_init
>  	crc32q   -i*8(block_1), crc1
>  	crc32q   -i*8(block_2), crc2
> @@ -203,6 +204,7 @@ LABEL crc_ %i

-- 
Kees Cook
