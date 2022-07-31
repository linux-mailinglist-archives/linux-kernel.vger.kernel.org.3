Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846AE585D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 07:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiGaFI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 01:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiGaFIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 01:08:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31013DE4;
        Sat, 30 Jul 2022 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VG/803tZkOvbYBCreVllSk19EdouWSWxaMRIYBi8YEo=; b=jLaGxuNKz2MbuMNtM7zNBVpdFi
        g6SYc7/SlNOeUWiAuxjY3hmc5XjJU4/4gLxRT1+7iVMIPThy2zJTzGJhY4STEdUcBLWWBV/PnfaWr
        e2T+AF+XXRv8k32Dh5KgVBtuaRecnVl/w6t33PppNSHM1DZn5jZlTFYToI4C28kxV+fbQeXj6x1Rb
        avMgyXUfLxvI6x9Dczotu0A5JWm3tq1yUizBvQlRjH65u2IjTkzMHKs2Naj71KwMkzVkpOIxbwLLp
        U7MTpjkkkym04hP+ObqWsCicBDNNtXIoaD++yxOxiZLbH1/kR3SyOVjVGn6rIeZemBWkXBtwHcVpX
        LhVLymlQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oI1Bx-008GAd-Cf; Sun, 31 Jul 2022 05:08:41 +0000
Message-ID: <d6629cf9-e730-09b4-a01b-2761c42b4390@infradead.org>
Date:   Sat, 30 Jul 2022 22:08:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] usb: dwc3: qcom: Provide stubs for
 dwc3_qcom_read_usb2_speed function
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1659237530-436-1-git-send-email-quic_kriskura@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1659237530-436-1-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/30/22 20:18, Krishna Kurapati wrote:
> This patch intends to fix a build issue that is occurring due to
> dwc3_qcom_read_usb2_speed function which uses usb_hub_find_child API
> in its effors to get the speed of devices (HS/FS/LS) connected.
> 
> usb_hub_find_child API is a part of usb core compiled into the kernel
> when CONFIG_USB=y. In some builds (make randconfig for i386)
> CONFIG_USB is not set and the usb core is not compiled into the
> kernel causing linking errors.
> 
> Provide stubs for dwc3_qcom_read_usb2_speed function to use
> usb_hub_find_child API only if CONFIG_USB is set. Else return
> USB_SPEED_UNKNOWN.
> 
> Fixes: 6895ea55c385 (usb: dwc3: qcom: Configure wakeup interrupts during suspend)
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Suggested-by: Randy Dunlap <rdunlap@infradead.org>

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
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
>  static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>  {
>  	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> @@ -318,6 +319,12 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>  
>  	return udev->speed;
>  }
> +#else
> +static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> +{
> +	return USB_SPEED_UNKNOWN;
> +}
> +#endif
>  
>  static void dwc3_qcom_enable_wakeup_irq(int irq, unsigned int polarity)
>  {

-- 
~Randy
