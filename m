Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C5E5065C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbiDSH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349420AbiDSH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:29:09 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF2C32EE9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:26:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p65so29474000ybp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+By+13aHrceERiXA8GaEyKGJGM9u84eKKU6Y0YD6p8g=;
        b=fvkANo2FkoqNw6ZvlzaUVbW++TfLInC9ftwHPOqz4I98vSskQfWr3jt9O4B+Fwqpal
         E91c+rV32XQU5elL2iLzNVD+LhrE3Hewf/vgwbuc2y5ut8D9p8el96K5P6328Ghj/Jja
         c1pxvGN01z0hmxF8mDy+R2GBzvbjj+lCpqrfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+By+13aHrceERiXA8GaEyKGJGM9u84eKKU6Y0YD6p8g=;
        b=NktCbxAYjcQf4Y+cXFTjLxhCBn1mmlhjqzuXbpPTFYWqqL0kuoDO0sJCg2CRa+4p53
         EyqDnBstQ74Cg7yFg5NPZQVnZe9Pp+1t/9/6Mk0evhVShTBkXyvuaOtuXKFfQE6M8G1A
         Y7awW/78hzVpD4MOwkKHVWhW1YzCaYxEvAfTFFPrJ/lQW4od9PLV1tmWRDiMI8v1EGeG
         yoDZPMm0BdQk8RHW6auNyp0WmKlo8CEj0clb2ATr94BtNOr90TyV2sCDdIKTvZ3DRvYZ
         GoQzUe7Sv3/h9a0weLLNoQdW0LtRKz7s9rv4WRj8UyhEC1Uvm3lxMNjAI8OyIUMS+Dsv
         hKfA==
X-Gm-Message-State: AOAM533Td7NfI/V7d8GaII4IZeO/gDlA+jcBuDocllm/52GJw3JSusE1
        sL7LKF/eV9Xbr12ShvKWAJVX7Q+hqr+9DDaT6X/kEA==
X-Google-Smtp-Source: ABdhPJyd6mZNo4xSs1xhZ5G3ywreqo4IEKfjKNlDn371K9W2aVL1vr9zOwSMuV+fUn1XPgz0cHx6O3I15DkvyCvkyFU=
X-Received: by 2002:a25:c708:0:b0:641:6421:a183 with SMTP id
 w8-20020a25c708000000b006416421a183mr14895321ybe.164.1650353181704; Tue, 19
 Apr 2022 00:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com> <20220418132154.7401-4-rex-bc.chen@mediatek.com>
In-Reply-To: <20220418132154.7401-4-rex-bc.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Apr 2022 15:26:10 +0800
Message-ID: <CAGXv+5GQR27+iomwHfwYb0gB_QVTZSy6TaZ+1qViMmNPka3Yjw@mail.gmail.com>
Subject: Re: [PATCH 3/7] clk: mediatek: reset: Merge and revise reset register function
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, yong.liang@mediatek.com,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 9:22 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> Merge the reset register function of v1 and v2 into one function.
> - Input the version number to determine which version we will use.
> - Add return value of reset register function for error handling.

Please do this in a separate patch. Also you are adding error messages
for when of_clk_add_provider() fails, which is not mentioned either.

Most of these platform drivers require a good cleanup of their error
handling anyway. It might be a good idea to tackle them later. Or if
they look the same, you could try using coccinelle to do a bulk cleanup.


Thanks
ChenYu

> - Rename reset register function to "mtk_clk_register_rst_ctrl"
