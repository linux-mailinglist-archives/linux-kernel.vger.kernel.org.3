Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956285A6EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiH3VLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiH3VLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:11:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280583BC9;
        Tue, 30 Aug 2022 14:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA2A6189B;
        Tue, 30 Aug 2022 21:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D60EC433C1;
        Tue, 30 Aug 2022 21:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661893889;
        bh=YQczJDoWHrrzHXLNRmEXxN/XN8OekTTO/w8CYT9s7Gk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B2WRfYXjcjJGlnFPKD5M6ghoxmQnEpee9Mr0TVTjurh4kJgO++pN6ZEbaz6j4BEt7
         kdgS5Q/ZLxvOOPJkfHMh179ewQDIH+qIOZwR1O0fQ1DPfl+PVSTCiOL2g/hRPsc3GE
         6cpcG8lE/IxJbP5jYobFBVTkPJIAjNlcawiiSvC+yNPlaMaWKQ05wrfzjJLaNnu3ZL
         nOu7XFqzU+ooLTsgcyXexX25WfU+nFoH0DrOeLcqeYQHtAavEGdlxr8L9+Z+wOSxJl
         BB4VjdTMlecIuDXNFKozxH+TdWD9IUKU1DRR9ApsN/Jkvj/d1G3oUHaYGZhcRf4YXG
         uyfn6u+97XWaQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yw2TsARPfuCLvDg0@matsya>
References: <20220201134108.2677578-1-vkoul@kernel.org> <YhUVAwtfjuIdKrRQ@matsya> <1c66890b-6736-61ef-7d16-619f90ced4a0@linaro.org> <4f1ae43c-0f22-19fe-0794-3cc268104396@linaro.org> <20220829222601.47241C433C1@smtp.kernel.org> <Yw2TsARPfuCLvDg0@matsya>
Subject: Re: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Vinod Koul <vkoul@kernel.org>
Date:   Tue, 30 Aug 2022 14:11:27 -0700
User-Agent: alot/0.10
Message-Id: <20220830211129.6D60EC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2022-08-29 21:36:00)
> On 29-08-22, 15:25, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2022-06-18 08:29:58)
> > > On 01/05/2022 22:41, Dmitry Baryshkov wrote:
> > > > On 22/02/2022 19:53, Vinod Koul wrote:
> > > >> On 01-02-22, 19:11, Vinod Koul wrote:
> > > >>> Hello,
> > > >>>
> > > >>> The is version 3 of support for PMIC v7. I have added a new prope=
rty
> > > >>> qcom,bus-id for supporting v7 and then add driver changes for v7
> > > >>>
> > > >>> This depends on yaml conversion patch:
> > > >>> https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-davi=
d@ixit.cz/=20
> > > >>>
> > > >>
> > > >> Any feedback on this...
> > > >=20
> > > > Another gracious reminder about these patches. At this moment this =
is=20
> > > > one of the important pieces lacking for the full SM8450 support in =
the=20
> > > > upstream kernel.
> > >=20
> > > Stephen, yet another ping. This is the blocking point for the further=
=20
> > > SM8450 progress.
> > >=20
> >=20
> > Sorry I completely missed this one as it fell off the end of my inbox
> > into the abyss.
>=20
> Thanks for the reply. Is this applied now or you have some feedback for
> me to address..
>=20

Does it apply along with the series from qcom[1]? I have to check and
make sure they both work together.

[1] https://lore.kernel.org/r/1651108369-11059-1-git-send-email-quic_fengli=
nw@quicinc.com
