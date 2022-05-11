Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6D523A84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbiEKQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbiEKQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:42:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E346220C;
        Wed, 11 May 2022 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652287330; x=1683823330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbqnRzCA4AJusA/+Im8zUQNaIw6T2LD8/Jmh9yj4tlw=;
  b=nvbQnCJNcc7uWqw8e+xJeXDz+S7gqGxELXYGIoZu2ODzsZjLmY/IbBVT
   QVbOdePg/z0CFEmeo6F1opqWCw9CK0Fwy2Z5w5zb3ffZ6S90hQEhcKDab
   nVvjJ8aH7TVlfhJkJDF8KL/tWcV7CiHwi+xH1YLenBph4RRrsuwoZorG6
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 09:42:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:42:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 09:42:08 -0700
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 09:42:08 -0700
Date:   Wed, 11 May 2022 09:42:06 -0700
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Guan Jing <guanjing6@huawei.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] usb: dwc3: include extcon.h to fix compile error
Message-ID: <20220511164206.GB5637@jackp-linux.qualcomm.com>
References: <20220511022622.168486-1-guanjing6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220511022622.168486-1-guanjing6@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:26:22AM +0800, Guan Jing wrote:
> If dwc3 is not include extcon.h, the dwc3 driver
> will fail to link:

That doesn't make sense... If the header/definitions aren't present you
should certainly see errors earlier on in the compilation of the object,
not the linker.

> drivers/usb/dwc3/core.o: In function `dwc3_probe':
> core.c:(.text+0x1095): undefined reference to `extcon_get_edev_by_phandle'
> core.c:(.text+0x10bd): undefined reference to `extcon_get_extcon_dev'
> 
> Add miss #include <linux/extcon.h> to fix this error.
> 
> Fixes: 0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guan Jing <guanjing6@huawei.com>
> ---
>  drivers/usb/dwc3/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 950e238c65bf..e619a3ef6c46 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -28,6 +28,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/bitfield.h>
> +#include <linux/extcon.h>
>  
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>

Below this we also have

 #include <linux/usb/otg.h>

Which itself has

 #include <linux/usb/phy.h>

Which also does

 #include <linux/extcon.h>

So extcon.h would have already been included via this nesting...

Jack
