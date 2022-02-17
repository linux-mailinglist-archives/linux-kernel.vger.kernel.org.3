Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1134BA5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243031AbiBQQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:22:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiBQQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:22:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FC162032;
        Thu, 17 Feb 2022 08:21:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gb39so8565308ejc.1;
        Thu, 17 Feb 2022 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DForfRnLwwnXduWv7pqOZNccFubmVw5bTqYdaZSmmMw=;
        b=Pb/AzPxSe22ghqMXbZYpZ5d+l2fDgDw3kNatdzvkFxy1fF4TmxetKp2MQIZIbo1zNX
         4YdvI0Lnd5YKvDRdrdwMW4S3YA/ntdNcQcqxphljojhS5nSiSECdGeran97F0wdpV760
         vAc2lJiPApvKXL4CM223ACwHfEpX0k6mLwwYAMHptQfLA6WyGEAaU/Yf+Q/E/lSFmffU
         LfrLQ/XxlsZR8m6SRQBgOULLYW5n56nEm2cpl3nK0+Vq/PFUirvBbuYusI6CN2aZXlHq
         6bS3/AC2XKz20pcRHgywtAihlk9f7auVCI5g9R5KRow+HgjpiR7Y2FW7Re26Wi5UaqKS
         UjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DForfRnLwwnXduWv7pqOZNccFubmVw5bTqYdaZSmmMw=;
        b=UIxxQF2OZO9t6KArXXQVv7/aLaBEPhXe8sZ25xSjScaPtCDdbICCTh5YenDVgIpR+4
         YN9kjqeLQkphmjtxVo9ndHFs8NpKljbdFLJr+YEH09zJgrte4DOaZzRpQRlpFZCjtkgI
         urzayt+kzyWPbsZCrcqgBPIoism1pSqwoRTfAP9aKMrd3npasQtq2Sv0yBzmIHwWJ7t7
         cW4OkJU6P9DzjLZKUZOsc+xejvjwmLN4bicbEW2EEyjuB/r7hIldXeOON357g3ZOb1Cx
         j+GL5RfPxPCptvWPQ4eZad20s47ums6Y9U0jRt9v7oezUICBU/yFoWg6H9AmiBY379OB
         g9Vw==
X-Gm-Message-State: AOAM531GsjFolR1R0xkBAwjkuotYn7fHVkKybDlTmwxNJi11SUv2X0/U
        RxgHaA117zL9eB2Ss5kZYlg=
X-Google-Smtp-Source: ABdhPJyjU5pLyn9ipTJJsTm1EuSFYs/qledmzIu5jwnqn3cnCeqYY1Wn4HRuKjvE5OKo1D4DI7lHcw==
X-Received: by 2002:a17:907:3c7:b0:6cf:8e46:617c with SMTP id su7-20020a17090703c700b006cf8e46617cmr2883137ejb.557.1645114913546;
        Thu, 17 Feb 2022 08:21:53 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id l12sm1303112edt.1.2022.02.17.08.21.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 08:21:53 -0800 (PST)
Subject: Re: [PATCH 0/3] drm: omapdrm: Fix excessive GEM buffers DMM/CMA usage
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, tomba@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <be4e1cd8-a994-303d-9424-14439ce1f7d4@ideasonboard.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <47dbc690-bff2-8839-f01f-9287403a7562@gmail.com>
Date:   Thu, 17 Feb 2022 18:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <be4e1cd8-a994-303d-9424-14439ce1f7d4@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 17.02.22 г. 15:03 ч., Tomi Valkeinen wrote:
> Hi Ivaylo,
> 
> On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
>> This patch series fixes excessive DMM or CMA usage of GEM buffers 
>> leading to
>> various runtime allocation failures. The series enables daily usage of 
>> devices
>> without exausting limited resources like CMA or DMM space if GPU 
>> rendering is
>> needed.
>>
>> The first patch doesn't bring any functional changes, it just moves some
>> TILER/DMM related code to a separate function, to simplify the review 
>> of the
>> next two patches.
>>
>> The second patch allows off-CPU rendering to non-scanout buffers. 
>> Without that
>> patch, it is basically impossible to use the driver allocated GEM 
>> buffers on
>> OMAP3 for anything else but a basic CPU rendered examples as if we 
>> want GPU
>> rendering, we must allocate buffers as scanout buffers, which are CMA 
>> allocated.
>> CMA soon gets fragmented and we start seeing allocation failures. Such 
>> failres
>> in Xorg cannot be handeled gracefully, so the system is basically 
>> unusable.
>>
>> Third patch fixes similar issue on OMAP4/5, where DMM/TILER spaces get
>> fragmented with time, leading to allocation failures.
> 
> I think this is just hacking around the problem. The problem is that 
> omapdrm is being used by some as a generic buffer allocator. Those users 

Well, the user of omap_bo interface I know is xf86-video-omap. Unless if 
by users you mean 'kernel users' which I know none.

I think that if 'we' are to teach xorg omap DDX (or any other user in 
that regard) to use GPU driver allocator for non-scanout buffers and 
omapdrm for scanout, it will become a mess. Not impossible though, just 
way more complicated than the $series. Also, why do omapdrm allow 
allocation of non-linear buffers and CPU (userspace) access to them, but 
refuses to export them to kernel drivers? Isn't that the whole point of 
DMABUF stuff? This is not consistent to me. The series fixes that 
inconsistency, nothing more.

> should be changed to use a their own allocator or a generic allocator. 

SGX driver/userspace has and uses its own allocator, however, I think 
there is more than that - what about TILER/VRFB? Do you say that SGX 
userspace shall be smart enough to requests TILER buffers from omapdrm 
when scanout buffer is requested and use its own allocator when not?

Actually I was thinking about something like that, and it is achievable 
now we have:

https://github.com/maemo-leste/sgx-ddk-um/blob/master/dbm/dbm.c (REed 
SGX 1.17 ddk gbm backend)

> And we could then drop the OMAP_BO_SCANOUT flag, as all buffers would be 
> scanout buffers.
> 

And what about OMAP_BO_TILED_XX stuff? To me this is even more of a 
hack, but it is what it is.

Do I get it correctly that you want to get rid of omap_bo_new/_tiled and 
have only dumb buffers available in omapdrm? TBH this would be great, 
however I still don't see how a TILER/VRFB buffer would be allocated, 
given that flags in drm_mode_create_dumb is not used anywhere in the 
kernel(AFAIK). Unless all scanout buffers are allocated through 
TILER/VRFB (which is a good idea IMO).

> Or do we have a regression in the driver? My understanding is that this 
> has never really worked.
> 

There are couple of patches in omapdrm that change around BO flags and 
their meaning so I think there is a regression, as the same 
userspace/DDX on linux 5.9 results in only 2 linear buffers being 
allocated, but as SGX driver has different version as well, I can't be 
100% sure without going through a lengthy assessment of SGX 
driver/omapdrm code and patches since 5.9. Which I am not going to do as 
I don't see what the benefit will be.

Please consider this patch series as a fix to an inconsistency, as it is 
merely that, it does not really bring any new functionality in terms of 
what is allocated.

Thanks and regards,
Ivo
