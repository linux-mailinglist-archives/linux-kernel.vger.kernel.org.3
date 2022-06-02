Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E453B56F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiFBIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiFBIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:52:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075F45ADC;
        Thu,  2 Jun 2022 01:52:31 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EE8752223E;
        Thu,  2 Jun 2022 10:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1654159949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwNt2A64Uimiyvogwxk15XDFZT8JagE7v8+a7BtJjLg=;
        b=fe22pOYV8FB4xcx1IleSAX6hTBhzhsIUT297iQf1Ox7Ux/zm3CJsGSl/fIHkD7VovutxPg
        4yYFBEaTP5mKwdjrgd6lVmhROpgnm+dWeHZSK7znQqB7q7vrJ+fFDrt9kzM8SD1LRC/d25
        7xh1P8z3T5mAtZ/07M8OjjptM7HzggU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jun 2022 10:52:28 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] earlycon: prevent multiple register_console()
In-Reply-To: <CAL_JsqK6DjLTXqu475XTJXBOFihJEePw40zQcx+sCF7tG3GkSA@mail.gmail.com>
References: <20220601135528.3176471-1-michael@walle.cc>
 <CAL_JsqK6DjLTXqu475XTJXBOFihJEePw40zQcx+sCF7tG3GkSA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c0b2814a22f6a15d465875f177d17ab2@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-06-01 18:39, schrieb Rob Herring:
> On Wed, Jun 1, 2022 at 8:55 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> If the earlycon parameter is given twice, the kernel will spit out a
>> WARN() in register_console() because it was already registered. The
>> non-dt variant setup_earlycon() already handles that gracefully. The 
>> dt
>> variant of_setup_earlycon() doesn't. Add the check there and propagate
>> it through early_init_dt_scan_chosen_stdout().
>> 
>> FWIW, this doesn't happen if CONFIG_ACPI_SPCR_TABLE is set. In that 
>> case
>> the registration is delayed until after earlycon parameter(s) are
>> parsed.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---


Scrap this version. Somehow I missed to add the actual check in
of_setup_earlycon() to this patch.

>> I'm not sure if this should have a Fixes tag or not. If so I guess it
>> should be the very first commit which introduced the support (commit
>> fb11ffe74c79 ("of/fdt: add FDT serial scanning for earlycon")).
> 
> Considering no one noticed or cared in 8 years and that earlycon is
> supposed to be a debug option, I'd say no.
> 
>> For the curious, here is the backtrace:
>> 
>> [    0.000000] ------------[ cut here ]------------
>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:3328 
>> register_console+0x2b4/0x364
>> [    0.000000] console 'atmel_serial0' already registered
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
>> 5.18.0-next-20220601+ #652
>> [    0.000000] Hardware name: Generic DT based system
>> [    0.000000] Backtrace:
>> [    0.000000]  dump_backtrace from show_stack+0x18/0x1c
>> [    0.000000]  show_stack from dump_stack_lvl+0x48/0x54
>> [    0.000000]  dump_stack_lvl from dump_stack+0x18/0x1c
>> [    0.000000]  dump_stack from __warn+0xd0/0x148
>> [    0.000000]  __warn from warn_slowpath_fmt+0x9c/0xc4
>> [    0.000000]  warn_slowpath_fmt from register_console+0x2b4/0x364
>> [    0.000000]  register_console from of_setup_earlycon+0x29c/0x2ac
>> [    0.000000]  of_setup_earlycon from 
>> early_init_dt_scan_chosen_stdout+0x154/0x18c
>> [    0.000000]  early_init_dt_scan_chosen_stdout from 
>> param_setup_earlycon+0x40/0x48
>> [    0.000000]  param_setup_earlycon from do_early_param+0x88/0xc4
>> [    0.000000]  do_early_param from parse_args+0x1a4/0x404
>> [    0.000000]  parse_args from parse_early_options+0x40/0x48
>> [    0.000000]  parse_early_options from parse_early_param+0x38/0x48
>> [    0.000000]  parse_early_param from setup_arch+0x114/0x7a4
>> [    0.000000]  setup_arch from start_kernel+0x74/0x6dc
>> [    0.000000]  start_kernel from 0x0
>> [    0.000000] ---[ end trace 0000000000000000 ]---
>> 
>>  drivers/of/fdt.c              | 6 ++++--
>>  drivers/tty/serial/earlycon.c | 5 ++++-
>>  2 files changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index a8f5b6532165..7f3524213b43 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1025,6 +1025,7 @@ int __init 
>> early_init_dt_scan_chosen_stdout(void)
>>         int l;
>>         const struct earlycon_id *match;
>>         const void *fdt = initial_boot_params;
>> +       int ret;
>> 
>>         offset = fdt_path_offset(fdt, "/chosen");
>>         if (offset < 0)
>> @@ -1057,8 +1058,9 @@ int __init 
>> early_init_dt_scan_chosen_stdout(void)
>>                 if (fdt_node_check_compatible(fdt, offset, 
>> match->compatible))
>>                         continue;
>> 
>> -               if (of_setup_earlycon(match, offset, options) == 0)
>> -                       return 0;
>> +               ret = of_setup_earlycon(match, offset, options);
>> +               if (!ret || ret == -EALREADY)
>> +                       return ret;
> 
> Wouldn't just doing a 'return 0' here be simpler? The only other
> caller of this function doesn't check the error.

Ok.

-michael
