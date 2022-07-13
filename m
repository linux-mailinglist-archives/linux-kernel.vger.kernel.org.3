Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D95572AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiGMBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGMBee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:34:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A024C923C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:34:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so1156244pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGSpGU9y1qKiwBDHtAjINY9EHDaIDTEGfdXCP9bclWI=;
        b=V4fBHAYghVFtCj/gyK9mu3PyvFXqcOoz2B2mKkJDh/adD4u9JvaBL253pjyTFBedRt
         GVuAft2l+07Oz6wgg4sUN8GjywhMpSBY8JBWFfogIjh3h/wQnPJNZJ7+uzDvCbVEyy7c
         TJy9acvtLuLwkUzPXiqBbcfn+02wtNDgmDZvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGSpGU9y1qKiwBDHtAjINY9EHDaIDTEGfdXCP9bclWI=;
        b=rHr6mNQHvF/Jti5YDtwB+i3sndlvx8USrOC2y8MNivB6u5xRaWI9ZNlt3oBiAgIgmV
         4Mcq9nK8jLop47pOTl9cYsME05r3WqrlFOEau1on326jc82YzB5X5R29VkMLO4R01enk
         T7il+NKSmb+3Y99D/ZrxggR8tYMO9B4aM8f355MNc9MzneobmapBHdp/rpI55zABo7p7
         ROa1Z20+1EYHoIXYNxT2XmBnAm4Io1SYUrg6T9cH/k2rICvfrMZdcUg+vSdom5IhjK5k
         gtrkg6eIZQw/p7xWhqGrtH4PUAjUqFV4Y2wubPBKHrgqufsmEPHGDbK8vO8ynp58oDFX
         uwhQ==
X-Gm-Message-State: AJIora9dsMdh1HhkGrs2qfEzeFFOLrx6MJgUMgrV13vF2n/mAWj5NklY
        yx7Z0XM1Lo8fcrgHZ7Q24184Rg==
X-Google-Smtp-Source: AGRyM1vI7qTqran/oYY9YxCvZJ1Kt81TzkURUZr5Ev/sRdQsuRtTkDpVmPEpjwtDdB06uhd4ToiPtA==
X-Received: by 2002:a17:902:b7c4:b0:16b:e3d0:c0fe with SMTP id v4-20020a170902b7c400b0016be3d0c0femr842506plz.98.1657676072727;
        Tue, 12 Jul 2022 18:34:32 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e036:8c0d:9cf:7a45])
        by smtp.gmail.com with UTF8SMTPSA id kk18-20020a17090b4a1200b001ec9dce6f10sm226231pjb.38.2022.07.12.18.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 18:34:32 -0700 (PDT)
Date:   Tue, 12 Jul 2022 18:34:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>, saravanak@google.com,
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
Message-ID: <Ys4hJrWjkn+LREZL@google.com>
References: <20220620085415.GA13744@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n52bq9feA6BVdAp791SWQtT1Yj4M2ppg3o_KOaRFO8r+0Q@mail.gmail.com>
 <20220628053148.GA21797@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n50PGw_XSZ0-iV7gem6+-LENoq6ZVOwX3f+0XjkrHg-rLw@mail.gmail.com>
 <c16a1c37-9183-8d0c-a5ad-39b897a0ab24@quicinc.com>
 <Yr5JmrSaus8xKpM9@google.com>
 <20220701101526.GA30468@hu-pkondeti-hyd.qualcomm.com>
 <Yr8YUYJGJ5FRA3cv@google.com>
 <09f6a717-2bbb-6bd3-f7a8-5ac9e3db51f3@quicinc.com>
 <9f9f9abc-9b37-8bfb-3efa-6c860b5dba8d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f9f9abc-9b37-8bfb-3efa-6c860b5dba8d@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:37:19PM +0530, Krishna Kurapati PSSNV wrote:
