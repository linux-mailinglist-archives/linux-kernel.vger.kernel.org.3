Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592804C8572
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiCAHtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiCAHtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:49:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D811C23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:48:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w3so20794288edu.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MnJLyK92wo1ianqqQrVmdLoec7cz9whmMUPEVRDu+oA=;
        b=CVaydF1H4XMdJDb1BVhWeAbLrkhb9uB/9ed31/P7uXF7fh/h34wU1g/MGHbhXoqq/x
         PlAA6ghBwhXkZz0+3VrZ5uw8cR7wUALpb3C1CE2aTbH7ymko5+P3tfVdexz15pSjAe8l
         47p28EUON+tDvymCauYnqyXsxHAAZpOOtW8m+9sos3qbT0ZULSdl3B2T0VP2mojFGfJP
         annWU+NbHk+NTBi5VKQ+btY6oC2k6BUdsouzaNAwklrdOGy7DM3k2xiDHropzjZFGyzj
         lJagdy3GeyFFJSAOggSBegP3gf/wrRzBZPpB1KdALfoSnYN8CAESli6mBQgCF+Uq482n
         iQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MnJLyK92wo1ianqqQrVmdLoec7cz9whmMUPEVRDu+oA=;
        b=w4HQj3ItrjXK1OmUmPDBT0HxY30oxoN8ef5C0Ggze8e6P3P7UgdKEsAwsgO7ei4kiJ
         oe/P6ed3nDkUvoyInOaSeLDoXrkVd+WO3EQm1EwLkRPJahNdEs9sMMsNhSj4FH0ohQ2k
         nuXU2c+kXCIjQFmze4qSHEvYhBPJfzesJ8sxecc46pj22HPCbumNZf3hwR08l5dqNIab
         4HvtAfqTzee4hMwW5k6OHDYIxxKJVxVMNWtto0v3P4f8c+TTtkOlPvaAXV5HBYmVNhd8
         n2kkTpBV1Fv8W1oIqtWW3R0d57ShXZljNqG2x5ZLhjbu0U+mOw5hNmdWMMz3w/461Zs5
         jcfA==
X-Gm-Message-State: AOAM530mIefZ5n5I8+sAhEpXXJxWc/aUlnHK01DYIJ0kJioC1CPO0Wc9
        kZUzPRlijE/6QKP2TNvkZPQ=
X-Google-Smtp-Source: ABdhPJxSZWuYz9uwbnnp09wf9QrW8XIJMOh8VgkpQ43KaO8e9NlZYPo3jPs4kTe8Z1mnpOegt8/XsA==
X-Received: by 2002:a05:6402:2065:b0:407:eb07:740 with SMTP id bd5-20020a056402206500b00407eb070740mr22917504edb.406.1646120897282;
        Mon, 28 Feb 2022 23:48:17 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
        by smtp.gmail.com with ESMTPSA id eo8-20020a1709069b0800b006ce6eef6836sm5045690ejc.131.2022.02.28.23.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:48:16 -0800 (PST)
Message-ID: <b87fb8ff-a427-491b-5a5e-3b401e1de462@gmail.com>
Date:   Tue, 1 Mar 2022 08:48:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: fix suspend/resume hang regression
Content-Language: en-US
To:     Qiang Yu <qiang.yu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220301062655.232955-1-qiang.yu@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220301062655.232955-1-qiang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.03.22 um 07:26 schrieb Qiang Yu:
> Regression has been reported that suspend/resume may hang with
> the previous vm ready check commit:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1915#note_1278198
>
> So bring back the evicted list check as a temp fix.
>
> Fixes: cc8dd2cc1a97 ("drm/amdgpu: check vm ready by amdgpu_vm->evicting flag")
> Signed-off-by: Qiang Yu <qiang.yu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2cd9f1a2e5fa..fc4563cf2828 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -779,7 +779,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	amdgpu_vm_eviction_lock(vm);
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
> -	return ret;
> +
> +	return ret && list_empty(&vm->evicted);
>   }
>   
>   /**

