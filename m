Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B6951A267
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351404AbiEDOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351382AbiEDOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:43:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3341306;
        Wed,  4 May 2022 07:39:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j6so3262797ejc.13;
        Wed, 04 May 2022 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BT8BrcD290OhlXLzO/WMuO9iyvHDkVdQoNtwipl/it8=;
        b=f8YKGkv96KqipMGRLRAqtvYuQU5pcL6bmvh6APgrpuajxzd6KJ1Yi0yaw0Vqv5XqpG
         AIPrhM5kOXh4mzvaKjBInTE6626gSl/2PBj7QwowFxDd9WZVH/ya8UQGvaooKmhbSGSk
         fJpuhfxPEUPMjW2r9EY6iUJy+Fz18cUlByOEqfMVBLhwriao+eUMc0+x1aggqNjt3Itz
         /xAAIYm4ebEfc0sXMnU8cC9gmFgVcTdU3Ww4ivSjWKep2YKEx9lVl2zjhaAfAlbVd7ml
         t1c2Zo8pwu7pelWphHS1o8zr+rY8uvTk+omRxkkxQD2DZQDnZJ8FJg6zIpabPB68A7NF
         bdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BT8BrcD290OhlXLzO/WMuO9iyvHDkVdQoNtwipl/it8=;
        b=3WaZ4mcIziG/QUpsect0G59F76i1tFAlMf0n3EyKBteu9gyyS1XWs7ZCozknHkAU6B
         jIUxPFhXGM5C0QAE60yEJRtbWjmuqKxERCV5+iS88aDl620O9psXwvWgbZOoMI7t5jUQ
         ngOnV4UgScWMZUq33fkcPtw+wKAHyD7lEe9AfO7J/SOD3vyT/slA7W6oHYOzwe9H31Bv
         9mKaABsP3juV99roWsDtOaVFOUFWmQjZWIPMlq/uGSBW/QM6LTZC5xqKcvvTt+POXaAe
         jVaNR9KosHVsVTZIyNLNnCFCUBDgokoMydUKz25KPedYsCZIJmBSy/oYXr1XidfLOPjw
         lY7w==
X-Gm-Message-State: AOAM530Zem37HGQ6IP8ZswrEb8MJlQx9UmHSwVLm/xLdbE/C/nVoNo/J
        GA5kvD/Zj0ZjMI8nKhJL3eMUVLXnwPOj/mnEptWD1T/P+Q1A9u0M
X-Google-Smtp-Source: ABdhPJzsXYIbUziV7EZsdqDOx8PlyMdpdiCWKdFtijm7TBxU9VjomPcWn0uGzn+kX6jz25hLou3tgpos6MBaauoe5is=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr1151943ejc.636.1651675167204; Wed, 04
 May 2022 07:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
 <CAHp75VeseZ2ChtbafmbgVavS4KvCvrQ4+XSRkeiJSyqr8__dSw@mail.gmail.com> <AM9PR06MB7844E8FE0EDF712C769271DAD7C39@AM9PR06MB7844.eurprd06.prod.outlook.com>
In-Reply-To: <AM9PR06MB7844E8FE0EDF712C769271DAD7C39@AM9PR06MB7844.eurprd06.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 16:38:51 +0200
Message-ID: <CAHp75VfEK_TXXA3NdGgjis7duHgoDo4aSOZntdO0wEGLw0sQ7g@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi chips
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
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

On Wed, May 4, 2022 at 4:35 PM LI Qingwu
<qing-wu.li@leica-geosystems.com.cn> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Wednesday, May 4, 2022 10:20 PM
> > On Wed, May 4, 2022 at 3:36 PM LI Qingwu
> > <Qing-wu.Li@leica-geosystems.com.cn> wrote:

...

> > > +struct sca3300_chip_info {
> > > +       const struct iio_chan_spec *channels;
> > > +       const int (*accel_scale_table)[2];
> > > +       const int *accel_scale_modes_map;
> > > +       const unsigned long *scan_masks;
> > > +       const int *avail_modes_table;
> > > +       const int *freq_modes_map;
> > > +       const int *freq_table;
> > > +       const u8 num_accel_scales;
> > > +       const u8 num_avail_modes;
> > > +       const u8 num_channels;
> > > +       const u8 num_freqs;
> > > +       const u8 chip_id;
> >
> > Why do you have const qualifier on all members?  The last one is
> > understandable, but the rest, esp. pointers should be justified.
> Because I thought it was static and has fix value for each chip, unacceptable for you?

But why const qualifier? What is the point of it for example for u8
members if the entire object is qualified as const below in the same
patch?

On top of that, please explain what in your opinion the "const ...
*foo" gives us, and what we will lose if we remove the "const" part
out of them.

> > > +       const char *name;
> > > +};

-- 
With Best Regards,
Andy Shevchenko
