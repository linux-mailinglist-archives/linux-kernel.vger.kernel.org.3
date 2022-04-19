Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80825076DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbiDSR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiDSR6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:58:25 -0400
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BEAE4B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:55:40 -0700 (PDT)
Date:   Tue, 19 Apr 2022 17:55:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1650390938;
        bh=PPJ08Z7LC0SXHf4H31iWdRBqP0exCCppE446+ZFQcHE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=tQ4pSJmcBk/k3762L94PTahcCu6Kr6yb0gzV8BvTnAQqIjaUp2oDDUWF0IGC0/qt1
         CnHBmxfVAYIB3r7mb0/EZRmiKCyPXGgJj3xsk0CaPXKJewDwXaBHWZCQZ2SrHgVN0F
         iJqhAzLvjcEizBsRrfKqqOmrGAXm90+7gJ+JZUQFAeI1xPSBk7Tt2hR14go7Bd/fZ6
         J7AUn5sObYWYOI0VwAugi0smzqYSRSqqUBJoXlSeH60tuQ476/ELo9fU7Hsb/mhvfz
         WTuAL1b1TjK81qjBLEe3WfR+FLnAQYevaLh67xiI6UfLl/TiEquNzvo9us2Kn+nrhw
         O3Md95y+s0loA==
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 3/9] clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF support
Message-ID: <sld5QpXz-AMurBB0RoYLgMHsEcUsgubB_V3YQO8HP8vFxjd7RwALrHFYBJSiv09SMsXuy4nnWDy2ZQ8IRlEnTl1zXb4EXqPT19y_n-GMd9Q=@protonmail.com>
In-Reply-To: <Yl72EFQbntGUi2tm@builder.lan>
References: <kXrAkKv7RZct22X0wivLWqOAiLKpFuDCAY1KY_KSx649kn7BNmJ2IFFMrsYPAyDlcxIjbQCQ1PHb5KaNFawm9IGIXUbch-DI9OI_l73BAaM=@protonmail.com> <Yl72EFQbntGUi2tm@builder.lan>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 19th, 2022 at 9:49 PM, Bjorn Andersson <bjorn.andersson@l=
inaro.org> wrote:
> On Fri 08 Apr 23:16 CDT 2022, Yassine Oudjana wrote:
>
> > MSM8996 Pro (MSM8996SG) has a /4 divisor on the CBF clock
> > instead of /2. This allows it to reach a lower minimum frequency
> > of 192000000Hz compared to 307200000Hz on regular MSM8996.
> > Add support for setting the CBF clock divisor to /4 for MSM8996 Pro.
> >
> > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
> > Reviewed-by: Konrad Dybcio konrad.dybcio@somainline.org
> > ---
> > drivers/clk/qcom/clk-cpu-8996.c | 61 +++++++++++++++++++++------------
> > 1 file changed, 40 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu=
-8996.c
> > index 8afc271f92d0..231d8224fa16 100644
> > --- a/drivers/clk/qcom/clk-cpu-8996.c
> > +++ b/drivers/clk/qcom/clk-cpu-8996.c
> > @@ -70,11 +70,11 @@ enum _pmux_input {
> >
> > enum {
> > CBF_PLL_INDEX =3D 1,
> > - CBF_DIV_2_INDEX,
> > + CBF_DIV_INDEX,
> > CBF_SAFE_INDEX
> > };
>
>
> I don't have this enum in my tree. Could you please double check that
> this works on linux-next?

It's added in a patch[1] that isn't applied yet. The patch is mentioned
in the cover letter, which you had trouble finding unfortunately.

> And can you please send the next revision using git send-email with a
> cover-letter, so that the patches are related in my inbox.

Sorry about that. I've already resent the series properly. You should
find [PATCH RESEND v2 */9] in your inbox, otherwise here[2] is a link.

[1] https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-1-konrad.d=
ybcio@somainline.org/
[2] https://lore.kernel.org/linux-arm-msm/20220416025637.83484-1-y.oudjana@=
protonmail.com/T/#t
