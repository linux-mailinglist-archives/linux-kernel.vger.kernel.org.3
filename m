Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3864D571775
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiGLKiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiGLKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5AC87F67
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 178316186B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7990CC3411C;
        Tue, 12 Jul 2022 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657622290;
        bh=g9iSON4TXybwNvD2rze+jwT0iy7FX9YywdBq9dE2W9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uLW3z0HWTrG26LAC00mFKdEArS2LQPNIiYSPg6NUh8yVPtgbTt/jtaRcZl/qrZVPy
         zPxj2M7lFnGdYoEfETy3yez8C7hCZ4RwUN0lfAVZ7hzLe72HKE7IQ8YBWFblFZc20X
         WwyuWJ3h9RXqtR8QoPmVzB6glyduS/xt2n7Ebm4eDEQLRof8gl8XcuUozSVyBEZu9P
         GRfd5TNFujzM0L0mxJnXJXvkXjbcnGgKO3sxBkmJbsAXk8kdyCDB8wMZIIDXIWOpPQ
         TQTcpfcm81UB3WgsOcXy91wCMLO9jE9GyPQHuTPuUVEXOjBdEjmEnxPie8Pdu+SQHf
         P/zA/YU9PSEUA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oBDHM-006u7c-97;
        Tue, 12 Jul 2022 11:38:08 +0100
MIME-Version: 1.0
Date:   Tue, 12 Jul 2022 11:38:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: thunderx: Don't directly include asm-generic/msi.h
In-Reply-To: <CAMRc=Mf-FEKu_HrZvsL7+H2NTnME6mVV4AjMmZkEOn0Ch+4yMQ@mail.gmail.com>
References: <20220711081257.132901-1-maz@kernel.org>
 <CAMRc=Mf-FEKu_HrZvsL7+H2NTnME6mVV4AjMmZkEOn0Ch+4yMQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6bb9c85796d248fdde3a6b060497b064@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: brgl@bgdev.pl, linux-kernel@vger.kernel.org, kernel-team@android.com, sfr@canb.auug.org.au, linus.walleij@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-12 11:22, Bartosz Golaszewski wrote:
> On Mon, Jul 11, 2022 at 10:13 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On architectures that require it, asm-generic/msi.h is already
>> dragged in by the higher level include files, and is commonly
>> refered to as 'asm/msi.h'.
>> 
>> It is also architecture specific, and breaks compilation in
>> a pretty bad way now that linux/gpio/driver.h includes asm/msi.h
>> (which drags a conflicting but nonetheless correct version
>> of msi_alloc_info_t on x86).
>> 
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Link: 
>> https://lore.kernel.org/r/20220711154252.4b88a601@canb.auug.org.au
>> Fixes: 91a29af413de ("gpio: Remove dynamic allocation from 
>> populate_parent_alloc_arg()")
>> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/gpio/gpio-thunderx.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/drivers/gpio/gpio-thunderx.c 
>> b/drivers/gpio/gpio-thunderx.c
>> index e1dedbca0c85..cc62c6e64103 100644
>> --- a/drivers/gpio/gpio-thunderx.c
>> +++ b/drivers/gpio/gpio-thunderx.c
>> @@ -15,8 +15,6 @@
>>  #include <linux/module.h>
>>  #include <linux/pci.h>
>>  #include <linux/spinlock.h>
>> -#include <asm-generic/msi.h>
>> -
>> 
>>  #define GPIO_RX_DAT    0x0
>>  #define GPIO_TX_SET    0x8
>> --
>> 2.34.1
>> 
> 
> Applied for fixes, thanks!

I'm not sure this is correct on its own without the original
patch mentioned in the Fixes: tag...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
