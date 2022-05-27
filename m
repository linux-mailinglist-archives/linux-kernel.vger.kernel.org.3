Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C97536879
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354796AbiE0VaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354793AbiE0V36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:29:58 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC146CF4C
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:29:53 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id p6-20020a4ad446000000b0040e8d086ee9so1014585oos.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sWnqhwDkczIhHwTjTv7vAXcYw3J6kKlPUvvwSLfh5AM=;
        b=JaA0Q9VKTrUYRSqVBCw8B+6tE/jw43Ri6DPaXQyzObATK8POeaXU86aOAOLMKiSa8P
         XccAEGKBl5MteXGMYalbaGFBe8dePa1f4TitQpAz9/DkGwJsmDZNcPI1aXsdAEFTTj+v
         lLpZpYwYb/+kLFo9uPWAdMpkJVOQhj+TjJ/cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sWnqhwDkczIhHwTjTv7vAXcYw3J6kKlPUvvwSLfh5AM=;
        b=YWA5Lvs5YhfG4/AaAL7obxMqrjcFZTZZzhjzsPX0y7NrgZhkZgX+IwtEBiXFyGuHWM
         L3qyDsGkvgQkPmbOn5rXaOZJpuzRyRPMfQIt9BAitJKTvNFYL2IFmaClbMKbhv6FELhg
         vYXRAtcaXNCTP6nILZjmGLBAtfl5TIRz6KK37uIfwYGdLpzDryVgPjHyeknzEU/0nLcN
         q/A18NY+X1R6lk0/S0iLu3KeYOz5ZiXgI+0EH5h9O9jPy0ydfWTf/w6QjY4QYaItjzpf
         UIve5VWXyD/+rIOGlZV7o1ideq7/DuPo9XyBcU8rE9N+WmhuigU3s9Kr1eA6+ZMg87AD
         gqiw==
X-Gm-Message-State: AOAM530HMtatpBxaDaI4gnOyCJktdF9bvao91EGtiUAVSKaRp7MczOgG
        hAXNFJxinoJLxnSkse8uODoG6KBm2dTIQ5EAzYOoDQ==
X-Google-Smtp-Source: ABdhPJxyyoit3bmwM3Zup7OjaADOAXkI86hQcqfZQkAzi0XJZBT2drhjSeRKHr0E2xqmk5P5SS0oDHmGuQGDN1v9WWI=
X-Received: by 2002:a4a:6f49:0:b0:35e:1902:1d3b with SMTP id
 i9-20020a4a6f49000000b0035e19021d3bmr17892535oof.1.1653686992468; Fri, 27 May
 2022 14:29:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 May 2022 17:29:51 -0400
MIME-Version: 1.0
In-Reply-To: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
References: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 27 May 2022 17:29:51 -0400
Message-ID: <CAE-0n50Cb5irGi-mf66qyDvSpy6p_QvZuBWXpK_C4geg+yyuTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: cros_ec_keyb - switch to using generic device properties
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2022-05-26 16:12:29)
> In preparation to enabling this driver on x86 devices let's switch
> from OF-specific property API to the generic one.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
