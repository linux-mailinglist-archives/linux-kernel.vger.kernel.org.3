Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB15AAA9F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiIBIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiIBIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:51:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D857B1D6;
        Fri,  2 Sep 2022 01:50:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nc14so2486295ejc.4;
        Fri, 02 Sep 2022 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=1i7j/swt16X4UVbcDcaXz040PkNBu1+BieE4zMZT53M=;
        b=R7m0JXjIGgvtEMkwEzdKz/sEvLuNbFj0OElMpeGlnRSJe0a0zDy/n8DwmFtuJeOqPE
         n51SJqi9JZ11It7JZBV3m0HZjRWAPkZc9Bp7IBPC8Iwct65MAk8Mch9CZKLsnd5bNIGT
         SHtpV/k2fC5kZ5KVOVbQydAbm9R3EhE/9/tO1oMumWtHbQ3qo0HOfpHGHQrgtf6GWTgL
         /gtPKGfgCfgbfUx6XaIc8C7YeQhlL+uYHZ0nbudsyt4kPNF9ysvmcCE8ESSfh1VsiHIj
         YpqDYur4SqoLXO/p/5iUXB1CJxe/FaYRWLWa/SALL4WKyAW0NCKFnCrA99jZQUb1QPdg
         f7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1i7j/swt16X4UVbcDcaXz040PkNBu1+BieE4zMZT53M=;
        b=I7WV7GVJS+FT7B7SKszEc/G2gcAwlxe2cVygUe1JforMGmzAVzjE314ERRK9xuOQUy
         gxRq6K3cue+j1skvA9jFcKdk20FIIkhclnhlqguTC8X2UxW1Gg1eF2rZMJ+6LXLMZX25
         Gez0b68VPVoDg5Lpom4qQ2aWxF7t+ODkCeKjSyNYkrDROgyo8jsrKEB3MBmhwbcngoe+
         HXHY2INTddfpk2jJFJzfuro7KRKCPBFGqcbMrZd0f66N1lQ5VtJaOti+NnTBHCvoFCAY
         6Swnarhuyt70pPgQ062RJUJgO8gUpL+vN8KfA2LWYkx/2KWtMTrpnUoXGJ5+j1xx63VE
         YjAQ==
X-Gm-Message-State: ACgBeo2L+v/egHf1pvcU9fi3CstAmioZjUtkpL8kkrDorBiyAVNTsxEK
        CNR2DTfggOojUz12rWGIbVY=
X-Google-Smtp-Source: AA6agR6MLwDBwdlGP1Bjq9Oj0xDdHx8qYK872NibXhNrSObgImW/WO16U9G8PdeOG2u66dkUJYt3hQ==
X-Received: by 2002:a17:907:a049:b0:73d:c6c9:5263 with SMTP id gz9-20020a170907a04900b0073dc6c95263mr26015814ejc.563.1662108631627;
        Fri, 02 Sep 2022 01:50:31 -0700 (PDT)
Received: from gmail.com (1F2EF751.nat.pool.telekom.hu. [31.46.247.81])
        by smtp.gmail.com with ESMTPSA id cb26-20020a0564020b7a00b0043d1a9f6e4asm1016225edb.9.2022.09.02.01.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:50:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 2 Sep 2022 10:50:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
Message-ID: <YxHD1MkulyL3yB9y@gmail.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic>
 <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com>
 <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <YkC08gKqJOUM7CA8@gmail.com>
 <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> On Sun, Mar 27, 2022 at 09:03:14PM +0200, Ingo Molnar wrote:
> > Yeah, good catch! ...
> > 
> > I use defconfigs by explicitly adding in the architecture:
> > 
> >   kepler:~/tip> make ARCH=i386 defconfig
> > 
> >   kepler:~/tip> kconfig-arch
> >   i386
> > 
> > ... so never I noticed this bug.
> 
> Ah, good point!
> 
> > I fixed this in the latest version (attached).
> > 
> > Arguably 'make ARCH=i386 savedefconfig' should preserve this, so that 
> > refreshing defconfigs on bi-arch architectures is idempotent, but that's no 
> > excuse to regress the existing defconfig behavior.
> 
> Hmmm, I thought that it would, but I think the behavior of savedefconfig
> is actually correct with regards to how it handles CONFIG_64BIT in the
> presence of an explicit ARCH value, based on how CONFIG_64BIT is
> defined:
> 
> config 64BIT
> 	bool "64-bit kernel" if "$(ARCH)" = "x86"
> 	default "$(ARCH)" != "i386"
> 	help
> 	  Say yes to build a 64-bit kernel - formerly known as x86_64
> 	  Say no to build a 32-bit kernel - formerly known as i386
> 
> As the default is no when ARCH == i386 and there is no prompt in that
> situation, "# CONFIG_64BIT is not set" gets dropped, as that is the
> default. Using savedefconfig without the ARCH variable would do the
> right thing.
> 
> I tried playing around with these Kconfig symbols to see if I could get
> something that would work for savedefconfig with or without ARCH, but I
> could not really come up with anything. I did not try super hard though,
> it might still be possible.

Unfortunately, even without the ARCH=i386 'make savedefconfig' doesn't seem 
to be doing the right thing & is dropping the '# CONFIG_64BIT is not set' 
line:

 kepler:~/tip> make ARCH=i386 defconfig
 *** Default configuration is based on 'i386_defconfig'
 #
 # configuration written to .config
 #
 kepler:~/tip> make savedefconfig
 kepler:~/tip> diff -up arch/x86/configs/i386_defconfig defconfig
 --- arch/x86/configs/i386_defconfig	2022-09-02 10:45:43.117430882 +0200
 +++ defconfig	2022-09-02 10:46:56.663864901 +0200
 @@ -282,4 +282,3 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
  CONFIG_EARLY_PRINTK_DBGP=y
  CONFIG_DEBUG_BOOT_PARAMS=y
  CONFIG_UNWINDER_FRAME_POINTER=y
 -# CONFIG_64BIT is not set
 kepler:~/tip> 

This is annoying in that every time I modify the i386 defconfig and use 
'make savedefconfig', I have to manually revert that change ...

This reduces the usability of 'make savedefconfig' quite a bit.

Maybe Masahiro-san can tell me how I'm doing this wrong?

Thanks,

	Ingo
