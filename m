Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64344FFF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiDMTwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiDMTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:52:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008A63C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:49:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s6so2169907qta.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWhg8FYrwiDvTjNkit0qohdSV+25nG22l6zhmrrKuHs=;
        b=UVXBRhGJXjk27RSaWfnvYK+Hqgi2ccUbtpZBIu0g1pYwBUFJd4upn4XRm+8sKCjh/0
         Kgw7t3ywUdk3/4eMTi7F6PH6vD7rDb2P93VT9nVR+5pGoP1IXw0EmTIu/kGAi8uIOaBN
         wfgXMm6pnfOFpY2vP7JWoeLJ9pY07qcraaedlopJHw7XTls158buDpA6q7cF0ki6m8aA
         HVNQIoOOPPCMVsddhVYdFgAt/6qf+J0yveWIAHSFB5Hu8Bu2u7kEga9T79kqjHmpKq3w
         +0RpilCycVK0mZB+NJsqao1XzV8evfmhQvccK/KRNhiuKSJPzA7ZxjdEwxQ1xwSl/7vF
         Xzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWhg8FYrwiDvTjNkit0qohdSV+25nG22l6zhmrrKuHs=;
        b=HXnvYjScBt+pZyIvJgm6U6fk2fwLvwocH3U98gGvPm6Dt2c9TTkhbglfk3zE9SM7c6
         ZZfDicCrI7Q/Sj56ZimAvLFJ0ae5pe5D5ZcLq3wrF3EMQhaeu4ksaHYM2YnHW/AL0qgl
         2mexzU4TduKzPJbsAk90mVje9jNFYoUNWp2HTRS+voJbZEc05AjdUS1CmtbOG5Ra92hY
         TxTQ9I+sglRBLdWloOSQnvDIFUP3n6yMR1uiAcuTerxkJtJSbyLZvQ4QxzSuFZSTMidG
         2VFFUT718cGMKiYx/YqICObHEEuBvCLffuNiENwaI4cblDNv/Dunr+mJHqDuqrCuwN6P
         yB8Q==
X-Gm-Message-State: AOAM531h5c0EMKFDPl46hcZUkLc1RH2ck9XtjXdzrPTIr3SvJ97g0T3o
        C+Ln0apJEIKqunX6HX+akgExHGUBQORGDgziNLng8Q==
X-Google-Smtp-Source: ABdhPJx0lncQLECFXIJV4QmB/4mAIDmn99y9fY2qi4N3G4NCzik8CW4CqUsgWH3Aw0AO2oqKkjChssJqTwvg7oic4tk=
X-Received: by 2002:ac8:4e52:0:b0:2e1:dad8:5141 with SMTP id
 e18-20020ac84e52000000b002e1dad85141mr8463022qtw.62.1649879382319; Wed, 13
 Apr 2022 12:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <c5af6c12-961d-43e2-31ea-cbda9ac347cf@linaro.org>
 <62570cdd.1c69fb81.7eb7.12e8@mx.google.com>
In-Reply-To: <62570cdd.1c69fb81.7eb7.12e8@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 13 Apr 2022 22:49:31 +0300
Message-ID: <CAA8EJpqB3EOniDhO3be4Faa1SBScobJ=tzf2Oh_Lh_38i5ZXGw@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Modernize rest of the krait drivers
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 20:48, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> On Wed, Apr 13, 2022 at 08:31:31PM +0300, Dmitry Baryshkov wrote:
> > On 22/03/2022 02:15, Ansuel Smith wrote:
> > > This is a follow-up to the ipq806x gcc modernize series. Manu cleanup
> > > changes and also some discoveries of wrong definition notice only with
> > > all these conversions.
> >
> > General comment regarding this patch series. It contains fixes, clock
> > conversion for several drivers, dts fixes, etc. It's, for example, not
> > straightforwardly obvious if Bjorn can pickup patches 04 or 06 without
> > picking up other patches.
> >
> > If would be best if you can split this series or at least pull fixes to be
> > the first patches in the pile.
> >
>
> Considering that now this is grown to 21 patch in v7 (that is still have
> to push)... Yes I think I have to split this...
> Wonder if you can give me some hint.
>
> - Series for krait-cc
> - Series for kpss-acc/gcc
> - Single patch for hfpll
> - Single patch for gcc fixes
> - Series for kpss-xcc
> - Series for clk-krait
> - Series for dts fixes?

