Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF446591697
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiHLVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiHLVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:04:45 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DEB4409
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:04:44 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id v14-20020a6b5b0e000000b0067bc967a6c0so1215118ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=EZPhLvqxjH7DlnwZ7ApNxUiZnxKWt7nngUkeSukkWJk=;
        b=5W1GacuVZEWh5xLOZWvfBzNUwgUOeKLu9y4jxPqmnz1YRbEzdlWfyQF8jgTY3cahsh
         x5VdAjWXGtP0t8EIiWy/pTxj1DxaNvQbSPAaRUMg/eWtM63pjPWc4kbbrIIEzz3V9Bb4
         QyEw24E0EMA7wrjN1+fRnwo7IcrKrUsSyFapZkDsj9UyQWry7SNd5KYrvas3AcAD6Hk8
         Y+ey4uI/pE7MlcoHwP4XWsEEFpP9437Ax8DaAkgdo7AIO/ZG1zTrqHtZS46vrnEeRcV4
         qtEEIShIEUBYQgoAwgz5KT99rFaQsTY882epA7ErvefmE+Pm5lspByyToLcZJTrfYPq3
         P1Tw==
X-Gm-Message-State: ACgBeo2abTaHZfmsCLLr34KpXy151mlXGlSOC+gisWF/OmBqqRTdzMvw
        Z1wVnUylCqo3DNpKxVClDXIR8R4A6UFgPC9mdz7I60XrUs1v
X-Google-Smtp-Source: AA6agR4HwG9XIviTxXABofMckWtRGeOD/pzisHBBhE61PadPxLYp+b+DX7ew4YDT+Shvdmvl0KiOkn8bBcWLoTfqBHGjtuOnHKC0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2a47:b0:67c:3ea9:1a97 with SMTP id
 k7-20020a0566022a4700b0067c3ea91a97mr2455827iov.180.1660338284015; Fri, 12
 Aug 2022 14:04:44 -0700 (PDT)
Date:   Fri, 12 Aug 2022 14:04:44 -0700
In-Reply-To: <20220812140439.6bb2bb17@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a03c5205e611a113@google.com>
Subject: Re: [syzbot] memory leak in netlink_policy_dump_add_policy
From:   syzbot <syzbot+dc54d9ba8153b216cae0@syzkaller.appspotmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 12 Aug 2022 10:04:26 -0700 syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    4e23eeebb2e5 Merge tag 'bitmap-6.0-rc1' of https://github...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=165f4f6a080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a433c7a2539f51c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=dc54d9ba8153b216cae0
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1443be71080000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e5918e080000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+dc54d9ba8153b216cae0@syzkaller.appspotmail.com
>
> Let's see if attaching a patch works...
>
> #syz test

want 2 args (repo, branch), got 15

>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20220812140439.6bb2bb17%40kernel.org.
