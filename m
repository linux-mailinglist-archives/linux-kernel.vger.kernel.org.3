Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA48526BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbiEMUo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244358AbiEMUoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:44:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEFB246405
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:44:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ks9so18400550ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55dffKzUURo3SfiqA/BEE8o52UNGk7nPiNJj9q1EvHo=;
        b=CkwOTBQa/6gpAvG7tg13PNADiJwjora+sLhHNmoDE5nuiBQ9yLYCkJyKH570Geq6zw
         4ayQB+4KtUdQOc7XprcGjHYoxqC2GIaCbnwloQ/SAKoCUo5gIvwmb+FljxCzfaZ1do3M
         fN40nTvQPGJixSvk/XOSsiVBi6lhuyEMXsIkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55dffKzUURo3SfiqA/BEE8o52UNGk7nPiNJj9q1EvHo=;
        b=VyHlVnEtAb6uAVPcY5gTV1voyrvmbXGBEWULBoEz25DXcdvQzdb9WwI4JitRFfvV6C
         RocZE0j4+X4N78VwIJqPRzlnI4AOeCXrmfQywcE2b4PrViId2e/8UN+DmU/fJpov4lrA
         7QSe8JtcOJUubANy1tLu1R3czImEiZrAaKsPTYAlpbSNNYs0uxlzoe72HqqUsQ/dvtuc
         3QWPnNaPIiYtcgrwpIYEoZicgTXBuuNvm/mvYOwV9zfUgZS5R8m2N35iVr4EaVHmQpqL
         ONE2QYqflCC7QVQABkFtXbrgI5xeYNseppVvdZMe2ELSsYTG7oiufvgoXX8DzqIdQsuh
         VvSg==
X-Gm-Message-State: AOAM531LsD5xce9QzSvlvHYuq1VmJgi7E+VOo8Jj9s0kWJDo6dNby/Zq
        2VMDi7rNZzsUr28lywUB5YiPh5BYglCNx28pmEQ=
X-Google-Smtp-Source: ABdhPJzEpqsGt1WNxSan0Q0H3bu2/IRDNUIIlTu+4kpPlI8SjyL242Un1iKdVuXOlxB0/WgYHnDi5Q==
X-Received: by 2002:a17:906:7c96:b0:6f3:b6c4:7b2 with SMTP id w22-20020a1709067c9600b006f3b6c407b2mr5855219ejo.676.1652474692663;
        Fri, 13 May 2022 13:44:52 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0042617ba63c6sm1338458edt.80.2022.05.13.13.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 13:44:51 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id v12so12815289wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:44:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2c1:b0:20c:5e37:3ed1 with SMTP id
 o1-20020a05600002c100b0020c5e373ed1mr5333219wry.342.1652474690235; Fri, 13
 May 2022 13:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.4.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid> <Yn7BbNeVXV1aGCsi@google.com>
In-Reply-To: <Yn7BbNeVXV1aGCsi@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 13 May 2022 13:44:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VpdfrkKJg8bgtTEACxH5VP+rXG0MTXPARi3S1htuqbSg@mail.gmail.com>
Message-ID: <CAD=FV=VpdfrkKJg8bgtTEACxH5VP+rXG0MTXPARi3S1htuqbSg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: qcom: Add more sc7180 Chromebook
 board bindings
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi,

On Fri, May 13, 2022 at 1:37 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 09:59:20AM -0700, Douglas Anderson wrote:
> > This adds board bindings for boards that are downstream but not quite
> > upstream yet.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I didn't follow the discussion about the odd sku ids (-sku1537,
> -sku1536, -sku1024, ...), but they match what is in the
> downstream tree, so it seems alright :)

It makes more sense in hex. hex(1536) = 0x600. Basically on these
boards there are two sets of GPIO strappings, the normal SKU
strappings and the panel strappings. Depthcharge combines them. You
end up with an ugly decimal number, but it's not the end of the world.

-Doug
