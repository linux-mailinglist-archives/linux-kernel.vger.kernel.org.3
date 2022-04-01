Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4A4EEBCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbiDAKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345198AbiDAKuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:50:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EC5DB2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:48:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso3288449wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oJkMxMbwxEJasoZlU3TxOexkvpR/xRpBOL5jB5OeKsI=;
        b=n6J4GKYqo32zfnvoBEflZ/pHPRtY5/OtPYELnVlZAGyiF3Op3VAwLta9DInyQbumcy
         2P0sIHx5NiFMJGl+on4wU9mXTHTXkM6e8u1g55Ukz8vuDIKup21ztoFxcOZhjHV5gxuo
         9/pSGfwyUEPhqcByQMj5KWTwrcAkYDsdarGgLVoEeKgZWtJQscJHipcCaQK8QVU0bMN7
         /5wtFoE1e+9VtnNlWEQ9JhE2FqrV4TGtuQj5GKzG++vKxtRbCHN6m/puu69+cOTVj6Hk
         JT21G45vA0HIw5ypHPFWvPM3M2cBzbGk4aGjx1CNIgL1BnwSrqk/NMORvkHJHFZyx61P
         Nf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oJkMxMbwxEJasoZlU3TxOexkvpR/xRpBOL5jB5OeKsI=;
        b=07UoFUBHWVA9Gm7S7n5iqPwo3SWUDSyNf+bdB0vxhBatyENQWWCA6yK7bmzpwxXGkV
         VmZ30SV9cRE2ZjJBUUsXTgcO0fldZem5BpgB69GUDetfA5B+mPEFRwSYXc6lXKr7swao
         bQcvZQq57TwwGvZamAwEO2msSV2PCZEcc+CD38GCbk1GAbwchVuNdix+ssP9wun4GRUQ
         dALIEq3cYTGK19VhxtAc+/MvxtmuyHmszaptW6+evzc6orAZBt2R2OXpJS1ai5WHyGIt
         HVbaq6YQBGSR1nYJ5emXBGSGetIBKl97yD0HRsPDIu/MMEGOkYfFBhIWJ+IsNBpyExy9
         aLGQ==
X-Gm-Message-State: AOAM530keqRsbDaAHLfF3+LCvCWsIV4G7k9089pqK/4nK4VbrToQAm+Z
        iO+aCSLWeifMy4sDLI6GdqI/RrMu2WkzSg==
X-Google-Smtp-Source: ABdhPJxNae5mtOUlcJ11V8CEEAmEBmIr/8nL58kA+6KZML9ebn7Mi62K14UfN7s2QyBaj6CiP7Da7Q==
X-Received: by 2002:a1c:4e02:0:b0:38c:8a10:e899 with SMTP id g2-20020a1c4e02000000b0038c8a10e899mr8210755wmh.125.1648810108632;
        Fri, 01 Apr 2022 03:48:28 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b0038cfb1a43d6sm1584746wmr.24.2022.04.01.03.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:48:28 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:48:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Create file descriptor after client
 is added to smi_clients list
Message-ID: <YkbYelifDo4zCf/x@google.com>
References: <20220401104451.1951544-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220401104451.1951544-1-lee.jones@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Apr 2022, Lee Jones wrote:

> This ensures userspace cannot prematurely clean-up the client before
> it is fully initialised which has been proven to cause issues in the
> past.
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> CAVEAT: This patch is completely untested
>         I can't seem to find a configuration strategy to compile test this
>         allyesconfig and allmodconfig do not appear sufficient
> 
> v2: Also remove Client from RCU list in error path
> 
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 24 +++++++++++++--------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Please ignore this re-submission, script error.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
