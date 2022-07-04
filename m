Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28654564F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiGDHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiGDHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:51:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F989B1D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:51:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id i17so5278162ljj.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ULobm+VCN9QC0SiaWvcA/Mc/bgYryB1cayxPAIAM4E=;
        b=HuoSzlhWy/Sd+i86BsF1pudkVOgoNR4N+zJTiPoUiG1MqSW6eFjBf0mGa/8WcxBqZm
         2nGkpI4+j3aFejxTDspWTvVnGgl9OeZ/lRpLHYoyjlb4luahZ0J+VnwRDld7aVXs5j8F
         CAWCxtKlbdUASc3awyVKx7Wop4TNXb68axwZ+HAN6+fm5ZVUadBP8eQDrjLZSICkAxWt
         ZzzMn5ivdnEZC/wzUVdhbhnpi1BNB6qrdkyKjoJO7LFor45ACKW6R1UHk4cqDgOos6Ht
         CbSmUsO6yI2JoqLH5OBLWRyYQjjTwDb7f1IM+++HdXoZz5z4/1WdGylE6tHewGfPAour
         9cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ULobm+VCN9QC0SiaWvcA/Mc/bgYryB1cayxPAIAM4E=;
        b=jRl/9JSB5krb0/HPPQDOceZkOCMWkuL+lDKsqUVCHe1jastnYxTiveQ25ap8kR4fQN
         tmb5C57hlsxmhL4zn4XDOvwoJsIGe0lr3LPSIYsPaAZ+vQU8l/f57gNKpNGzrhlgWsMh
         xhVcvkGwbkY61eGlhlS7JTYqvpM/XsiactxBSrrR8v/0ade8OkL8Chyw+QOcBHNXfBk3
         9OXwrcKnj8OVcXcOScskZmbJFdtWH0e23NCg151qyjtpYoWCCHDkvap6dqh7gRiovlXH
         AqG3/5g2GawjesW9YZ/VvJgGh0CiX6y6wxH0ZwmbkkjfcQcR+nckul2/2DBx4uIW9l6X
         ydTA==
X-Gm-Message-State: AJIora+LJpLWAjFJOV1GIzHH70pDkR2q0EXQ7PnhsqNcCn+z+ykCnoSM
        zpKov54zp+0oUZRH/9PCBaocMYhCAxT3pXYr8/W1ag==
X-Google-Smtp-Source: AGRyM1sOWXkKniRiwLYzPvdXTy9IWV92rClhT6o0h8bt5CdVK8rEkWmvzY6hbqakopbii3/XQhmGjz/CFprgefSP43U=
X-Received: by 2002:a2e:924b:0:b0:25d:1e72:acf1 with SMTP id
 v11-20020a2e924b000000b0025d1e72acf1mr2669714ljg.92.1656921086661; Mon, 04
 Jul 2022 00:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000915bd505ddaff576@google.com> <00000000000049a18105e2c34a0c@google.com>
In-Reply-To: <00000000000049a18105e2c34a0c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Jul 2022 09:51:15 +0200
Message-ID: <CACT4Y+bZPUDMR50mYSG5s=ABw54_JpHEWSgNDm8TSAQkpyJryg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
To:     syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
Cc:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        anthony.l.nguyen@intel.com, clemens@ladisch.de, coding@diwic.se,
        colin.king@intel.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, naamax.meir@linux.intel.com,
        perex@perex.cz, sasha.neftin@intel.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 at 21:21, syzbot
<syzbot+39e3268af9968f153591@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0125de38122f0f66bf61336158d12a1aabfe6425
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Wed May 25 13:12:03 2022 +0000
>
>     ALSA: usb-audio: Cancel pending work at closing a MIDI substream
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1180b25c080000
> start commit:   2a5699b0de4e Merge tag 'leds-5.19-rc1' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f915857c44e13980
> dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d1fcbf00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17716bedf00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ALSA: usb-audio: Cancel pending work at closing a MIDI substream
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: ALSA: usb-audio: Cancel pending work at closing a MIDI substream
