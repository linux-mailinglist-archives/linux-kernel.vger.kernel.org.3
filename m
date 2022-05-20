Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DE52E90D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347776AbiETJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347782AbiETJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:41:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2BF1498CD;
        Fri, 20 May 2022 02:41:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gh17so1535714ejc.6;
        Fri, 20 May 2022 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=+Q0QiA7ru6i8BsA9kJw7SZPGcwHJrhsZ4QvZNcEI9Dg=;
        b=qx0h4A1phm5nsIroUsJwfajaIeD7n912JaN0mRC5EAn8j78j6xSyKlsylTXxCMZuKu
         eJvfLlqevQHJrDbbh7RkFrgnPLbVyOxA6T9kGy/6LI16CeXYpHply9dWKVG9qsadXonh
         oan7RSXE4Ywm7kwFwLR7qTXKKepqKeKLatdAyrw8LsA0D3fkmQoEcENyBFUc0pgNnUzv
         TUhQ/gF8jQ2uG8pFukE4tFlIdVmD2EMpRZTmNRVm5JXZTwwTbDOJSagsWkk/d9WtHaaD
         AlY40bQ44f2z94SYbbgiGUKxRMvQI2lfY23GPi27X4wixARlyi6KppYRTutH5kuyy17j
         w/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=+Q0QiA7ru6i8BsA9kJw7SZPGcwHJrhsZ4QvZNcEI9Dg=;
        b=xunQQkfiWyeLedzfRvS0yQbpHXW5IaFZOkJ+f2Vs36/3Gz5pfmf2QwLqp/KKYp0Om2
         Km7GYLcvDuey7cslQ2qOpJcxa+pSilGRAXuOpaAmHH3lmWUicbxOcOaoI/1ZlF1qg+Ch
         t9mIFUNg+TOKmG2HTPPnNkhRA2yofOG07AvB3DwcJ+MHek2rGbpVlegwxEI6xYy07jFJ
         CRgt1SvB5zFr/Z1r2vSVHL0LOwMlRa9gXBsKZQrNWQSd8L6mg4GZhpT5rHQY5wIiy5o5
         TWIH1E6lZSCFNGmLlqoZ4bXCGBkMkOEjCAQl/IJlZ+rhW6tGLb0wK23h4X8vZNrrjwH4
         lFlA==
X-Gm-Message-State: AOAM533ydAmMN/EdVR1Xborgf5k9PeEvhSPLe+QJoVccydURpMOS3CmR
        4B+w7XiftOiTjOGkmL8EXZM=
X-Google-Smtp-Source: ABdhPJx8KoctJFPDI79r21gvLJwl+tekVa1UwU2OiLxDKk1gsbX922JsgN+mWcLDYdoCB7xhEaRD/A==
X-Received: by 2002:a17:906:1f52:b0:6f4:ebc2:da82 with SMTP id d18-20020a1709061f5200b006f4ebc2da82mr8207315ejk.176.1653039705676;
        Fri, 20 May 2022 02:41:45 -0700 (PDT)
Received: from [192.168.151.247] ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906435600b006f4c4330c49sm2937723ejm.57.2022.05.20.02.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:41:45 -0700 (PDT)
Date:   Fri, 20 May 2022 13:41:33 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 3/6] clk: mediatek: reset: Return reset data pointer on
 register
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?iso-8859-1?q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Message-Id: <9LD6CR.FM55IKDYS0IC2@gmail.com>
In-Reply-To: <5b5f6656-8694-dc78-ef42-7ce301849aa4@collabora.com>
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
        <20220519134728.456643-4-y.oudjana@protonmail.com>
        <5b5f6656-8694-dc78-ef42-7ce301849aa4@collabora.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 20 2022 at 10:42:40 +0200, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 19/05/22 15:47, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> Return a struct mtk_clk_rst_data * when registering a reset
>> controller in preparation for adding an unregister helper
>> that will take it as an argument. Make the necessary changes
>> in drivers that do not currently discard the return value
>> of register functions.
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Hello Yassine,
> 
> Thanks for your efforts on helping to make the MediaTek clocks better 
> - I agree
> (and I'm not the only one..) that there's a lot of work to do on this 
> side.
> 
> Though... I don't think that this is the right direction: you're 
> right about
> properly unregistering (in patch 4/6) the reset controllers on 
> rmmod/failure
> but I'm not sure that this kind of noise brings any benefit.
> 
> Explaining:
> You definitely saw that there's a new register _with_dev, which uses 
> devm ops
> and that's going to automatically cleanup in case of removal/failure.
> This is what we should do.
> 
> Hence, my proposal is to drop patch 3/6, 4/6, 5/6 and (slowly, 
> steadily) migrate
> all of the MediaTek clocks from CLK_OF_DECLARE() to platform drivers 
> (which also
> means that we can eventually change them to tristate!), so that we 
> slowly remove
> all users of all functions that are not "_with_dev", and that we 
> finally remove
> all of these then-unused functions as well.

I've tried to make small (but hopefully not too small) steps with
little improvements. Originally in MT6735 clock drivers v1, I only
added reset controller unregister, and while rebasing on Rex-BC's
reset cleanup series I found mtk_clk_simple_probe/remove while
looking for references to mtk_register_reset_controller, so
I thought of using it for my drivers resulting in this series
adding support for the extra 4 clock types. I started finding
other things that could be improved such as the other clock types
not having register_*_with_dev(), but I had to avoid adding
anything else since that would only make me find more things to
improve and this series would've never been finished and sent.

With that said, if these patches could become an obstacle for
later more complete reworks, then by all means drop them.

> 
> Making sure that I don't get misunderstood:
>      I'm not implying that this huge migration work is on your 
> shoulders!
> 

Of course. I would never be able to handle such a large task.
Everyone currently helping with modernizing this common clock
framework has my full respect. You are doing amazing work.

Thanks,
Yassine



