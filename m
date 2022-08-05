Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C058AEF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiHERdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHERdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:33:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0F3A2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:33:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t22so3393233pjy.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rZtwmuWIKJRZKs7sJolgB/YTLmgyIVLtF2FTeQENAKA=;
        b=cWzBk5CsfTOPBiDuvc8HX3X8YRWrERP57Qe85hgJsdyGLoTSO6mTs0Aw8yl2ETfVVL
         LQ6P+QyV3H95Y0nQIndg3cHMhoaxJIcs1oxaCGtctP1ej99kx1dtvGgLporEOijiY5up
         dSnvvjnt1wvshH333faX0u+mub6gTkpxErxkN5XkEQ/TIhi1F15nxoRtPlMnu8y/V+5i
         SRei16P8CzHxh4qm2XCoskapfNQ/328M0XLIYsqvNKE1UZT1ItyUE6wjic0nN8intNwc
         GGuKSjgWnrgaxDmmgJZ7Jt5OsIXf91Ztyhis8NlkAFlbi/z2zeDJlpzT79OxRqFlLVJU
         jB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rZtwmuWIKJRZKs7sJolgB/YTLmgyIVLtF2FTeQENAKA=;
        b=Nn2ylKXSBxOpGU2ppfsc06KUJpK3jL6abiSOzVsw/RwapjhzfAgiI1zdzGPpSeso/c
         AjV3HbDY7SaJ49TQuF6P5WExLe7oc5rBuwlVOV/JNrL42ZMR1Bhkou0CyNbT7woLDOuH
         UptJPb4RUoaU/4mD/9uGUYtnuwfOdogg/dHQQ9mowc+2MfTHsWJ65zK2Lx/bnf54Kpe+
         JXbo2/TaancXyppSApCPuMJBciVCibMW2GR0gEofg176zllprekW/1I289gUwJZc0+9a
         E5XyqUDmo8Q7VRZZ32qahR8MWhvYfvvmyJZH9IXGT8RgoksjVWCbG/Ye4Av0Ni1HRBsi
         Ye3A==
X-Gm-Message-State: ACgBeo0RCg90AG06faLUTt+w0LonsGYIa2QPggdKbGe3L5uPw2FwxkL5
        4Cz+znDgTg8UM+9k4pEHm1PccGDC+rY=
X-Google-Smtp-Source: AA6agR4TzY0EtG9blLfWDhjBRChkONpmZLWVrj/WjTLdbuFHvKEc1dAOxUI4sd6ymqR5oUfR9FX51Q==
X-Received: by 2002:a17:90b:3e86:b0:1f5:2b4f:7460 with SMTP id rj6-20020a17090b3e8600b001f52b4f7460mr17183530pjb.97.1659720784164;
        Fri, 05 Aug 2022 10:33:04 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090340cd00b0016dc6279ab8sm3236534pld.159.2022.08.05.10.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:33:03 -0700 (PDT)
