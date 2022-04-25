Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043A50DFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiDYMPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiDYMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:15:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC11A04A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:12:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z99so18112024ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8jWkC3uGhpIesYWEXYlUoa6QOg8WMwc/6eHbmnOET0=;
        b=z8IQnKw/QCUVdEhGIPQl+8KO75rfqTMoiKMA3BB9sFazxr+viuAmkDtOFAjYYeqiOc
         BICBVB5W2S7RFYNSYuiQ6npvOUj18cyj24dNXTVDLHF+Df1i3nrw0JfwTe3/UGJ4/wUE
         Qca2+w5QoifM49TBcyBSRvgIievMdF2gdAJds31r60IivrAwNdzi3MI849ffzBimYtZG
         vwDiY04IZruTc3NDSAl4XfavEBJ1vfBwMPdlEkYSVfnOVY15MH9gH0F7JHLbs43U8yMf
         h/8JO4jyVbPJnAS414pRuAsGdZ9Da+iWc9gku4zBIfYqxQSrDaaccKm2crCoDnSsiUne
         u/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8jWkC3uGhpIesYWEXYlUoa6QOg8WMwc/6eHbmnOET0=;
        b=AG3aJIzUWWAeIrdw4oPPdLU0Z1g+da0dCexQlSZnPMLfCMdjS6PF43U0WcCydXR0cm
         wri1lwAZ21KbmnvjYF4K5G6XIL/+syx1/02LOEzPkXEyWZi/sd5XeJCbjKQ8GJY9pinR
         MKHO6u2dTemPSJlpTc4qrkDH19zkgNSfK6jWf3UhoNhFp7VrPhk8JjiLvzCmHUnRZqNO
         DELmVYqzqjwLV47JLl54AycVg5YyiXnJTlNuGo55l7gPsJC0yeejaQiktN0nT0OCQNoV
         cLM6yHPA2P4+BmEPniTZmMUyzXfwO2nxACyWq9fTNYPFvUTv4gb9jkzHC5+tzosuPkZZ
         bi3A==
X-Gm-Message-State: AOAM532EbAU0mzbyFfIrpgtcIi92viMUa4vJ8BLRko6/gkcmVg1IE/XV
        AjKJ7PWTYXZnEldLwvaUD2cRiZMKHhVgYRZeZq4IBhBSqGQ=
X-Google-Smtp-Source: ABdhPJyaFAHnaHfcxF9oK2zzYsY2EtPh/uGq+12bC7Ho7eUw/yPfwKq2bJmWpg53blCYTMA1ROMhpC7iIBK74ygqh2U=
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id
 n9-20020aa7c789000000b00413605d8d17mr18351707eds.100.1650888752051; Mon, 25
 Apr 2022 05:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220425105346.324864-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20220425105346.324864-1-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 25 Apr 2022 09:12:20 -0300
Message-ID: <CAAEAJfA2K2-YOruDMUjHixaPa1wfTSwpb3K5A-y_i3H6BF7oKQ@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: HEVC: unconditionnaly set
 pps_{cb/cr}_qp_offset values
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jon@nanocrew.net, Adam Ford <aford173@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 7:53 AM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> Always set pps_cb_qp_offset and pps_cr_qp_offset values in Hantro/G2
> register whatever is V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT
> flag value.
> This fix a couple of tests in fluster.
>

Which tests?

Thanks,
Ezequiel

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index 2c8eb0720db8..bb512389c1a5 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -194,13 +194,8 @@ static void set_params(struct hantro_ctx *ctx)
>                 hantro_reg_write(vpu, &g2_max_cu_qpd_depth, 0);
>         }
>
> -       if (pps->flags & V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT) {
> -               hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
> -               hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
> -       } else {
> -               hantro_reg_write(vpu, &g2_cb_qp_offset, 0);
> -               hantro_reg_write(vpu, &g2_cr_qp_offset, 0);
> -       }
> +       hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
> +       hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
>
>         hantro_reg_write(vpu, &g2_filt_offset_beta, pps->pps_beta_offset_div2);
>         hantro_reg_write(vpu, &g2_filt_offset_tc, pps->pps_tc_offset_div2);
> --
> 2.32.0
>
