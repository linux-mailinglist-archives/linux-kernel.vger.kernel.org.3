Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9407151AD8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377488AbiEDTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377485AbiEDTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:11:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADBE43AF6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:07:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so2270602plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1NLrXVkZbGvcjOZGn3V43bG6P23uJxS+WvWDtv6ftUw=;
        b=V035LlW/suuLYmq2whqz7nWNDcWJ0bWZ7JlvvMg43vQqd9Ijkjh5vRtZWrIg+AElWN
         0F76O0rqrVr3vDzwX0i8m+uZV0/A6KpOwBQkcX0Tysyn6WWHFybiVCiFXMXiLZMRKkIX
         WKxWVRZ1NRBz7JKxIdZtmxXOQE+NM0NOTyWag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1NLrXVkZbGvcjOZGn3V43bG6P23uJxS+WvWDtv6ftUw=;
        b=DHuxn1S4zY9Vrri4sd3iLTw1V6v+6NOSfvG0wzdhp4+qyd/+HgU2LfDhSPOmdxG8T9
         OuFdmeeS1ypNiRcgQc623Ok3OryfAwmAOoZMY84HgDLMK6BTQP3pDBUxBJE/TOCZqyeS
         2tu2ihKCCXWz022IKFJCd/md8ecwc94Qn18hpyrtmA5hIQNnnwq3YHu2ryx9RsGMWBNC
         I4EfAKZkg80RVEuTgBmw7/39bewQnsMbdtmceeJ3PS3NggcBZ5UyrLyHjoDndWSY5ut3
         +paszNDtsF4bFWHISxOfnOhFICsn5hoesvxiJ47O0Dco/YIn8J6ZPdbvybDf6x21rtJe
         5rTQ==
X-Gm-Message-State: AOAM530CFtU0I/noQagU5Bf5k1h8k6Tdan2J9c49zxHh5rvOdrQtxp2J
        Z52rrcx711xLJPIGpbmosZDTkkPfEBHh6A==
X-Google-Smtp-Source: ABdhPJy9u+QW5lZIpB3ltPiys1+HxI4FHV55hPmgEabatNCHNWjjD5WduiYt7Ke854+7rHOSZNyrXQ==
X-Received: by 2002:a17:90a:4413:b0:1cd:2d00:9d0b with SMTP id s19-20020a17090a441300b001cd2d009d0bmr1097083pjg.81.1651691278894;
        Wed, 04 May 2022 12:07:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b0015e8d4eb224sm8794928plg.110.2022.05.04.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 12:07:58 -0700 (PDT)
Date:   Wed, 4 May 2022 12:07:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        alex.popov@linux.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 09/13] lkdtm/stackleak: rework boundary management
Message-ID: <202205041205.803FD491@keescook>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-10-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427173128.2603085-10-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:31:24PM +0100, Mark Rutland wrote:
> There are a few problems with the way the LKDTM STACKLEAK_ERASING test
> manipulates the stack pointer and boundary values:
> 
> * It uses the address of a local variable to determine the current stack
>   pointer, rather than using current_stack_pointer directly. As the
>   local variable could be placed anywhere within the stack frame, this
>   can be an over-estimate of the true stack pointer value.
> 
> * Is uses an estiamte of the current stack pointer as the upper boundary
>   when scanning for poison, even though prior functions could have used
>   more stack (and may have updated current->lowest stack accordingly).
> 
> * A pr_info() call is made in the middle of the test. As the printk()
>   code is out-of-line and will make use of the stack, this could clobber
>   poison and/or adjust current->lowest_stack. It would be better to log
>   the metadata after the body of the test to avoid such problems.

Yeah, I noticed this too when I was testing the v1 series. I started
cleaning it up, but your version is much better. :)

-- 
Kees Cook
