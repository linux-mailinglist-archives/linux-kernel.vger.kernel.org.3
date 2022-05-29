Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9802E536FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 07:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiE2FX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiE2FXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:23:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C2AF307;
        Sat, 28 May 2022 22:23:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d129so7378977pgc.9;
        Sat, 28 May 2022 22:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T5XFxBmhA+Yi1gVGr5oW1G0EspvBXVIjAMsTMV065mY=;
        b=QAWpoJZCKF7T0vZBtphN+2DNdtfi3T0OkcWuaFphp80JM9vAtF4y2pvAepLlAC3Zrn
         bFZ7dYpki1E/vErAHcAz4YEQP0FYC5C+IxoMCAHqRUWMw12OTSyjPA9B9gyTz5YIc9S3
         0p0XpJdYR81NYPyyvA3kI3zjHjEbgV/tYPAMzBeJzxXvvI4F/BxnbSNdQtemE3RHLTKb
         kP22NG3oqYJwQ7LO4Wyy3WLcU5aZEtjjXOIqwnwW88Mq5vw8tKxzQn7SQ+o9i298opNG
         JuK6WMVKufc0UFEQkQxin0s2eTdicputubLMaLGPkY2I8gE3++c0Ses4UPiXpHsaHNyk
         5S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T5XFxBmhA+Yi1gVGr5oW1G0EspvBXVIjAMsTMV065mY=;
        b=jVzIa0DxpnKRmU+/ewQITfm1JpooPRb9VtTF7obbX53zUYLs8M38wTxVYZTka8tqb6
         fNVuFBwJAjr1zqeA+rE71hF+B4bkp0GqwSKtxOutfZgew72FStrNYhdLlIJcnpNDxf+N
         Wu3vnhxLB8FCBqh22BhN5w+i7nImr2ZtCFQI38goBgUb9yVgVfHVmPXVbK5fgMv7l68D
         iUrNnRMEs15iXOx7W4pvusXZ2vgYQYgXYOxEjjI8zyGLhyaEU2SA/wQ5Sc1N1LjSSczM
         BvfERqoII+4RQDh3LSLoty89LJgJP51sshVq8cf5h2DwKbxl03HFqSH4Xvi4aInomSIv
         +wHA==
X-Gm-Message-State: AOAM530hcc+O/WW2isCQhRCALYCoWVokpW2FIR/SzerHftp+i8gclr3e
        LRwwYPaM6jIujW53Dc59FV9mnTpjj24=
X-Google-Smtp-Source: ABdhPJwGHmvbTI1lv9t0UPg5Z2nY7WeVEoA3G10fVVPpkiSXwhqJRCAulrJUSFmKdTYgXLRNALmXuA==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr50898462pfu.6.1653801833255;
        Sat, 28 May 2022 22:23:53 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:781a:4ab0:a93b:176b])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902f78600b001635c9e7f77sm6541632pln.57.2022.05.28.22.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 22:23:51 -0700 (PDT)
Date:   Sat, 28 May 2022 22:23:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
Message-ID: <YpMDZORAlHmg/x/0@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
 <YoHf6Z4HTfh4Y+bn@google.com>
 <874k1qkk7n.fsf@baylibre.com>
 <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
 <Yosex9/a7OTuC6ZK@google.com>
 <87y1yq91on.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1yq91on.fsf@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 09:21:28PM +0200, Mattijs Korpershoek wrote:
