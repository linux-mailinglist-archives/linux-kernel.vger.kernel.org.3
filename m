Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6A50F07D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiDZF4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiDZF4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:56:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EA6D4CA;
        Mon, 25 Apr 2022 22:53:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so13082604ejj.10;
        Mon, 25 Apr 2022 22:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HreG5iqkoPQvq2wHeL0ySPRcF1pvIlKmELTDhNYq298=;
        b=OUhk0zi0Bx0SiBNpcggwH5oBYYuQKX+buxKfMyKmlSff7jWuchQWUmtrMNyKj16ycS
         nuB7144T9WM9z/uXI2NEaT8rCSEUtmknrUZYhZsj6mruCmtC0dBxxVZl6bmL4EGFLcXA
         4uu9y+j+67uPKtrgEL9EFBWxXJUhMRxQ6ts2WZx4xRItHkv/TKkbmxGr2O6o5gV950ab
         nW20PAiS9CYvW82DTr16HvRK/wHUDtdXwmgsqzCmwXLt9gTs1ABqaWgf/HgYZXK2PdeU
         4cbwCFSKTFyq4pyucu2USDu5VGItbxeKzZkcogTYpuanV2MHAed1CFPqKylm7YoG0Yv2
         GdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HreG5iqkoPQvq2wHeL0ySPRcF1pvIlKmELTDhNYq298=;
        b=suqK3iqHpzBXl7AgWb5rXejqJznvfkm4Efb0i2EnkdOP19a0F3yVezK1uAAPbN5oiE
         LVShPh9PsjJGbwjZx9nMnUNGQOytWgu+jJA0TF8IReV5FmL/DockDBHGPSDUa4JEpTqE
         m7m2KSwRheXovGheRWt6xLNpsMotXf2N8JAkdgH69s+AY8IppT9z5nkDvUr7CcpfYWZF
         d99USdewJefxWFJ3DzkskY4orMvoElMTf2PKPC6NteD3bEBOnWQK0bXYy6CR1ZbF4pF/
         TQzgEEfaFtyCyogKK71uVeHwdFMOaQTMENFYwlt/VjBs3jtnX4hFk98KMcd3ArcZrW5a
         hiHQ==
X-Gm-Message-State: AOAM5330cllFxcCeLOT1ifNG1g9l1kdPEp+i89Mv0XEgkLwTR1JELMck
        IpuDf3jwq4FWhyuWwB/hIs3p04vVnAOB+oPoxSI=
X-Google-Smtp-Source: ABdhPJxkClHqWWyqwQfoyzsXc4tqiMcXcMgJa1jL1Fo9fRkw2oX6EC8yaiYoQCvfDNaHA3WMzwmC6+9efT/ldNX1K3A=
X-Received: by 2002:a17:907:d04:b0:6e8:8cbc:e86a with SMTP id
 gn4-20020a1709070d0400b006e88cbce86amr20051293ejc.194.1650952393864; Mon, 25
 Apr 2022 22:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220422085408.634616-1-dzm91@hust.edu.cn> <YmV9heuEM+zpaE+x@pendragon.ideasonboard.com>
In-Reply-To: <YmV9heuEM+zpaE+x@pendragon.ideasonboard.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 26 Apr 2022 13:52:47 +0800
Message-ID: <CAD-N9QX-FDcd4EsBggOOVAevJmD8y+9VWxKpMVpWhMS+ebcyUA@mail.gmail.com>
Subject: Re: [PATCH] media: ov7670: remove ov7670_power_off from ov7670_remove
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:40 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Dongliang,
>
> Thank you for the patch.
>
> On Fri, Apr 22, 2022 at 04:54:05PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > In ov7670_probe, it always invokes ov7670_power_off() no matter
> > the execution is successful or failed. So we cannot invoke it
> > agiain in ov7670_remove().
> >
> > Fix this by removing ov7670_power_off from ov7670_remove.
> >
> > Fixes: 030f9f682e66 ("media: ov7670: control clock along with power")
>
> ov7670_power_off() is a no-op if power is already off. What does this
> fix ?

Yes, this is true. I just thought this is redundant, so I remove
ov7670_power_off from ov7670_remove

If current code is fine, please ignore this patch.

>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/media/i2c/ov7670.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
> > index 196746423116..1be2c0e5bdc1 100644
> > --- a/drivers/media/i2c/ov7670.c
> > +++ b/drivers/media/i2c/ov7670.c
> > @@ -2017,7 +2017,6 @@ static int ov7670_remove(struct i2c_client *client)
> >       v4l2_async_unregister_subdev(sd);
> >       v4l2_ctrl_handler_free(&info->hdl);
> >       media_entity_cleanup(&info->sd.entity);
> > -     ov7670_power_off(sd);
> >       return 0;
> >  }
> >
>
> --
> Regards,
>
> Laurent Pinchart
