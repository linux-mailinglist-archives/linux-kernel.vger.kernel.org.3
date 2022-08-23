Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF03959ED69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiHWUhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiHWUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:36:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD77265
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:19:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c39so19480072edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=l1iBTcJ+I4g1JTfLPRirKOb7WIUh6Sd18iAIN/V+zHQ=;
        b=c8YudHngMrJ4MJ/hfh+NjYvkynkWBEcm198z3KwNDaSkrf1RxEwqATZXSwqBGDFOTT
         hlQPvg5TesRDlRGUuREBGEinJDUhhl1SRcCV7VC9o4AYNQB37qJ+t2nQXkBvWmX+j4No
         3cW0/JEE7YEr4J5wK93gzjyGDLNaFzJp88t0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=l1iBTcJ+I4g1JTfLPRirKOb7WIUh6Sd18iAIN/V+zHQ=;
        b=sId/tGp2Q0wtHoKs1QmCrnRKHtNeX6Ioyk7OhkHY/X98Zyb1Db2ODlHlgAzAP/AWdu
         qNqPVixHbPABFNas1QNHg/Yn5NDSHTmhLjORRyT1oiDl8/CPjobkTgXZl4mqvulPn4GK
         WDCelXiurQtNZM31pQ8I1B6KDwxRYsa/RYKG0Z/aiMBC1k1L7LP7ZrUdDCqEAv/gOTEC
         KBCiOCO5E/BOTtoLgnFQ0Be352FCs1XkI2oMUDwXi5f3OYaMM+WQuT7iLbLQvwHYvnlG
         jZcrStn5Zq4rimub/WIIhuyp6vGX/ee0Llm3oDIaFx8qCtmeTNoLf+Dd0mB6l2Zy1Ek+
         DkCg==
X-Gm-Message-State: ACgBeo0gn+LcPP2CQhcsqIq6jlmu4bkju+8BMeynrd4RXU7+Ku/AqxkO
        Yyeia02NI0DfLJTG9qw1dkoFPPKG8Fp13p7pn/w=
X-Google-Smtp-Source: AA6agR5z6QX+XHXJkawHhUKqvOEM9r8zWmaTFfCMLn882ehUJ7vamUvJJA2t1Z792qUJdai+1jKCgA==
X-Received: by 2002:a05:6402:4411:b0:437:b723:72 with SMTP id y17-20020a056402441100b00437b7230072mr5124189eda.38.1661285939301;
        Tue, 23 Aug 2022 13:18:59 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id ky9-20020a170907778900b0073d64fcd8aesm232174ejc.219.2022.08.23.13.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 13:18:58 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id n7so18303037wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:18:58 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr14338202wrr.583.1661285938285; Tue, 23
 Aug 2022 13:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220726102024.1.Icc838fe7bf0ef54a014ab2fee8af311654f5342a@changeid>
 <20220822193153.zn2oxljmd76awqot@halaneylaptop> <CAD=FV=V_V-M1fJmeWH_=wG4GB9GERL9ToAZTwAjX9i-6k6QkWA@mail.gmail.com>
 <YwTQ1i5s5cwowRss@sirena.org.uk>
In-Reply-To: <YwTQ1i5s5cwowRss@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Aug 2022 13:18:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V5VF-cwN7xiqz5HHPORrGGDPgVehC7zwQj2xfi0mi2Jw@mail.gmail.com>
Message-ID: <CAD=FV=V5VF-cwN7xiqz5HHPORrGGDPgVehC7zwQj2xfi0mi2Jw@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

On Tue, Aug 23, 2022 at 6:06 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Aug 22, 2022 at 01:13:55PM -0700, Doug Anderson wrote:
>
> > I guess at this point I'll wait for Mark to give his suggestion for
> > what to do. Options I'm aware of:
>
> > a) ${SUBJECT} patch was written as a cleanup as per Mark's request and
> > we could just revert it.
>
> > b) We could make it so that failures to get the input/output voltages
> > doesn't count as an error when going through the get_optimum_mode()
> > path.
>
> We could push the checks for a valid voltage down into the drivers, a
> lot of things aren't particularly sensitive to the output voltage here
> and are much more sensitive to the current draw.  Depending on people's
> attitudes to DT stability for Qualcomm platforms we could also fix the
> affected DTs as well, though that doesn't stop us handling this in the
> core too.

OK, patch posted with this approach. ("regulator: core: Require
regulator drivers to check uV for get_optimum_mode()") [1]

[1] https://lore.kernel.org/r/20220823131629.RFT.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid
