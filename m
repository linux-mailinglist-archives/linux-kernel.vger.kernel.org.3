Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5484ACBD5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbiBGWIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbiBGWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:08:02 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41AC0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:08:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d187so15397489pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tWrUH0/2WksDBWa18gtzsMkaDJc90addPmZE3/A1VQs=;
        b=Z2KHWsSlYbT//VOpYTnsnCI4+qhPgIK3t46x31rkFoO5ONCFeKMB0eBS8wfxLY/rHH
         DDbbHdNF8IDkq8l2KB7GWf6f87zyM2JbhposV61iCOirtJgTuA2qicPr1czJfliHIbY2
         S3Ez++GqAIK0YbE8VZFaswNcQ5OATUtK2scAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWrUH0/2WksDBWa18gtzsMkaDJc90addPmZE3/A1VQs=;
        b=aiel7b+/eSD4lwPHvANEQnaVQ2IW2h5OCHUGuIzfHZ2HY5T/t3SM8NpWAM6ycyIrJf
         gN1/ipx2FZHWHSvrDHA2OX8ZfJWmarT1AE+Y2fy9d8gH5lC64dj15cpr5aubSN47Vh1O
         jEQE44eDBWHH7pEQJxsN6/Cmbd40qoyw/0QF2gOB09VVV9wcJBngRfeNN1PiJyuZzuyH
         7W7L8HPVsSCg3VFl4UsKAQqrSob4/k6/PICssuE0DW40KX4qRW+jq9suqoSzCvvVmYk5
         aJQk4l6FLYnPqz5DLL92t9p5DLfSYMtRI+0HqzFEvZPaOY6S2JZcxqvYrjV9mSEvtxh8
         NeAg==
X-Gm-Message-State: AOAM531jwAzFKnRHSM4YhSVKR7N43Thn3C7rfEkm0ZQIauiVrc6EIq7D
        W7WlaYifS6vzMzceenaRTFm634HJOXQ2oQ==
X-Google-Smtp-Source: ABdhPJwt1VK44ImLNBUFQZ5ofmSi8ahLthLH5mh0+UjMF0vB3tsRE2HKk/VedZZ1we9FF4YvN78UmA==
X-Received: by 2002:a63:9245:: with SMTP id s5mr1111836pgn.277.1644271681885;
        Mon, 07 Feb 2022 14:08:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl12sm351392pjb.1.2022.02.07.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:08:01 -0800 (PST)
Date:   Mon, 7 Feb 2022 14:08:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] x86/cpu: Remove "noclflush"
Message-ID: <202202071408.60A31586@keescook>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-7-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127115626.14179-7-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:56:26PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Not really needed anymore and there's clearcpuid=.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
