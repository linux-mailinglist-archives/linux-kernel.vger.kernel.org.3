Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5859ECEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiHWT47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiHWT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:56:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7A62C0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:05:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 12so13070701pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Kdb8TxBwkoe3B83ftbWvI5bDuEon4/Ru3EI6rNbmWGQ=;
        b=Z43eXf7sSp1pEmvfjoOW73lKT1LlllQnMFnv9B3dxhgO56wTdDsGRHhL+uMhTwxJxe
         6hNMX3LPN8+gR924uesklbfSY7g4v3CrRBOEhPQPmQprz2riJgnmlZV6S1ItTsUk6p0f
         Yai/xfjAr7wSQXab8eWRJEHot/0yLlRO3HyYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Kdb8TxBwkoe3B83ftbWvI5bDuEon4/Ru3EI6rNbmWGQ=;
        b=dh1UJ54rQMstCnc7EBbWcLGIifFvjokZJgnIfsA3Z/vm63h8Q4BP04XEcjFLKxFF56
         Mo8k7DVnyVKaDLOLCG8b7MpTNN7a4PuIFFJvSGTT0WDuDY7qQqGR52BOT16ZT5iN3+Ne
         o6Dh8CIJR2yK3X0DDuqHovw6W4dNPRyxMf8glDNQupYhgSRQWHRTPLQ2UNyigVsyRlty
         gMmnQFSntRRODP7fPKxJDtocWR9/h+QhIb2Kt6MIRyOGPNHiAmW//noFl5W4c5fR6bst
         vKO8oeCdrhPrQ2KJKZ9VbOF9YJBsOqBksdkF3xBl7mVWJ/0nvfUHbqchLZhWUMgK6BMj
         Hvxg==
X-Gm-Message-State: ACgBeo2lJ6YSd7bDTIwTsL74dLZ3l92jgqzdB1oNl03NVboRa7g+1AVD
        xA1ZKFepQUhbaAt/RKL/rTfPoA==
X-Google-Smtp-Source: AA6agR6IieQ04uStZ7vlgwdj4aRqXinsIAlMP+KbxaXdW2rId0+ARMMoqZr7isvwnxHsH3I//9epxw==
X-Received: by 2002:a63:5418:0:b0:42a:d773:cbd6 with SMTP id i24-20020a635418000000b0042ad773cbd6mr5543100pgb.106.1661281533664;
        Tue, 23 Aug 2022 12:05:33 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:fee6:a961:5d1d:553])
        by smtp.gmail.com with UTF8SMTPSA id e3-20020a170902784300b00172de80fec4sm5824250pln.69.2022.08.23.12.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 12:05:33 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:05:31 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sc7180: Keep USB GDSC power domain on
 when USB wakeup is enabled
Message-ID: <YwUk+ymRUdwzBTnX@google.com>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220822235207.A4D8EC433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220822235207.A4D8EC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Aug 22, 2022 at 04:52:05PM -0700, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2022-08-22 11:53:10)
> > Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domain of SC7180.
> 
> Why? Does it fix something? Please add details to the commit text so we
> know how urgent of a patch it is and why it is important.

Without it USB is broken after resume when the PHYs remain enabled
during suspend.

Johan just sent a patch [1] that always disables the PHYs (again)
during system suspend, with that this series shouldn't be needed.
It is possible that in the future we add a mechanism to keep the
PHYs on depending on some config option (quick, kconfig, ...). If
that happens we'll have to revisit this series, for now it
shouldn't be needed assuming Johan's patch gets landed.

[1] https://patchwork.kernel.org/project/linux-usb/patch/20220823124047.14634-1-johan+linaro@kernel.org/
