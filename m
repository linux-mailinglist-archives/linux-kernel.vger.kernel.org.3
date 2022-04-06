Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0BA4F626E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiDFOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiDFOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:51:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BDE55A9B2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:25:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p8so2185814pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyk8xTMjH/DJBXZpWSm5gtyrwHKcY5V7aOEPyHINN9g=;
        b=ck3vGGzD0sLUD0SfXv3dreaZ1Ek4bWn8ZNESDidGGpY3eEz6RL5o4wfc4LUNWWmi58
         GmfiX58B6ouw4Mb3vM83PjEpxT67WlJ3LYvpRCodMHsLS1kIYRZjz5k+R1HDVSykewob
         svjCgJF8KLM+YrBmaLHWjjfWspx0wBVyqdyyR+AA2ybE9TfZ3YakwfqNlThu2F4WuXSD
         EvKmFfHCFxrBHbnL+pgxNcBlbtLTdwTiPVo6eeFJmbGJnGNpY4qQIGUvS7kDwobXQr+Q
         bYM8ZW7ji5dpc6lpM04+0tKJZqtPcoO6vtNIXGvWhYuCf6BFY3Mk0V8UAAQU7G/1DWfl
         jIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyk8xTMjH/DJBXZpWSm5gtyrwHKcY5V7aOEPyHINN9g=;
        b=VXu4mj4t+9wM7KdJqWWxWm3/FxM5JXBhS/yu75JcjsLXwavJDLvDnw9zwPT0uW6FOg
         YKoPl802+3LMz9RO08ipJd5oW0T/ZTU7c/2fjpunzLxPLFTRMe0JqrqFs1qtY84+9a6P
         I2p5AmwFrLu1a3CLH7WAwDJgxCxF7r5ukofc9FvQgWSDns04qvNyJ6fBPozW6qnBcn02
         +PBppPmmSR8UGI4Ln8wL8j9FyOJqsnrPGhNgV8yZyGPOx1L+yyS7k6J1gkXviPPsZBVI
         sh3ye2ECln1Den34NsbdFaDObf5SeH9eyb9tlLIAKV8H7IZ3QNCVV66zJ/SFRaeKRKqc
         RNYA==
X-Gm-Message-State: AOAM532XLY3TKdWfE3UQNSDnXvb0PfKixlnBK54Ao+aPNeP7OZUksCiG
        CUgPcyrwy2xwwDJF8JwaPMrztYM/MyYQCWv5Pg==
X-Google-Smtp-Source: ABdhPJykyT9QZJZh5h36/jePZDuYOCk2rqWs/F/99ioWJhe8a3s1By+H10Z5SxwZHrOCLmPCHB72bj6AE04Kg/qpQYA=
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr6795871pgi.542.1649244315566; Wed, 06
 Apr 2022 04:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220405121038.4094051-1-zheyuma97@gmail.com> <20220406100121.GV38351@ediswmail.ad.cirrus.com>
In-Reply-To: <20220406100121.GV38351@ediswmail.ad.cirrus.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 6 Apr 2022 19:25:04 +0800
Message-ID: <CAMhUBj=RMT_jOkzsET2jx3Opihz6P+sNczZrNK+efkWr0SN2LQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm8731: Disable the regulator when probing fails
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Wed, Apr 6, 2022 at 6:01 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Tue, Apr 05, 2022 at 08:10:38PM +0800, Zheyu Ma wrote:
> > When the driver fails during probing, the driver should disable the
> > regulator, not just handle it in wm8731_hw_init().
> >
> > The following log reveals it:
> >
> > [   17.812483] WARNING: CPU: 1 PID: 364 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> > [   17.815958] RIP: 0010:_regulator_put+0x3ec/0x4e0
> > [   17.824467] Call Trace:
> > [   17.824774]  <TASK>
> > [   17.825040]  regulator_bulk_free+0x82/0xe0
> > [   17.825514]  devres_release_group+0x319/0x3d0
> > [   17.825882]  i2c_device_probe+0x766/0x940
> > [   17.829198]  i2c_register_driver+0xb5/0x130
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
>
> Mark just merged a big chain overhauling a lot of this driver, at
> the very least this patch is going to require a rebase on top of
> that lot.

Thanks for your reminder, this bug has been fixed in the latest code.

Regards,
Zheyu Ma
