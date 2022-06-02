Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F087D53B181
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiFBCFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiFBCF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:05:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6B1BC08
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:05:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id u4so535514pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=URF0KJqcnQJdafYkmvxoqi27tjApzf9mIKrv77oxeQo=;
        b=HWmRbjlLQ1At9RTtfbPnIPFy0hNqycG0lZrF5Ak3Q8KUkiDskbb/KLuehLJU5avohJ
         2p/OABhcbIbLJdV+CMAiuBhLA+Ch9qTwHloA0p6mTIibuELCUQ52Xl3ZSaljSTWuELY6
         dmp+zoDPUJLlPQJyp4fIjWHBwIBIDClveK8BJpCnO/Op4Vt7jQ8Qh2Nz6Pxc6/CWUXmC
         4pzg3qbAyFSzi7oINSo85H8buI8nAH47PBAtoJdGbsqzs670sJJAy0c3pOmtIgVtd/yy
         7upHoZiA8/RsTkTLvpXPQzEmdK8+8LzVX2yPaTdv2pc1quLQ9/Ff4seFydguwHsam9fn
         qjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=URF0KJqcnQJdafYkmvxoqi27tjApzf9mIKrv77oxeQo=;
        b=W+o8syfNnHR3GrmCQ8YZitZjPBbjnfOprPpJbWKACKVr5/zpHR8H5ASfKjoGiaI007
         /y0kw0+eBG5mzIuJgVuVF/nppzbfUDfk9XlFKvIPHmiNDjKbRXUut7JSQsUpvS49ct2r
         CJ2ywLjDc3MxCIJvFooyixgxO3qFCUfLOdp0GO1+EKXaiU9MfANYlSYhy3Jw6krfm5+k
         MqmXTyaysuiVVZ8LaQormd/cTuft4nZiuFvC/40w8WUfvvkEH/9rfU3vbaGu4y07OLTv
         SN+Ah6dwx0YxPxMEK0K1RRwmw0W8QzHeWfUX4OJccnT6gFrhNKlsT1R8xEsUzUxkJq7s
         M5rA==
X-Gm-Message-State: AOAM532DBJndJQz+mXpTgimTSDAjmZYO9CS6CJEAokBn0j+Tw9Iv/J+Y
        Lt7EwBoOh7oXyiwXjqL6RAY=
X-Google-Smtp-Source: ABdhPJwQEE3C13gQMFEFQ5DJFjmLka2jZUHIOR9JwKjObBQkkgDiO/DDLTm3pxoQH3/DS7QZ8dty2g==
X-Received: by 2002:a63:104a:0:b0:3fa:d1ea:54d7 with SMTP id 10-20020a63104a000000b003fad1ea54d7mr2081134pgq.124.1654135528265;
        Wed, 01 Jun 2022 19:05:28 -0700 (PDT)
Received: from [172.16.4.4] ([219.142.146.177])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090a740c00b001e2b19e6cfesm4613629pjg.12.2022.06.01.19.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 19:05:27 -0700 (PDT)
Message-ID: <59ea53d6-2856-fedd-3a5e-6ad5bdcd4a20@gmail.com>
Date:   Thu, 2 Jun 2022 10:05:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] drm/v3d/v3d_drv: Fix PM disable depth imbalance
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220601122050.1822-1-linmq006@gmail.com>
 <YpdpCWW9+igsVydr@phenom.ffwll.local>
 <55d99105-8492-e020-bed6-82e52b5fc8a1@gmail.com> <Ypd76wmrBsIgeE3O@orome>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <Ypd76wmrBsIgeE3O@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thierry

On 2022/6/1 22:47, Thierry Reding wrote:
> On Wed, Jun 01, 2022 at 09:55:02PM +0800, Miaoqian Lin wrote:
>> Hi, Daniel
>>
>> On 2022/6/1 21:26, Daniel Vetter wrote:
>>> On Wed, Jun 01, 2022 at 04:20:50PM +0400, Miaoqian Lin wrote:
>>>> The pm_runtime_enable will increase power disable depth.
>>>> If the probe fails, we should use pm_runtime_disable() to balance
>>>> pm_runtime_enable().
>>>> Also call disable function in remove function.
>>>>
>>>> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
>>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>>>> ---
>>>> Changes in v3:
>>>> - call pm_runtime_disable() in v3d_platform_drm_remove
>>>> - update commit message
>>>>
>>>> Changes in v2
>>>> - put pm_runtime_disable before dma_free_wc
>>>> - rename dma_free to pm_disable
>>>>
>>>> v1: https://lore.kernel.org/r/20220105120442.14418-1-linmq006@gmail.com
>>>> v2: https://lore.kernel.org/r/20220106124657.32737-1-linmq006@gmail.com
>>> Maybe a bit late since we're at v3 already, but are there no devm_
>>> functions here that would dtrt automatically? 
>> Sorry I don't see one, or we can use devm_add_action_or_reset() to add handling
>>
>> action. something like disp_cc_sm8250_probe() in drivers/clk/qcom/dispcc-sm8250.c
>>
>> How do you think?
> Looks like there's a devm_pm_runtime_enable() helper that does exactly
> that. See commit b3636a3a2c51 ("PM: runtime: add devm_pm_runtime_enable
> helper"). I haven't seen any large janitorial series yet for that, so
> perhaps it's just not widely known yet.

Great, very helpful. Thanks for your kind reminder.

> Thierry
