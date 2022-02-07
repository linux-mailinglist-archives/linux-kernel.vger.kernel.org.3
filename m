Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8044A4AC021
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387675AbiBGNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449362AbiBGNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:22:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB3C043181;
        Mon,  7 Feb 2022 05:22:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y7so5828024plp.2;
        Mon, 07 Feb 2022 05:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ju2l/FTOazvAgEsgoP0lVMN/oy2jY6VCO2qhYuBvO+8=;
        b=I7IS3BD35XHkQy2sPJWEoEzD1sGY4JMUSHDzyIdB3U6J5ZReyRDzBhJ+3p+0V3TxWR
         FHPCX0EfPMnDy8hcEvivuS1CAn1r20pCO6XDK+Y+jjKYSJCXq76C13tpr/gmUmgmLlh+
         vF/YST96NbsioBQ1OLgvFYjRW7P+WyOiFT5t6t0vwfCITMSSHqwNjg8CXu2eZKrolRzN
         9DCNXFGqak3A683JlVrsXAFWXEJMJ/spsnTjoXweIlP1R1caNS1uRGTISeqfSnGn1P5c
         TUKANZlgyjbgb+Y9fyIoFLuU2AxZzZgWnC2FhE5R5j1PvFC7mexIuKs0esY4u8zbEzOO
         4brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ju2l/FTOazvAgEsgoP0lVMN/oy2jY6VCO2qhYuBvO+8=;
        b=u1IMNjTK7eT2SgNwzqqMMi2XGAjzFX5jxkp8UCoED/uN5BL3V3LdQUe96froNiyOj8
         ZRBUFYjv4dxC5HhbkT63qlN4MBp3OrUv3Au+709RQPjEb8VqMxduqnIyBMWDqsaCg9pf
         vs+q7ucwWreb7MU6KhnplLIQ9Dh2JvQ7ATP6BYXqzxRILqfZtO/Qmox8LwglP/gQKgPN
         aAD211pDp20lCR5tbV5hty2pf7LIqUOVQDUYqRaIPUVnOlVD6A/WKVHJfGMdmc/3LMhG
         7h0jXUe/O5lQMlIPsi8nS+AxU6X2d6c4RtH5LCb7nplJ6Fjvo5kah/z+Tap6lZXc4uS2
         ZdNw==
X-Gm-Message-State: AOAM533XH2LOh7Be5h5xJ0Jrm+HQsMeEcriKAIm/v4A14o71XSBHmPt6
        wAgDUkCQR7hrEL7V0ToNCE5sWvi7Kcwe9fElUbc=
X-Google-Smtp-Source: ABdhPJyTq8JBdhOsZS50GkUhARRIubUwI6701QLskwR/acn9mfZnCszpP4jNm7WoIkdWO3Qxpdwk4PcwQ4jm1qRvvmU=
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr15997335plb.147.1644240121582;
 Mon, 07 Feb 2022 05:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20220203060641.119522-1-vimal.agrawal@sophos.com>
 <20220204083933.136096-1-vimal.agrawal@sophos.com> <Yf2fB4mzdLiWtoki@bombadil.infradead.org>
In-Reply-To: <Yf2fB4mzdLiWtoki@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Mon, 7 Feb 2022 18:51:50 +0530
Message-ID: <CALkUMdRv0tMuLpi3Syw7MndBTa9b0xRLGdb6QvM8Q69zXnmUkw@mail.gmail.com>
Subject: Re: [PATCH v5] modules: add heuristic when stripping unneeded symbols
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        nishit.shah@sophos.com, Vimal Agrawal <vimal.agrawal@sophos.com>,
        Dirk VanDerMerwe <Dirk.VanDerMerwe@sophos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> You did not explain why you change your code to not use the below
> (!best) branch. I'd much prefer it there as that is when we know
> for sure we have no real symbol defined.
>
>   Luis

