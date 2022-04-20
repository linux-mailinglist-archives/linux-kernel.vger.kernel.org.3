Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778675089B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379157AbiDTNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376677AbiDTNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:49:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5123BBD7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:46:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x80so1994216pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q6jrkZFlCbwn0WTvEVs0btNJ3ts6C00LvQRtxh2AOjE=;
        b=DPZDNn9sPB8FUXiCbQR8I5Tb2hCJdcWYPSTUnivCRb+iBRy5aKJvOxdYXzwyAbyuw+
         q2xTmlz38+4CW7dNvBdxku+UmYgu/sJtNfsoVCgjPjHm/pOs80TmckFLvB/DRQv++AIQ
         tKLB1JkYGNVSE1vEVAqroOsTo/aCdpuaCtDzDKp+e4mUHQqm71wNu8+HoC4c3/BvonoK
         uQIDV0XYEmM3jalKUW7A2S8fZDA9uUQBMt8Jk1WLAaLO7zrpfm7PNDiifZ+pq1oTSuaa
         XJN2utWzmD/F5BdJGqFxaB+cONpwsWUIjBjla1dakkFxCNWpiH1MWjWK0fyYUxMLt5Ma
         T4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q6jrkZFlCbwn0WTvEVs0btNJ3ts6C00LvQRtxh2AOjE=;
        b=2XWsTS9jSAMaJxWYHgP4dYldFVK3Z3ukAqKqJsw+IZ2jNvlR7odwTy6dptMT7TWGqy
         PCh2B61ktcmENwMSbxFyaK4nMth9nAWBPsil3EOh7zvFnqIqoGfK371d9+dfvsaFwgu5
         rt6lf6ShdVDO0+pCUqSBu8D+/hyH2JHR0VAMrw7/GJfFDgEjIkBUbnCVr+fNVnfM946y
         8qpCIDMFx6HIubOEo7CQOFPSwITWEsXCmBUQUXUroIaTFkrG+5DmT+uOpaUwIDdyfU8o
         VFZ01fR+H8lccLMg90DrO+q8e/qeOyQGrF5bv8e0OyJpdvADyo7sDKx/ztljNb2NL0/H
         /4SA==
X-Gm-Message-State: AOAM530flc/PjXsPp6SZ1sqmyXgOdB+KKqr8pB4Kk3o3HI0lDGM3f3tu
        u3AW4GgNg/m6G5I3hkfL2QU=
X-Google-Smtp-Source: ABdhPJyvRpVgkmJHIJdX4ski3xEdOk/1vExt5dfNhj+zxHR/wDP4IVTdMND8YtovToQ0YOxhDZTipw==
X-Received: by 2002:a63:2d4:0:b0:3aa:7a8b:25ba with SMTP id 203-20020a6302d4000000b003aa7a8b25bamr969322pgc.251.1650462407068;
        Wed, 20 Apr 2022 06:46:47 -0700 (PDT)
Received: from [172.16.10.243] ([106.39.150.10])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b004fe3d6c1731sm20222786pfo.175.2022.04.20.06.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 06:46:46 -0700 (PDT)
Message-ID: <7d99fb81-d799-8785-8fe4-44772e26408a@gmail.com>
Date:   Wed, 20 Apr 2022 21:45:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <Yh90u+E3RTuGEDWU@sirena.org.uk>
 <20220420021855.8224-1-linmq006@gmail.com> <YmAD6MIuKdjgm7Yu@sirena.org.uk>
 <4e3309d9-879f-3385-3e8e-0fa1a31ddd9a@gmail.com>
 <YmANgcO9BMxp8PLC@sirena.org.uk>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <YmANgcO9BMxp8PLC@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/20 21:41, Mark Brown wrote:
> On Wed, Apr 20, 2022 at 09:35:55PM +0800, Miaoqian Lin wrote:
>> On 2022/4/20 21:00, Mark Brown wrote:
>>>> - rebase on top of commit 559089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP")
>>> Why rebase on top of that seemingly random commit?  Is there some sort
>>> of dependency here?
>> Hi, it the head of master in when I made this patch. It's because you pointed out
>> that patch v1 doesn't apply against current code. But I am not sure what's the problem.
>> So I ensure the codebase is up-to-date. If this patch have no conflict, you can ignore it.
> Current code here is my git tree (-next is often a fair approximation) -
> if people have been making changes since the merge window then often
> code written against mainline won't apply and things need to be based on
> people's current work.  You're looking for
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

I get it, thanks for your kindly reminder.