Yes, this sounds more or less logical. hfpll can go together with any
of the krait patches.
If you'd like a fewer series, the following looks sane too:
- fixes for hfpll, clk-krait, etc. Small changes that can be picked up
immediately.
- modernize gcc,
- update dts to follow gcc changes
- cpufreq drivers conversion
- update dts to follow cpufreq changes

As a generic notice: it might sound awkward, but could you please
split dt-bindings conversions (that were not R-B yet) into separate
parts:
- Just convert to yaml, no changes
- fix this-and-that.

I think Krzyshtof and Rob has already asked for that, but it's still
worth mentioning.

To stop from flooding the list, what about:
- posting fixes patches
- posting and polishing gcc conversion + dts updates

The rest can come up later. It might sound like a delay, but in
reality it might be easier to review.

> Wonder if this kind of split can work?
>
> > Patch 01 is only used by patch 10, they can stay close.
> >
> > In some of the commit messages you describe what do they do, but you
> > completely omit the reason for the change, why is the change necessary.
> > (Yes, I spot that because I also too often skip that).
> >
> > >
> > > The first patch is an improvement of the clk_hw_get_parent_index. The
> > > original idea of clk_hw_get_parent_index was to give a way to access the
> > > parent index but for some reason the final version limited it to the
> > > current index. We change it to give the current parent if is not
> > > provided and to give the requested parent if provided. Any user of this
> > > function is updated to follow the new implementation.
> > >
> > > The patch 2 and 3 are some additional fixes for gcc.
> > > The first one is a fix that register the pxo and cxo fixed clock only if
> > > they are not defined in DTS.
> > > The patch 3 require some explaination. In short is a big HACK to prevent
> > > kernel panic with this series.
> > >
> > > The kpss-xcc driver is a mess.
> > > The Documentation declare that the clocks should be provided but for some
> > > reason it was never followed.
> > > In fact in the ipq8064 DTSI only the clocks for l2cc are declared but
> > > for cpu0 and cpu1 the clocks are not defined.
> > > The kpss-xcc driver use parent_names so the clks are ignored and never
> > > used so till now it wasn't a problem (ignoring the fact that they
> > > doesn't follow documentation at all)
> > > On top of that, the l2cc node declare the pxo clock in a really strange
> > > way. It's declared using the PXO_SRC gcc clock that is never defined in
> > > the gcc ipq8064 clock table. (the correct way was to declare a fixed
> > > clock in dts and reference that)
> > > To prevent any kind of problem we use the patch 3 and provide the clk
> > > for PXO_SRC in the gcc clock table. We manually provide the clk after
> > > gcc probe.
> > >
> > > Patch 4 is just a minor cleanup where we use the poll macro
> > >
> > > Patch 5 is the actually kpss-xcc conversion to parent data
> > >
> > > Patch 6-7 should be a fixup of a real conver case
> > >
> > > Patch 8 converts the krait-cc to parent_data
> > > Patch 9 give some love to the code with some minor fixup
> > > Patch 10 drop the hardcoded safe sel and use the new
> > > clk_hw_get_parent_index to get the safe parent index.
> > > (also I discovered that the parent order was wrong)
> > >
> > > Patch 11 is an additional fixup to force the reset of the muxes even
> > > more.
> > >
> > > Patch 12-13 are some additiona taken from the qsdk that were missing in
> > > the upstream driver
> > >
> > > Patch 14 converts krait-cc to yaml
> > >
> > > Patch 15 add to krait-cc Documentation the L2 clocks
> > >
> > > Patch 16 converts the kpss-acc driver to yaml and fix some Documentation
> > > error
> > >
> > > Patch 17 convets the kpss-gcc driver to yaml
> > >
> > > Patch 18 finally adds all this stuff to the ipq8064 dtsi (and fix the
> > > stupid PXO_SRC phandle)
> > >
> > > I tested this series on a ipq8064 SoC by running a cache benchmark test
> > > to make sure the changes are correct and we don't silently cause
> > > regressions. Also I compared the output of the clk_summary every time
> > > and we finally have a sane output where the mux are correctly placed in
> > > the correct parent. (till now we had the cpu aux clock all over the
> > > place, probably never cause problems but who knows.)
> > >
> > > v6:
> > > - Move dts patch as last patch
> > > - Address commencts from Rob
> > > - Fix warning from make dtbs_check
> > > v5:
> > > - Address comments from Krzysztof
> > > v4:
> > > - Fix more dt-bindings bog errors
> > > v3:
> > > - Split Documentation files for kpss and krait-cc
> > > v2:
> > > - introduce new API instead of fixing the existing one
> > > - do not reorganize variables in krait-cc
> > > - fix some comments error and improve it
> > > - return better error for patch 7
> > > - fix missing new line on patch 16
> > >
> > > Ansuel Smith (18):
> > >    clk: introduce clk_hw_get_index_of_parent new API
> > >    clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
> > >    clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
> > >    clk: qcom: clk-hfpll: use poll_timeout macro
> > >    clk: qcom: kpss-xcc: convert to parent data API
> > >    clk: qcom: clk-krait: unlock spin after mux completion
> > >    clk: qcom: clk-krait: add hw_parent check for div2_round_rate
> > >    clk: qcom: krait-cc: convert to parent_data API
> > >    clk: qcom: krait-cc: drop pr_info and register qsb only if needed
> > >    clk: qcom: krait-cc: drop hardcoded safe_sel
> > >    clk: qcom: krait-cc: force sec_mux to QSB
> > >    clk: qcom: clk-krait: add apq/ipq8064 errata workaround
> > >    clk: qcom: clk-krait: add enable disable ops
> > >    dt-bindings: clock: Convert qcom,krait-cc to yaml
> > >    dt-bindings: clock: Add L2 clocks to qcom,krait-cc Documentation
> > >    dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
> > >    dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
> > >    ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and
> > >      clocks
> > >
> > >   .../bindings/arm/msm/qcom,kpss-acc.txt        |  49 -----
> > >   .../bindings/arm/msm/qcom,kpss-acc.yaml       |  94 +++++++++
> > >   .../bindings/arm/msm/qcom,kpss-gcc.txt        |  44 -----
> > >   .../bindings/arm/msm/qcom,kpss-gcc.yaml       |  69 +++++++
> > >   .../bindings/clock/qcom,krait-cc.txt          |  34 ----
> > >   .../bindings/clock/qcom,krait-cc.yaml         |  65 ++++++
> > >   arch/arm/boot/dts/qcom-ipq8064.dtsi           |  24 ++-
> > >   drivers/clk/clk.c                             |  14 ++
> > >   drivers/clk/qcom/clk-hfpll.c                  |  13 +-
> > >   drivers/clk/qcom/clk-krait.c                  |  44 ++++-
> > >   drivers/clk/qcom/clk-krait.h                  |   1 +
> > >   drivers/clk/qcom/gcc-ipq806x.c                |  27 ++-
> > >   drivers/clk/qcom/kpss-xcc.c                   |  25 +--
> > >   drivers/clk/qcom/krait-cc.c                   | 186 ++++++++++--------
> > >   include/linux/clk-provider.h                  |   1 +
> > >   15 files changed, 453 insertions(+), 237 deletions(-)
> > >   delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> > >   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> > >   delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> > >   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > >   delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> > >   create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry
>
> --
>         Ansuel



-- 
With best wishes
Dmitry
