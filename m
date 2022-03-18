Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7444DE2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiCRUvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240818AbiCRUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:51:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5069105AB0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:49:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so19245752ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NU7ZEUVN8ql0G77/7yngvtcg81ZP18IxeW3MoR+mnfc=;
        b=gpHKTFIoWyAq7NJYgL2fOfmoLbteYLBivfRhZtIWyYRoeqPxZlUTFgVE/91YpoliOl
         XS+43IHaFHuR8HuVTku97Q+qeetO2lxfYsxuEC+NklwtlcX5mvMY59yMqLpXAkwhxnz/
         xWXCkzlbR7QWcm+aZoxF+OKNDmMkcloCojUIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NU7ZEUVN8ql0G77/7yngvtcg81ZP18IxeW3MoR+mnfc=;
        b=3L+xjFh2cLWaSJH9YwJ8KtGvPCz5/BLLZ3am0OrYc3DiwXFe9LSiZmG+3hdPJskcD/
         Bl/XQDMADxBSC6HAruZgjQephfReZaPNKg2RrS4cBuOZTle0V5QmXsJF2WUefDqTwQIa
         xOC3cPBzJ31kmD5DwrGFfsmw1YCwDoIGwiWSYHhzHgN/OG64WP2hp0QlN74powzs+UkR
         gnP+57/tBTmuQDDblp/YkGdb7hjlCGh5vCN2Bl2KMRrKoOTgk2DEbfWFrT1TS9STBpVu
         zch+J+OjChF60BNYIEOGeKTsld0nsDePRuOycyMHl7d1oFl1jKlYALftfEnGflIyxTxQ
         rgrg==
X-Gm-Message-State: AOAM533NN2NxMfumXK3UkSv9K3+jEPuVbfgrF6kQvDKEpfQjWdT7l0Lc
        rCK83zLWnxAkbwbhoGk5Yz4bOLAB4cI+/wMvYvM=
X-Google-Smtp-Source: ABdhPJx6PaDKYXa5EvngajicRK4fdGK7Hke3KKrRo14BtOjfDf3xYTrgqBiVu/KSZKAMtnbW5Q1bDA==
X-Received: by 2002:a17:907:97d4:b0:6df:ad22:f9c with SMTP id js20-20020a17090797d400b006dfad220f9cmr6420325ejc.680.1647636584003;
        Fri, 18 Mar 2022 13:49:44 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id y8-20020a50eb08000000b00418b114469csm4705727edp.52.2022.03.18.13.49.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 13:49:43 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id h23so12583627wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:49:43 -0700 (PDT)
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr9445786wrc.513.1647636582819; Fri, 18
 Mar 2022 13:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220318015451.2869388-1-swboyd@chromium.org> <20220318015451.2869388-3-swboyd@chromium.org>
In-Reply-To: <20220318015451.2869388-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Mar 2022 13:49:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WR9hkRF9BLCMNkH53bYz-sLZ_p=xWzh1EXST=dfkp-mA@mail.gmail.com>
Message-ID: <CAD=FV=WR9hkRF9BLCMNkH53bYz-sLZ_p=xWzh1EXST=dfkp-mA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/chrome: cros_ec_spi: Match cros-ec-fp compatible
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 17, 2022 at 6:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add the fingerprint cros-ec compatible and spi_device_id so that we can probe
> fingerprint devices.
>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
