Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691735754BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiGNSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiGNSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:14:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234DD67CA9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:14:52 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j3so3339771oif.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yL38y/2bFG1AO5qjLaabbJhiweElDmrY+o816APFSRc=;
        b=Ux+0eZn8uZtPH+hZ2lAG9pVVSBXTqp/fZBKovKB09+ewbBwSxUUfldTSCtw75y8LIv
         +tO7muQOWwlfNC51j0F7GNuUhwVxTPmLNQk/5o2qEQHoD0y/dEsVbJVAF4J25HtTWYFM
         vHQJ7vLQHU0xHeP8k4RYHCAUU3cGCE7cG5ZOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yL38y/2bFG1AO5qjLaabbJhiweElDmrY+o816APFSRc=;
        b=e3ju9B9poEKQXgFdR/opKljSHEtdAM+R4w2TvmGd2ngkFxiaNSwAKvzMFl3Fd5HpZY
         n5CqLx94eZ+PJ/hGnECLehEL4lhtjEeLjOonG86ac4Z+no3UoEK3sb1d6e2E0U3PR/UY
         OK+S56ejSg93uWzOr2VHsJnoEB8C2xfcQt/w5insLL1UWrPoRVDvpZl9j3KhmUapmh//
         Lm17HjqxRo5CPb5Hez2QMYbZK8PtLkJw5+PRQvACVGO6WZUB2YpKFfwHY9IbqFuG7Lrm
         S6JA8d2KAvx2b9UpdLAsPKfGVoX3zqUZA7YuJmt+HjmamQAk/mbWFNi6P+tWPfVbAhXt
         l6aA==
X-Gm-Message-State: AJIora8+JwQ2hyD8/XjRlgZxvvCK1URtU+u2Sk2XVFUQXj7EKZt3bEDA
        NMSbiIKgxURqV20sH1D/Re7pDB7f7RtG7g==
X-Google-Smtp-Source: AGRyM1sF/O89XDBF+v83v7NBQ40CfjoaL+nG848yCyAys3SYcHAzRE9apzSIB+5C845E2FB+nPMLPQ==
X-Received: by 2002:a05:6808:1648:b0:333:45ae:3777 with SMTP id az8-20020a056808164800b0033345ae3777mr8459229oib.4.1657822491047;
        Thu, 14 Jul 2022 11:14:51 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id l9-20020a544109000000b0033a05951ccdsm895342oic.12.2022.07.14.11.14.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 11:14:49 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id k8-20020a9d4b88000000b0061c7f8c4f77so822241otf.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:14:48 -0700 (PDT)
X-Received: by 2002:a05:6830:3493:b0:61c:140e:b2e2 with SMTP id
 c19-20020a056830349300b0061c140eb2e2mr3766958otu.292.1657822488121; Thu, 14
 Jul 2022 11:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220708080726.4170711-1-judyhsiao@chromium.org>
In-Reply-To: <20220708080726.4170711-1-judyhsiao@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 14 Jul 2022 11:14:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM-Cb8idKp+9nBDrGd5SRb4dy20TChAQT3WmdwS+wbzNw@mail.gmail.com>
Message-ID: <CA+ASDXM-Cb8idKp+9nBDrGd5SRb4dy20TChAQT3WmdwS+wbzNw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: rk3399: i2s: switch BCLK to GPIO
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lin Huang <hl@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

On Fri, Jul 8, 2022 at 1:07 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> We discoverd that the state of BCLK on, LRCLK off and SD_MODE on

super-nit: s/discoverd/discovered/

(If this is the only issue, perhaps Heiko can fix that when applying.)

> may cause the speaker melting issue. Removing LRCLK while BCLK
> is present can cause unexpected output behavior including a large
> DC output voltage as described in the Max98357a datasheet.
>
> In order to:
>   1. prevent BCLK from turning on by other component.
>   2. keep BCLK and LRCLK being present at the same time
>
> This patch adjusts the device tree to allow BCLK to switch
> to GPIO func before LRCLK output, and switch back during
> LRCLK is output.
>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

IIUC, it's not guaranteed everyone is using max98357a on this I2S
channel, but I suppose this change is still safe anyway? Or if this is
expected only for Gru-related boards, we could override the i2s node
settings in rk3399-gru.dtsi or similar.

Anyway, I think this is right:

Reviewed-by: Brian Norris <briannorris@chromium.org>
