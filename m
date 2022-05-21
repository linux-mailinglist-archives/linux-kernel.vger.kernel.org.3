Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72952FCF4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbiEUNpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiEUNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:44:58 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2E7DE29;
        Sat, 21 May 2022 06:44:57 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f189b07f57so13243384fac.1;
        Sat, 21 May 2022 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=81spVghcZ1b5INr6qvaKCcFhE6aDceL23pFyCnpeyd8=;
        b=cFb/+uZVt5A2eDRFqr6mbDYCejXwBZGT/Sx0wVvFw+Rp+PZ1C+eEv36CdOPLCR6xaN
         Rwph8NqLVvjx1YRR3R7qyH96aPSQcoOs8CPZL2bnlaAUlp3TkGS9T8SR0trwss9RJcU8
         tQkL9w/njja8xuOceNQamMMf9c1jl183krYYXQMMU/qYB5oSWpXUBrTPiW32tQPsIrGa
         pgHLJdPYvrnBCGGYDdLoYaiOv09s4R9/P3bztYKm5+CmJa6400tiWfYehOBgnKH9cZG2
         Ni4fxwQmWXAJMQ+K7zvyGpO4aCe+SG+aDq5btVVBw/35aYSm1/glEWo2MCdT46hSbdpt
         Iadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=81spVghcZ1b5INr6qvaKCcFhE6aDceL23pFyCnpeyd8=;
        b=w7JBG3e/YHErFE8oVHxxslDgEt1RDtbiVTv/RpB+cHGwdjk4DJ2f9mdq+nc1J+vIz6
         K2TuzqSucPSP2azM/WuQe6zXNXFw1rjLuC9U9+CpKjHzJ8fTFUKL2x/0r/syMuGHXfs4
         sTXnZP2jV+/miDlAhfav1b2VLG8pevNRMPRz/ZTrHTR9u12YTd4A1xSNSssN4upGTHPE
         y24T9uIxH5AVBO3rcjh0CSMouYa7zLhBU8CCuSajfKRzs8HQflIuM102E9GyEGBhyvvu
         4l0rD8OAAJb1k10WtAWeJoMkUzS0N7H+MeUp5VFkNmXEWuMRs9q5V6kBR0kp6nqO4DZH
         /Nrw==
X-Gm-Message-State: AOAM530uILJZDp1QKjyUbVCYdkSHB24DweHjnJnVIH7OFX9XsYuOkA5C
        woDB8Ac/4CNE55O9kES/X1IVEZ4fAz55ww==
X-Google-Smtp-Source: ABdhPJwcWAm8eF8epLhg82PB80IgXiUiv7K412i+CXEqjbI/LZyUKUt13QvLtk0c7IZqR6QKuLPF3w==
X-Received: by 2002:a05:6870:f149:b0:dd:f3b0:986d with SMTP id l9-20020a056870f14900b000ddf3b0986dmr8671712oac.148.1653140697050;
        Sat, 21 May 2022 06:44:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 184-20020aca05c1000000b0032698578409sm2284562oif.38.2022.05.21.06.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 06:44:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2cecb83a-ebf2-0f48-e542-8d099c92048d@roeck-us.net>
Date:   Sat, 21 May 2022 06:44:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] usb: typec: tcpm: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220521111145.81697-52-Julia.Lawall@inria.fr>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220521111145.81697-52-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/22 04:11, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
>   drivers/usb/typec/tcpm/tcpm.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bc2f4ebd1fe..7039383eac6d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -471,7 +471,7 @@ struct tcpm_port {
>   
>   	/*
>   	 * When set, port requests PD_P_SNK_STDBY_MW upon entering SNK_DISCOVERY and
> -	 * the actual currrent limit after RX of PD_CTRL_PSRDY for PD link,
> +	 * the actual current limit after RX of PD_CTRL_PSRDY for PD link,
>   	 * SNK_READY for non-pd link.
>   	 */
>   	bool slow_charger_loop;
> 

