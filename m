Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2659E9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiHWRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiHWRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:39:05 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD63A50D7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:26:25 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1661268384; x=1661527584;
        bh=Msghlf12raNIScWJPwCFZQkNuK7gxnsi0PR0wqpSkQE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=OxOdxTbfNq2TL66PhbmYfaMiUh4WY3NPB6peSpeoXQ+cput5Cf1FLzivaWwsRcocO
         2Xlj2h248643Uin68xTm0KLOgGH6agdOOQCRQ+H9F8NzcRXl2/12tyNUWsIcPO+EYZ
         IF76JI779TZbq73qGIlQSuH4b2hH82wv34alz3WE=
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com, linux-clk@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH] clk: qcom: lpass: Fix the invalid index errors seen at bootup
Message-ID: <4551f8f0-9cf7-3a45-5eb3-e64066fdf00c@connolly.tech>
In-Reply-To: <1661245527-5596-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1661245527-5596-1-git-send-email-quic_c_skakit@quicinc.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you adjust the subject line to reflect which CC this patch is for?

clk: qcom: lpassaudiocc-sc7280: Fix the invalid index errors seen at bootup

This matches other commits in the subsystem.

On 23/08/2022 10:05, Satya Priya wrote:
> After support for resets is added, qcom_cc_really_probe()
> would be called twice for the same cc which causes
> invalid index errors in qcom_clk_hw_get().
>
> qcom_cc_clk_hw_get: invalid index 5
> qcom_cc_clk_hw_get: invalid index 6
> qcom_cc_clk_hw_get: invalid index 7
>
> Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock contr=
oller for SC7280")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> This patch depends on [1]
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=3D667=
984
>
>   drivers/clk/qcom/lpassaudiocc-sc7280.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lp=
assaudiocc-sc7280.c
> index 063e036..5d4bc56 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -785,7 +785,7 @@ static int lpass_audio_cc_sc7280_probe(struct platfor=
m_device *pdev)
>   =09regmap_write(regmap, 0x4, 0x3b);
>   =09regmap_write(regmap, 0x8, 0xff05);
>
> -=09ret =3D qcom_cc_really_probe(pdev, &lpass_audio_cc_sc7280_desc, regma=
p);
> +=09ret =3D qcom_cc_probe_by_index(pdev, 0, &lpass_audio_cc_sc7280_desc);
>   =09if (ret) {
>   =09=09dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC clocks\n")=
;
>   =09=09pm_runtime_disable(&pdev->dev);
> --
> 2.7.4
>

--
Kind Regards,
Caleb

