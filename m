Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BC496735
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiAUVRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiAUVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:17:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985FFC06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:17:34 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id h5so1576767pfv.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vJ+RHoi8eduKJloDZDcsYEBN9Qtvx5eq+iW8jR4mX4=;
        b=fGEhx6uxC3cC4gc2OTa1ylRzj+5dolwd85ADHWWdJgFRByjrjwSHejf67rUvXeggWP
         NC/AFikcIFiIaD/DkQDVnBLzwiQYhh8I5n5d0O6bLhozvsnM8XiL3aIuQLmQU8Spo1Xd
         kpdntXmercL/4XIgqOOJPq7FqRy0ym8Oay9b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vJ+RHoi8eduKJloDZDcsYEBN9Qtvx5eq+iW8jR4mX4=;
        b=mFxH88B6O6O7G6J5/wSVSkly/REaNvAWZSX2X7FO2awb+9Ph6ocXInUd7HzKd6CKy8
         vhRVx+Xi2Ro/gnSStGHlCZN8lUMVY8uc/JQrm2dLK0hXzWu1AUvlCNTAIY1GEZ2DAwf6
         rCeBo/+rk9oiryoDg90nCPfTpOdzGEiI2DV8wxhZk4oP09jpqiNDoK0mIC3F3Gld0GMl
         l7Uqdbk3pdTSbOrby6XC75xZFcCPtrC7KFhjonDBtvrTOjBLzk/kH4yqT/wljyncGLGV
         PDvvY4WujYGYJA4fJ10vFp8D0fFEVK/D+y853VV1hdYTM+TM048H/VHHJ4ZuuGAE+Jk4
         3QEg==
X-Gm-Message-State: AOAM532DffpriD7odnN98j24s64dS5KQ3exkdXdAtnzKVAGz3Gw1Wwyh
        r6UHGcQ1l4wpRCNAP9+MUiBaKg==
X-Google-Smtp-Source: ABdhPJxrMDgnzspExKVFoFsyjDpZTuTz53tYwGwpZGvee2N+8L8QCJGlIseBftLfU+Li0zmHJ8dGtQ==
X-Received: by 2002:a63:b245:: with SMTP id t5mr4134085pgo.388.1642799854144;
        Fri, 21 Jan 2022 13:17:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e15sm8029924pfv.59.2022.01.21.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:17:33 -0800 (PST)
Date:   Fri, 21 Jan 2022 13:17:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/lkdtm: Add UBSAN config
Message-ID: <202201211317.2E858328@keescook>
References: <20220121145154.1795447-1-usama.anjum@collabora.com>
 <20220121145154.1795447-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121145154.1795447-2-usama.anjum@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 07:51:53PM +0500, Muhammad Usama Anjum wrote:
> UBSAN_BOUNDS and UBSAN_TRAP depend on UBSAN config option.
> merge_config.sh script generates following warnings if parent config
> doesn't have UBSAN config already enabled and UBSAN_BOUNDS/UBSAN_TRAP
> config options don't get added to the parent config.
> 
> Value requested for CONFIG_UBSAN_BOUNDS not in final .config
> Requested value:  CONFIG_UBSAN_BOUNDS=y
> Actual value:
> 
> Value requested for CONFIG_UBSAN_TRAP not in final .config
> Requested value:  CONFIG_UBSAN_TRAP=y
> Actual value:
> 
> Fix this by including UBSAN config.
> 
> Fixes: c75be56e35b2 ("lkdtm/bugs: Add ARRAY_BOUNDS to selftests")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
