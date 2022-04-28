Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D365139B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349952AbiD1Q1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiD1Q1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:27:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F5C6C969
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:24:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e2so7469692wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kflk9OISBqAQ9MGmpMOjj5cfrdUkwPfhW0JnSd4hFng=;
        b=QzFgtfPtRHZVZHWlKKx+wCmON1HzgoxMtZKa93YtvPSdL1DoMx/D8vI4ngamV6uS15
         Hktqp7FjmyIoN0i63TTEZjTnUV6A3jMt7r9hwVl5//UUjy8ch5KINk2nykx1vvaPbV0s
         dq596L5nX9hoDkv8BnyyMgwGroU2EHHgkwBhijw1T9OYQtpEm1jNJVBDYkZUv3W0N4HB
         w22yM/PdFH0F8RWTyz594D4wZB8lIPZC8730+bQdgjUz+55degVbr4IDHuryv59ZTYoj
         rsMhHi19FUTQJd05nIkH4ZJ/ffjsNeVuq3AMI72yB0oImAmZa74dDiYonriSfg2pMf1X
         W6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kflk9OISBqAQ9MGmpMOjj5cfrdUkwPfhW0JnSd4hFng=;
        b=sGdlE0OX7L6lDIYTFhtyG9UCm6hOhIMV5RwU9vFGoTijbcZ36DRXP/z164FNVReXCO
         ZG02K1hS2yi/2CQ+F7iLjp3evqZm3faxP4GjhbvUJVStklvIYKr6r2uRDojb1H+KMtIs
         EhdnWz3gFgsqAANm7NiT6CgDdpR5zCNfiSkhocc3ARPqBxjAhrKCJjf33AihlV+Pp0GH
         41qYmILwTASPrGaLnmrPThp4cDkRbUYpqovfjfK5hQBTlLoLYFIe6AGcPkcLlzc4jew7
         t6TSGe2X6JYz2c8lK/zucBpEUKT4SZUXsz7Gu9eZAQUYHjpJY8MeziJPid+jGVdckW/r
         a6nw==
X-Gm-Message-State: AOAM530cL4JBlmFFc/OOX0AuQ1YUmH1h9DTB4+893QXXJMdtTtlbMNt3
        pfNWd8GSEOSbptKQU8Lc312DooQVk1BfWA==
X-Google-Smtp-Source: ABdhPJwdCVhhfINCa1iGzjvCS08hiIcmNour0OKFFXsjmxhup/DGRv4WTsd5gUJt8zXv0HXlv3en5g==
X-Received: by 2002:adf:e646:0:b0:20a:d3b3:f176 with SMTP id b6-20020adfe646000000b0020ad3b3f176mr21766533wrn.695.1651163064336;
        Thu, 28 Apr 2022 09:24:24 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b00393e84ea043sm324857wma.44.2022.04.28.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:24:23 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:24:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] mfd: twl6030: Make twl6030_exit_irq() return void
Message-ID: <Ymq/tVTo2JIEDEQa@google.com>
References: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
 <20220113101430.12869-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220113101430.12869-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022, Uwe Kleine-König wrote:

> This function returns 0 unconditionally, so there is no benefit in
> returning a value at all and make the caller do error checking.
> 
> Also the caller (twl_remove()) cannot do anything sensible with an error
> code. Passing it up the call stack isn't a good option because the i2c core
> ignores error codes (apart from emitting an error message).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/twl-core.c    | 4 ++--
>  drivers/mfd/twl-core.h    | 2 +-
>  drivers/mfd/twl6030-irq.c | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
