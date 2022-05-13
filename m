Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97E525F69
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379246AbiEMKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbiEMKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:06:48 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 03:06:44 PDT
Received: from smtp102.iad3b.emailsrvr.com (smtp102.iad3b.emailsrvr.com [146.20.161.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25566663C3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1652435909;
        bh=6HQSMLhL1Di2JFWD3jyK8sB/rv+s9jBCEgbZg24jR+4=;
        h=Date:Subject:To:From:From;
        b=lNt5irZTCy/xniing+AEFQ2HCx3ZsExjFiblj8Too0PiV+87ux5maPk0N2MqFu00N
         feXc72jjA4AanY07GCEcwqJtJZ58ytcInmo/i630MWZiN+Eh9CLKWyas7NX689GFyP
         IEdORNY35jMYSTMcuI3XNqDcxSoOTNI7pJyQ8xig=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp5.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CB17E400DC;
        Fri, 13 May 2022 05:58:28 -0400 (EDT)
Message-ID: <86b36563-af34-b105-650b-63a1e92912bd@mev.co.uk>
Date:   Fri, 13 May 2022 10:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drivers: comedi: replace ternary operator with min()
Content-Language: en-GB
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <20220513071608.49047-1-guozhengkui@vivo.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220513071608.49047-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 4281c6e2-bdd8-4a30-8c69-e8403c57c52e-1-1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 08:16, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> drivers/comedi/drivers.c:857:12-13: WARNING opportunity for min().
> 
> min() macro is defined in include/linux/minmax.h. It avoids multiple
> evaluations of the arguments when non-constant and performs strict
> type-checking.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>   drivers/comedi/drivers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
> index 8eb1f699a857..d4e2ed709bfc 100644
> --- a/drivers/comedi/drivers.c
> +++ b/drivers/comedi/drivers.c
> @@ -854,7 +854,7 @@ int comedi_load_firmware(struct comedi_device *dev,
>   		release_firmware(fw);
>   	}
>   
> -	return ret < 0 ? ret : 0;
> +	return min(ret, 0);
>   }
>   EXPORT_SYMBOL_GPL(comedi_load_firmware);
>   

Looks good thanks.

I was wondering if it could be replaced with a simple `return ret;`, but 
unfortunately the `ret = cb(...);` call returns a non-negative value on 
success for some of the drivers' callback functions.  (The usbdux* 
drivers return the result of a call to `usb_control_msg(...)`.)

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
