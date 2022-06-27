Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF0A55C3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiF0IEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiF0IEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:04:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21A60D8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:04:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f190so4587264wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0FVLPiv4NDiiBhwt5cYTrJXFCY1RC0UN/Up924t8JTQ=;
        b=uaRtBKPp+icGnxfXPVREzbW2Yspl6xh4bieDYDPsmc2lcM7NQ2VdShDqFZhS+lhE81
         2v8FC6UbCn2Mcl+OR+1FAdmyK9ns8TaP1jSArfWjkRCHmt1crs+cmTyTvK8Bja2wZC+N
         x9WlNaro/CpetZtunkOCACDA0f03npEgkUONk4aXDutlWMwEhG5PNL+7A3MqP+wb+ZsV
         s8y1fT1JXdKkpBj5KY4A3KZwV7lyO0TipD0MD68koZjftVYSUnqYibXmA+z7JuOs6phv
         jSSQzbqQwRAl7KNK20nId3achcH8t4AztkzMRd1jWKYu1ru3lIUKkdHgu3K1z0nloksl
         S/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0FVLPiv4NDiiBhwt5cYTrJXFCY1RC0UN/Up924t8JTQ=;
        b=p114iNXWxPvKN2EpsBAfiu7O20hLH3eY1RGeJioM61kyt16sj0/ZtIHVbjnhafYHqe
         1HUzmm7NDmn/b5OGXVZalt4YR3+H9NbUsfD5IpAMkTQpfpMV3qXEYwsML4syUhZnwKFx
         5bNI28pFzwg9GwGZorrfarL/2Uc4fCiXYV96bkW5rH4s2N8fAu5LUGCE5t3AulhIHoIJ
         d6KHtx54S5rS9nedby4Qw9v8PNDY6yH1RsM34l/J1kPtY1U13eoSQ9fJEW8lL6SUluGp
         9S2/8HhI4BGAEQwfMFUfWea8Tx6tq0gTl4Z6vbGWcp1MiLj49K1QpS+fUBkkBcW0TXke
         LThA==
X-Gm-Message-State: AJIora9f8TTYz+zH6m1zfSpLKZdbPMNQSljWUw35gMmBm97K8tA1jUNN
        HN5zHMUF/Qj8i3ctAwhLT0a7mw==
X-Google-Smtp-Source: AGRyM1uRpyMQGBUWRWwf72yyMy9bCFJHaoehnqnL2BK5L2HssOuVrI5PbTuruSiBPLHUjk2sd2wJTw==
X-Received: by 2002:a05:600c:2651:b0:3a0:4624:b781 with SMTP id 17-20020a05600c265100b003a04624b781mr8507964wmy.15.1656317042866;
        Mon, 27 Jun 2022 01:04:02 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t8-20020adfdc08000000b0021350f7b22esm9613717wri.109.2022.06.27.01.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:04:02 -0700 (PDT)
Date:   Mon, 27 Jun 2022 09:04:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, yilun.xu@intel.com,
        hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v3 1/3] mfd: intel-m10-bmc: rename the local variables
Message-ID: <YrlkcCdYVz8Yri+j@google.com>
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
 <20220624092229.45854-2-tianfei.zhang@intel.com>
 <e6e5547e-d4d4-03a5-43cd-90922f9d1959@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6e5547e-d4d4-03a5-43cd-90922f9d1959@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022, Tom Rix wrote:

> 
> On 6/24/22 2:22 AM, Tianfei Zhang wrote:
> > It had better use ddata for local variables which
> > directly interacts with dev_get_drvdata()/dev_set_drvdata().
> 
> This is a cleanup, not related to the patchset, it should be split from the
> patchset.

So long as they're contained in their own patch, clean-ups are fine.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
