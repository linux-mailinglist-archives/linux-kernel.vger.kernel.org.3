Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1FA5308F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiEWFmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiEWFmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:42:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A44E222B2;
        Sun, 22 May 2022 22:42:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q4so12119103plr.11;
        Sun, 22 May 2022 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V+esiB0EBSG8dOJHRbOX36eLypWwW10L3M7nK7Ft+JA=;
        b=LqWsFoEhEtXJ03wP/CUlkiR2MMLHq9MdzTMrsCEsLAQKdHKeXsVfUj3PsYC9pmAQXR
         DoUWCY4o8SqL4E1YOw7ASXbHe5nHHyBIqVMHaIHq5y5qnNErHsJj3tI5lekMLR79O52B
         TBCLlo94cF7d5mzPOHPI4OUL37J/Zq6Bm6LHAG/XKDRuPXXPnuzl8aNEVPUKlZUlKg8v
         l88you7k8V6dkm9HIB1wErtuBDzTM+e/zpU8KBOkk23R7FdvMxiKMobK8oe/4LmNAbPQ
         9ssDVfmfmcG71IfTL9NJ6vumoBwbr3bcfjEEV3xcNluHiLnWnoSMFounR8tQrsn1usAW
         780A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V+esiB0EBSG8dOJHRbOX36eLypWwW10L3M7nK7Ft+JA=;
        b=b8JtE68SuKpU75B9lDX8x8WvvLesfgsdJ6SfJQhLakLeYpsyn+WTULviBw6citMk2M
         JcQjcsM9f1R8TVgKdZDlpsUoK+ievhEN3T3S/2sb4MxiCG64cvdJga4sCPfDeIV0CYur
         WkBlj5jEnKuDQmHF3JWWStvZn+aUHWWvN2zkt387frWJ4blXHwtBPAjEPqht7Aht7Zs5
         VFPsXui7CdNXp0HZFz5tXgcxGODpXX+3ZkHlr3KTkrhy/1wSjpmKqi95ZZ+NZ5F1QcYS
         BogUSdo5jX1U8+p2ACynJawaOBi7eiPbtdSp2GaHmYEuKjKXUTXouZbgKzR+laBr+Oe0
         f01A==
X-Gm-Message-State: AOAM5328U0wEtFMXJBfmo/GhmMhdY3Ggqi+IG4aDpagasQGNewYE5Bnl
        y+XJcBJZCP33m4Vme0IVGXQ=
X-Google-Smtp-Source: ABdhPJyyQ+cfxgfexa3htOxvWWsetFYRz47y02NjNOB0aSqzbEXIh5HdyuJt4/n8vLL4FQWN4tGpgg==
X-Received: by 2002:a17:90a:2809:b0:1df:35ca:2e6a with SMTP id e9-20020a17090a280900b001df35ca2e6amr24493051pjd.8.1653284555278;
        Sun, 22 May 2022 22:42:35 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d84e:5dcd:9d68:ebbf])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902f38200b0015eaa9797e8sm4051485ple.172.2022.05.22.22.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 22:42:34 -0700 (PDT)
Date:   Sun, 22 May 2022 22:42:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] Input: mt6779-keypad - fix hardware code
 mapping
Message-ID: <Yosex9/a7OTuC6ZK@google.com>
References: <20220513151845.2802795-1-mkorpershoek@baylibre.com>
 <20220513151845.2802795-2-mkorpershoek@baylibre.com>
 <YoHf6Z4HTfh4Y+bn@google.com>
 <874k1qkk7n.fsf@baylibre.com>
 <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7bcbfb-12da-0e3f-8732-ecc53046a4ff@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 01:06:43PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/05/22 09:30, Mattijs Korpershoek ha scritto:
> > Hi Dmitry,
> > 
> > Thank you for your review,
> > 
> > On dim., mai 15, 2022 at 22:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > > On Fri, May 13, 2022 at 05:18:44PM +0200, Mattijs Korpershoek wrote:
> > > > In mt6779_keypad_irq_handler(), we
> > > > 1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
> > > > 2. Use that hardware code to compute columns/rows for the standard
> > > >     keyboard matrix.
> > > > 
> > > > According to the (non-public) datasheet, the
> > > > map between the hardware code and the cols/rows is:
> > > > 
> > > >          |(0)  |(1)  |(2)
> > > >      ----*-----*-----*-----
> > > >          |     |     |
> > > >          |(9)  |(10) |(11)
> > > >      ----*-----*-----*-----
> > > >          |     |     |
> > > >          |(18) |(19) |(20)
> > > >      ----*-----*-----*-----
> > > >          |     |     |
> > > > 
> > > > This brings us to another formula:
> > > > -> row = code / 9;
> > > > -> col = code % 3;
> > > 
> > > What if there are more than 3 columns?
> > That's not supported, in hardware, according to the datasheet.
> > 
> > The datasheet I have states that "The interface of MT6763 only supports
> > 3*3 single or 2*2 double, but internal ASIC still detects keys in the
> > manner of 8*8 single, and 3*3 double. The registers and key codes still
> > follows the legacy naming".
> > 
> > Should I add another patch in this series to add that limitation in the
> > probe? There are no checks done in the probe() right now.
> > 
> 
> I've just checked a downstream kernel for MT6795 and that one looks like
> being fully compatible with this driver as well... and as far as downstream
> is concerned, apparently, mt6735, 6739, 6755, 6757, 6758, 6763, 6771, 6775
> all have the same register layout and the downstream driver for these is
> always the very same one...
> 
> ...so, I don't think that there's currently any SoC that supports more than
> three columns. Besides, a fast check shows that MT8195 also has the same.
> At this point, I'd say that assuming that there are 3 columns, nor less, not
> more, is just fine.

OK, now that I looked at the datasheet I remember how it came about. The
programming (register) interface does not really care about how actual
matrix is organized, and instead has a set of bits representing keys,
from KEY0 to KEY77, arranged in 5 chunks of 15 bits split into 5 32-bit
registers. So we simply decided to use register number as row and
offset in the register as column when encoding our "matrix".

This does not match the actual keypad matrix organization, so if we want
to change this, that's fine, but then we also need to recognize that we
are skipping bits 16-31, 48-63, and so on, so to get to the right key
number we need to do something like:

	key = bit_nr / 32 * 16 + bit_nr % 32;
	row = key / 9;
	col = key % 9;

I looked at the datasheets I have and they talk about 8x8 single keypad
matrix, and 3x3 double keypad (with actual matrices either 3x3 or 2x2)
but I do not actually see this map layout that Mattijs drew  documented
anywhere though...  I also wonder if there are already existing DTSes in
the wild that will be rendered invalid by these changes. I wonder if it
would not be be better to document the existing meaning of row and
column in the driver?

Thanks.

-- 
Dmitry
