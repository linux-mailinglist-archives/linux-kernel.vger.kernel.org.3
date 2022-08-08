Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2958C8EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbiHHNBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243057AbiHHNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68ED2DA;
        Mon,  8 Aug 2022 06:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 727C3611EC;
        Mon,  8 Aug 2022 13:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7380EC433D6;
        Mon,  8 Aug 2022 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659963617;
        bh=2CWNRw3SZiNvEQoOHynSGdYSYJb4sRo+hBpwso9st7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxqMMGjE2+zN11NBpzF97pIQ41023k+y+C7iX7t+zKsRV76Nzt0SQcAkNnu42IZM/
         a8PpHdwwm38uPzySKx+RcKH/Ai8Ni3puw0YW4cfStCQkGElMzYPDLgxJcv+uN/KtEr
         CudkyIYeDGmaoOUSvvx1G9T+LzuKUH7oJGT0Ui/w=
Date:   Mon, 8 Aug 2022 15:00:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: qcom: Provide stubs for
 dwc3_qcom_read_usb2_speed function
Message-ID: <YvEI3vQ+Km1oOisQ@kroah.com>
References: <1659337215-20421-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659337215-20421-1-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:30:15PM +0530, Krishna Kurapati wrote:
> Dwc3 Qcom driver makes use of usb_hub_find_child API in its efforts
> to get speed of connected devices (HS/LS/FS) and enable interrupts
> accordingly. usb_hub_find_child API is a part of usb core compiled
> either into the kernel or as a module (CONFIG_USB= Y or M). In some
> builds (make randconfig for i386) CONFIG_USB is not enabled and the
> usb core is not compiled resulting in linking errors.
> 
> Provide stubs for dwc3_qcom_read_usb2_speed function to use
> usb_hub_find_child API only if CONFIG_USB is enabled. Else return
> USB_SPEED_UNKNOWN.
> 
> Fixes: 6895ea55c385 (usb: dwc3: qcom: Configure wakeup interrupts during suspend)
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: Updated commit text to include cases when CONFIG_USB=m as well.
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index c5e482f..bd8dc5a 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -299,6 +299,7 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
>  	icc_put(qcom->icc_path_apps);
>  }
>  
> +#ifdef CONFIG_USB

How is code for a USB host driver being built if CONFIG_USB is not
enabled?

Shouldn't this driver be split up cleaner to not be built at all if that
is not happening and this is a gadget-only configuration?

thanks,

greg k-h
