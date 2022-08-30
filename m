Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235875A6F34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiH3Vfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3Vff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF91F51A04;
        Tue, 30 Aug 2022 14:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF42618D1;
        Tue, 30 Aug 2022 21:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4FCC433C1;
        Tue, 30 Aug 2022 21:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661895333;
        bh=x1sCWCTYTgRWZSrAxd+CG69DWl89Qy8FYP1J3jZbV2w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QW9dkOSDL3LcXJ2CGAGZmb53L5XBaDxaYAFVmLanW0euALps4DYP71DcaZo1qw3yQ
         KLb9U6BPqHT9OffKATcXHB/kdt6aLWNfnQzJfyFDbBl2EjNMyOj1skn6iQyzW2aNIB
         pOHal4yvccQfjpuxFY0N/HqIiKrpIir0pcqsUZr3/HpOjOo0oj+jAMIOfUabENkHRQ
         ZMt/EhuyY8nrY0wh15rXYlpjps+msr2YJ38UosPKSjcgm4vROnLGFSJf9KSqmc9SxB
         ClQW3xYp1n9ti4JUKWwaLxGubjWK6c87CKnaZh2QugYPyRk7rGSu73AveFfxKkh5+V
         xq3jFqBhwIN8g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com>
References: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid> <20220826024003.qpqtdmdohdmpcskt@baldur> <5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com>
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc-sc7180: Keep the USB GDSC always on
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-clk@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Date:   Tue, 30 Aug 2022 14:35:31 -0700
User-Agent: alot/0.10
Message-Id: <20220830213533.7C4FCC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2022-08-29 01:12:02)
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index d3244006c661..0fe017ba901b 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -368,6 +368,10 @@ static int _gdsc_disable(struct gdsc *sc)
>          if (sc->pwrsts & PWRSTS_OFF)
>                  gdsc_clear_mem_on(sc);
>=20
> +       /* If the GDSC supports RET, do not explicitly power it off */
> +       if (sc->pwrsts & PWRSTS_RET)
> +               return 0;
> +
>          ret =3D gdsc_toggle_logic(sc, GDSC_OFF);
>          if (ret)
>                  return ret;
>=20
>=20
> So with that change, we would then not need the ALWAYS_ON flag set for us=
b gdsc,
> instead we would update the .pwrsts to PWRSTS_RET_ON instead of PWRSTS_OF=
F_ON,
> and that should make both usb wake-ups to work and we can still have the =
usb_gdsc as
> a subdomain of CX for performance state voting.

To clarify, usb_gdsc is not setup as a subdomain of CX so far, right?
Just that eventually we'll make usb_gdsc a subdomain of CX so that
dev_pm_opp_set_rate() can target the CX domain instead of the usb one?

> Does that sounds like a reasonable solution?

It sounds good to me. What about the existing users of PWRSTS_RET
though? If I understand correctly this flag means the domain will never
be turned off, instead it will hit retention during low power modes.

While you're crafting this patch can you also document the PWRSTS_*
defines so that we know what they mean? I can guess that PWRSTS_RET
means "retention" but I don't know what it really means. I guess it
means "Deepest power off state is retention of memory cells".
