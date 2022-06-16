Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4154EBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378858AbiFPVDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiFPVDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:03:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD872CC9C;
        Thu, 16 Jun 2022 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=l5SmrcbO4GZrUo3EqVT75W/un0U3qwBg6eyDpd+eRLs=; b=P3IR48QvvLm+efucSZUbbj02F6
        WSscTALgM/IMzD8eVS9UBe7Y8ahSF4J7Gz1wgx7ZYEb1sZTGIEoyaifNpan3/36AalpDYJv1RRxCU
        +C6lp/aEtT78C5eUymdZQ5AkFyiUpnCzZOTzHhjW5V1QdiLkISHVowUyXV/SElc7GPCJ1NRiOddxa
        KgWmONu2jPggVwiarSa/T0kbt62Xs4XTLwNA3gJwXUZgIUHqaIt3wdOdKGSgU9n+bNoy4AnY5auGJ
        Klcs4PFrIRdwM/E+WLCejBXEyaAAiBkQMgS36zWKDHt7kUxUmBnfKIpR5nvWopxfMWG/B8Yx1oqYx
        DWSWvLSg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1we6-008VxI-GG; Thu, 16 Jun 2022 21:03:19 +0000
Message-ID: <3230f073-5228-693e-f7cd-5fc4b7226a66@infradead.org>
Date:   Thu, 16 Jun 2022 14:03:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 13/20] rv/reactor: Add the panic reactor
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <67e522ab57e64eee313af508a8c70f3cce33e525.1655368610.git.bristot@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <67e522ab57e64eee313af508a8c70f3cce33e525.1655368610.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 01:44, Daniel Bristot de Oliveira wrote:
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index be8e3dab0a52..91a17b13a080 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -60,4 +60,12 @@ config RV_REACT_PRINTK
>  	  Enables the printk reactor. The printk reactor emmits a printk()

	                                                 emits

>  	  message if an exception is found.
>  
> +config RV_REACT_PANIC
> +	bool "Panic reactor"
> +	depends on RV_REACTORS
> +	default y if RV_REACTORS
> +	help
> +	  Enables the panic reactor. The panic reactor emmits a printk()

	                                               emits

> +	  message if an exception is found and panic()s the system.

-- 
~Randy
