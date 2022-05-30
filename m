Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F715388AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbiE3Vtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiE3Vte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:49:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F8B52E7F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:49:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id l82so12037188qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXaOVjxu9BRXioIvJGUPeph15IZ7f+RIDq16BIHjmoA=;
        b=MXfdGkwALQnjWH6rK/1fSXDcuWOUo9C8ZG2sO9wNr+MKKvRiwjciQ+mEp7fq6ZKKqa
         JiGwltb6kFwr13ASse+qgNwZCbfGcmKHJxoZLefcqsu1qhJfmzrT1+t8yJM+/YPxJx1M
         kXIQUt3oIqyISHEgwiqR1EqnwC3doPe+j9SbWXoAY3vW7WOYYGQhvNJ3FSrlS9jkb/5+
         XGOKTUgJnkooU8bIUvkgV0Zibj2hN4HTtvYI4YTKbQKaRDEEPGsM8LqZWUzpVTR8WBOz
         sMEvIlx182Rg3pXShcGXIvjgCMGFOqWUkCtm2qDhMz6tOKceqZEPvRXb6fxxhjEI4q0E
         N0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXaOVjxu9BRXioIvJGUPeph15IZ7f+RIDq16BIHjmoA=;
        b=23ppEoTeENuGcbZrFpPmzyZGO9vrwjTqtCL+5bwCaqYZmpKnNFWFL/FlAdHr0jpbhB
         BwWn5+qX+YCTpSHzgFzRullBZukXVsa4q+uMCnwbA8i87K+RqCBrryRqpaN33JNQI4qd
         b960NFqt8ylRicvxwGqwGurA1ieuGy+9U3l/xY/ayAs8nWepbUKNDrZwTS0JDQxbSA5C
         uvZIbMsuKUBBkRJRaSeVfdnf1cJ4X16+mqlA6ZNwfQy2L7lEXMTHQah7he6lnQsjIxV5
         XddBd9wrs1rfkvnf1YyRfLHK12YzzAbXJPe6vy7IabUNGME4RnYlm41noB0IKzkvzIgr
         uMRg==
X-Gm-Message-State: AOAM532PbwE4cZpwca+0Kovwp54+gVfx7U481OY1CNxV5lB0unIgnn/r
        e+XsyuFBQrdk+fAJD3shePk+2cfmdAcKf/KWlVwmFw==
X-Google-Smtp-Source: ABdhPJzh9WsdzR5//egtXV1XikapFrTINZPmX4fFRgsjAj4mQhfoLHQ1FXuKd2ZeCPj/PcYntJhO1dwhQVQuvS6qnJQ=
X-Received: by 2002:a05:620a:414e:b0:6a5:8dec:57bb with SMTP id
 k14-20020a05620a414e00b006a58dec57bbmr21169409qko.30.1653947372228; Mon, 30
 May 2022 14:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1653896005-25168-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1653896005-25168-1-git-send-email-baihaowen@meizu.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 31 May 2022 00:49:21 +0300
Message-ID: <CAA8EJpoA2VOO28tzT24fzYseFg__thXHcuXHiXGX-pwxGNz8HQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix pointer dereferenced before checking
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A nit: patchwork thinks that two patches from the same author with the
same subject are two versions of the same patch. In future, could you
please send such patches with distinct names? No need to send v2 now
unless review shows other issues with the patches.

On Mon, 30 May 2022 at 10:33, Haowen Bai <baihaowen@meizu.com> wrote:
>
> The ctx->hw is dereferencing before null checking, so move
> it after checking.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
