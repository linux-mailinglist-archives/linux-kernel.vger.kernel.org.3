Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C678753BAC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiFBOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiFBOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:30:01 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DA26A903;
        Thu,  2 Jun 2022 07:30:00 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e93bbb54f9so6898386fac.12;
        Thu, 02 Jun 2022 07:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCZRja3up0NniP+FBJkrSPbAN7cm/0rj1PnFJjF7f58=;
        b=0hbvPX1Er6UnKKclVv6OyHAbnw57+gTFo+aVPC6TAKDQ7awz7Cv5TxVnHTx6eAoA+I
         zvGop4d0/+vSzpumf0Rn/xxbIaWwFGSEtoS9R5DfLYR8LvSP6GB5eeN3anIPTnpOtYXh
         /3e8ctMHpBvygpe4i0Ei19KLPPr7Wiz+cZKP2gBuGqBZ1ifi5bFnQlH8CVNEwQmLaGH3
         XRrvf62bPDZniFFfFBpIKiodUcGGay0L82J4rd7eKsoWciPbIZJWD1CMi9xZFCMMLtyI
         I744haA8CZDti6ru/F4kTT8Cm2PAyAbFUwTZ6eN+mb9KG0NFGz3HTcMQeE4PVGuTc2nP
         8Psg==
X-Gm-Message-State: AOAM533OMAVOVSwH9MyoeaLqj9MUacCG/ndpozLQcb74Zm4Zs0Z3k3Qv
        1x1VfBWpH3Uq2BvlWAAVQek4g4zDbw==
X-Google-Smtp-Source: ABdhPJy0wN+X8qo0zzoZjphbLnRoW33ogoxYcs/yMHHCE8XzMYyUyT5udgELdnz3goP8BW7MQrZazw==
X-Received: by 2002:a05:6870:c390:b0:f1:6a3a:227b with SMTP id g16-20020a056870c39000b000f16a3a227bmr2979334oao.142.1654180200039;
        Thu, 02 Jun 2022 07:30:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hc12-20020a056870788c00b000f33804cea9sm1966400oab.36.2022.06.02.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:29:59 -0700 (PDT)
Received: (nullmailer pid 2256680 invoked by uid 1000);
        Thu, 02 Jun 2022 14:29:59 -0000
Date:   Thu, 2 Jun 2022 09:29:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] earlycon: prevent multiple register_console()
Message-ID: <20220602142959.GA2256623-robh@kernel.org>
References: <20220602090038.3201897-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602090038.3201897-1-michael@walle.cc>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jun 2022 11:00:38 +0200, Michael Walle wrote:
> If the earlycon parameter is given twice, the kernel will spit out a
> WARN() in register_console() because it was already registered. The
> non-dt variant setup_earlycon() already handles that gracefully. The dt
> variant of_setup_earlycon() doesn't. Add the check there and add the
> -EALREADY handling in early_init_dt_scan_chosen_stdout().
> 
> FWIW, this doesn't happen if CONFIG_ACPI_SPCR_TABLE is set. In that case
> the registration is delayed until after earlycon parameter(s) are
> parsed.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - add missing EALREADY handling in of_setup_earlycon()
>  - return 0 early as suggested by Rob
> 
> For the curious, here is the backtrace:
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:3328 register_console+0x2b4/0x364
> [    0.000000] console 'atmel_serial0' already registered
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-next-20220601+ #652
> [    0.000000] Hardware name: Generic DT based system
> [    0.000000] Backtrace:
> [    0.000000]  dump_backtrace from show_stack+0x18/0x1c
> [    0.000000]  show_stack from dump_stack_lvl+0x48/0x54
> [    0.000000]  dump_stack_lvl from dump_stack+0x18/0x1c
> [    0.000000]  dump_stack from __warn+0xd0/0x148
> [    0.000000]  __warn from warn_slowpath_fmt+0x9c/0xc4
> [    0.000000]  warn_slowpath_fmt from register_console+0x2b4/0x364
> [    0.000000]  register_console from of_setup_earlycon+0x29c/0x2ac
> [    0.000000]  of_setup_earlycon from early_init_dt_scan_chosen_stdout+0x154/0x18c
> [    0.000000]  early_init_dt_scan_chosen_stdout from param_setup_earlycon+0x40/0x48
> [    0.000000]  param_setup_earlycon from do_early_param+0x88/0xc4
> [    0.000000]  do_early_param from parse_args+0x1a4/0x404
> [    0.000000]  parse_args from parse_early_options+0x40/0x48
> [    0.000000]  parse_early_options from parse_early_param+0x38/0x48
> [    0.000000]  parse_early_param from setup_arch+0x114/0x7a4
> [    0.000000]  setup_arch from start_kernel+0x74/0x6dc
> [    0.000000]  start_kernel from 0x0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> 
>  drivers/of/fdt.c              | 4 +++-
>  drivers/tty/serial/earlycon.c | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
