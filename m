Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C99459EF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiHWWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiHWWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:33:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D87DFE0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:33:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u6so14746698eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yqrXq+bY5tVc+esQPHlVJG1yydskeyLcWUdDCNI95n8=;
        b=DhBMzCKnhsbJS6PK4JwYIfkKsxh/J+WEPz2kqhVUzcy+8sMAA8DkbgwXZN+d8pzi9c
         uisecMhxXxV+IESDfSU2nJKKlSOXV6bYow82spTLEG3B6zbhUpoaU3QP3ZP0XtrX3Ew0
         qMFMVBOvDukLzxlPa6Ls1fBifMoDY6770EYeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yqrXq+bY5tVc+esQPHlVJG1yydskeyLcWUdDCNI95n8=;
        b=mg2OjxMc38MR6Zc3lIBNQOtmm01o90RdN/68OdOr/PDnkW4CYLclspYmx5LiStMSqx
         fLGnDy/d9MpLQCvCgfT4EikW9NwcQOEHKj6ZcdUSA6E/ZgssAjHwY6oxiLu9ekAFzi+N
         14AI4iKifsUfgGjQgILEhkbkgz+sYUrY4CYsx9zZ7RKi7Ed5kz8yoraplvuiy6TxWVbm
         Hoes05ddFo7wOHgUIOeYoPP9XASoeOLtRS2er2QlJW++5YT5Q7QRTx1GP6dQPa3ckC5O
         1eMqd3pUFEtc7YMuaYH1vvg24ZhMxRH+4OgHeW+bDRXS/vj0pacnGGykFBOyFcMxgrqu
         yhAQ==
X-Gm-Message-State: ACgBeo3vU9fvNcBgAQ8QcefobR1twokKm5QGPl88TRETFgbuhM+w6Q5A
        2j/DRXve0bza0UmFXzgTN7dT4CFvwzh6DLpK9VY=
X-Google-Smtp-Source: AA6agR6LFT3ZVbpewPpSorLYs+JKWwaTLkog0dz6SSjg8SVR80+ALLx9b93RR6K0crHpAT/UtlzALg==
X-Received: by 2002:aa7:c78e:0:b0:441:c311:9dcd with SMTP id n14-20020aa7c78e000000b00441c3119dcdmr5174929eds.155.1661293981371;
        Tue, 23 Aug 2022 15:33:01 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id fi20-20020a1709073ad400b0072f42ca292bsm369006ejc.129.2022.08.23.15.33.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 15:33:01 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id h5so17815388wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:33:00 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr14518804wrr.583.1661293980586; Tue, 23
 Aug 2022 15:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220823131629.RFT.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
 <20220823221429.3bte2tgtyniur4wb@halaneylaptop>
In-Reply-To: <20220823221429.3bte2tgtyniur4wb@halaneylaptop>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Aug 2022 15:32:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSSrObW2PthmUL+t=VYJ+mN6Z763pozCQDbOdPtAXyQA@mail.gmail.com>
Message-ID: <CAD=FV=WSSrObW2PthmUL+t=VYJ+mN6Z763pozCQDbOdPtAXyQA@mail.gmail.com>
Subject: Re: [RFT PATCH] regulator: core: Require regulator drivers to check
 uV for get_optimum_mode()
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Aug 23, 2022 at 3:14 PM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> I think this makes sense, but unfortunately it doesn't entirely fix my
> issue introduced by efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()"),
> I'm seeing this now:
>
>     [    1.240757] vreg_l17c: mode operation not allowed
>     [    1.245586] vreg_l17c: failed to get optimum mode @ 800000 uA 0 -> 2504000 uV: -EPERM
>     [    1.253631] ufshcd-qcom 1d84000.ufs: ufshcd_enable_vreg: vcc enable failed, err=-1
>
> which if I understand correctly is because my devicetree isn't setting
> regulator-allowed-modes. It appears most of the qcom one's don't set
> that (and a good number set regulator-allow-set-load, which I think is
> necessary for the RPMH regulator to get this far), so I think others
> will be in the same boat as me.
>
> Just for clarity, I'm running with this dtb right now:
>
>     https://lore.kernel.org/all/20220812165453.11608-4-quic_ppareek@quicinc.com/

Wonderful. I guess the old mechanism that RPMH was using totally
bypassed regulator_mode_constrain(). Seems crazy that nobody has
noticed that till now...

I guess maybe we could add the "initial mode" as an implicitly allowed
mode? I guess the other option is to implicitly disable
regulator-allow-set-load if no allowed modes are listed? Both of these
two will still change behavior for your board, of course. Since I
think previously we were setting modes completely ignoring
"regulator-allowed-modes" both of those two options will effectively
disable mode switching.

I guess the other option would be to say that if
"regulator-allow-set-load" is set but not "regulator-allowed-modes"
then we allow all modes? Somehow that doesn't seem like the "safest"
option, though.

...or, of course, we could say that these device trees are broken and
we're not going to care about supporting them, then we could fix the
device trees...

-Doug
