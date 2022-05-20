Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA052E41C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbiETExN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbiETExC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:53:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111014ACA2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:53:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ck4so9204831ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HelS1YSgoBW0SE2UIxwjEVxXmUoAGRP6Ud70VaUb1RA=;
        b=H6iH3aexSzoRS3xXyRLeJheX9vWo0LSI92UAWGJj3vVnikNVcBAUVV//3jW+OoHWMo
         c6QuxxhcpXAZBwmBxi7/BCYKY2HuDVbJgHBMKEtcou/69yjh3SsfubfIpwV8ZiWSmLnM
         9YQff4597xej1VzxR5vTD6CKVagarFZCMisUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HelS1YSgoBW0SE2UIxwjEVxXmUoAGRP6Ud70VaUb1RA=;
        b=jSVw6NAxYCqIUe2brSTd20TsYuyiqlU0+EYX4JqL/9gdgQgAVqVmPkDI9a+Wck3n7p
         DAiwi4/VCAzEiV3G8pbzSknArxR3lLgVanUlru7SIf6QrKiVILvxenMlAe7S4vpm1VSo
         GCC+U9RBWYK3x1c+0fXucssn8LjIKFbsWw/vDVM49ItMwezGrckDfis9r5ggyhnEhQOV
         fiPBNOPMZ0LuNOLAkdLQTS8AxR1Wzc2ff+3zrnRtmBXwfBXeM6BaUGptuWscXPo/vGdz
         F71yCGIX+ynb+11ZzRy+FqpkveaQUrNoqCgDUmrifIWIW5BANFr5fMaK5QGb8AiNJRZT
         Ljhw==
X-Gm-Message-State: AOAM531uMywxve9hLukNRS47ICXSgDqXVdo0TPnbPMargopbKN9j3Jnm
        vhhfVNgDTOEeDDB4jm1UpVIbV+UfzT4hCulnrYUemg==
X-Google-Smtp-Source: ABdhPJx//tzm42OLUTVgIaPY6+uQ1fk21PSPAoxge18XjLdO9zIresHOvI3h20PeWG9DGgGmlfuWizAbefFCfNTPqQQ=
X-Received: by 2002:a17:907:c12:b0:6fe:22bb:7a0 with SMTP id
 ga18-20020a1709070c1200b006fe22bb07a0mr7327804ejc.450.1653022381201; Thu, 19
 May 2022 21:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220519134728.456643-1-y.oudjana@protonmail.com> <20220519134728.456643-2-y.oudjana@protonmail.com>
In-Reply-To: <20220519134728.456643-2-y.oudjana@protonmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 20 May 2022 12:52:50 +0800
Message-ID: <CAGXv+5GNoi_e2Ms3rcTTZ59k+_TZOB9qBM0p_BtE8EtDKYfpOQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 9:49 PM Yassine Oudjana
<yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> This allows it to be used in drivers built as modules.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
