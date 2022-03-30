Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B94ECC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350206AbiC3SsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350069AbiC3SsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:48:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7922DE;
        Wed, 30 Mar 2022 11:46:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h7so37420520lfl.2;
        Wed, 30 Mar 2022 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VsweRR9Bm1elugFuLjB+sHVW+IhoGa/6l3x6FlcUvOw=;
        b=B32lQ5FlBZfygIdUdw0TYad6RyBN8VI3SfsZjYHT9E6jPq3HNr+2wwMZvWnoo6p1hI
         sIg/VxZR2RZEl9yH1qJd7JloeBErlrRzvtj98akVrwPyZVQWXay/Pe1dYB0YJngDQKFm
         ov7kNJbaoX/hs7RMBJa8ZNJcGCLIqGE1xwkes7zJghrSxIVbvPVEDlzXqPsQ7Eiqc6X2
         7trm1JnCQIL/DH7yiTnU0dNGeBzS/q7xEc0QWfUJ5vMRFnRpgRFnAilgye3ilugCTpG/
         Nz4KSC5nzDPHTCFyUNuUObr5j+KUPJHwZ1l0PvWGKj6hL4fGVP4B8cPWNhA9/wo6Ewc7
         rVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VsweRR9Bm1elugFuLjB+sHVW+IhoGa/6l3x6FlcUvOw=;
        b=mskhFB7s7/Hm3BnTlOSD0kk0w1++A0LG0PHg6or1KgO+QD0tf0Ff6FhXF4Sb72pcKH
         II0P69N2TEF2vfLnLu9yRW/RGnMJSI6XDHDGFTyS8Nf4XTYkmomc7oXKtFcPNHEbnb/j
         LemSDJNuDn5tKUOwJielq8wiwOB9fr/6IbPr+EOAiDUhfGoAvOSPKdKLEqDAsca+MPQg
         iNdZcUnokOcKEeglfU48RNbbLVDFwhaa9ahSmygj+x5ScegZ7QClZxTjghz4LSxhhKoU
         l1oG1XSCSIhVSOekqZ3AGlDxxI6HCY1Az5k7GvbTfhqftoXbl39Yb2OxJUJQooc1KdiC
         ZTwA==
X-Gm-Message-State: AOAM533E8+35jxjau/rxCeOhKGU8E1Y+67VN+AqE5hHA8e5fhuga7tTA
        TJwU/ZkW3LHf2JVuk/5itfk=
X-Google-Smtp-Source: ABdhPJxNOffv3wHbgOEwwqgQ7jn38JCaYiHhqAWPbcL9zTBjblqOl5truR1ByGuh3tMSD6h4o3Id2A==
X-Received: by 2002:a05:6512:b11:b0:44a:2ead:daf2 with SMTP id w17-20020a0565120b1100b0044a2eaddaf2mr7881574lfu.642.1648665973113;
        Wed, 30 Mar 2022 11:46:13 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id s10-20020a19ad4a000000b0044826a25a2esm2410533lfd.292.2022.03.30.11.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:46:12 -0700 (PDT)
Message-ID: <bb97600c-c865-10ab-fdb9-861c5423ddb0@gmail.com>
Date:   Wed, 30 Mar 2022 21:46:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] KASAN: use-after-free Read in em28xx_init_extension (2)
Content-Language: en-US
To:     syzbot <syzbot+99d6c66dbbc484f50e1c@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000453f3d05db72fc7e@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000453f3d05db72fc7e@google.com>
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

On 3/30/22 20:36, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    52d543b5497c Merge tag 'for-linus-5.17-1' of https://githu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b804fb700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161c4739700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16432d51700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+99d6c66dbbc484f50e1c@syzkaller.appspotmail.com
> 
> em28xx 5-1:0.130: Config register raw data: 0xfffffffb
> em28xx 5-1:0.130: AC97 chip type couldn't be determined
> em28xx 5-1:0.130: No AC97 audio processor
> ==================================================================
> BUG: KASAN: use-after-free in __list_add_valid+0x93/0xa0 lib/list_debug.c:26
> Read of size 8 at addr ffff888027458250 by task kworker/1:1/40
> 


Just want to warn anyone looking into this bug.

I came up with the fix, that passed syzbot testing and patch has been in 
Linus' tree for couple of months: see commit 2c98b8a3458d ("media: 
em28xx: add missing em28xx_close_extension").

After some time Maximilian sent a report about kernel hung bug caused by 
my fix [1]. Just random hung caused by wrong reference counting 
somewhere. No idea how to reproduce it locally or how to fix it.

I had to revert my fix, of course. That's why this bug appeared one more 
time.

So, if you are going to send a fix, please, check that it does not have 
same problem as mine.

Thanks


[1] 
https://lore.kernel.org/all/6a72a37b-e972-187d-0322-16336e12bdc5@elbmurf.de/ 



With regards,
Pavel Skripkin
