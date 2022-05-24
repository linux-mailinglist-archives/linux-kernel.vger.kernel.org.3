Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986DB5333B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiEXWzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbiEXWzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:55:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DAA78925
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:55:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m11so11121652ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRekGLDNoP5rx+B/vd1upb7Kog4EGMQSA7iBIC0Yezs=;
        b=Gv/w8RNRdDD3hMud5SnXZlnk9lZvZKr0+Er5LfMrhCX40eBKdAxYrF6Y3WtLOnsME5
         GDhztOnfzyoaXqkUhjNFShhdy4rmAyuPrTA9VkHja5PF/eBdJgO+LH5Gt8i/31ELd305
         CMup3uVMJAR4BVAAVXA1WXI9ctzjuWjapyJJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRekGLDNoP5rx+B/vd1upb7Kog4EGMQSA7iBIC0Yezs=;
        b=A9PUJ1/+tOy5R8acNunqokVa+nzKsspzw9ldBl6xZ4LSOYhmlZEf2nwxkTJpyAtWn/
         thdxS356ohxVTxVmjtQkiBTTyZTijRAlluvVVZuYWjwI6RCzKHZUNCFc/s0mCACuHT+E
         53YtCNOCv89vP3wfBD36XH89xnNbppaIaKGPNshMf9UzHalzmLWee9w6nCNsfUJjxuZm
         8N1M4lsvi+Uy5NUT7W0w8fh/1qLs6HZQ+fPaVuGS90BE1FCi1sX9boIHHmwpz5AEVae9
         qdsknxhlcgPea03lDASQ51BsdM53kR1nQbt1dQnXAJGtCTtgHLXhbCdldSY+1eXghoVm
         lcGw==
X-Gm-Message-State: AOAM533VtH4vxgZPzvHRrTTxrSBan4t+c56OWKiQ9XIBPck1m8HMsV4g
        D7KLl8wz1rRgyGbplYLXV5Q/46YWY2wIj6EK1bw=
X-Google-Smtp-Source: ABdhPJyjHAdsG8eIQk9Q80liw7jiXMZvL3nTSBkolofzcuCkxYgkXWZ4bqu0B2YVmQQB87HSrQ7o8w==
X-Received: by 2002:a17:906:58cd:b0:6fe:f9fe:8342 with SMTP id e13-20020a17090658cd00b006fef9fe8342mr7891578ejs.510.1653432920007;
        Tue, 24 May 2022 15:55:20 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709063da900b006f3ef214e2csm3095849ejh.146.2022.05.24.15.55.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:55:19 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id x12so3469020wrg.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:55:19 -0700 (PDT)
X-Received: by 2002:a5d:5009:0:b0:20d:846:f4da with SMTP id
 e9-20020a5d5009000000b0020d0846f4damr25189228wrt.301.1653432918580; Tue, 24
 May 2022 15:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220524134840.1.I80072b8815ac08c12af8f379a33cc2d83693dc51@changeid>
 <311a23c9-e31d-e20d-8ba9-80d3197e8d1d@somainline.org> <CAD=FV=WKgPWxEL+mhb9cCGOLObJEPtX_sHLQ1z3rz3usDG1m+Q@mail.gmail.com>
 <1d602bb6-d3a4-2ec0-e3e7-d9395edec416@somainline.org>
