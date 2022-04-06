Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435C84F5BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443751AbiDFJeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580385AbiDFJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:20:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DC140DFF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:26:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so957239edw.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVrhTvL07JA+qLuxrHPB76KlfjN/HKd1U84mtNSDmA0=;
        b=T0BGJvEhCp1XVdquKEt/pKpKuXICocX/83Jn1wmpWHLF+zAcgvEjroM6jN40LltZzX
         eMGubAQqVa1BAfUAJ6zJ44VHTiXyP35A/O3aT2a9JHsAVd9eFDNtGArHLbyUm08Qfrok
         /pQJpFIXc2NeHopH7wDHcDYOA8JpjD92gDXmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVrhTvL07JA+qLuxrHPB76KlfjN/HKd1U84mtNSDmA0=;
        b=v+6BF24mTxiEv9/3E1JyKpxfbgehq+1jeshRY1d6+nAGfRBTw5veESRp3i111wVYcF
         fPQ5ri8xNQj+Vy8MBrTOnItmt6VMOBdKW4fThuR0F//6j7Y0YuHZM0NeQabYeYmu+gKA
         rcu+flsALaq3OgHJeDfEzw1VrZCiOHM5mWKjAUKbZXK/7qL/nt+XtxNDHXOguz6P+V1i
         PQn8w1J9Rvh6aSf+8cARLPQcpq18z6n+7I1kdXSCcJ+hQDMZ1nE6ZEk8F4cWvRVsX8yr
         UWCvWBFArLc+KJO3W+YpumsaLhQvFyYnkM2hZsiTOzjIekL2dwyNi1HLOni/MwSuoNGf
         MizQ==
X-Gm-Message-State: AOAM532jMGuPnNmiJZz7/nOJXlGGOyaSXxVLIQVh8j62sw2n5/bXNaT+
        4KcnVLTzZPSwuzotXs7Zkj5o11yNk+X65o3nrYw=
X-Google-Smtp-Source: ABdhPJweee1NV8I+cn8MRIfg+U9lhogZHkKzOG5thGkldSQIVCGVSNoMveRbaFdY8w17tPDTptcZ8g==
X-Received: by 2002:a50:9d47:0:b0:40f:9d3d:97b6 with SMTP id j7-20020a509d47000000b0040f9d3d97b6mr6523013edk.392.1649212002774;
        Tue, 05 Apr 2022 19:26:42 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id v5-20020a50c405000000b004161123bf7asm7182389edf.67.2022.04.05.19.26.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:26:42 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id j12so1090570wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 19:26:42 -0700 (PDT)
X-Received: by 2002:adf:e591:0:b0:206:1202:214 with SMTP id
 l17-20020adfe591000000b0020612020214mr4789813wrm.342.1649212001620; Tue, 05
 Apr 2022 19:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220406014842.2771799-1-briannorris@chromium.org> <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
In-Reply-To: <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Apr 2022 19:26:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wdp5ax_MhGg-=ocSPS=cs1nUCRcz+E81Z2V-w_YVuzUw@mail.gmail.com>
Message-ID: <CAD=FV=Wdp5ax_MhGg-=ocSPS=cs1nUCRcz+E81Z2V-w_YVuzUw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 5, 2022 at 6:49 PM Brian Norris <briannorris@chromium.org> wrote:
>
> See the previous patch ("soc: rockchip: power-domain: Manage resource
> conflicts with firmware") for a thorough explanation of the conflicts.
> While ARM Trusted Firmware may be modifying memory controller and
> power-domain states, we need to block the kernel's power-domain driver.
>
> If the power-domain driver is disabled, there is no resource conflict
> and this becomes a no-op.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
