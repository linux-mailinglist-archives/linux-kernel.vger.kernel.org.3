Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35805A5715
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiH2W0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2W0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103D6DAF2;
        Mon, 29 Aug 2022 15:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E733E612D8;
        Mon, 29 Aug 2022 22:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47241C433C1;
        Mon, 29 Aug 2022 22:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661811961;
        bh=9PgmZy0jvGGRZ2ByCdHTr65AHI6ebSwTd6y0g9N3GOc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LCBpru72pBaMJ5AELcSqRoMr/A3XblQW4ulGWkoiYS3y4lYd10IdmIlg57eXIPsyd
         E7cOicFmHoM+tbRvuXLk+qbt0QmCyTZCJZFfzYcY6C0Ckk7YM+INL/pALjgI/kUwg6
         ku6yHlhagIAmrDnU4KmbmtDI3ZHgdBDrfxCdSFRAxL+5a0lQsO0fLcDJ54onAUZESR
         tvNCBYSmZmeRCuX9ChJespHhMxCNVei15V34zBYTQthcGHjOLiXNUrHmikDM3roOhY
         +4spE0hyY4KpHzkC+rVyWCETQm66h/sBGNlRu3x3Sxv1ARA/qrYKlES5846IWmKrZV
         QHJkHaowrCzQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4f1ae43c-0f22-19fe-0794-3cc268104396@linaro.org>
References: <20220201134108.2677578-1-vkoul@kernel.org> <YhUVAwtfjuIdKrRQ@matsya> <1c66890b-6736-61ef-7d16-619f90ced4a0@linaro.org> <4f1ae43c-0f22-19fe-0794-3cc268104396@linaro.org>
Subject: Re: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     David Collins <quic_collinsd@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Date:   Mon, 29 Aug 2022 15:25:59 -0700
User-Agent: alot/0.10
Message-Id: <20220829222601.47241C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2022-06-18 08:29:58)
> On 01/05/2022 22:41, Dmitry Baryshkov wrote:
> > On 22/02/2022 19:53, Vinod Koul wrote:
> >> On 01-02-22, 19:11, Vinod Koul wrote:
> >>> Hello,
> >>>
> >>> The is version 3 of support for PMIC v7. I have added a new property
> >>> qcom,bus-id for supporting v7 and then add driver changes for v7
> >>>
> >>> This depends on yaml conversion patch:
> >>> https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ix=
it.cz/=20
> >>>
> >>
> >> Any feedback on this...
> >=20
> > Another gracious reminder about these patches. At this moment this is=20
> > one of the important pieces lacking for the full SM8450 support in the =

> > upstream kernel.
>=20
> Stephen, yet another ping. This is the blocking point for the further=20
> SM8450 progress.
>=20

Sorry I completely missed this one as it fell off the end of my inbox
into the abyss.
