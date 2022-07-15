Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB645762E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiGONjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiGONjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:39:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEAB6555;
        Fri, 15 Jul 2022 06:39:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b2so3259192plx.7;
        Fri, 15 Jul 2022 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3zcReKKPCl4pQfStU8KJyyb526NKeaNzK/QPxFbU0Q=;
        b=oUISVFpG2W55igRVsZbMaXRwe6/uSGv+PhyFZMdIaAtvafigw/8rvLLhiGWUP3at7f
         3Sh+fHjIn7OItecWS9qDWZqKWXpO8CqjhKbc629XakaDhyX+RBoSfktJHzczjytVNcdU
         puApFAv92FIdbQlha8wSF+kedozyyQrAGPGJWa1a2h5UOWOAovMSmMxErNCXnDZRZK0n
         YEW22oVy9sgfjIk2orT7C3d+Pm/N7onyHNmL18Nwdkc6WRFC8KkabtbFuk++LJHEQkpG
         XwEw3oXw5pg4Sxstvr+VLcUoZ12WYC+LyyyZX1WpLc5j0SaMI0aXbIBXB294VOp+Gq2o
         Z/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3zcReKKPCl4pQfStU8KJyyb526NKeaNzK/QPxFbU0Q=;
        b=ujDFyQzaxLr2Nqn81s7jYfq6ITDduTXRMRmsY2fO4sXZODHLpitFag5sxgICOizDqv
         8C0kz6oTTdX7f5owZGH3TkolasY7ByylkcNWc9KW5r4JlWBvuGKz+/R9fRt6OclGpn7e
         1C217neS6tHhMBcggbYhGI1io595m19SX4soyIkynABI04twKU9+TgJNHZN2ZrR2lDHG
         0HUlingXs0QT/a/RPL3qUfCFvbsmdHc+wkhQbmDyk9LLqdpem9lAzrNeBmatXEj3dCeJ
         PcTrm1NEG1rIOYFQLdbIN6i01DEQfdn6NI/U+wzX95lr2aZ866fYat9txZW1Gq/+IGPb
         p0aA==
X-Gm-Message-State: AJIora9Gmfw3aOlQgllBpi+Z2Wmidz5IJ00rQ0PAlFtVNa82GuAAmE8f
        vS0wPpecfy2OMFTzS38KKLg=
X-Google-Smtp-Source: AGRyM1sfhzLSOw1MRORpdrgpiHdtGYM58C0qdHhaqmyY8XX5GHleb7w2KfrsakPVDHnml2MeVRz/OQ==
X-Received: by 2002:a17:90b:17d1:b0:1f0:6f1:90d1 with SMTP id me17-20020a17090b17d100b001f006f190d1mr15544509pjb.221.1657892360080;
        Fri, 15 Jul 2022 06:39:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001690d398401sm3621963plh.88.2022.07.15.06.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:39:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <39602911-2520-65fd-9479-9abed301f3f7@roeck-us.net>
Date:   Fri, 15 Jul 2022 06:39:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] usb: typec: tcpci: Add get cc tcpci callback
Content-Language: en-US
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
References: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
 <20220715100418.155011-3-gene.chen.richtek@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220715100418.155011-3-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 03:04, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add set_vbus tcpci callback for vendor IC workaround.
> According to different rp level detected, set corresponding
> rx dead zone threshold in order to decode right pd message.
> 

Looking at the next patch, I dispute the need for this callback.
 From what I can see, the additional code should be implemented
in the driver's interrupt handler whenever CC changes, not when
CC values are read from higher level drivers.

Guenter

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/usb/typec/tcpm/tcpci.c | 3 +++
>   drivers/usb/typec/tcpm/tcpci.h | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f33e08eb7670..fc2f6191b7d3 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -243,6 +243,9 @@ static int tcpci_get_cc(struct tcpc_dev *tcpc,
>   	unsigned int reg, role_control;
>   	int ret;
>   
> +	if (tcpci->data->get_cc)
> +		return tcpci->data->get_cc(tcpci, tcpci->data, cc1, cc2);
> +
>   	ret = regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &role_control);
>   	if (ret < 0)
>   		return ret;
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index b2edd45f13c6..2cef19e131f8 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -190,6 +190,8 @@ struct tcpci_data {
>   	unsigned char vbus_vsafe0v:1;
>   
>   	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> +	int (*get_cc)(struct tcpci *tcpci, struct tcpci_data *data,
> +		      enum typec_cc_status *cc1, enum typec_cc_status *cc2);
>   	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>   			 bool enable);
>   	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,