In-Reply-To: <1d602bb6-d3a4-2ec0-e3e7-d9395edec416@somainline.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 May 2022 15:55:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U2C1W+JHWyGRfyRB=WiPKLYvtjO90UDoJ9p+Xwe09+ow@mail.gmail.com>
Message-ID: <CAD=FV=U2C1W+JHWyGRfyRB=WiPKLYvtjO90UDoJ9p+Xwe09+ow@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add touchscreen to villager
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 24, 2022 at 3:41 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> On 25/05/2022 00:14, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, May 24, 2022 at 2:13 PM Konrad Dybcio
> > <konrad.dybcio@somainline.org> wrote:
> >>
> >> On 24/05/2022 22:48, Douglas Anderson wrote:
> >>> This adds the touchscreen to the sc7280-herobrine-villager device
> >>> tree. Note that the touchscreen on villager actually uses the reset
> >>> line and thus we use the more specific "elan,ekth6915" compatible
> >>> which allows us to specify the reset.
> >>>
> >>> The fact that villager's touchscreen uses the reset line can be
> >>> contrasted against the touchscreen for CRD/herobrine-r1. On those
> >>> boards, even though the touchscreen goes to the display, it's not
> >>> hooked up to anything there.
> >>>
> >>> In order to keep the line parked on herobrine/CRD, we'll move the
> >>> pullup from the qcard.dtsi file to the specific boards. This allows us
> >>> to disable the pullup in the villager device tree since the pin is an
> >>> output.
> >>>
> >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>> ---
> >>> This uses bindings introduced in the patch ("dt-bindings: HID:
> >>> i2c-hid: elan: Introduce bindings for Elan eKTH6915") [1].
> >>>
> >>> [1] https://lore.kernel.org/r/20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid
> >>>
> >>>    .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 11 ++++++++
> >>>    .../qcom/sc7280-herobrine-herobrine-r1.dts    | 11 ++++++++
> >>>    .../dts/qcom/sc7280-herobrine-villager-r0.dts | 25 +++++++++++++++++++
> >>>    arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 -
> >>>    4 files changed, 47 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> >>> index a4ac33c4fd59..b79d84d7870a 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> >>> @@ -134,6 +134,17 @@ &sdhc_2 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> >> Please drop this line, this isn't msm-3.4. It's immediately obvious that
> >> if a pin is referenced by a label and it is not defined in this file
> >> (because otherwise it wouldn't be both defined and referenced here..),
> >> it comes from a previously included device tree.
> > In general these headings specify a change in sort ordering. Without
> > them then either we intersperse pinctrl overrides with other stuff,
> > which IMO is overall worse or people have no idea why the sort
> > ordering changes.
>
> I get what you mean, but at the end of the day, the entire machine DT
> specifies all machine-specific changes and only machine-specific
> changes. They all are a part of a bigger picture, sometimes being
> downstream from the SoC, sometimes downstream from a common board. I
> don't think it brings much benefit if at all to separate them into
> sections like these, if in the end they all correspond to modifications
> present in the hardware. In its current form, the sorting is all over
> the place, and ideally we could have labels sorted alphabetically.

I think overall DT just made it hard. In my mind the root of the
problem is actually that we're trying to avoid replicating hierarchy
from the dtsi files that we include. In other words, we try very hard
to do:

&qup_i2c2_data_clk {
  bias-disable;
};

Instead of replicating the hierarchy in the board dts files, like this:

/ {
  soc@0 {
    pinctrl@f100000 {
      qup-i2c2-data-clk {
        bias-disable;;
      };
    };
  };
};

(and, of course, you could replicate parts of the hierarchy too).

When you avoid replicating things then it really causes everything to
become scattered / disorganized and I think there's a benefit to
trying to enforce some type of ordering.


> The present solution, in my opinion, causes more disarray as you first
> have to think about what is the change against and then find it in the
> corresponding subsection instead of thinking of it as a complete
> quote-on-quote diff against the parent DTSIs.

It's a fair opinion. I'd be interested to know if others feel the same
way. In general it feels like a style decision for the people working
on these boards, subject to the approval of the Qualcomm tree
maintainer(s).


> Plus, most DTs don't split
> it like that.

I will say that it's hard to compare the trogdor (and now herobrine)
situation with most other ARM boards out there. There are _a lot_ of
different variants and revisions and it's, IMO, more art than science
in trying to balance all of the tradeoffs between duplicating code and
ending up with unreadable spaghetti. I won't claim that we made the
right tradeoff in every case, but so far experience on trogdor has
been that things ended up being fairly understandable I think?

-Doug
