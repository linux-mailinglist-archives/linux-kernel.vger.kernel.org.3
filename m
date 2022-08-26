Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBA5A2681
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbiHZLEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbiHZLE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:04:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB61895BD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:04:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so2496213ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Mo0Po55MrltQlOf9otDY45W2NU30AebQjce6V8ULWN4=;
        b=VvOz75vXDfguNnZLVcPMsvzH/GHMCE8wmoT/mbk8ZGRbOe7B99+18xa7t8lM5d30d3
         7h+wfgHgVwqGkJplsz5JNw2MV2NBqOwRKE4uw8G4LnZ3M5vt2WsJEE2Ve//6z+R/57cw
         WMUlM77P4f59X8OeGXH24poHiT8Iwg95ImrmaEbxKhU7RfFDvpMEhnTdcvG3v5VZqb80
         knw5EhcVyM0meowHk2wm1N3salnvqRAgVHL7AsYt4N8sAQ5YM8GdoQoYXINVuLHvNKOc
         +aZB0gwOBXTcOcV0GtOyTUvfJckgTQFNfuFVNFnEJog+ydX36ho0kxzqIzhdaG09fHGM
         eurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Mo0Po55MrltQlOf9otDY45W2NU30AebQjce6V8ULWN4=;
        b=soTBUXMCGjzJM/meGdpdVpEQhzkqMPp6BN9orRSBEWURXO62AzZimiry2cPCnXBa1J
         dFh8A+3EegSBordq+nvcfpwN0AH8p8KKmBHelosSrglxYyAnVt6snpM2fTp1zMfma7is
         doDRJSL1rsXVMeuTWxW0t6uYWvgZQlhlcyBo2tcCUVqaQPDaqSYkdymclqGjgfl9EZIY
         2byWpMB5jPixevg71OXJGS2bseESEtNpVIQW0oOpbrBswtv4YTwrRXKBv4Tc229KAIme
         KQI09ubg45Q3IPYnartyF31V6dUu1Q1xZT39ue1KxT8iK95kEhBM60RYDECXPHJsE0hZ
         7JaA==
X-Gm-Message-State: ACgBeo3xDr7uVuSnYIsOsX/1/zn87ebnIOOC+5q9p9PnJKCe8IwbAxjb
        IkiOTGF+osAKCg4mXYcLtMvyeG0oHfILWakNT8UmKA==
X-Google-Smtp-Source: AA6agR7QvLAqRTdbq4TYx8odE7Pqo40mqPQ7sAdhFJHTRKx9db4amFYUeVLwc3JxKBRaLd1/RwuUkCD9eIGDI9WitBI=
X-Received: by 2002:a17:907:72cf:b0:73d:d007:e249 with SMTP id
 du15-20020a17090772cf00b0073dd007e249mr4908899ejc.500.1661511842254; Fri, 26
 Aug 2022 04:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220824071253.1261096-1-piyush.mehta@amd.com>
In-Reply-To: <20220824071253.1261096-1-piyush.mehta@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 13:03:51 +0200
Message-ID: <CACRpkdae4fijFrFs-1u-AUNExvbda=6yeAyQJRQeVVQmdQOQZQ@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: udc-xilinx: replace memcpy with memcpy_toio
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        michal.simek@xilinx.com, michal.simek@amd.com,
        shubhrajyoti.datta@xilinx.com, lee.jones@linaro.org,
        christophe.jaillet@wanadoo.fr, szymon.heidrich@gmail.com,
        jakobkoschel@gmail.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, siva.durga.prasad.paladugu@amd.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 9:14 AM Piyush Mehta <piyush.mehta@amd.com> wrote:

> For ARM processor, unaligned access to device memory is not allowed.
> Method memcpy does not take care of alignment.
>
> USB detection failure with the unaligned address of memory access, with
> below kernel crash. To fix the unaligned address the kernel panic issue,
> replace memcpy with memcpy_toio method.
>
> Kernel crash:
> Unable to handle kernel paging request at virtual address ffff80000c05008a
> Mem abort info:
>   ESR = 0x96000061
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x21: alignment fault
> Data abort info:
>   ISV = 0, ISS = 0x00000061
>   CM = 0, WnR = 1
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000143b000
> [ffff80000c05008a] pgd=100000087ffff003, p4d=100000087ffff003,
> pud=100000087fffe003, pmd=1000000800bcc003, pte=00680000a0010713
> Internal error: Oops: 96000061 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.19-xilinx-v2022.1 #1
> Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __memcpy+0x30/0x260
> lr : __xudc_ep0_queue+0xf0/0x110
> sp : ffff800008003d00
> x29: ffff800008003d00 x28: ffff800009474e80 x27: 00000000000000a0
> x26: 0000000000000100 x25: 0000000000000012 x24: ffff000800bc8080
> x23: 0000000000000001 x22: 0000000000000012 x21: ffff000800bc8080
> x20: 0000000000000012 x19: ffff000800bc8080 x18: 0000000000000000
> x17: ffff800876482000 x16: ffff800008004000 x15: 0000000000004000
> x14: 00001f09785d0400 x13: 0103020101005567 x12: 0781400000000200
> x11: 00000000c5672a10 x10: 00000000000008d0 x9 : ffff800009463cf0
> x8 : ffff8000094757b0 x7 : 0201010055670781 x6 : 4000000002000112
> x5 : ffff80000c05009a x4 : ffff000800a15012 x3 : ffff00080362ad80
> x2 : 0000000000000012 x1 : ffff000800a15000 x0 : ffff80000c050088
> Call trace:
>  __memcpy+0x30/0x260
>  xudc_ep0_queue+0x3c/0x60
>  usb_ep_queue+0x38/0x44
>  composite_ep0_queue.constprop.0+0x2c/0xc0
>  composite_setup+0x8d0/0x185c
>  configfs_composite_setup+0x74/0xb0
>  xudc_irq+0x570/0xa40
>  __handle_irq_event_percpu+0x58/0x170
>  handle_irq_event+0x60/0x120
>  handle_fasteoi_irq+0xc0/0x220
>  handle_domain_irq+0x60/0x90
>  gic_handle_irq+0x74/0xa0
>  call_on_irq_stack+0x2c/0x60
>  do_interrupt_handler+0x54/0x60
>  el1_interrupt+0x30/0x50
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x78/0x7c
>  arch_cpu_idle+0x18/0x2c
>  do_idle+0xdc/0x15c
>  cpu_startup_entry+0x28/0x60
>  rest_init+0xc8/0xe0
>  arch_call_rest_init+0x10/0x1c
>  start_kernel+0x694/0x6d4
>  __primary_switched+0xa4/0xac
>
> Cc: stable@vger.kernel.org
> Fixes: 1f7c51660034 ("usb: gadget: Add xilinx usb2 device support")
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> Changes in V2:
> - Address Greg KH review comments:
>  - Added information in the form of a Fixes: commit Id (commit message).
>  - Cc stable kernel.
>
> Link:https://lore.kernel.org/all/YwW8zE8ieLCsSxPN@kroah.com/

That link should be up under the commit message, but it's not very important.

The solution looks reasonable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
