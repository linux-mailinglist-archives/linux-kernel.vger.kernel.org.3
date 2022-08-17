Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B40596978
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiHQGVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiHQGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:21:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0246DF8A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:21:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ba1so4456903wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=khB20IPcVm4LmT/fQkPCK8rCyXeZDwKHmcQKc9vJOvk=;
        b=IaNwYW13LfZmEUQvOi0TP9bqbQWgYzh53ws3fOiElKfEwqKBUxRR4XLEfK80yBiiyA
         ysp51hzlfSr7UcQ0w6DQ0ZUAiWst6kNL4u2Ye2js2YTWE2CsPHyW8plbYzO1FhEZxpRP
         TGeP79b17eDJVAuwL6/+Kb25eDRavfo2PyUO/zGzKgz6h8suS9cEoJd2LCgHNDNk4Ss1
         mGLbxuCfOw8WnmYfuXOKAJO6tFJOBQTEgWofhWFFq6tW6wUZadSIEBJ5ce5rtG6YRQjD
         4Sm+qtG3LHh69S2x9vzpKOPhWUM4nSnef34pmgRG/LQOwM9HDGjlQ9ha9eIUx1JTCZS7
         apPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=khB20IPcVm4LmT/fQkPCK8rCyXeZDwKHmcQKc9vJOvk=;
        b=RDpROCJTtCawpSWjAXtBOf59msZ4Ww7pxuibwVzomcdy9y7ubsq4O4fdLmx7UJDDvK
         S6d7JttDnY1xmMd5fhfo2/+DgGFAxKHa37Jn1OJZo9zoInGfoXn+8qPQDrGbuVU+xYkd
         mFDfGvVkI16HohQgp4qViiJ5TISTJnIOADsIYul3OdfoRNVUlWxjahuJKfnO/MlryXvu
         LgnhOIEr2TcJIWKECJGQCA3sGXNvsGItuukLxO+MLZ13p9ovDLfuR/yDDA8bhKqOKUIQ
         cGQU8+Wl4ejBnR2cAIzixXNGYyHr48ZaRIKIs4FKnKOt78OtChov4CThVLRDPwGjqJy8
         sWlA==
X-Gm-Message-State: ACgBeo0TONzHLJSF+Jj2buKXnvLapjTpxKaNK12x5FyXW1RyWoyZs+nj
        +dqxXZTjXTc2NTFYkcV7fjX8O5WA27qpLHLrjOtPwmPjSGE=
X-Google-Smtp-Source: AA6agR7Ic0pRjgTQ94iWPIZ5rgSaQqAPSXO83NX28fvIglU5zlIw6TjRdEWNUKcqglFLeLKa3OGayTRPQ1C8l1jAg0U=
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id
 y14-20020a056000168e00b0022087dac3e4mr12912740wrd.559.1660717267652; Tue, 16
 Aug 2022 23:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <1660713867-26921-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1660713867-26921-1-git-send-email-shengjiu.wang@nxp.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Tue, 16 Aug 2022 23:20:56 -0700
Message-ID: <CAGoOwPT1tP-HP+0J1ddZ0Ea+67zzLzFFTeptTpNwkzxRK45b5g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Remove unnecessary FIFO reset in ISR
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:41 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The FIFO reset drops the words in the FIFO, which may cause
> channel swap when SAI module is running, especially when the
> DMA speed is low. So it is not good to do FIFO reset in ISR,
> then remove the operation.

I don't recall the details of adding this many years ago, but
leaving underrun/overrun errors unhandled does not sound right
to me either. Would it result in a channel swap also? Perhaps
there needs to be a reset routine that stops and restarts the
DMA as well?
