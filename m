Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D854A346
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiFNAuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiFNAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:50:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791FB2FFFE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:50:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x138so7187485pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACPm1ucMTOfi6ue/vXhWlbqaubMdDkKHxItbdVtdzEE=;
        b=iYC0JOhxEj9AINp/vrpMdikzU0oJrpyR1YAiazkp6nK8NrpW3f0uAlfOrYHcimtc35
         jiBw/PzazQUFDPZ32OuGe1CmP66JTJhZtSKcyXfAQfCez7PoDjHOkozPQPpDZH7ip/6A
         IH4Nh/Ru2fAg85Aan/uHiiT0PwXc1LstPcudo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACPm1ucMTOfi6ue/vXhWlbqaubMdDkKHxItbdVtdzEE=;
        b=EaDGO3MiIDpE6kBtjL/n0y5vml/pQDC0aeU9kXJc1ia6fhBuJfJhzLWCkyOYy8kJf9
         piFqpDqvoeeLcazAxAZRChLzKr0RTvMAKSfqG1OUAjiGv+FID5qohUx8RvLjMTccsgYW
         sveSkj5VdtP4y4TkYWFAqLqPDZTviw9JYcHC2zD75iOESjcflD9A3FT5SqACQsOP3h7P
         doSJ+R+dn2/Tr2ukhP6K6ITvlKV8TqZYfOEzAxKafuXvZySXpWRJ8tqfr2pmLAk1AfNQ
         TnG7dHAbip0I3mVz9+LXHSN83HNXDp9akIodNtHM+VkL8nFL2hPthmtK7IBriWKhUCQV
         jb7w==
X-Gm-Message-State: AOAM533AxmwmfRgcdjWY6oXygUcQL3PUSJLbWHZQH/JJQU7Tv2kftlBq
        qg3P3UIeQXRZMItTTqUJAWpajw==
X-Google-Smtp-Source: ABdhPJz1vRzxCw2py7mXm3l4Hx3ORSS7vhcYns5Vnoc1vi1vDPLfl40RxweDgBEXhirb4w8MXGVOjA==
X-Received: by 2002:a63:c046:0:b0:401:abda:a537 with SMTP id z6-20020a63c046000000b00401abdaa537mr2140270pgi.150.1655167827954;
        Mon, 13 Jun 2022 17:50:27 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c4fb:a1d8:47ef:f10c])
        by smtp.gmail.com with UTF8SMTPSA id f4-20020a62db04000000b005184fe6cc99sm6028282pfg.29.2022.06.13.17.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 17:50:27 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:50:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [v21 4/5] usb: dwc3: qcom: Configure wakeup interrupts during
 suspend
Message-ID: <YqfbUu/X1joc1rUJ@google.com>
References: <1655094654-24052-1-git-send-email-quic_kriskura@quicinc.com>
 <1655094654-24052-5-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1655094654-24052-5-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:00:53AM +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Configure DP/DM line interrupts based on the USB2 device attached to
> the root hub port. When HS/FS device is connected, configure the DP line
> as falling edge to detect both disconnect and remote wakeup scenarios. When
> LS device is connected, configure DM line as falling edge to detect both
> disconnect and remote wakeup. When no device is connected, configure both
> DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 72 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 62 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 7352124..1046ea8 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -20,7 +20,8 @@
>  #include <linux/usb/of.h>
>  #include <linux/reset.h>
>  #include <linux/iopoll.h>
> -
> +#include <linux/usb/hcd.h>
> +#include <linux/usb.h>
>  #include "core.h"
>  
>  /* USB QSCRATCH Hardware registers */
> @@ -76,6 +77,7 @@ struct dwc3_qcom {
>  	int			dp_hs_phy_irq;
>  	int			dm_hs_phy_irq;
>  	int			ss_phy_irq;
> +	enum usb_device_speed	usb2_speed;
>  
>  	struct extcon_dev	*edev;
>  	struct extcon_dev	*host_edev;
> @@ -296,11 +298,34 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
>  	icc_put(qcom->icc_path_apps);
>  }
>  
> -static void dwc3_qcom_enable_wakeup_irq(int irq)
> +static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> +{
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> +	struct usb_hcd *hcd = platform_get_drvdata(dwc->xhci);
> +	struct usb_device *udev;
> +
> +	/*
> +	 * It is possible to query the speed of all children of
> +	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
> +	 * currently supports only 1 port per controller. So
> +	 * this is sufficient.
> +	 */

nit: not sure it's really valuable to mention what could be done
theoretically. Saying that the dwc3 driver currently only
supports one port per controller should be enough.

No need to respin for this,

> +	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> +
> +	if (!udev)
> +		return USB_SPEED_UNKNOWN;
> +
> +	return udev->speed;
> +}
> +
> +static void dwc3_qcom_enable_wakeup_irq(int irq, unsigned int polarity)

'polarity' isn't really accurate, the parameter also encodes whether the IRQ
is edge or level triggered. 'irq_type' would be clearer.

Also no need to respin just for this.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