Message-ID: <7498668e-0e91-be2b-daf2-a45bf0cf40c9@gmail.com>
Date:   Fri, 5 Aug 2022 10:33:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] lib/cmdline: avoid page fault in next_arg
Content-Language: en-US
To:     Neel Natu <neelnatu@google.com>, linux-kernel@vger.kernel.org
References: <20220728232434.1666488-1-neelnatu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20220728232434.1666488-1-neelnatu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/28/22 16:24, Neel Natu wrote:
> An argument list like "arg=val arg2 \"" can trigger a page fault
> if the page pointed by 'args[0xffffffff]' is not mapped and potential
> memory corruption otherwise (unlikely but possible if the bogus
> address is mapped and contents happen to match the ascii value
> of the quote character).
>
> The fix is to ensure that we load 'args[i-1]' only when (i > 0).
>
> Prior to this commit the following command would trigger an
> unhandled page fault in the kernel:
>
> root@(none):/linus/fs/fat# insmod ./fat.ko  "foo=bar \""
> [   33.870507] BUG: unable to handle page fault for address: ffff888204252608
> [   33.872180] #PF: supervisor read access in kernel mode
> [   33.873414] #PF: error_code(0x0000) - not-present page
> [   33.874650] PGD 4401067 P4D 4401067 PUD 0
> [   33.875321] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> [   33.876113] CPU: 16 PID: 399 Comm: insmod Not tainted 5.19.0-dbg-DEV #4
> [   33.877193] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [   33.878739] RIP: 0010:next_arg+0xd1/0x110
> [   33.879399] Code: 22 75 1d 41 c6 04 01 00 41 80 f8 22 74 18 eb 35 4c 89 0e 45 31 d2 4c 89 cf 48 c7 02 00 00 00 00 41 80 f8 22 75 1f 41 8d 42 ff <41> 80 3c 01 22 75 14 41 c6 04 01 00 eb 0d 48 c7 02 00 00 00 00 41
> [   33.882338] RSP: 0018:ffffc90001253d08 EFLAGS: 00010246
> [   33.883174] RAX: 00000000ffffffff RBX: ffff888104252608 RCX: 0fc317bba1c1dd00
> [   33.884311] RDX: ffffc90001253d40 RSI: ffffc90001253d48 RDI: ffff888104252609
> [   33.885450] RBP: ffffc90001253d10 R08: 0000000000000022 R09: ffff888104252609
> [   33.886595] R10: 0000000000000000 R11: ffffffff82c7ff20 R12: 0000000000000282
> [   33.887748] R13: 00000000ffff8000 R14: 0000000000000000 R15: 0000000000007fff
> [   33.888887] FS:  00007f04ec7432c0(0000) GS:ffff88813d300000(0000) knlGS:0000000000000000
> [   33.890183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   33.891111] CR2: ffff888204252608 CR3: 0000000100f36005 CR4: 0000000000170ee0
> [   33.892241] Call Trace:
> [   33.892641]  <TASK>
> [   33.892989]  parse_args+0x8f/0x220
> [   33.893538]  load_module+0x138b/0x15a0
> [   33.894149]  ? prepare_coming_module+0x50/0x50
> [   33.894879]  ? kernel_read_file_from_fd+0x5f/0x90
> [   33.895639]  __se_sys_finit_module+0xce/0x130
> [   33.896342]  __x64_sys_finit_module+0x1d/0x20
> [   33.897042]  do_syscall_64+0x44/0xa0
> [   33.897622]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   33.898434] RIP: 0033:0x7f04ec85ef79
> [   33.899009] Code: 48 8d 3d da db 0d 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 9e 0d 00 f7 d8 64 89 01 48
> [   33.901912] RSP: 002b:00007fffae81bfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   33.903081] RAX: ffffffffffffffda RBX: 0000559c5f1d2640 RCX: 00007f04ec85ef79
> [   33.904191] RDX: 0000000000000000 RSI: 0000559c5f1d12a0 RDI: 0000000000000003
> [   33.905304] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   33.906421] R10: 0000000000000003 R11: 0000000000000246 R12: 0000559c5f1d12a0
> [   33.907526] R13: 0000000000000000 R14: 0000559c5f1d25f0 R15: 0000559c5f1d12a0
> [   33.908631]  </TASK>
> [   33.908986] Modules linked in: fat(+) [last unloaded: fat]
> [   33.909843] CR2: ffff888204252608
> [   33.910375] ---[ end trace 0000000000000000 ]---
> [   33.911172] RIP: 0010:next_arg+0xd1/0x110
> [   33.911796] Code: 22 75 1d 41 c6 04 01 00 41 80 f8 22 74 18 eb 35 4c 89 0e 45 31 d2 4c 89 cf 48 c7 02 00 00 00 00 41 80 f8 22 75 1f 41 8d 42 ff <41> 80 3c 01 22 75 14 41 c6 04 01 00 eb 0d 48 c7 02 00 00 00 00 41
> [   33.914643] RSP: 0018:ffffc90001253d08 EFLAGS: 00010246
> [   33.915446] RAX: 00000000ffffffff RBX: ffff888104252608 RCX: 0fc317bba1c1dd00
> [   33.916544] RDX: ffffc90001253d40 RSI: ffffc90001253d48 RDI: ffff888104252609
> [   33.917636] RBP: ffffc90001253d10 R08: 0000000000000022 R09: ffff888104252609
> [   33.918727] R10: 0000000000000000 R11: ffffffff82c7ff20 R12: 0000000000000282
> [   33.919821] R13: 00000000ffff8000 R14: 0000000000000000 R15: 0000000000007fff
> [   33.920908] FS:  00007f04ec7432c0(0000) GS:ffff88813d300000(0000) knlGS:0000000000000000
> [   33.922125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   33.923017] CR2: ffff888204252608 CR3: 0000000100f36005 CR4: 0000000000170ee0
> [   33.924098] Kernel panic - not syncing: Fatal exception
> [   33.925776] Kernel Offset: disabled
> [   33.926347] Rebooting in 10 seconds..
>
> Signed-off-by: Neel Natu <neelnatu@google.com>


Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.


> ---
>   lib/cmdline.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index 5546bf588780..90ed997d9570 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -260,7 +260,7 @@ char *next_arg(char *args, char **param, char **val)
>   				args[i-1] = '\0';
>   		}
>   	}
> -	if (quoted && args[i-1] == '"')
> +	if (quoted && i > 0 && args[i-1] == '"')
>   		args[i-1] = '\0';
>   
>   	if (args[i]) {
