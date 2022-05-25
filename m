Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDDD534290
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbiEYRy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiEYRy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:54:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38627E0D2;
        Wed, 25 May 2022 10:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEBD8B81E9A;
        Wed, 25 May 2022 17:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC9FC34113;
        Wed, 25 May 2022 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653501292;
        bh=Bxsx51A3dmaidPe4kzMODy2iXwDJWMqWkVu5YRnrJb0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dBUSKX3HrKas7TAzQjjMqNQ8LMFDnGDOAUO4teJZSxa4r9UvZJLCG5fuyBx+/A6Iz
         RR51L9WFxasClytEgEwHhgpWxmHilQqYUwOJx1rsXenZeTUsottvNQ+lgcY6qFu0lh
         8TI1a6hNLk3h76BxfBzOyb64v8JPBXFSCtJRVPuxYzdZ8TdEn/UVMtUuV3zJ176sqw
         jxH3cHOg4mJAZFhgTLQ2QdKOoWBOiu06bAqv0THovEeFaywdBdmk1MPsMzZHklcT4a
         yoFR7euO1cvBCtz78wOdhAVGu5PBMkRBe+Mtiuitqkp4Qd0ZpJVLONz4xx/ySjuhCi
         IteKaPyq7JO9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523092314.14252-4-quic_tdas@quicinc.com>
References: <20220523092314.14252-1-quic_tdas@quicinc.com> <20220523092314.14252-4-quic_tdas@quicinc.com>
Subject: Re: [PATCH v2 3/3] clk: qcom: lpass: Add support for resets & external mclk for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <quic_tdas@quicinc.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 25 May 2022 10:54:50 -0700
User-Agent: alot/0.10
Message-Id: <20220525175452.5FC9FC34113@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-05-23 02:23:14)
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lp=
assaudiocc-sc7280.c
> index 6ab6e5a34c72..536509b78341 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
>  static const struct of_device_id lpass_audio_cc_sc7280_match_table[] =3D=
 {
>         { .compatible =3D "qcom,sc7280-lpassaudiocc" },
>         { }
> @@ -741,6 +754,8 @@ static int lpass_audio_cc_sc7280_probe(struct platfor=
m_device *pdev)
>                 return ret;
>         }
>=20
> +       ret =3D qcom_cc_probe_by_index(pdev, 1, &lpass_audio_cc_reset_sc7=
280_desc);

What if it fails? Shouldn't we pm_runtime_disable()?

> +
>         pm_runtime_mark_last_busy(&pdev->dev);
>         pm_runtime_put_autosuspend(&pdev->dev);
>         pm_runtime_put_sync(&pdev->dev);
