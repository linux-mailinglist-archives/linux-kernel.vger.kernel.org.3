Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879A35A6E51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiH3USi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiH3US2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:18:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91365286C3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:18:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p7so5942630lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1yeP3DjVWaMGF9lHlaP/DrKMq/Tp9AtHGNc7ptmf5YA=;
        b=CVPzEkz5uPI8rDre+RUzmevOwuldj7MWQUhT749lZ0N2Tv8G+sg/fIPVM+Zs6FKpWa
         drrtDv3XsftxYHApfXVOwWowWUlQj3eVEY3Q6fepbpIKIV07GtgLdZgKcb6TRRL6auBu
         Rq9Gy61LL2U9VHkNyUjdNl160fz/KcwQY2Siw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1yeP3DjVWaMGF9lHlaP/DrKMq/Tp9AtHGNc7ptmf5YA=;
        b=QVMKluL2DMJkfo1sq/yUZ/aTY05G2wOcIQ+nCMxS54G9Yh9kY1d6qwWw7AnP1kb6ZC
         AajcgBSSrKJFl4AmMCRdLJQ1kW8ChUW73SKuaOAUju8mHGyJrL8Mcn8n27m2axJkGGfY
         Y9FStNgm9gIYlVHFRC5F2S5bbBV+/sMrQz/qJwDThRLX9MXQyW2D8N4gIPqJjIn4AfmK
         z/AsZFm7DDOAqn0gOcKWzsxABEPxtJyMh0eqVOE4XdNLeumb/YaYp9yRWywq6ZO3ebO6
         NSW1MKGtqk2bVs2V2AH56M5dTc49xrm5frLE1162dZAFE0LG0TQ8yb2YiRblfkG5mAie
         tm3A==
X-Gm-Message-State: ACgBeo1M0LTAVJpzcq6wjRH9DGoRitGTj5u6polFQcAisjE/j2AYhApB
        M0fJG3lRHHTJ0XeeCqh2Ve6ivX4BmxTZnQ==
X-Google-Smtp-Source: AA6agR7TpR9bu7YNulTD94Bi03voOoPkabf8AG9/Et8pIwfW9dVKVB3zfa+8sWCwO5ASbg4suBLUSQ==
X-Received: by 2002:a05:6512:22d4:b0:494:839a:9449 with SMTP id g20-20020a05651222d400b00494839a9449mr562368lfu.10.1661890702693;
        Tue, 30 Aug 2022 13:18:22 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id be43-20020a056512252b00b004946e727118sm715875lfb.88.2022.08.30.13.18.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 13:18:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q16so12546250ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:18:21 -0700 (PDT)
X-Received: by 2002:a05:651c:241:b0:25e:65bd:3a8a with SMTP id
 x1-20020a05651c024100b0025e65bd3a8amr7863518ljn.206.1661890700872; Tue, 30
 Aug 2022 13:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220830123231.1.I98d30623f13b785ca77094d0c0fd4339550553b6@changeid>
 <CAD=FV=XO++XMrdZmupY8ED97W6AaU=H=sB2PN=6EpRxOOo4Afw@mail.gmail.com>
In-Reply-To: <CAD=FV=XO++XMrdZmupY8ED97W6AaU=H=sB2PN=6EpRxOOo4Afw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 30 Aug 2022 13:18:09 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO_iqH8pPmPPH2=3RWVVDKa2XYLNEp4P=1r+b4=VsxNHw@mail.gmail.com>
Message-ID: <CA+ASDXO_iqH8pPmPPH2=3RWVVDKa2XYLNEp4P=1r+b4=VsxNHw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, zain wang <wzz@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:51 PM Doug Anderson <dianders@chromium.org> wrote:
> nit: Sinze zain wang's SoB is first then I think either the patch
> needs to be "From" zain wang or you need some different tagging, like
> Co-Developed-by or something.

Urgh, I think I did a conflicting combination of --reedit-message= and
--reset-author when cherry-picking / rewriting. Fixed for v2.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!
