Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1E525239
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356330AbiELQMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356319AbiELQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:11:47 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB3236668D;
        Thu, 12 May 2022 09:11:42 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1npBPf-0001Vm-00; Thu, 12 May 2022 18:11:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 402D2C01D7; Thu, 12 May 2022 18:08:27 +0200 (CEST)
Date:   Thu, 12 May 2022 18:08:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Zhi Li <lizhi01@loongson.cn>
Subject: Re: [PATCH] MIPS: Loongson: Use hwmon_device_register_with_groups()
 to register hwmon
Message-ID: <20220512160827.GA14475@alpha.franken.de>
References: <20220511145659.2976950-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511145659.2976950-1-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:56:59AM -0700, Guenter Roeck wrote:
> Calling hwmon_device_register_with_info() with NULL dev and/or chip
> information parameters is an ABI abuse and not a real conversion to
> the new API. Also, the code creates sysfs attributes _after_ creating
> the hwmon device, which is racy and unsupported to start with. On top
> of that, the removal code tries to remove the name attribute which is
> owned by the hwmon core.
> 
> Use hwmon_device_register_with_groups() to register the hwmon device
> instead.
> 
> In the future, the hwmon subsystem will reject calls to
> hwmon_device_register_with_info with NULL dev or chip/info parameters.
> Without this patch, the hwmon device will fail to register.
> 
> Fixes: f59dc5119192 ("MIPS: Loongson: Fix boot warning about hwmon_device_register()")
> Cc: Zhi Li <lizhi01@loongson.cn>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/platform/mips/cpu_hwmon.c | 127 ++++++++++--------------------
>  1 file changed, 41 insertions(+), 86 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
