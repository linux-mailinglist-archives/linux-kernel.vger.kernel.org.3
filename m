Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9059C38F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiHVP6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiHVP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:58:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E02B625
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:58:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jl18so10332376plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=lRsMu7u7pkvgPwCAcHon0nI7C9GxsTgw5MC2MQrhow0=;
        b=uFdiRaLy1d28fCJR9DWr6kVIHS48hIvQbhDv/zPV5J5Mczdetr2+QmrdZHr27n2aPD
         qYs5DKWV0u7JExAyx17hynaNQ6SODgx1S/JZlqatqY59yoaBcyeOSHKWGA9RNfkcvCY1
         GvY8rjn+jzsYIKmqMZoG2g9+SeqyR+Tjj+4CT/gXmlM0ZzKbFPOQhNJNGfYGn82EcOj3
         AXY843REFaFnE9xnqHJtgAT87S8RzwEk2CGrwgk8+eSX6QnJbNQlC6t+j1/MAdF9X3ux
         W2EQLmybjPsSadxrNJv2+Y/RCnFqvUe28m7coZEJ25pCuq6ZHrI08NOEDNVZOX8CWN8I
         w2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lRsMu7u7pkvgPwCAcHon0nI7C9GxsTgw5MC2MQrhow0=;
        b=Vuad9g2YOPozBCRCrvqPcxfeD3WQ6cvUV3AkUOSeyao/w3Yz4Z4z4D+6xcvMWPToRu
         2SDZnuVeV0vvQxXsLXj9FsvbX13Gvtaphv2gPr49rQv3oaLge+TXSymaFdF5gJgE7BO/
         +sgrA3aOG5fYF2Dg56Wkf5yh4HZP1PZPflTyR7lCQMKP1UMzsMNtyxS94ftdR6tk/C/B
         Po4XYzW6lEqc2r7sGrzU4ZI8s5f1Vz7T2vWaoj+hGZTcXfn+LjybfmL7zl+sYfe/LDdB
         1QCJVsidNqQDY+TO4HmN2qkWcK+j9qWrzGYiRGYKTtqWXIwSLriTJ2GkwQGIMLZIqLa2
         Mn0Q==
X-Gm-Message-State: ACgBeo23QRXOhSTTVeBmYiEy/1cgSc8Jeta0x6eTATtaZ62Ud1ldRPQv
        SJ1Stud1t11FFSNkl/VzZRsSBw==
X-Google-Smtp-Source: AA6agR6fJieHxJUsIxfV91LpmNfv1QWUOuSRWheIn+ggsRS+wj94JooRiWx6ZzER3vPihAUPgB7TwA==
X-Received: by 2002:a17:90b:38d1:b0:1fa:ccde:fa4c with SMTP id nn17-20020a17090b38d100b001faccdefa4cmr23545408pjb.145.1661183887090;
        Mon, 22 Aug 2022 08:58:07 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b0016d9b101413sm8586303ple.200.2022.08.22.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:58:06 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:58:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: trbe: fix Kconfig "its" grammar
Message-ID: <20220822155804.GA1583519@p14s>
References: <20220715015925.12569-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715015925.12569-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 06:59:25PM -0700, Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction "it's"
> where appropriate.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/hwtracing/coresight/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Applied.

Thanks,
Mathieu

> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -193,10 +193,10 @@ config CORESIGHT_TRBE
>  	depends on ARM64 && CORESIGHT_SOURCE_ETM4X
>  	help
>  	  This driver provides support for percpu Trace Buffer Extension (TRBE).
> -	  TRBE always needs to be used along with it's corresponding percpu ETE
> +	  TRBE always needs to be used along with its corresponding percpu ETE
>  	  component. ETE generates trace data which is then captured with TRBE.
>  	  Unlike traditional sink devices, TRBE is a CPU feature accessible via
> -	  system registers. But it's explicit dependency with trace unit (ETE)
> +	  system registers. But its explicit dependency with trace unit (ETE)
>  	  requires it to be plugged in as a coresight sink device.
>  
>  	  To compile this driver as a module, choose M here: the module will be
