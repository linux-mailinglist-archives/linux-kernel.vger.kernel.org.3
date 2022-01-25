Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2066E49BDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiAYVD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiAYVD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:03:56 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D6DC06173B;
        Tue, 25 Jan 2022 13:03:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m4so33610813ejb.9;
        Tue, 25 Jan 2022 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZWmh2h20/Ppq9P53tUgQhWhtyYToJQ+iTOhDusr5rAo=;
        b=E3zyjjFljbfKMMIVTkx1OrDkDkxLl7L2rwhzpPRP1QcrCG/xkBC08O16xwkDwBhPoK
         UJg+G2weiSCuCFIcS3Uj3Zm322hVruu/H49emGu6clkplX4qmolrJSUd5mRQqARZZ2PE
         JTNuPlCDT1fZkRHJKp83FIDae29PR+zSA6oFRME2+kfuxDpB9G8Y+AO7CTyfMYOenT6S
         d6q4eucSD/U6WhztaZ8C8VX2aodDEdjNvqwzzyn/wE3thGGmXxmyo7X8OlgxgCbgieGS
         d9nX9Ifa9JZbv/LBcRLcFu7OMTJu8dEcDwjlEVMfHxhdrPWebqaeJMvXdM6+9zFHsafh
         Zagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWmh2h20/Ppq9P53tUgQhWhtyYToJQ+iTOhDusr5rAo=;
        b=Y+LGHQBy+wFWE2xbSy0jZiHBSKYRbt2DmZD5xP6we7wVVxGJja+fAqAUaTJdagLtJA
         I3d2keiRPRfeC2/9dIRqL4Q1CkRL7EGJED/boW5r+1ooVyXeXIiTOLPAzPSnAJo5GVM0
         9wtEdXz6a9rCqKjcKnLeGgpn472uS0pAaDx1A0B79Bdo3v1qeoxLV8kfrJ2ANAAYeOvI
         Sw/YEj1aXRPmz9zXNZFWxSfZVypFWgI3gKVRHZzA2oDKYvjbFHth2KCu+6wgGd2tIC7/
         0m63w7zZ3xGaBjpOXHkmVBAEqZlzStKV/3FxMGTs7mCHRGLxlKWtp3FMj0zmU2UtqeKJ
         XRrA==
X-Gm-Message-State: AOAM533WDpRhtYPM4lyC1A4l+DiWTriuwadIm5tg99xHuQNp4vuvUOg0
        survPsppjSouV+/sO75aYVw=
X-Google-Smtp-Source: ABdhPJzRPXpObjl/ffulnHt+jhYqdswb14Wztnlsd0cdOo95B7pxvqPfzqsAhv8h2/x4qy/Ozr8BjA==
X-Received: by 2002:a17:907:7291:: with SMTP id dt17mr4650144ejc.521.1643144634272;
        Tue, 25 Jan 2022 13:03:54 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id q10sm6640067ejn.3.2022.01.25.13.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:03:53 -0800 (PST)
Message-ID: <61f065b9.1c69fb81.ed14d.b9e2@mx.google.com>
X-Google-Original-Message-ID: <YfBluFBV6OS/MTlx@Ansuel-xps.>
Date:   Tue, 25 Jan 2022 22:03:52 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/15] drivers: clk: qcom: gcc-ipq806x: add additional
 freq for sdc table
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
 <20220121210340.32362-11-ansuelsmth@gmail.com>
 <20220125204555.91DB4C340E0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125204555.91DB4C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:45:53PM -0800, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-01-21 13:03:35)
> > Add additional freq supported for the sdc table.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq806x.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > index 77bc3d94f580..dbd61e4844b0 100644
> > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > @@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] = {
> >         {  20210000, P_PLL8,  1, 1,  19 },
> >         {  24000000, P_PLL8,  4, 1,   4 },
> >         {  48000000, P_PLL8,  4, 1,   2 },
> > +       {  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */
> 
> Why the comment and fake rate? Can it be 51200000 instead and drop the
> comment?

I will add the related reason in the commit.

We cannot achieve exact 52Mhz(jitter free) clock using PLL8.
As per the MND calculator the closest possible jitter free clock
using PLL8 is 51.2Mhz. This patch adds the values, which will provide
jitter free 51.2Mhz when the requested frequency is 52mhz.

-- 
	Ansuel
