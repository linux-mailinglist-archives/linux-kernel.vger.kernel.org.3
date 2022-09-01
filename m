Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D365A900A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiIAHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiIAHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:23:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11924124847
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:21:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id t129so16693107pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0HqSn0Ox0h+zex/0MovePHLPQd5vbfE0VJ6wh/+Xb8U=;
        b=FCUYOtcqINLucitLMdn4Q7w+N4jAz3oWi3yz/tfuivP4ZP27j39mUYEhUHGJ1tCcBS
         abuZ269dc3vVPf02Cm3ZYdpuRWAv/vaN7KWstNn0Dm0xK4GqFVGeosCDnC6056RFPyp3
         ThDjOnr2DfQru8Kr3c7DEg9KTbWKiBEy9KuflUWgIy9thMney4Jv4nkrFaPeTdJAt0Pi
         PfH+9qa2HQb07xs2eQA+GnWMsKkKUg9GdE2qMXaVBIifVUty9467gajKo4j7oQqLo0Dh
         CvF/1a0PXCXWfpsbNMIGUqyLcyWOKbeXlL2KgC8P8DfkHM3mQe1TV/47gX9/YMc0R6R6
         rkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0HqSn0Ox0h+zex/0MovePHLPQd5vbfE0VJ6wh/+Xb8U=;
        b=0PbIb0gvReaxzvKbaC+Vxa8TUT+CgSyOYFtBd6xx1NKK3CJR/lT4WZ/apbaWe8Kuag
         cI5XNNm2in6onZVBW0Ypy6M+X73045icJoJGFUujG2ILRjR4xVPW3+0qUiTRRMwEe1Hy
         QctJYwzEcv7twicapwI4dGSM0n5rJ7JV6e3WqipzabM5meD2PTD2OrZsAa4c0ZEkdkEl
         j8h1T6xAFxMZLDaTziUN7EyrhtzfcVlBbeu4XF1qN+KCM8Qg5x0onwctQUbEx1Eozk0K
         3Y28ny7rafLSkRN1w3fHWO2yya3txV9VYiLvo990nb9zMX+Qnb4hqqvPkw9DjwEROfzx
         KN8Q==
X-Gm-Message-State: ACgBeo38pZNp+D7cMPvZpOMOvlJHJh1H9nMNwx0/9GDIdVbhccQzM7Ky
        +Oux5lSMJS8YeNThchCBAU6GWfIBda2yTrI3KxbddQ==
X-Google-Smtp-Source: AA6agR46mHRzWOrAOTwErntVCqk2ig3IBvg1EIYAc3L1t8gfnMPbA60TmU3+pvCDmudNP1FIpFuB7d1BB18zX7L8x4w=
X-Received: by 2002:a62:30c7:0:b0:52f:9a31:5935 with SMTP id
 w190-20020a6230c7000000b0052f9a315935mr30042793pfw.14.1662016903630; Thu, 01
 Sep 2022 00:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-3-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-3-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 09:21:32 +0200
Message-ID: <CAHUa44Fxg4p1t4O+P094m2vvjOVaJ-phPVZTLVKbdL0pOQNGkA@mail.gmail.com>
Subject: Re: [PATCH 2/9] tee: optee: Use ffa_dev->ops directly
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
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

On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Now that the ffa_device structure holds the pointer to ffa_dev_ops,
> there is no need to obtain the same through ffa_dev_ops_get().
>
> Just use the ffa_dev->ops directly.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
