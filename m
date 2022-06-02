Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65153B6BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiFBKP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiFBKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:15:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4482A2AD9AC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:15:21 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j3so3287184qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGK0zPU93j8Ge2AzP1KbQCzIzb8femdDnLBXlrSmAF4=;
        b=rGExpiOaZ1dgPz/IIE7N5VFS9CKXCNxc1uESwdH+rJIsRxPqcrxLlunbdvz9yDCtDJ
         voN25Ke98eRyOfhycMhlE6/BhgKy9kGqk0aVat6o8LmN+Dvtjo+t62ITp+NdHdJ8DaZp
         ZK1f4mTGjjBMuaKsCEJuIAl4s/rcnw8J1EsiMHkl+n5vTmEsXXhs/HU2YbrLab9gd73W
         iO3SqhvP749pR96qrqOJg0OsiHYyZEd0RhLMp5fjNgjRvmKi2oDsFTp7dnlJPyIfNnhF
         ozhd2EusWxJT1KgDiXtn64VqP2yLPhmHegWOXpJfg3beGU/wXASf74PTlh8Zrta1jYLL
         E8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGK0zPU93j8Ge2AzP1KbQCzIzb8femdDnLBXlrSmAF4=;
        b=svr70iid4okRRJbaP1+KeSdOQ2k7e7hckgUarQxDgDTtKjqihBUcJ8kquxfRhnwahg
         /K/QULXVadlGqK/Wn+dxiDzKBoNEBT9KenVAILf910Ol7eNJOaNsDT3Fm3f5wClYsIFB
         IcShx+wJa27TIG9HzZrrTprjt4pPz6JFE8p5QLp/RM11+zEabvR3RkEq2VxFDUOy7TdP
         XI1YOoXGoaf36BGauKhF5e+xHIR2opbtEMBR0URQjt+l0ZWp7UUVctO7A9TZgk6NczmQ
         aT1DPPNETjLHPBhi1cNNwks2N9hapmpIXrHrGKeRge0NRGLNSU0XWwR0ahdlTFXTNXu3
         LUgQ==
X-Gm-Message-State: AOAM533zrGH+BlCYFnp4VeSewNhRBV6KCFsksF5tNACLVDgAZ2mmZIxs
        9NOozF0Bhjd0U3t/TZaY5HB3H2ATYe6UzJn6gATqBQ==
X-Google-Smtp-Source: ABdhPJwZVrgPJE/PLNJFp4EqWodbfWB4zXOatz/ZqouAf8UAnlORn21DQ04M5d/rYnMf/jo5weyIf8kqSfgKMKENP48=
X-Received: by 2002:ad4:5b81:0:b0:465:ded8:780 with SMTP id
 1-20020ad45b81000000b00465ded80780mr4768269qvp.119.1654164920448; Thu, 02 Jun
 2022 03:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220601220747.1145095-1-marijn.suijten@somainline.org> <20220601220747.1145095-3-marijn.suijten@somainline.org>
In-Reply-To: <20220601220747.1145095-3-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Jun 2022 13:15:09 +0300
Message-ID: <CAA8EJpp0Nv=H3Xm-PQyr0__KA_tP1p6LeSkDwGSMBx0X8kpZ8g@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 at 01:07, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Add the devres variant of clk_hw_register_mux_hws() for registering a
> mux clock with clk_hw parent pointers instead of parent names.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  include/linux/clk-provider.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 4e07621849e6..316c7e082934 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -980,6 +980,13 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
>                               (parent_names), NULL, NULL, (flags), (reg),     \
>                               (shift), BIT((width)) - 1, (clk_mux_flags),     \
>                               NULL, (lock))
> +#define devm_clk_hw_register_mux_parent_hws(dev, name, parent_hws,           \
> +                                           num_parents, flags, reg, shift,   \
> +                                           width, clk_mux_flags, lock)       \
> +       __devm_clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL,  \
> +                                  (parent_hws), NULL, (flags), (reg),        \
> +                                  (shift), BIT((width)) - 1,                 \
> +                                  (clk_mux_flags), NULL, (lock))
>
>  int clk_mux_val_to_index(struct clk_hw *hw, const u32 *table, unsigned int flags,
>                          unsigned int val);
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
