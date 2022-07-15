Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6542157684C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiGOUmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGOUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:42:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672AF528A6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:41:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o12so5599320pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WtZRDzM8YJ97S/1Li5D/D44YAKcdEwJfblvdKCPMsAc=;
        b=h9mO28BVHHbGShv1uBCtq7ZZifV3OOTDANCsGvtddURVoUa57Ouy0cRfb8h/UxuZUn
         wHWtFVlfeAly/PSS/772SluwtFygGQYZrM+pSzu07xnsKlX06xwKk3lXfQqTnzgpPYgs
         vG9B137tWetNmkSVx/6ucFo/nv10tm0kBnsjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WtZRDzM8YJ97S/1Li5D/D44YAKcdEwJfblvdKCPMsAc=;
        b=i09bxE8I1IggRqB0T7t1RThBT4AjSOx+kTwdJxxU8Y16/YVw5l+Tz/jMVnI0cP/aIA
         1h0/dOS+cMY1ES7tsdMhaNIqajNj/l9sQWMyAZcl+RMeHKWbIBUehJFBUcoyyvHV+aBE
         IiNe68ftG2swLh/t/i5+wLL28bXV6rGh4p9azcoILz/u6xh3cQ5/YUfCcy+3Z0Xr7lAT
         64YSxw5DZkVXtDgB7ii3CNuqbYav4NxXSbrB6exAHkBtqC8AHGIS3FDtBytX1NEJ8Tq1
         icVdfkU4H3Xq7ltvt3c81LkxH71+4rUp5rB+4DTr4cnXAYGJmljN/jxXpwcwnX/vZ4HT
         yCOA==
X-Gm-Message-State: AJIora8A/50bbx5/hqbzBo4FLb6kv871+zZRvrGXyOehB1CjEJJUVwGm
        FjKPsvCgphFP/dDikAcA03PMLQ==
X-Google-Smtp-Source: AGRyM1vr9Gi++zE+26ugt96VQljO9f6LQq5uJA99uXorvAUYnr7XDA1roHUKlradhlJytAU1JAbaOQ==
X-Received: by 2002:a63:2486:0:b0:412:9de2:eb49 with SMTP id k128-20020a632486000000b004129de2eb49mr13912375pgk.224.1657917718974;
        Fri, 15 Jul 2022 13:41:58 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:835b:7656:818:a69a])
        by smtp.gmail.com with UTF8SMTPSA id 187-20020a6205c4000000b0051c4f6d2d95sm4309705pff.106.2022.07.15.13.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 13:41:58 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:41:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't
 probed properly
Message-ID: <YtHRFcol5uslEel1@google.com>
References: <1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:51:52PM +0530, Krishna Kurapati wrote:

> Subject: usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't probed properly

nit: "isn't probed properly" sounds like a bug or HW issue. In case
you re-spin maybe change it to "hasn't probed yet" or similar.

> On SC7180 devices, it is observed that dwc3 probing is deferred
> because device_links_check_suppliers() finds that '88e3000.phy'
> isn't ready yet.
> 
> As a part of its probe call, dwc3-qcom driver checks if dwc3 core
> is wakeup capable or not. If the dwc3 core is wakeup capable, driver
> configures dwc-qcom's power domain to be always ON. Also it configures
> dp/dm interrupts accordingly to support wakeup from system suspend.
> 
> More info regarding the same can be found at:
> commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
> commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> 
> In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
> probe, driver ends up reading the wakeup capability of dwc3 core as false
> leading to instability in suspend/resume path.
> 
> To avoid this scenario, ensure dwc3_probe is successful by checking
> if appropriate driver is assigned to it or not after the of_platform_populate
> call. If it isn't then defer dwc3-qcom probe as well.
> 
> Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reported-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Please make sure to add reviewers of previous versions or other folks you
would like to review your patches in cc. I found v2 accidentally while
looking for something else.
