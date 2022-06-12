Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635B5547B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiFLShj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiFLShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:37:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21622532E2;
        Sun, 12 Jun 2022 11:37:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a15so5741374lfb.9;
        Sun, 12 Jun 2022 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nC0UTP8DRXmynVdBku/6hOPWOfi7VmddW1Od6mn5ECQ=;
        b=GM8IQb6uDiETDnSJH8HJW7XwCKF964hAwlaV8Q/SOybZDkFwDcihd4BWzTbus6vSwV
         zt+QPBw9/BCA91OFsUiVQ8JTaqNmHFT6Tdk1paoTJQ8uRBH0k0ci332kp4Gs4sXpQC/5
         pmm2Rw6RGmQ1IzwsRqBB9UrMseUy5ebTlTIUXubsE3lFPRrLNcn15NKs1j/fjYM0L4HV
         x3GtmCS4CVmeMFrJ6n3W82+nHXSsPy73NRJFAt/wywBA8VNK/y+GPcJN3rc0Ee7kJO6B
         CP3MGy4Ap3X+s53K0MgFRzooc++eOPsG8L1es/4TdNOak8ljPrNHy1TAzIDwSUxCHquW
         aWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nC0UTP8DRXmynVdBku/6hOPWOfi7VmddW1Od6mn5ECQ=;
        b=LN+ZKHAwtB4XNmpHDdO6Uqwi9dPPb1LRTc0DaejtyC+IQN54PZFP2/IdYMGBJ25k8Q
         1+6XS9Of5NYLT/o88JkQa3ULpQLBKkcmJqPwPsQ68hLRQHEnWd8AQLAYrmhrM2EZOoJq
         FuoWpxHR+FLBOJZxdODrr5530WuHcoKLOPd52Qe8gQOe4OVRGtLKggCbleVAXJcOZ2qN
         72xmpYVUX/+fyQMeZD5YMGH0vwZxYn/9tiF6LhrdJzoMQ/nxtciMpcTXZMMRNh73A3yk
         OpypTJXB4mOKBQu2MPApSCFKivcqwjWtBDpmtb5E51FAaIO5nDEj6j5jmn5alIGel/Ex
         jJ1g==
X-Gm-Message-State: AOAM5329rA0hh9YcpAcM1/tlzptSN+BNqx16fV/mND4XofWVlXpU1YdS
        lQSPRQECQMqfiMvHBXzgxp2wo9zEWRs=
X-Google-Smtp-Source: ABdhPJw9Q5IRxDV1xO1UNwdlc4gnU2JESARv7pgIPp/+IrgH9XdkqD2rwvKYTXJT9fGaZ08Ug8rBvQ==
X-Received: by 2002:a05:6512:693:b0:479:892:3091 with SMTP id t19-20020a056512069300b0047908923091mr32966652lfe.122.1655059051704;
        Sun, 12 Jun 2022 11:37:31 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.73.3])
        by smtp.gmail.com with ESMTPSA id h9-20020ac24d29000000b004791b687257sm687885lfk.237.2022.06.12.11.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 11:37:31 -0700 (PDT)
Subject: Re: [PATCH v2] ata: pata_pxa: handle failure of devm_ioremap()
To:     Li Qiong <liqiong@nfschina.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com
References: <20220612073222.18974-1-liqiong@nfschina.com>
 <20220612125700.11740-1-liqiong@nfschina.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <fbbed055-fa60-cdee-589b-5d8c12672e94@gmail.com>
Date:   Sun, 12 Jun 2022 21:37:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220612125700.11740-1-liqiong@nfschina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/22 3:57 PM, Li Qiong wrote:

> As the possible failure of the devm_ioremap(), the return value
> could be NULL. Therefore it should be better to check it and
> print error message, return '-ENOMEM' error code.
> 
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> v2:
> - add driver's name (pata_pxa) to subject.
> ---
>  drivers/ata/pata_pxa.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 985f42c4fd70..cd1a8f37f920 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -228,6 +228,11 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
>  						resource_size(dma_res));

   Looking again into this driver, this statement doesn't make sense: dma_res
points to a DMA resource, calling devm_ioremap() on it is just wrong... and
'ap->ioaddr.bmdma_addr' doesn;t seem to be used anyways...

MBR, Sergey
