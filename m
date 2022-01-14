Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E0348F24D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiANWOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiANWOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:14:48 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:14:47 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id g205so14174268oif.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYV16qevHj4p7hlLpZ6J16ZgY/GOnmPRNbn5bSOrpF0=;
        b=pXObq9jNXB+xl5VNQoXixXjnKJNMmmzf2mRCw0cf9PNS8h0QeZ7tJ/kNZzfS91pgMl
         6gTRVKWjU+c0fEf/lq+17cIotcYHE8+Xuulz05CJrjEBkrJV6fmdb8mn4xODwMPGwTFd
         BYpfifWCARc11AxRieTkORSa0DMh0H4HeRVdhyUSfSbPpQhnGLuuXUzY6KPnXvywFnoY
         0/TBF6ub0df1eApPgahG8OXVpjKQKa6lgmXAYl+PqdL/r3h5Bgz7oxhscqNlooh9qTH6
         O63vC5IG9MyhhOd7tv2Htr1lNnfgvkzGgN7AzuZyqLlJGirKwjHsgKQHQG3te6FluhhR
         MRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYV16qevHj4p7hlLpZ6J16ZgY/GOnmPRNbn5bSOrpF0=;
        b=s4OLLmJDJm8jBU6rbbmPHLF/fsP0MB04Lk2sbrEFRQESBppEKMfZG5GEt1Q26mQacn
         YPlKbiY5zLnQJvIfKhJnZIRpjco9rpiruM9L3qCPxKA9BNkI3s1zd6wgVyxvz6ZiUlPB
         Bp58iwnjWkiKdrhTxDffHnpMu3gL/gwttYVZwDUWYpmhjAickl/j8DvRT+PWDxq0sMYK
         +lVs84dLCaqh/Cm8fanTkY7oQDzNiGgNKZaI8ThypJl7GDPAY2XLTBmnlrvoLu8SxL9i
         an2wbxk3w7agDq69diZg4RlUWZJodLU2ogWDCUrIlE84PwhRESLTpIqd7s2zccG2x3sb
         OCOg==
X-Gm-Message-State: AOAM531GXMgZ86DQlh0wzWD32D2uJWQxYD/dxoskLRcekjlDGivUwkeK
        B5oT/j9DPU1eaRrA4bU6ITqn0/xcxCyHoqahyVE=
X-Google-Smtp-Source: ABdhPJweLPMcJclJfI9XNTVbnCxnkVCqxmj1qpkgHZgEpoFuH5bUKIeSNZUwzGC93g5CmQrRMDb859fmSpKl25OLqJQ=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr14120373oig.5.1642198487405;
 Fri, 14 Jan 2022 14:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20220114092036.766001-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220114092036.766001-1-deng.changcheng@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 14 Jan 2022 17:14:36 -0500
Message-ID: <CADnq5_P_MOsTOoRWfe95pvJ9SR6FzfcP3Un6cy9_9WB2Nv-UxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Replace one-element array with flexible-array member
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>, Dave Airlie <airlied@linux.ie>,
        Zeal Robot <zealci@zte.com.cn>,
        xinhui pan <Xinhui.Pan@amd.com>, deng.changcheng@zte.com.cn,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Fri, Jan 14, 2022 at 4:20 AM <cgel.zte@gmail.com> wrote:
>
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members" for these cases. The older
> style of one-element or zero-length arrays should no longer be used.
> Reference:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> index eb0f79f9c876..701aae598b58 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
> @@ -121,7 +121,7 @@ typedef struct SMU_Task SMU_Task;
>
>  struct TOC {
>      uint8_t JobList[NUM_JOBLIST_ENTRIES];
> -    SMU_Task tasks[1];
> +    SMU_Task tasks[];
>  };
>
>  // META DATA COMMAND Definitions
> --
> 2.25.1
>
