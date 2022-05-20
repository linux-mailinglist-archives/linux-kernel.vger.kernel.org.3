Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130FC52E406
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbiETEty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbiETEtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:49:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076113C357
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:49:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id wh22so13319791ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+rF6dhHbqvrEHl1JWCO7qzVBXB368ohsf4MuiTQiGc=;
        b=ZOuuxSvg8cjtrSjVsHC3HrcS4loCp7wFy+f6Np3AgYS0CzySnmkUv+4mYG9zHnv8ne
         1vAVNQiWeEr2Yn9HphkCERYB38suK9P+DcVnterVzxpYuv4Mq+IVxpVVS1J/MIuFojpQ
         /y4nqyfZ1QbwjMIy5PtGCH35SRYTPqk9OI9B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+rF6dhHbqvrEHl1JWCO7qzVBXB368ohsf4MuiTQiGc=;
        b=H7nvxJzqgR4CWDYmmAXBQXGOOh8X+gslEPi+PjpQ9ZSmAecWGJTuxjArhbZfSbcbiT
         2OVEo7EqmlseL9JQ3wqD2RbeQXIcwp+F26+a3cgXFqaIRBquHAwAai6NLy/PiBT4Npf4
         QxVQBHwr0K1sOu3JJsY7g2F2fmSfsh2K6RfrblCDHiHBvCOmTVA+vjI518zDiMHAjCqc
         keHjwH111QqB0enL0kdAUgaqTEGV91RC0DkESPSOwhJIpZ6R9twu071yvipsS48sL7i4
         kiLcNmEInaQZouZYTnYG3UbHCOqLS0ZFWTllkgtFHJqUvKzc+mxAmTJcXF16J7zmjnHh
         Amqg==
X-Gm-Message-State: AOAM530tFp5/TqDAoJHpSL3F/jqlDaD6XFmaJAaOdKFClRqiyII4TONE
        UTyX46Snv/YlL20xIRd8Ypip5WaVh9evDa3XWjQ6RQ==
X-Google-Smtp-Source: ABdhPJzGKNfnnGJBNEgXcSGNHSdo0I8dXA7F0rfAVqQ9CybvOQZe8592uBcZxReyMAUCaispAKzhJxf4iQLyBJlbE0s=
X-Received: by 2002:a17:906:c142:b0:6da:9781:ae5d with SMTP id
 dp2-20020a170906c14200b006da9781ae5dmr6803613ejc.73.1653022189315; Thu, 19
 May 2022 21:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220519134728.456643-1-y.oudjana@protonmail.com> <20220519134728.456643-3-y.oudjana@protonmail.com>
In-Reply-To: <20220519134728.456643-3-y.oudjana@protonmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 20 May 2022 12:49:38 +0800
Message-ID: <CAGXv+5GnjY1DOWHx-B4PZqNi5tnWOgYQ_TCk6YzhtEnPQnVVnA@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: mediatek: Use mtk_clk_register_gates_with_dev in
 simple probe
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
> Register gates with dev in mtk_clk_simple_probe.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
