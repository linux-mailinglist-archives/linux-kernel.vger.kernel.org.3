Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849B44DD029
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiCQV2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiCQV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:27:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84523E127E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:26:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 6so3628575pgg.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t3AEOAq14i3EG/rquowlVe/zjdaZDH/WIKQHfOErJko=;
        b=UVHNXXnOEefY1Vy3hj/0OCtNe0JL8d0KcntvVuMCDGi5ySZpLRjcvDWZjscPkaXYUL
         4aW3QgrkeWASmfJWSKiiG6kZc/H1pzq6pbGJ7GCQLgWp4SmesyDfNh2hd9esKtvnyxsv
         b+B/TF1CHJ4H+QRBYkPUhwm86M8au6P02KeLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3AEOAq14i3EG/rquowlVe/zjdaZDH/WIKQHfOErJko=;
        b=1GJCdO1T4oJP80zJsgPuNmmo+Ti77oZht9853frzQtHFL+n7WyajPBUG4/ny2zpwHY
         yKx4t8t7WqWCGEH0jS+CuzzAC/3H+RqtxgYGtXtdvyJAEebnE6jXfGYRZ2cY94BPuraL
         MbU3VQ1MphUCusNpPmZaPgg/2fzUweOPZ3gXSJ17pl+OIyjosnN8imgQcYqPVg+2uYd0
         ZpLhCKJveKRn8sHmtRTlxSMccf6JrUeEek12omzbsZTxdStM0nR4M395n57Sr4/Yxktr
         lluIhFbXe8AFPHeOatfM4eel67QQmVkiaJfN6wNWqCEZez0ihOWKe2CoIBmqPXilGx2d
         AfTw==
X-Gm-Message-State: AOAM533jQo3RGLr5+YpYoCyHmZXXzBIvytRO/p4ItLDFkskCmr13JBZW
        QjkjcZz8JHF+p7txFRWY9XJ5SQ==
X-Google-Smtp-Source: ABdhPJxv39a1M1FCYdm1DZMI4PMp646IDuGYZTbImyl9pmm2fzbnwYdGE1sQXO2UUSvX2ZZp4e9tfA==
X-Received: by 2002:a05:6a00:2d0:b0:4f4:1f34:e39d with SMTP id b16-20020a056a0002d000b004f41f34e39dmr7042633pft.14.1647552395033;
        Thu, 17 Mar 2022 14:26:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f6519ce666sm7735505pfi.170.2022.03.17.14.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 14:26:34 -0700 (PDT)
Date:   Thu, 17 Mar 2022 14:26:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 3/3] elf: Don't write past end of notes for regset gap
Message-ID: <202203171425.565EB773FD@keescook>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
 <20220317192013.13655-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317192013.13655-4-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:20:13PM -0700, Rick Edgecombe wrote:
> In fill_thread_core_info() the ptrace accessible registers are collected
> to be written out as notes in a core file. The note array is allocated
> from a size calculated by iterating the user regset view, and counting the
> regsets that have a non-zero core_note_type. However, this only allows for
> there to be non-zero core_note_type at the end of the regset view. If
> there are any gaps in the middle, fill_thread_core_info() will overflow the
> note allocation, as it iterates over the size of the view and the
> allocation would be smaller than that.
> 
> There doesn't appear to be any arch that has gaps such that they exceed
> the notes allocation, but the code is brittle and tries to support
> something it doesn't. It could be fixed by increasing the allocation size,
> but instead just have the note collecting code utilize the array better.
> This way the allocation can stay smaller.
> 
> Even in the case of no arch's that have gaps in their regset views, this
> introduces a change in the resulting indicies of t->notes. It does not
> introduce any changes to the core file itself, because any blank notes are
> skipped in write_note_info().
> 
> In case, the allocation logic between fill_note_info() and
> fill_thread_core_info() ever diverges from the usage logic, warn and skip
> writing any notes that would overflow the array.
> 
> This fix is derrived from an earlier one[0] by Yu-cheng Yu.
> 
> [0] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/
> 
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> 
> v2:
>  - Warn and break out of the note collecting loop if the allocation would
>    overflow. Note: I tweaked it slightly to do break instead of continue
>    and to do it before SET_PR_FPVALID(). (Kees)

This looks great; thank you for the tweak. :)

Acked-by: Kees Cook <keescook@chromium.org>

Shall I take this separately into the for-next/execve tree, or would you
rather is stay in this series?

-Kees

-- 
Kees Cook
