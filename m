Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246F2545A60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbiFJDTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:19:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B3137468;
        Thu,  9 Jun 2022 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hkLBPPlvjtC3ylOP5SeJ09/0O1+6FtwXDlDt3P/zie4=; b=VDpaFaucn2HiAgAPRvAcwLUruo
        9sjYMXoxBkiCQynlNPbnVLzt8p1uwPbEonyfN+wbQAOAG8kKwR3uPriQlrUREQNG8h0KPQ3HRO3yY
        K5NrlAjOIHU0+B8VgFZtSAPF3YRM1SaHWrHeE0Epkx3tN2qvg756Hn8oFB87n3nWETx4VJ+JD+G3p
        gyK3dFwhanbDwApcpN8WYPGHa4YTbKPynARLlNBGKXOKvNMFGMDflWvbP3/wLdp+/bJbFCbQ6Xl4F
        Xrqvc3nZCqkKFoXptDf5dqf3hKjDX0NI3vF/R0YfRf8AbW4+Zc30XV1QRyiQGRoEBJCWtzvI9CJNg
        5T7ruYYA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzVBR-00E6SY-KL; Fri, 10 Jun 2022 03:19:37 +0000
Message-ID: <395072af-3349-cead-fe07-62d3d758d635@infradead.org>
Date:   Thu, 9 Jun 2022 20:19:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 1/2] thermal: Add thermal driver for Sunplus
Content-Language: en-US
To:     =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>, krzk@kernel.org,
        rafael@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "lh.kuo" <lh.kuo@sunplus.com>,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>
References: <CAGcXWkzJwOPXfE6ESAtwBbe7W-UkApKosKUy=UBRh0kmi-Bc2Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAGcXWkzJwOPXfE6ESAtwBbe7W-UkApKosKUy=UBRh0kmi-Bc2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/9/22 18:32, 郭力豪 wrote:
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0e5cc94..c85e668 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>     If you say yes here you get support for the FAN controlled
>     by the Microcontroller found on the Khadas VIM boards.
> 
> +config SUNPLUS_THERMAL
> + tristate "Sunplus thermal drivers"
> + depends on SOC_SP7021 || COMPILE_TEST
> + help
> +   This enable the Sunplus SP7021 thermal driver, which supports the primitive
> +   temperature sensor embedded in Sunplus SP7021 SoC.
> +
> +   If you have a Sunplus SP7021 platform say Y here and enable this option
> +   to have support for thermal management

End the sentence above with a period ('.').

And the indentation here is all messed up.
See Documentation/process/coding-style.rst:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


> +
>  endif

-- 
~Randy
