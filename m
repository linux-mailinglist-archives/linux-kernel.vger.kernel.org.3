Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECB5A6C80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiH3SoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiH3SoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:44:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF057436B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:44:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q15so6835507pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NZVZkfFYq+g48u9ab87ZWo6dPBjM06Q+lLAU8Yvk5EA=;
        b=Axzf/shUDMALwg8iHDSJOsle0Qw6yo7nQ4L0Ew2LPymFZnPev4UAjpWJldbz1gztDq
         jKZJw7kpHpXifWeb417pif3gyrl7IsgOi9WFU3RwiXyuvYeVh5uByAISbNeGVLzQ7MTp
         gueWsarra0u8xd3OAbrUmHKAixAZjsKVVwK1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NZVZkfFYq+g48u9ab87ZWo6dPBjM06Q+lLAU8Yvk5EA=;
        b=qqhWndmo3oySBvRxzEw6leMX5139VZboaT70M4dQAn79r3nHwm5OIJ8hm4imyics0F
         abKRzJjl4p9RzKaEWeTmdyolrZ+DrslfudSzENNH52apPWnS/V5gFae19eEhy92XXmRb
         vtUAnfo7BRAhgbEWjMP0Hx/3Iq/kSeJGPTDbK+FL9OrExJTkFHneVN02Whn6O1IO6etd
         AwAIVlV3D42xqQHqgSfbfaIzE+9XgB2TKjfpRoH4BmIyQfkm4p+nyyxdZbUFQoopH157
         aouNh3I7bVyLE3L9YfrataXMUB7fDZyD+TYqJmNEbW8+RZjBbvRzb4LTkidPwcSocxbe
         eYXw==
X-Gm-Message-State: ACgBeo3AXqOdYNJhEEPXaQXx8mOjqb0uh2BdMhOhsid0XM5ospHOvd4I
        1E/IN5mt50wub4m/5MvAioTB5g==
X-Google-Smtp-Source: AA6agR7zpTyvcECkA2jQOB4My7timJiRT9otT5h6XOP4Y4xqijtClzf1Ffy2uOmONrciFnSEmceaNw==
X-Received: by 2002:a63:1841:0:b0:429:8268:1fc with SMTP id 1-20020a631841000000b00429826801fcmr19102261pgy.78.1661885039627;
        Tue, 30 Aug 2022 11:43:59 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:f023:bd53:48bf:f508])
        by smtp.gmail.com with UTF8SMTPSA id b11-20020a170902d50b00b0016dc2366722sm10163636plg.77.2022.08.30.11.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:43:59 -0700 (PDT)
Date:   Tue, 30 Aug 2022 11:43:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-clk@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc-sc7180: Keep the USB GDSC always on
Message-ID: <Yw5abfBHQSl62pB9@google.com>
References: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220826024003.qpqtdmdohdmpcskt@baldur>
 <5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 01:42:02PM +0530, Rajendra Nayak wrote:
> 
> On 8/26/2022 8:10 AM, Bjorn Andersson wrote:
> > On Thu, Aug 25, 2022 at 06:21:58PM -0700, Matthias Kaehlcke wrote:
> > > When the GDSC is disabled during system suspend USB is broken on
> > > sc7180 when the system resumes. Mark the GDSC as always on to
> > > make sure USB still works after system suspend.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > Rajendra, where you able to find some time to look into take the GDSC
> > into retention state? Do you suggest that I merge these two patches for
> > now?
> > 
> 
> Hi Bjorn, based on my experiments to support retention on sc7280 these are
> some of my findings
> 
> On Platforms which support CX retention (for example sc7180/sc7280) instead of
> CX PowerCollapse (PC), We can leave the GDSC turned ON. When CX transitions to RET state
> the GDSC goes into retention too (some controller state is retained) and USB wakeups work.
> 
> On platforms which support CX PC, just leaving the GDSC
> turned ON will not help since the GDSC will also transition to OFF state
> when we enter CX PC, hence wake-ups from USB won't work.
> For such platforms we need to make sure gdsc_force_mem_on() is called
> and cxcs (* @cxcs: offsets of branch registers to toggle mem/periph bits in)
> are populated correctly, while leaving the GDSC turned ON.
> This will make sure usb gdsc transitions from being powered by CX to MX
> when CX hits PC and we still get USB wakeups to work.
> So in short we could do the same thing that this patch does on those
> platforms too with additionally populating the right cxcs entries and it
> should just work fine.
> 
> Now the problem that I see with this approach is not with getting USB wakeups
> to work in suspend, but with supporting performance state voting when
> USB is active.
> The last conclusion we had on that [1] was to model usb_gdsc as a subdomain of CX,
> so if we do that and we model usb_gdsc as something that supports ALWAYS_ON,
> we would _never_ drop the CX vote and prevent CX from going down (either to ret
> or pc)
> 
> The only way I think we can solve both the USB wakeups and performance state
> needs (with usb_gdsc as a subdomain of CX) is if we can model a RET state for gdsc
> which sets the mem/periph bits while leaving the GDSC ON (Today the RET state sets
> the mem/periph bits but turns the GDSC OFF)
> 
> That would mean a change in gdsc.c like this
> ---
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index d3244006c661..0fe017ba901b 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -368,6 +368,10 @@ static int _gdsc_disable(struct gdsc *sc)
>         if (sc->pwrsts & PWRSTS_OFF)
>                 gdsc_clear_mem_on(sc);
> 
> +       /* If the GDSC supports RET, do not explicitly power it off */
> +       if (sc->pwrsts & PWRSTS_RET)
> +               return 0;
> +
>         ret = gdsc_toggle_logic(sc, GDSC_OFF);
>         if (ret)
>                 return ret;
> 
> 
> So with that change, we would then not need the ALWAYS_ON flag set for usb gdsc,
> instead we would update the .pwrsts to PWRSTS_RET_ON instead of PWRSTS_OFF_ON,
> and that should make both usb wake-ups to work and we can still have the usb_gdsc as
> a subdomain of CX for performance state voting.

Krishna and I confirmed that this works from the USB side for sc7180 and sc7280.
