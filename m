Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2188D4EB1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiC2QVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiC2QVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:21:51 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E6D1AD1D5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:20:07 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2e68c95e0f9so189710317b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+cPcA1MdpcxCl1Fud3F8uMJqpHFql9isbi4TC94PVI=;
        b=xN8WgVCiCYwFm8ilUQje8wkU7kxFCkNusS7kydKR96hcg/btmQgA4JM4cIjX/qC6zK
         OeGMX1SHe/xltwW9/kCA6xoRRVl5ZQA8cruG/WRJSAIUAk0ZLGarCoSnLdsX5JiivA0H
         7U8DvX+AxGkuzzvANWmVO9VTRuAOkQzjrJqVlKjXCvhUqxZC7cfHAaTW6KIGPLTDj53K
         gs5GjT9aSxUpRSfZ4Yr4KynImdRk8VlP9H6vUhHpN28VwPdinfq85owKeJxO3Xa9o/0e
         Vu06YgaIHCAc+cwoEkCGNsFxC51BKdNvkpukCXFdeme19KUAt2HnFs8TqbOPVAlR5G+X
         C3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+cPcA1MdpcxCl1Fud3F8uMJqpHFql9isbi4TC94PVI=;
        b=pnU6r1NxjofmmLaLGkqm3zaeWFOTCSoKSOOgabN1K7oenLFIUrHjQdZ5DL/89/PeP8
         lfet4uOOeuYweN1+GMIFpo7uwD4/J8L3yLB9f0iAzd2udD+G5DjXIrRU8ZZz9R57oIeU
         nvtLUuDf6/vFPjpp0t5EVlQF+c04RqAvv7Hr9UOPWFEDFl33ZSZq6GOka1CLoLuVCAzY
         mX76o6rrNmUnMdwspjCnhIT5hFTCj93ZPPYLs0Y1kC2uPNHjTCrl++AZ2iv9bPfe9D0E
         Lv2Jh7L7aHdFiZr5sjhkERKzOZ7o2t3PrY1dnl10vhCLJkWL1pMMkX7temtK2zOZWt8v
         zgDw==
X-Gm-Message-State: AOAM5328aoxL97yeyFzy2Om0nNIKmos/rgrTvpCDD5/h4G0SKS5uIlzr
        dXvUS2S9bbREWShneYS1VPHF2GdbtRX0FcZips2dAA==
X-Google-Smtp-Source: ABdhPJySCueyNElcU6iBARblDBGTj6cLFwcu/NFFhKAV32k64Aq1Ty4XbqqFM45LeF6b7WU4KU65JrtsLzWyNvxACbc=
X-Received: by 2002:a81:b50d:0:b0:2e5:b653:7e97 with SMTP id
 t13-20020a81b50d000000b002e5b6537e97mr33216518ywh.140.1648570807014; Tue, 29
 Mar 2022 09:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220329033226.535475-1-y.oudjana@protonmail.com>
In-Reply-To: <20220329033226.535475-1-y.oudjana@protonmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Mar 2022 18:19:55 +0200
Message-ID: <CACRpkdaakmGHo_VWNJsf2ph-EcFY_G_NMVfVFFK7oVUR7Bj_DQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Reset err after not finding static battery
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Mar 29, 2022 at 5:34 AM Yassine Oudjana
<y.oudjana@protonmail.com> wrote:

> Otherwise power_supply_get_battery_info always returns -ENODEV
> on devices that do not have a static battery, even when a simple
> battery is found.
>
> Fixes: c8aee3f41cb8 ("power: supply: Static data for Samsung batteries")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Quick and nice fix, thanks a lot!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
