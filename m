Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E745B1D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiIHMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiIHMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:45:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9824F45057
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:45:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so37682666ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DagdkGgwofcQurfY/oyoSLL8TcjsetOya7w6PT/SbE4=;
        b=MzSOAiaTHDehvcg2VS85/lF6JzmFEboY16cjI2o/4s3gyYIhTZWm61Pk6oxHcRcZCF
         XtwZ3bFIjug/tRqX/BfXhbbjLePx0JdOkjV5XSYyjQ47lMovO4L1Mr9KdR4LQxNXxic2
         0RMC/EC32luZL2NtXROmJfdA4W/a5pta/b3TcXJlMizZevHyBOTvJ2yokffqdCJ7GF33
         CbUP9Akt0eqSghmqbUV7Lpz7ybvi8EI0FXGe0xhBREcMLKNWMa8tlnK8o68/PO9Wx1Ax
         bK1SWlyaUNJRR37oOT8JuVksIxlTs/2EKa1k0yfRETEic9p73AO5FnnXexCB755gooFT
         ZNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DagdkGgwofcQurfY/oyoSLL8TcjsetOya7w6PT/SbE4=;
        b=WFaZNdX/f9mol90nbluCyfDFMqGHx+eGlI3GUdxZnsOyVwIwbeuKCgwJSaZ5cam12R
         iHbBhPdK48IIlKvQs5oalBJwpd6ub2lRuDvTi174+kp+zfnwQdwU8DMcaOR4mAYNsCuO
         287BsHHQnNJZEa/Y3OaHyQxx1PACSs/I/Ea1iVPiQxfm0EvhB8fXs339Ljfps3Pq/Snd
         oNgoYQ5k1VpuXY9/ylzWG2YO8tGvROsnJHWQt8piYBre552LlZMIGD87vMTzVmTKWh2Z
         hfazECw1AoJmFpC4CAvACoLARcg6FGBRXfSz7zDo3Y1iogBvbcFmoazv1qDRUhk30wd+
         DxuQ==
X-Gm-Message-State: ACgBeo1zecfYmOQ3qG8Ky40r9H8LBWQrNqnSBdXapeG9Rq1DMOGmX5nG
        u+MGRLuV7I3Gem/89tPyeGwpcSxC2d/ZpkxYzpdDrA==
X-Google-Smtp-Source: AA6agR5J2k6FOxbxd3dYWzdKv22WlViwHevJxlJ+++nc5B9SzV1he7qwEe80kqFmU+D3ju05H9mEZ9bITtJ4T2XdQJY=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr6033974ejb.500.1662641139016; Thu, 08
 Sep 2022 05:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220908053949.3564796-1-dmitry.torokhov@gmail.com> <20220908053949.3564796-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20220908053949.3564796-4-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 14:45:28 +0200
Message-ID: <CACRpkdYUi0vUSS4Y+7qP9cmwFFbfWMYOgyCf5PPKWXnza2R6zg@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpiolib: of: factor out conversion from OF flags
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
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

On Thu, Sep 8, 2022 at 7:40 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> There are several places where we need to convert from OF flags to
> "normal" GPIO_* flags, so let's introduce a helper and use it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
