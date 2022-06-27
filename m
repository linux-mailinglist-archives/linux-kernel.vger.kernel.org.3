Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4073855CBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiF0Ro4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbiF0Roy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:44:54 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845ADEEA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:44:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id be10so13823988oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v+dkrP2udNa9sOxtusDdTPKwT59IDya3j7lSRZunhgo=;
        b=hq0YjRdG9AhL2dAGsQRZXNGTdvU4mcLdbhoK6/QbH1g+a5rBIVlYtl9tqXCIkSN4U7
         gtiV3/f9XovWSBq7G2K/20G4aSKDGIAEMqx5wtUkiv9cyWQFtBf72eEAFyJs7jTlNHZQ
         VITvQB+1q0n+jtiPp7xYaVdO7JZ2APg24MQxs0ZeTqGMaGDwQCYywXfru6wL/haAQPy+
         EEHt0s7ggb3g21vp3p+IGbKiZ243SeRZandqU9a2nIooRpNeR++J0jsS02uulYlsX5dq
         bec4pW4+j4Zxz4vHNfKpFxciD8P/KaR+1qBhctFCb7IUiRQ1Rz2mHZqrXV5sgdpPiOim
         lofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+dkrP2udNa9sOxtusDdTPKwT59IDya3j7lSRZunhgo=;
        b=ajbYmmFP9jyoeuBaPcICt5+3iyL054qhcicQwbjZlb1Fd7PWvfawZpYPdVkvilYfT/
         FqOjFE3UO5Q1+Rmmd2ivS7iMfT0FvGCgIu0LPguL0TrR5+LrzzTNT9A23/CsnCtnoM8W
         shBOp6gZWXjsOyXmTMJw1TjM287+ypWWe4cbokPSOpVeqnakyzkkjjFPYQQNCy+Z9JPr
         AqlPHNfYmcLqDmkfkngDxLYOOQazB3NcQVGuN5LvcFWe6QiKZJa5JLbXRBRyJp1u6hwI
         Uk/nXFQVpr7QtpZ0RDBNPfJImQCMJQXYqRx7kPDyU+t8MEoO0ktMk4sdkGFSOCwF5Y1E
         Kv6Q==
X-Gm-Message-State: AJIora/dJOb6XAImqukEWK6jltGtXIQS1DuHzO9GChgUczdrR/VrKUdM
        lB1D5gRX/LWJED8i319CeHC1SQ==
X-Google-Smtp-Source: AGRyM1tcFw++OyIJoIgcqrFORwWhgAzwJoCx66v4j6E9ylGaKiz54nY3UYOhi5uhQbmV96+7sensEA==
X-Received: by 2002:aca:f03:0:b0:335:4760:d9c8 with SMTP id 3-20020aca0f03000000b003354760d9c8mr8262390oip.128.1656351889745;
        Mon, 27 Jun 2022 10:44:49 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id k19-20020a056870d39300b0010200e2828fsm7424768oag.30.2022.06.27.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:44:48 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:44:43 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] media: rkvdec: Disable H.264 error detection
Message-ID: <Yrnsi2lbtYEDgTEk@eze-laptop>
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
 <20220610125215.240539-2-nicolas.dufresne@collabora.com>
 <YqNzt9T9BaYu8tgb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqNzt9T9BaYu8tgb@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Fri, Jun 10, 2022 at 09:39:19AM -0700, Brian Norris wrote:
> On Fri, Jun 10, 2022 at 08:52:11AM -0400, Nicolas Dufresne wrote:
> > Quite often, the HW get stuck in error condition if a stream error
> > was detected. As documented, the HW should stop immediately and self
> > reset. There is likely a problem or a miss-understanding of the self
> > self reset mechanism, as unless we make a long pause, the next command
> > will then report an error even if there is no error in it.
> > 
> > Disabling error detection fixes the issue, and let the decoder continue
> > after an error. This patch is safe for backport into older kernels.
> > 
> > Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> 
> This is effectively how ChromeOS previously was using this hardware for
> years. When moving to the upstream/staging driver, this started giving
> us problems. This fix is helpful; we'd rather sacrifice error detection
> for now, to avoid hanging the hardware in error cases ;)
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Given this is stable material, looks like we should queue it,
while the rest of the series is still being discussed.

Thanks,
Ezequiel
