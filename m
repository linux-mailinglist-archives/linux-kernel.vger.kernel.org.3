Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CBD59CB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiHVWbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiHVWbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:31:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19651411
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:31:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso12691944pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yA55LWsUqx+EY3j76KfUtoYpWHB5KIhjswVr3ZOiS0g=;
        b=X9awsab89oouZvULxAXG4hU+UalhOJWDfyoKYVufR9R1WcZfmluKvo6rxCTlN24OGT
         h8FoBbDs6a18++3vMYTNubweVDZ9iU4U0YBo8uhdq6tL0wOzMcKVQSkBezlwPB9aCIQj
         HZPYfSmn4fI+XkraTZkaybT99dlsumdmC45vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yA55LWsUqx+EY3j76KfUtoYpWHB5KIhjswVr3ZOiS0g=;
        b=cAIfI2ymKt1dvms6h9qFpUM3Fd0/oFcGvZz47M0M5UnKlJG0KkL+hUvLNM9zx3lWtE
         aeT7ACTD69RkDSc8CDJKBSkw2Hev4Ga7QQGbRf80ac760j4XjPOO56ca/i85vSDvdSdC
         2UUvx1j1oVjbSLO1zt8WmAucowPfeDzVVo0Eld69SYLF2B8X5c28Ru0ByYDbn4zvddDm
         J7yLDMMigT0ymU8WD0a1B8avxSzn3CVioCvoq5h5G28UHDaJXqhv7pZKcsD/1NOde9fU
         IpihTd9isKxmrKThW/ALJnvTAzH0QvL1ZagG/vmFGzkkv30Q054cEoshRDwbxxqG4+tu
         WJfw==
X-Gm-Message-State: ACgBeo0T+sklpWIgvKWvzgsn0Zpnn816pnvxWTW+Bg8tHeqJU5/F/Ymm
        JXrNmxTPIoLsDbDyYyk9wGzaMg==
X-Google-Smtp-Source: AA6agR4lkM+O28NwF/maGoBvvjVrV30yZX0jTqemn/8bNrfD6P+b7QRP5VtGTTd12SwSeu79q0vrNA==
X-Received: by 2002:a17:902:ab52:b0:172:f759:f997 with SMTP id ij18-20020a170902ab5200b00172f759f997mr3371800plb.140.1661207483747;
        Mon, 22 Aug 2022 15:31:23 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:1969:d650:d765:53ef])
        by smtp.gmail.com with UTF8SMTPSA id p18-20020a170902ead200b0016a6caacaefsm8870435pld.103.2022.08.22.15.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 15:31:23 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:31:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, andersson@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: move USB wakeup-source property
Message-ID: <YwQDuXXkgwPAu55D@google.com>
References: <20220802152642.2516-1-johan+linaro@kernel.org>
 <YwOBEhViD1iY14yL@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwOBEhViD1iY14yL@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 03:13:54PM +0200, Johan Hovold wrote:
> On Tue, Aug 02, 2022 at 05:26:42PM +0200, Johan Hovold wrote:
> > Move the USB-controller wakeup-source property to the dwc3 glue node to
> > match the updated binding.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> > 
> > This one can be applied once the following series has been merged:
> > 
> > 	https://lore.kernel.org/all/20220802151404.1797-1-johan+linaro@kernel.org
> 
> The above series has now been merged (for 6.0):
> 
> 	https://lore.kernel.org/all/Yv56fFpuUsxCSxJ8@kroah.com/
> 
> so that this patch can be applied.

Please apply it together with "clk: qcom: gcc-sc7280: Keep USB GDSC power
domains on when USB wakeup is enabled" [1], otherwise USB wakeup won't work,
and worse, USB would be broken after returning from system suspend.

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid/
