Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011EF4E8296
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 18:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiCZRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiCZRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 13:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72BA134BB5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648314530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsSrWIqPfk2quPBaJHDrYcj65RLxmIBGnRe4ZxcsCNw=;
        b=PjRmjovcDZQraxJXKnXu+frKkd5Yia4dRMvnWlbLTJjyxGNC/3BoDhhJKmDXhGpHxt7Jso
        3+RQPlSM7UbNOt0JPwE6IpvJpEaKjEcm9A+MHNqLvONdzuuMe+kF/MNnG5WLFA/Sf7q6+3
        MuOUpwD9UNmx3u5YBDUonkj38u4s94c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-Qdyjc7XaOHK_YOP420utHQ-1; Sat, 26 Mar 2022 13:08:48 -0400
X-MC-Unique: Qdyjc7XaOHK_YOP420utHQ-1
Received: by mail-qt1-f199.google.com with SMTP id l19-20020a05622a175300b002e1a85b5b52so8329174qtk.21
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KsSrWIqPfk2quPBaJHDrYcj65RLxmIBGnRe4ZxcsCNw=;
        b=n5JhruE3Bm0822txXRZwNCpYhxVTew6nwPCPDCQsg+SfCnJyqP3PLeZ7COwCjbzZLL
         l4rmnKa2NyL3R421GC3poPK1rFvqOxAVyyepfVZBj0XZYwqqAZevwmyzCziaLJ1xj5tX
         xpNrQHkOviD3dXlkH8LIyTA3XRnc34z/eWg9oaFz/RV1okYHxKjJYAq18cEquQopLYnh
         VfNCybtdXWB76yfD96gWWCzwhzYnsIEHQ9G5JldjlxYlXwRgUQRVNtZMCQW3+5mlf7Ix
         7Eibk14cdGjBZRAp8npmgW+fnEe1hpsfClvjHblUkP46x9RPDMIJRfadngxg//yN+Ks4
         Dd0Q==
X-Gm-Message-State: AOAM530bUo2ioaot3bsxoZ6DG6otPGWiAx9TzVL9gXsMhuChelZo3r/h
        fjEnqAazrQJkMAqnesiYIxEbmnYU1WsfcgTvLQntNtVtNKUicCNHYsMVBe+iBP4egHqFwnRmn8N
        TQ8vjGI6uWXNg83BxcMi7K/8S
X-Received: by 2002:ac8:5e10:0:b0:2e1:cb3e:bb87 with SMTP id h16-20020ac85e10000000b002e1cb3ebb87mr14884470qtx.4.1648314528093;
        Sat, 26 Mar 2022 10:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcTdcjSdnI+5liW0mpIFMK4UfyXML3yGh5wbmKsyzyWMx+AMLApJvYOFeehZbXiBNRUQclpQ==
X-Received: by 2002:ac8:5e10:0:b0:2e1:cb3e:bb87 with SMTP id h16-20020ac85e10000000b002e1cb3ebb87mr14884462qtx.4.1648314527854;
        Sat, 26 Mar 2022 10:08:47 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r17-20020a05620a299100b00680b43004bfsm3273144qkp.45.2022.03.26.10.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 10:08:47 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] fpga: Use tab instead of spaces for indentation
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
 <20220322082202.2007321-5-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f8929af9-daa4-2111-1dff-edbf1f2041e7@redhat.com>
Date:   Sat, 26 Mar 2022 10:08:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220322082202.2007321-5-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/22 1:22 AM, Nava kishore Manne wrote:
> Trivial fix.

This is not descriptive.

Improve the commit log to explain the issue and solution.

Tom

>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-None.
>
>   drivers/fpga/Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 0bff783d1b61..5935b3d0abd5 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,9 +18,9 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>   obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>   obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>   obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> -obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
> -obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> -obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> +obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
> +obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>   
>   # FPGA Bridge Drivers
>   obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o

