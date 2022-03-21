Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E264E3018
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352229AbiCUSiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345165AbiCUSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:38:00 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381117CDEE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:36:35 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so20163951oos.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yXYEBuW6VaDVgClKY3HKdDJSY8KyrlZEOVA56VtcWa4=;
        b=AMClZKU3SKzDzuaJpTabi6xrGsDRYAM73Jppk48lHzd5Ma/lHr8lXJh6zbwtJujY1g
         GEvaGdwRC5L+KCqVFgYYzHdGxuSuCTJs4B9LawELpTXpNAytnHhivXUlbApZ/KBvnmqP
         eDlEeAC9gzGFA7ALWMLyd7iG/Fe+t/5EV/AeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yXYEBuW6VaDVgClKY3HKdDJSY8KyrlZEOVA56VtcWa4=;
        b=4D7Vdy34c5pmeCrB4yCCRDncftC/aBIWfuVMPWuMLenG/ga9yZrrfK4P/HBRFmxxC1
         T/Dz0RvZ+aCZmD0ZPiq7pT2pZnDb75DC/ApX/DwVUoePWKtm48xFHCrCvHtrmDWWlR+f
         HdJOGl0k3CSAiFyx/F2sPkgG8bf/XDPdcNlwbIcLTdw8Ojha13MBYvfM8geIIC5JsWFn
         bEe1bXNs/U+2KXF/zw1gufyfOn11cXSHIt21XBK+BGb62z3geGZ1eeX+QtdsJMnPXYW+
         hCLoRcW998l6JKzGiHhM/dBFDOtKV5MgXNwW0P0z58PZwSbnMbbJGZBX/em5p6Amxbp0
         C7nw==
X-Gm-Message-State: AOAM533y0teMJrD5Hx6sBLZq/rQrXUkDJBGObyfz9hS/19WLGEqLgrUi
        DIaVzC1NrCc3RY0uI9bvlS86j/NrpPQr5wr2vn1m1A==
X-Google-Smtp-Source: ABdhPJzUFRaISHJP1MIIbyFz2LgziTazZlouqsO6VXm4BnAJFnDis079ZvsCevPAQzA5liEcTbirPV3VGTbE530ZTg8=
X-Received: by 2002:a05:6870:c0cb:b0:da:2bcc:aa09 with SMTP id
 e11-20020a056870c0cb00b000da2bccaa09mr194320oad.63.1647887794519; Mon, 21 Mar
 2022 11:36:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 19:36:33 +0100
MIME-Version: 1.0
In-Reply-To: <20220319152641.49d8b3e1@jic23-huawei>
References: <20220318204808.3404542-1-swboyd@chromium.org> <20220319152641.49d8b3e1@jic23-huawei>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 19:36:33 +0100
Message-ID: <CAE-0n52jDZz0qKhfg8OWVDmDg5+xXo-qSL3jNka82QHwA2-xsw@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Cameron (2022-03-19 08:26:41)
> On Fri, 18 Mar 2022 13:48:08 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> Hi Stephen,
>
>
> > There are four possible gain values according to sx9324_gain_vals[]: 1,
> > 2, 4, and 8. When writing and reading the register the values are off by
> > one.
> > The bits should be set according to this equation:
> >
> >       ilog2(<gain>) + 1
> >
> > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > in the register field, etc. Fix up the functions.
>
> So is the 0 value reserved?  I can't find an sx9324 datasheet but he
> 9320 is online and that seems to be the case there.  If so please state
> that in this description as well.

Yes 0 is reserved. The top of this driver's C file has the datasheet
link[1]

>
> >
> > Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/iio/proximity/sx9324.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > index 0d9bbbb50cb4..a3c8e02f5a56 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -379,7 +379,10 @@ static int sx9324_read_gain(struct sx_common_data *data,
> >       if (ret)
> >               return ret;
> >
> > -     *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > +     regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > +     if (regval)
>
> If 0 is reserved then I'd return and error code here to indicate
> we don't know what the gain is rather than carrying on regardless.
> Or is this going to cause problems as it will be an ABI change (error
> return possible when it wasn't really before)?
>

That sounds OK to me. The driver is only being introduced now so we can
still fix it to reject a gain of 0. Unless 0 should mean "off", i.e.
hardware gain of 1?

[1] https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
