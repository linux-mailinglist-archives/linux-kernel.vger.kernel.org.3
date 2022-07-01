Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA1563741
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiGAPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGAPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:52:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561012D2F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:52:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 136so2808424pfy.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwCJQx8sgFjKqx/lCA3RxH+lFCAU49v9gAkFazVr4kI=;
        b=JGyKim5cmpBfr8P3eul8H76XrfNlBpwWXjFJV6xVwpsD8Wx+/M1K7OOCy9WXfWxjjd
         lJzA67y66zVfCRfRcnAC9DhfnLsXQjccJc3KhK4qyFU33+g0xaWzX5KGnRiVKwn6nvJn
         IRswZzOBwkqI61T41Z6RekZBAHdeIEba6xJFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwCJQx8sgFjKqx/lCA3RxH+lFCAU49v9gAkFazVr4kI=;
        b=jziBcr1pSAAS8HxQImEDZjIKEO1Esv6IIJWNigRQ3mfgzZxRZYLLWXBE3z+NarPXYC
         krYyo3gMpYIW1hcdmU/9NI7dVVjrlR6vC6SGyAiYl/XKkXseh2b8G44PrAHNy1wzBuM6
         GTcQ0A0zOJ0L15KNH6IWtKRqEwEJNv7bj6WirZRruppUfhj1W97lDbHTWx6+93dDu81B
         7XNm3hA4lHIwse/Qo7L4hc23RMaO1zQV8I1GCsTpEvSOoUCM6Pq3IPaM4Uo+TVTsWRXt
         AKICMJkzjgBhHOd1WWTPkL4MW5AtrsauKNkpgBJoS0qn1/xfg5Dhinr4GV1jj0vNF0q5
         cExg==
X-Gm-Message-State: AJIora/cy/Yqf2KH7KxjfLE8EcAcAHdJwFzL5PhCIb9TjCuL6tP8rV8j
        e4HDfJyto6RJ+2Wj/MWjaj3gWzMUxg3pGQ==
X-Google-Smtp-Source: AGRyM1unAQ7Hy3XTb21SIviGN36FXP7laFKOa5oKp755UdNTtbj9rY+F/HVa5luU0xbBFupWbBWmmw==
X-Received: by 2002:a63:334d:0:b0:40c:3c28:1ec4 with SMTP id z74-20020a63334d000000b0040c3c281ec4mr13002795pgz.623.1656690772093;
        Fri, 01 Jul 2022 08:52:52 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:faad:e53e:b60a:f694])
        by smtp.gmail.com with UTF8SMTPSA id mj17-20020a17090b369100b001e2bd411079sm4327044pjb.20.2022.07.01.08.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 08:52:51 -0700 (PDT)
Date:   Fri, 1 Jul 2022 08:52:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_vpulyala@quicinc.com
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <Yr8YUYJGJ5FRA3cv@google.com>
References: <YqjLHyUVEjf7I3MI@google.com>
 <20220616091110.GA24114@hu-pkondeti-hyd.qualcomm.com>
 <YqtlRQOwb3t6Xtd0@google.com>
 <20220620085415.GA13744@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n52bq9feA6BVdAp791SWQtT1Yj4M2ppg3o_KOaRFO8r+0Q@mail.gmail.com>
 <20220628053148.GA21797@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n50PGw_XSZ0-iV7gem6+-LENoq6ZVOwX3f+0XjkrHg-rLw@mail.gmail.com>
 <c16a1c37-9183-8d0c-a5ad-39b897a0ab24@quicinc.com>
 <Yr5JmrSaus8xKpM9@google.com>
 <20220701101526.GA30468@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220701101526.GA30468@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:45:26PM +0530, Pavan Kondeti wrote:
> On Thu, Jun 30, 2022 at 06:10:50PM -0700, Matthias Kaehlcke wrote:
> > > > dwc3-qcom should wait for dwc3 core to call component_add() and then do
> > > > whatever needs to be done once the dwc3 core is registered in the
> > > > dwc3-qcom bind callback. Honestly this may all be a little overkill if
> > > > there's only two drivers here, dwc3-qcom and dwc3 core. It could
> > > > probably just be some callback from dwc3 core at the end of probe that
> > > > calls some function in dwc3-qcom.
> > > Since the issue we are facing is that the ssphy device links are not ready
> > > causing the dwc3 probe not being invoked, can we add an API as Pavan
> > > suggested
> > > to check if deferred_probe listfor dwc3 device is empty or not andbased on
> > > that we can choose to defer our qcomprobe ? In this case, we don't need to
> > > touch the dwc3 core driver and would be making changesonly in qcom glue
> > > driver.
> > 
> > As mentioned above, it shouldn't be necessary to add component support to
> > all the glue drivers. An API to check for deferred probing is an option,
> > however there is a possible race condition: When the dwc3-qcom driver checks
> > for a deferred probe the core could still be probing, in that situation the
> > glue would proceed before the core driver is ready. That could be avoided
> > with the component based approach.
> 
> The race can happen only if asynchronous probe is enabled, otherwise the
> child's probe happens synchronously in of_platform_populate() 

I was thinking about the case where the dwc3-qcom probe is initially deferred,
then the deferred probe starts shortly after (asynchronously) and now the
dwc3-qcom driver does its check. Probably it's not very likely to happen ...

> OTOH, would the below condition suffice for our needs here? if our device
> is not bounded to a driver, we check the state of initcalls and return
> either error or -EPROBE_DEFER
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 7b6eff5..519a503 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>  		dev_err(dev, "failed to get dwc3 platform device\n");
>  	}
>  
> +	if (!qcom->dwc3->dev.driver)
> +		return driver_deferred_probe_check_state(&qcom->dwc3->dev);
> +
>  node_put:
>  	of_node_put(dwc3_np);

I like the simplicity of it, no need for new APIs.

The components based approach would be slightly safer, but in practice I
think this should be good enough.