>    On 7/6/2022 12:28 PM, Krishna Kurapati PSSNV wrote:
> 
>    On 7/1/2022 9:22 PM, Matthias Kaehlcke wrote:
> 
> On Fri, Jul 01, 2022 at 03:45:26PM +0530, Pavan Kondeti wrote:
> 
> On Thu, Jun 30, 2022 at 06:10:50PM -0700, Matthias Kaehlcke wrote:
> 
> dwc3-qcom should wait for dwc3 core to call component_add() and then do
> whatever needs to be done once the dwc3 core is registered in the
> dwc3-qcom bind callback. Honestly this may all be a little overkill if
> there's only two drivers here, dwc3-qcom and dwc3 core. It could
> probably just be some callback from dwc3 core at the end of probe that
> calls some function in dwc3-qcom.
> 
> Since the issue we are facing is that the ssphy device links are not ready
> causing the dwc3 probe not being invoked, can we add an API as Pavan
> suggested
> to check if deferred_probe listfor dwc3 device is empty or not andbased on
> that we can choose to defer our qcomprobe ? In this case, we don't need to
> touch the dwc3 core driver and would be making changesonly in qcom glue
> driver.
> 
> As mentioned above, it shouldn't be necessary to add component support to
> all the glue drivers. An API to check for deferred probing is an option,
> however there is a possible race condition: When the dwc3-qcom driver checks
> for a deferred probe the core could still be probing, in that situation the
> glue would proceed before the core driver is ready. That could be avoided
> with the component based approach.
> 
> The race can happen only if asynchronous probe is enabled, otherwise the
> child's probe happens synchronously in of_platform_populate()
> 
> I was thinking about the case where the dwc3-qcom probe is initially deferred,
> then the deferred probe starts shortly after (asynchronously) and now the
> dwc3-qcom driver does its check. Probably it's not very likely to happen ...
> 
> 
> OTOH, would the below condition suffice for our needs here? if our device
> is not bounded to a driver, we check the state of initcalls and return
> either error or -EPROBE_DEFER
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 7b6eff5..519a503 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device
>  *pdev)
>                 dev_err(dev, "failed to get dwc3 platform device\n");
>         }
> 
> +       if (!qcom->dwc3->dev.driver)
> +               return driver_deferred_probe_check_state(&qcom->dwc3->dev);
> +
>  node_put:
>         of_node_put(dwc3_np);
> 
> I like the simplicity of it, no need for new APIs.
> 
> The components based approach would be slightly safer, but in practice I
> think this should be good enough.
> 
>    Hi Pavan, Mathias,
>      I have tested the suggested code and verified that it works on
>    sc7180. I see that the API has been removed recently in the following
>    patch :\
>    commit 9cbffc7a59561be950ecc675d19a3d2b45202b2b
>    Author: Saravana Kannan [1]<saravanak@google.com>
>    Date:   Wed Jun 1 00:07:05 2022 -0700
>    driver core: Delete driver_deferred_probe_check_state()
>    Can we make a patch and add it back to the kernel for this purpose ?
>    Hi Saravana,
>      Can you help suggest if we can revert your patch or make a new one to
>    add back the function.

The cover letter [1] of the 'deferred_probe_timeout logic clean up'
series [2] has more context:


  A lot of the deferred_probe_timeout logic is redundant with
  fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
  a few cases.

  This series tries to delete the redundant logic, simplify the frameworks
  that use driver_deferred_probe_check_state(), enable
  deferred_probe_timeout=10 by default, and fixes the nfsroot failure
  case.

  The overall idea of this series is to replace the global behavior of
  driver_deferred_probe_check_state() where all devices give up waiting on
  supplier at the same time with a more granular behavior:

  1. Devices with all their suppliers successfully probed by late_initcall
     probe as usual and avoid unnecessary deferred probe attempts.

  2. At or after late_initcall, in cases where boot would break because of
     fw_devlink=on being strict about the ordering, we

     a. Temporarily relax the enforcement to probe any unprobed devices
        that can probe successfully in the current state of the system.
        For example, when we boot with a NFS rootfs and no network device
        has probed.
     b. Go back to enforcing the ordering for any devices that haven't
        probed.

  3. After deferred probe timeout expires, we permanently give up waiting
     on supplier devices without drivers. At this point, whatever devices
     can probe without some of their optional suppliers end up probing.

  In the case where module support is disabled, it's fairly
  straightforward and all device probes are completed before the initcalls
  are done.

[1] https://lore.kernel.org/all/20220601070707.3946847-1-saravanak@google.com/
[2] https://patchwork.kernel.org/project/linux-pm/list/?series=646471&archive=both&state=*


Does anything speak against returning -EPROBE_DEFER directly from dwc3-qcom's
probe()? Now with deferred_probe_timeout > 0 there should be at least no endless
probing.
