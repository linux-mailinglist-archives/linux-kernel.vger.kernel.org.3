Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722ED4EDF73
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiCaRRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiCaRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:17:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3145B7F7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:15:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a1so682174wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X2OXV90aO+ODMFfuSOMa4DDXkG0Jjwo9L8KTnXeA4Kk=;
        b=PqBZtpUPmhfAj1raRjgQALlfKWfXQPEXvq3x7gojRbU6+/VShr/zvJvItrBKZpXbLd
         dBpxrF/b4HTeg8y9AT6zJ81ItjH5NSGldowXm//os/Db0ZpIaTwQ74Q6I8WLdltnV3Vd
         M6e+NQhaVjl6rquODd2VNjTIdnwzz/2hTY46ZISGHX3BL+LoPs1/kZS8XtxFG82kjTg7
         zhs7dTMqfI8vDYTIMPL3q03M+OGdh8HoJYU1LpwHfanHUCYq0PVpurqAMHeq99QiFUoe
         4BgeSdT9ZoIaU9nevG92ViaO6GU1mTxXBzxr+MIZWmf93EfSEbb/NhA5I1Kg+djEa82k
         rgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X2OXV90aO+ODMFfuSOMa4DDXkG0Jjwo9L8KTnXeA4Kk=;
        b=Mtgfuy9OPn+K28io9pVEKZHd4szZDzph2cVT1UnabVedyikjDhHHCtI+ssHZL+jDMh
         j+eFyaM6KQrGr0OiKQfTxeRsDpX+OrDX1b9hMja9nnyc7a9qQ4nxGrlRfTIIPRyWmM8D
         2OG64B+NOUJTV0iRPIwJn7Ipfavb9dvGA+2a0HX2nreZczNZRqbuE1kP6APAaxfjjnpd
         rmo+ZbcNtxLJKUzgoGhb2c4NzXenI/zwfs8rDX95gyHdttUx4OP5HJ0YKRUjYxlQ0zRu
         OAuHp5tEk+bYKtM9drlP0Yz5A1dUooS0SghVTV/Pv5w8atgCPAugb0px9jLxMbC5Vo+y
         Nxww==
X-Gm-Message-State: AOAM533vDtEucWRTTN66dUv2JvcR5jHIikLFK6ZxIJrObM5BL9zhHGfj
        CufmtI1e2GXsvR5EXenzfyndCw==
X-Google-Smtp-Source: ABdhPJz2ULczMysarpVs35MfQnPspUQoA02V0ccHg5zENWursAdxOTaN4Q79HUBEnAhpNjkSCP3GpQ==
X-Received: by 2002:a05:6000:1545:b0:205:a82d:8007 with SMTP id 5-20020a056000154500b00205a82d8007mr4987338wry.88.1648746926278;
        Thu, 31 Mar 2022 10:15:26 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b0038cfb1a43d6sm7968863wmr.24.2022.03.31.10.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:15:25 -0700 (PDT)
Date:   Thu, 31 Mar 2022 18:15:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Create file descriptor after client
 is added to smi_clients list
Message-ID: <YkXhq/APK44/hpvX@google.com>
References: <20220331122117.1538913-1-lee.jones@linaro.org>
 <f38e4782-1959-d1f3-e8d7-f60e199514e3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f38e4782-1959-d1f3-e8d7-f60e199514e3@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022, Felix Kuehling wrote:

> 
> Am 2022-03-31 um 08:21 schrieb Lee Jones:
> > This ensures userspace cannot prematurely clean-up the client before
> > it is fully initialised which has been proven to cause issues in the
> > past.
> > 
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> I will apply to patch to amd-staging-drm-next.
> 
> > ---
> > 
> > CAVEAT: This patch is completely untested
> >          I can't seem to find a configuration strategy to compile test this
> >          allyesconfig and allmodconfig do not appear sufficient
> 
> That's very strange. It should get compiled if CONFIG_HSA_AMD is
> enabled.

Okay, I figured it out.

Apparently you can't give 'drivers/gpu/drm/amd' as a build param.

'drivers/gpu/drm' works as I expect however.

> I will at least compile-test it before I submit.

Great, thank you.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
