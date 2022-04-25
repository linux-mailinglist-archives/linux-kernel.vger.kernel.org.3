Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14D50E9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiDYUNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbiDYUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:13:36 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7AD1E3ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:10:30 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e922e68b0fso6176190fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=K7sT4j1j79zUgHhHLdRo7ZuD61k8VXDTntHyuzX/BXA=;
        b=OUAaD5Us01krjFlnDs+151g4ok09UyRZuEIHUE1jPBEyR9mx/A7sAsmhjHf63EwNHq
         tIGiZUlZHdnlAbywcerGTsEzOjmesGLQUY9f6NI+BrVAm9kyrLaCHdJc504J1oJXK0wM
         YXgRd77RKxlXmiT+xTLg8ZVph4cRCjsfDql8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=K7sT4j1j79zUgHhHLdRo7ZuD61k8VXDTntHyuzX/BXA=;
        b=SFqtRUANvmEJdJ4KcZo2XhTxyoHcphloO3fyUntKTZ/udRg9Hx5OKdzpu2drVoISVn
         G3GwEw7+sXDaOgeeuQKNieCkk07QHCpl9YBlth2JnJu++8cJFSIJdTT6seVUIUN5qMP7
         s0BqjWlf9sS6+StSH5bkRfPeYs8n/wiBCQo6rHqxXiIzaNqDibmWKBN9bvsvR1j5hg8Z
         BGSqk81ANlXNy+ukA9odhBxAMCHPes9HTmwjN5o1Ng3szN8ThfpaXFyUY2f4PdrpkY2K
         RKQkPC+JZ6/CNeoBgCZoJCf6NVxAJTzfeQ51+qjHpY2TVEUiMv/Her+8+zyp7Hllwlzt
         OMYg==
X-Gm-Message-State: AOAM530K+VKSNNGkUJepXi4W0kDEoKhKdUN8DWngnHHcISwFWZrGExcL
        MU8jh1fCRdP7YPzu3MKXdjMAZTWchPku5puzLcHGVinvtlI=
X-Google-Smtp-Source: ABdhPJwJ17fs8iCiZSEbXH7jLlKJyr/HpN9dSlTTmysq4gFTTyFY8Gf7w8AN4qbNPPUFTtheyeMgr9f/4ynX6qJHPkc=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr8031779oao.63.1650917430300; Mon, 25
 Apr 2022 13:10:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Apr 2022 13:10:29 -0700
MIME-Version: 1.0
In-Reply-To: <20220425090947.3498897-1-lv.ruyi@zte.com.cn>
References: <20220425090947.3498897-1-lv.ruyi@zte.com.cn>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 25 Apr 2022 13:10:29 -0700
Message-ID: <CAE-0n50fs1fFQcwMCq_x_UG8ZJKprjcYKwcy1+1ckD--XE28+g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: fix error check return value of irq_of_parse_and_map()
To:     cgel.zte@gmail.com, robdclark@gmail.com, sean@poorly.run
Cc:     quic_abhinavk@quicinc.com, airlied@linux.ie, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, bjorn.andersson@linaro.org,
        angelogioacchino.delregno@somainline.org, tiny.windzz@gmail.com,
        architt@codeaurora.org, jsanka@codeaurora.org,
        skolluku@codeaurora.org, ryadav@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-04-25 02:09:47)
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return a negative value anyhow, so never enter this conditional branch.
>
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---

Question still stands why we can't use platform device APIs.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
