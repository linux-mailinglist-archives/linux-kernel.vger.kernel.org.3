Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1150045D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiDNCiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDNCiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:38:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897AF1F63E;
        Wed, 13 Apr 2022 19:35:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so3549967plg.5;
        Wed, 13 Apr 2022 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=banPxa9mjLz4QtsVZqr7bQ+Z1tRTpMcXp2eR4D900HQ=;
        b=IiUKzDWM52iO3GcXKasA41gw4qGcs3Qraiu/Fn1dkvUPCtvPMZO9zGarb8HmUQFBN5
         oaq05TvWx5a0sDOgjZzGIGZumxQIxriXuZEz2RqQwp0xwGZGoXaOwuBlPCUWT8JKmfVx
         iYkNzpheF2/u3lfnvFoe2haeGsIHQeJI2ZRO96i+crqh7xM6V1cKzjqJDz24h0JM8NZq
         chBZUMEfL+8t8B1Ua0ZQdnw9fRiqbBNCdfvk/YuNOHW1UgwdeN41C5HXTZndoTBnogJL
         XEpTbe5nJt5k2sNJ0dzyBxB1h4VkKD7cimZamCGj3+7fN26aosDGZWwq7cNiEcYXPEKR
         CVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=banPxa9mjLz4QtsVZqr7bQ+Z1tRTpMcXp2eR4D900HQ=;
        b=QnhkIGJtyKDhbqgBH+ORFSfnsNzp2Ov6xpAy3jlZt6hlDsAwogw7MPQZY574ntzYgl
         VGE7xFLCp3Pd69XMrdtAULZtu6YjtiBLdnDgoNPnszodPXhuwYuymfBRc/oYKPBX5822
         R6qCxBSTpop1ko0T+YMW9NDRFQPNSWcTppRXLprqyJb3so7BsApGrEEduR2k35qFvgj9
         FGkcRKZraz95DHkpHQcygGVV2izpUZaVMiduDI/WZ5iwuey4ydXLlDSGb0mH9NaGRolh
         Zps8GdB+oyJF37boe6eCJeZnKISkVOE69Y/+iswKBzLL5iyH1LvV63FbJuHs55FYo8oC
         /xxw==
X-Gm-Message-State: AOAM5322mzE4ImXyQwVaAi32iZIsoXzIEpRBvEIa2A4q6f+/p/qLj3a0
        SrLWvTFqYmm3HxsUR0V8bW+mEgrMa45u2nMU2w==
X-Google-Smtp-Source: ABdhPJwTNLMWTa4frWD8F/W1HLZUen2VPTunozndbetzvl6lm/UdmRAGgwMfqaFO7TB+Fsa7mGPFWhfsL6wPIvvBgSg=
X-Received: by 2002:a17:902:a404:b0:14b:1100:aebc with SMTP id
 p4-20020a170902a40400b0014b1100aebcmr46084837plq.133.1649903754047; Wed, 13
 Apr 2022 19:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220409140939.2176161-1-zheyuma97@gmail.com> <Yla9f03/j9sEB2Rc@paasikivi.fi.intel.com>
In-Reply-To: <Yla9f03/j9sEB2Rc@paasikivi.fi.intel.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Thu, 14 Apr 2022 10:35:42 +0800
Message-ID: <CAMhUBj=-TWjKFiGf_sE9umW3CtTiazqKPd5XabLhzTk6RiErag@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: dw9714: Register a callback to disable the regulator
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
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

On Wed, Apr 13, 2022 at 8:09 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Zheyu,
>
> Thanks for the patch.
>
> On Sat, Apr 09, 2022 at 10:09:39PM +0800, Zheyu Ma wrote:
> > When the driver fails to probe, we will get the following splat:
> >
> > [   59.305988] ------------[ cut here ]------------
> > [   59.306417] WARNING: CPU: 2 PID: 395 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> > [   59.310345] RIP: 0010:_regulator_put+0x3ec/0x4e0
> > [   59.318362] Call Trace:
> > [   59.318582]  <TASK>
> > [   59.318765]  regulator_put+0x1f/0x30
> > [   59.319058]  devres_release_group+0x319/0x3d0
> > [   59.319420]  i2c_device_probe+0x766/0x940
> >
> > Fix this by adding a callback that will deal with the disabling when the
> > driver fails to probe.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  drivers/media/i2c/dw9714.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
> > index cd7008ad8f2f..eccd05fc50c7 100644
> > --- a/drivers/media/i2c/dw9714.c
> > +++ b/drivers/media/i2c/dw9714.c
> > @@ -137,6 +137,13 @@ static int dw9714_init_controls(struct dw9714_device *dev_vcm)
> >       return hdl->error;
> >  }
> >
> > +static void dw9714_disable_regulator(void *arg)
> > +{
> > +     struct dw9714_device *dw9714_dev = arg;
> > +
> > +     regulator_disable(dw9714_dev->vcc);
> > +}
> > +
> >  static int dw9714_probe(struct i2c_client *client)
> >  {
> >       struct dw9714_device *dw9714_dev;
> > @@ -157,6 +164,10 @@ static int dw9714_probe(struct i2c_client *client)
> >               return rval;
> >       }
> >
> > +     rval = devm_add_action_or_reset(&client->dev, dw9714_disable_regulator, dw9714_dev);
> > +     if (rval)
> > +             return rval;
> > +
> >       v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
> >       dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> >                               V4L2_SUBDEV_FL_HAS_EVENTS;
>
> Could you instead disable the regulator in error handling in the probe
> function?

OK, I will send a v2 patch.

Zheyu Ma