> On dim., mai 22, 2022 at 22:42, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Mon, May 16, 2022 at 01:06:43PM +0200, AngeloGioacchino Del Regno wrote:
> >> Il 16/05/22 09:30, Mattijs Korpershoek ha scritto:
> >> > Hi Dmitry,
> >> > 
> >> > Thank you for your review,
> >> > 
> >> > On dim., mai 15, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >> > 
> >> > > On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
> >> > > > In mt6779_keypad_irq_handler(), we
> >> > > > 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
> >> > > > 2. Use that hardware code to compute columns/rows for the standard
> >> > > >     keyboard matrix.
> >> > > > 
> >> > > > According to the (non-public) datasheet, the
> >> > > > map between the hardware code and the cols/rows is:
> >> > > > 
> >> > > >          |(0)  |(1)  |(2)
> >> > > >      ----*-----*-----*-----
> >> > > >          |     |     |
> >> > > >          |(9)  |(10) |(11)
> >> > > >      ----*-----*-----*-----
> >> > > >          |     |     |
> >> > > >          |(18) |(19) |(20)
> >> > > >      ----*-----*-----*-----
> >> > > >          |     |     |
> >> > > > 
> >> > > > This brings us to another formula:
> >> > > > -> row = code / 9;
> >> > > > -> col = code % 3;
> >> > > 
> >> > > What if there are more than 3 columns?
> >> > That's not supported, in hardware, according to the datasheet.
> >> > 
> >> > The datasheet I have states that "The interface of MT6763 only supports
> >> > 3*3 single or 2*2 double, but internal ASIC still detects keys in the
> >> > manner of 8*8 single, and 3*3 double. The registers and key codes still
> >> > follows the legacy naming".
> >> > 
> >> > Should I add another patch in this series to add that limitation in the
> >> > probe? There are no checks done in the probe() right now.
> >> > 
> >> 
> >> I've just checked a downstream kernel for MT6795 and that one looks like
> >> being fully compatible with this driver as well... and as far as downstream
> >> is concerned, apparently, mt6735, 6739, 6755, 6757, 6758, 6763, 6771, 6775
> >> all have the same register layout and the downstream driver for these is
> >> always the very same one...
> >> 
> >> ...so, I don't think that there's currently any SoC that supports more than
> >> three columns. Besides, a fast check shows that MT8195 also has the same.
> >> At this point, I'd say that assuming that there are 3 columns, nor less, not
> >> more, is just fine.
> >
> > OK, now that I looked at the datasheet I remember how it came about. The
> > programming (register) interface does not really care about how actual
> > matrix is organized, and instead has a set of bits representing keys,
> > from KEY0 to KEY77, arranged in 5 chunks of 15 bits split into 5 32-bit
> > registers. So we simply decided to use register number as row and
> > offset in the register as column when encoding our "matrix".
> 
> That's correct and that's a good way to phrase it.
> I will add that in the commit message.
> 
> >
> > This does not match the actual keypad matrix organization, so if we want
> > to change this, that's fine, but then we also need to recognize that we
> > are skipping bits 16-31, 48-63, and so on, so to get to the right key
> > number we need to do something like:
> >
> > 	key = bit_nr / 32 * 16 + bit_nr % 32;
> > 	row = key / 9;
> > 	col = key % 9;
> 
> I would prefer to have the driver's matrix_keypad (build in probe()) to
> match the actual hardware. To me this seems easier to understand for
> people familiar with the hardware.
> 
> I've also tested the above snippet and it matches my expectations.
> 
> >
> > I looked at the datasheets I have and they talk about 8x8 single keypad
> > matrix, and 3x3 double keypad (with actual matrices either 3x3 or 2x2)
> 
> Indeed. I plan to send out double keypad support for this driver since
> that's actually needed for mt8183-pumpkin as well.
> It's already in our mtk-v5.10[1] integration tree but I have not submitted
> it yet.
> I planned to send this a separate series to avoid burdening / have
> smaller chunks to review. If that was a mistake, please let me know.
> 
> > but I do not actually see this map layout that Mattijs drew  documented
> 
> The map layout that I draw is not directly copied from the datasheet.
> It's a "translation" of the following table:
> 
> | hardware key code | col0 | col1 | col2|
> | ----------------- | -----| ---- | --- |
> | row0              | 0    | 1    | 2   |
> | row1              | 9    | 10   | 11  |
> | row2              | 18   | 19   | 20  |
> 
> It seems that caused more confusion than actual useful information,
> sorry about that.
> 
> > anywhere though...  I also wonder if there are already existing DTSes in
> > the wild that will be rendered invalid by these changes. I wonder if it
> > would not be be better to document the existing meaning of row and
> > column in the driver?
> 
> The concern for "DTSes in the wild" that will break is a valid point.
> I'm not aware of any of those. Most vendor trees i've seen don't use
> this driver at all. I hope that will change at some point.
> 
> In the end. I'd prefer to have the driver's keypad matrix match
> the actual hardware. Right now we can have a 5x32 matrix which seems
> absurd. Having at most an 8x8 is more reasonable.
> 
> I'd like to send v3 with just fixing the row/column suggestion in
> mt6779_keypad_irq_handler() that Dmitry suggested.
> 
> Would that work Dmitry?

OK, let's do that. Although I'd be curious to see the double keypad
patches as according to the datasheets I saw the translation is
different for those.

Thanks.

-- 
Dmitry
