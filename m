Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF056A744
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiGGPvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiGGPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:51:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323BD27FE2;
        Thu,  7 Jul 2022 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wCZZ2/uGgTcF5BUB8FW1vc1kQ7Ai6eNSWA8QNhgd6vY=; b=sExNCI50yPnSnoa9m5VfBya8DV
        Fo4iI4uh2AWsNrN/TvVgSpHtrNSF0qIzhzhSi3jXgam2fU8+e6dOIr3Fi+ymvo2cjBCMqZUtrj+1d
        Piq9ZXhwmXjacZP8Hi74ptQuWCDzQogihZcwWbYFCxOw0Vp0VmhfPWDMmpd55Vvf+VfTmsQO/6fa0
        n6XxX1zWiPyDMyFBZmPb97rPlkNSRDMaPsgzTjtBcNWNfGlYn2dh+qVAub1eC+BgUxz/1o1JrdY05
        CrZ9+vtP6OF5DzhHOvCk1aRu7+kGmDA3ULktypF3ViL0/cvaz3WLfejh48Cd8UEbiiLydxJf/haCa
        IcynlKuw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9Tmx-00GqIW-AZ; Thu, 07 Jul 2022 15:51:35 +0000
Message-ID: <85f0c3f1-52a0-2fa1-9e43-06ad9553f400@infradead.org>
Date:   Thu, 7 Jul 2022 08:51:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 2/2] platform/x86: Add virtual PMC driver used for
 S2Idle
Content-Language: en-US
To:     Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org
Cc:     dmy@semihalf.com, mario.limonciello@amd.com, seanjc@google.com,
        dbehr@google.com, upstream@semihalf.com,
        zide.chen@intel.corp-partner.google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
References: <20220707125329.378277-1-jaz@semihalf.com>
 <20220707125329.378277-3-jaz@semihalf.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220707125329.378277-3-jaz@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/22 05:53, Grzegorz Jaszczyk wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bc4013e950ed..dee974321b01 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -479,6 +479,13 @@ config WIRELESS_HOTKEY
>  	 To compile this driver as a module, choose M here: the module will
>  	 be called wireless-hotkey.
>  
> +config VIRT_PMC
> +	tristate "Virt PMC"
> +	depends on ACPI && SUSPEND
> +	help
> +	  The Virtual PMC driver is meant for the guest VMs and it's main

	                                                        its main

> +	  purpose is to notify about guest entering s2idle state.

-- 
~Randy
