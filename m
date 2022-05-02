Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3185177A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiEBUGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiEBUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:05:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD62BC3D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:02:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y63so16272178oia.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QEMEmP9AFwKD9PuPFuz7FtA9CKMnwJQdZuR1KlEi0ec=;
        b=TGAsUXy8H/BxAJnKXeAzdX4rbwF1tnpUhGUo74IEgZTF2PzOrDwfbPqi5TOyIPrlOo
         e+LTfigpajFOE7cy4pFswHBbUFgZoJLhSKwSzGqWdhiGr1TJa5LP/U4aozq8+29WSl1c
         9evbOrsV8PzQHsiO3HN5GYmh1I2wSylM/DbEmOBUIIjdhGpAkibuVqh4G2VfyrZHM97S
         Qmtrd30A/CQ5VY7rN3SShduRAWwtB2pagExtU7bpDCNo3wOYidk6AS3r3rrn/4D2HDVc
         uuEmvqaTt2HxCcpkWcpjdAjhbc3UuSu4OxX7XtYu/QLUVdnuTw1oJUBvL1e4UUyjxCbD
         7Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QEMEmP9AFwKD9PuPFuz7FtA9CKMnwJQdZuR1KlEi0ec=;
        b=2gao3jitqXzdiD5Q/TPr9y6XStaEaj5GkHhzcISKy6csgJc7dZPBse4T5Qs1jh8GGk
         JEA5vOLQ2B1rgoc12B2JkC7Nbdnm1D4O42/Kc2Tr5UIjeYTYIas1v9KkkMJSQJCh+Kyv
         B701fARUYLR6C302kJjqnniIQ+dAkLgb+3kWP5SGuiZ1C5lRfVAPIdvPbY1tYtgDZQ3p
         B37imUyr2hTJgF0liL9Xc+jCvktfLEREUXAG1QbWGbwlhWi+Ujoihw843WjXSdWgZlhv
         Z9dV0+j/lWTD1klF+uDDhXzuSfBLrN3lmX+ii3uHimsvXSYZATGL6ovp+vWJYsaA4YYa
         fO6g==
X-Gm-Message-State: AOAM530gl4pvu0ssORrdUPpvxWkX7uR2YvL13eP8P+zGzrO1DyA4ya9V
        izfAiKpvxKEUrtzrGq9zLZl/Mw==
X-Google-Smtp-Source: ABdhPJyEv7A2qZgdGaNVirxGDjsj+wiE7tAobTjtZKmxCrNgz12wtGoVx3tKYgNGWRq3h80A3hKoSg==
X-Received: by 2002:aca:1b0a:0:b0:325:bff8:e73a with SMTP id b10-20020aca1b0a000000b00325bff8e73amr397100oib.168.1651521748923;
        Mon, 02 May 2022 13:02:28 -0700 (PDT)
Received: from [192.168.86.188] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id l1-20020a4abe01000000b0035eb4e5a6c2sm4268400oop.24.2022.05.02.13.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:02:28 -0700 (PDT)
Message-ID: <2a3f8b4c-2c0d-28bc-8dcd-c56c7b8a2bb4@landley.net>
Date:   Mon, 2 May 2022 15:07:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
 <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
 <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net>
 <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 03:37, Geert Uytterhoeven wrote:
> Hi Rob,
...
> Until I tried "ifconfig eth0 up", which causes a lock-up.
> Interestingly, the 8139 irq was 112 with and without Sergey's patch,
> so there must be an irq remapping missing.

Yup, that's it.

> I also test regularly on landisk, where 8139 Ethernet works fine.
> Turns out landisk uses arch/sh/drivers/pci/fixups-landisk.c to fixup
> the irq...

I didn't think the patch was wrong per se, just that something broke when
jiggled. :(

> arch/sh/include/mach-common/mach/r2d.h has:
> #define R2D_FPGA_IRQ_BASE       100
> Subtracting 16 here does not help.
> 
> With this (gmail-whitespace-damaged) patch:
> 
> --- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
> +++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
> @@ -31,9 +31,9 @@ static char lboxre2_irq_tab[] = {
>  int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>         if (mach_is_lboxre2())
> -               return lboxre2_irq_tab[slot];
> +               return lboxre2_irq_tab[slot] - 16;
>         else
> -               return rts7751r2d_irq_tab[slot];
> +               return rts7751r2d_irq_tab[slot] - 16;
>  }
> 
>  int pci_fixup_pcic(struct pci_channel *chan)
> 
> it no longer crashes, but ifconfig still fails:
> 
> / # ifconfig eth0 up
> ifconfig: ioctl 0x8914 failed: Invalid argument

Sounds like it's now outside of the IRQ range allocation, but I can't find where
that's requested when registering the controller? (What is a "swizzle" anyway?)

I'm looking at kernel/cpu/sh4/setup-sh7750.c but I don't understand why it might
work for landisk but not there. (Bit out of my depth in this plumbing.
Head-scratching at include/linux/sh_intc.h #defining DECLARE_INTC_DESC()... hard
to work backwards to find where this stuff STARTS...)

> Note that there are more implementations of pcibios_map_platform_irq()
> that do not use evt2irq(), and thus are probably broken by this patch.

Yup. Sounds like something could be consolidated. Unfortunately I only have 4
test systems for this platform, only 2 of which are easy to cycle...

> Gr{oetje,eeting}s,
> 
>                         Geert

I can try sticking printk() into this to track it down if you haven't got any
more time to look at it. I don't understand this plumbing very well but "error
return code comes from here, that tested this variable, which was set here..."
is generally a deterministic approach, if glacial.

Rob