Actually I had it  under (!best) in my first patch. I had to change it
because it was resolving the address to symbols like __this_module for
init address at times which is not correct for text address. It was
not entering inside if (!best) as it found some match but the match
was not correct. It could be fine for some non text addresses but not
for text addresses.

So I had to move this check out of (!best) and put a check explicitly
for text address to avoid any impact on non text addresses by
following:

+       if ((is_module_text_address(addr) &&
+               (bestval < baseval || bestval > nextval))) {
+               /*
+                * return MODULE base and offset if we could not find
+                * any best match for text address
+                */

I tested it on next-20220116-1-gff24014a52c0 today and I am able to
repro at least for init address easily with test_module.ko.
it is showing like following without the patch in my latest run (
decoding it to __this_module wrongly as mentioned earlier) :

[129558.843823] CPU: 2 PID: 39541 Comm: insmod Tainted: G        W   E
    5.16.0-next-20220116+ #6
[129558.843827] Hardware name: innotek GmbH VirtualBox/VirtualBox,
BIOS VirtualBox 12/01/2006
[129558.843829] RIP: 0010:__this_module+0x9fc4/0x9fc7 [test_module].
<<<<<<<<<<<======================
[129558.843840] Code: Unable to access opcode bytes at RIP 0xffffffffc083ffda.
[129558.843841] RSP: 0018:ffffa2cc800cbbf0 EFLAGS: 00010202
[129558.843844] RAX: 0000000000000035 RBX: 0000000000000000 RCX:
0000000000000000
[129558.843846] RDX: 0000000000000000 RSI: ffffffffb6d930f1 RDI:
0000000000000001
[129558.843848] RBP: ffffa2cc800cbbf8 R08: 0000000000000000 R09:
ffffa2cc800cb9f0
[129558.843849] R10: ffffa2cc800cb9e8 R11: ffffffffb7155108 R12:
ffffffffc0840007
[129558.843851] R13: ffff97acb458d580 R14: 0000000000000000 R15:
ffffffffc0836040
[129558.843853] FS:  00007f752eb90400(0000) GS:ffff97ad80f00000(0000)
knlGS:0000000000000000
[129558.843855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[129558.843857] CR2: ffffffffc083ffda CR3: 0000000100786001 CR4:
00000000000706e0
[129558.843863] Call Trace:
[129558.843865]  <TASK>
[129558.843866]  ? init_module+0x40/0xff9 [test_module]

Not sure what has changed but it is not showing the absolute address
as I had seen earlier.

post my patch, it is showing like following:
[   59.600299] CPU: 1 PID: 1620 Comm: insmod Tainted: G            E
  5.16.0-next-20220116+ #7
[   59.600303] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[   59.600305] RIP: 0010:[module __init]+0x4/0x7 [test_module]
<<<<<<====================
[   59.600315] Code: Unable to access opcode bytes at RIP 0xffffffffc0827fda.
[   59.600316] RSP: 0018:ffffbda002a8fc20 EFLAGS: 00010202
[   59.600319] RAX: 0000000000000035 RBX: 0000000000000000 RCX: 0000000000000000
[   59.600321] RDX: 0000000000000000 RSI: ffffffffa0f930f1 RDI: 0000000000000001
[   59.600323] RBP: ffffbda002a8fc28 R08: 0000000000000000 R09: ffffbda002a8fa20
[   59.600325] R10: ffffbda002a8fa18 R11: ffffffffa1355108 R12: ffffffffc0828007
[   59.600326] R13: ffff9554c4e72220 R14: 0000000000000000 R15: ffffffffc0822040
[   59.600328] FS:  00007f9c773d8400(0000) GS:ffff9555c0e80000(0000)
knlGS:0000000000000000
[   59.600331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.600333] CR2: ffffffffc0827fda CR3: 000000000c19c003 CR4: 00000000000706e0
[   59.600338] Call Trace:
[   59.600340]  <TASK>
[   59.600342]  ? init_module+0x40/0xff9 [test_module]

I can update the patch explaining this in comments in between the code.

Vimal
