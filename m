Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC03B55DBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiF0NEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiF0NET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:04:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B770D127
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:03:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l68so338583wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L882Qi37qgymZbCBpAO6lxX5xZGhjw0/8e7sf/riPRY=;
        b=OElTWkNKtpQqellzrB9QTjaZMqFULrJ39h9Zuvrnv7fHYbC3K0Y/+k0chZnnyhITKQ
         q1Su1dm4C80yP0/DawYBoUfBR7TBBmXa45RHeDIgpMSOE77KVjqmze4UPVzTG+qxNiPM
         J6CsKfyuMQiawUJTjLzj96gcA//6DI431ZmytVuyp62KBtff1VIVyd9FlpzNRwDGAf5u
         peruN5j3nDCK9cmfE51P7D8qnU4bCMuU8V+2Nfgod7QNK8R4VtUxm/MJPVr2sRTwTf5s
         +rSE9TjeI/BlHBUf1irvcf4dIipxvGz2tKJ6xQ7c7Z/foj0NgdV7yRP/ozHTPBaA8ssP
         blIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L882Qi37qgymZbCBpAO6lxX5xZGhjw0/8e7sf/riPRY=;
        b=SZlKh71iAY09rz4te2pZ+pM4DgGQSFIbC3aIvik+QrNgPN0a3DnGRuU89TizyCNBU5
         HbIZ8WDpu7qssiUTG5b3xsDj485gA2xjAVCPI0GAWgVWh7uxdRrtzG76Kz3FOhaP0NWc
         VpjfCsgq/u/MYNi1U4r1oqqoW9V8K+4JF4Q7lYUoIb6IjOEG360DvrJO8O4xCCn9Q9Pr
         mVUMGZqRlebdoflDz0jDWcfnDzQ17W276YinTM3HeZfUPmXoBfGTTLtaEin6u6Bq1omG
         bl7l2AcsM3OLHPHxRVCirowW2V8M3KKUOr3XrLz9/4KkAZHh6IAqAep7x+qQwjasInPG
         8bxQ==
X-Gm-Message-State: AJIora/qa2qQASDZhHj9mbdGUXg1WYeI1Yy/2Aq1u0+3gSxMMFdYPdBB
        CUVubbzOXoccQTMvje11qwUa6Q==
X-Google-Smtp-Source: AGRyM1suF2dPiURcmGK9WbFjLgebYglBZizVQFOYmypHt4B+qJRtY4JFvr8wTuDBORu+tW+FRGkDog==
X-Received: by 2002:a7b:cc94:0:b0:39c:4507:e806 with SMTP id p20-20020a7bcc94000000b0039c4507e806mr19785729wma.91.1656335015949;
        Mon, 27 Jun 2022 06:03:35 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c2-20020a1c3502000000b0039c5328ad92sm17737451wma.41.2022.06.27.06.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:03:35 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:03:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] mfd: tc6393xb: Make disable callback return void
Message-ID: <YrmqpN2VnjHSgMRW@google.com>
References: <20220619082655.53728-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220619082655.53728-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022, Uwe Kleine-König wrote:

> All implementations return 0, so simplify accordingly.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> compared to (implicit) v1
> (https://lore.kernel.org/r/20220530192430.2108217-5-u.kleine-koenig@pengutronix.de)
> this is rebased to v5.19-rc1. Up to now there is only a single patch in
> next (next-20220617) since -rc1 touching one of the files:
> 
> 	0fdebc5ec2ca ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_56.RULE (part 1)")
> 
> I don't expect any conflicts that need manual intervention.
> 
> Best regards
> Uwe
> 
>  arch/arm/mach-pxa/eseries.c  | 3 +--
>  arch/arm/mach-pxa/tosa.c     | 4 +---
>  drivers/mfd/tc6393xb.c       | 5 ++---
>  include/linux/mfd/tc6393xb.h | 2 +-
>  4 files changed, 5 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
