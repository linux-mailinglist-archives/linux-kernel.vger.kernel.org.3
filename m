Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF58951BFF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378291AbiEEM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378418AbiEEM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:58:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F775674C;
        Thu,  5 May 2022 05:54:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DC261E0C;
        Thu,  5 May 2022 12:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3489BC385A8;
        Thu,  5 May 2022 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651755259;
        bh=6lsmH0CxgqYKBOcML9+EDkwriT9FTWy1+KKvkIcEEc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c8RxOr9faMCBiRtMQ5zYMH4HMGNtFnSpywnsWHCaLmRJ32wDcwkkYuSbGcQeFmthK
         /fe3QHQCQaDHRJKWSuA4EMgP5Sz/aSteyeVk7veahmLe4ulzVRxmNbBux6tCivlfTz
         oOiYMUEpf+Vr7hGbc7tm8SHP3ogwJ84S7gQvzVKjdX/WvpSmBtav/LSI+xBiyMV5iX
         95nd+Ai6d5wAwH5HdcJZYOsjhmn8s+/w145K3ESSk91/ysHnAMLft+KY/8u1KJwwAm
         tS28s56PJRveoEubU+hTlrlEuyXuCsnkWi0TOpU0G9JluMovwtjhjnV2mZBYcg4gd0
         dGczW2ilWeqbA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nmazo-009Cyd-PY; Thu, 05 May 2022 13:54:16 +0100
MIME-Version: 1.0
Date:   Thu, 05 May 2022 13:54:16 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] gpio: max77620: Make the irqchip immutable
In-Reply-To: <CAMRc=MeXUN6P8kWxB75GsXdKD7Owz9mX5HpgfQoMGeJh-z3=Rw@mail.gmail.com>
References: <20220504144406.36744-1-jonathanh@nvidia.com>
 <CAMRc=MeXUN6P8kWxB75GsXdKD7Owz9mX5HpgfQoMGeJh-z3=Rw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6629e06d06f647923c04502ce3133f76@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: brgl@bgdev.pl, jonathanh@nvidia.com, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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

On 2022-05-05 13:42, Bartosz Golaszewski wrote:
> On Wed, May 4, 2022 at 4:44 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>> 
>> Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
>> immutable") added a warning to indicate if the gpiolib is altering the
>> internals of irqchips. Following this change the following warning is
>> now observed for the max77620 gpio driver ...
>> 
>>  WARNING KERN gpio gpiochip0: (max77620-gpio): not an immutable chip,
>>         please consider fixing it!
>> 
>> Fix the above warning by making the max77620 gpio driver immutable.
>> 
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
> 
> Queued for fixes, thanks!

You mean fixes for *5.19*, right?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
