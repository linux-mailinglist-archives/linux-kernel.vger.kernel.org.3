Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F179539183
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbiEaNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbiEaNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:12:12 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C459306
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:12:10 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c26so13526271vsl.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=DDM4rTpw89TAOEx0UETJodx1vXw6LNr23K1kqgXIMaM=;
        b=fOVv3qfAWeLkYn3Iyq73LQLz/ZtYdD/BIVvAii/hj0CfgXhMqfsds7hdgEWE1Omf6C
         RKl0hfvD98ZFHAeOO9C9HRWgPEQYdEW0+1KqSmW6S5Nc+7YiLtXg6VfoPxUKfY+Iw1v7
         gVoEMjG75caYH8T706epTgddgYrqc0n67BHlmT9JAjlKe4y7N6dhkkmCck8Yp4U+igSr
         DHCo0JgQdll5A/jbrbN5NiO+811miF2ivkhOVU0sbieDrNXsbRciJSJ6zSnHG1+dXGJs
         DqZqoRweMvcWBxfxcbygZMB204gu9RGhGDMoubEKfMx+VqRUNqd0IKG/9febJxi4V1aN
         ACBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DDM4rTpw89TAOEx0UETJodx1vXw6LNr23K1kqgXIMaM=;
        b=QwDpHvBGR5z5JliSYGJqNPZ13XBN85N02Ud9XlYRguXvsxhZeEJ3FortB/jyqKdIHW
         s4VXjQABJCcq919rJ8DpwTFPmBfhzyVT/XokPWPCGYlp3su2SpQYpv/Bb8mu/g16T15l
         g2Inv/YUyEalXFOO3WL8Os/o7yLuur6SOldvOE3jZ/OrOwOrluararpLo75jUc2JqFN+
         pLXqf4n2CtxvU3mu6EENVHmzQzYZPREInI3GAUeRYpCj4xTYqk4iemuioyNW26EI9Qkf
         qN7hgncdnQos/nB11sWkSojOb4gZ2yry+VfSdcUbeBTd+UXoqwBDurOon7ETX5JN/u1U
         198g==
X-Gm-Message-State: AOAM533TI6DkalGjz+sdSnPelyPcpihfAKshTbEKIFwGfGVI8B8ECdzT
        DWKWCRYoSYKGZsog8XUT8lB7UEJ3HVWobuV7Me/VPFTxjtY=
X-Google-Smtp-Source: ABdhPJzDsi3CXA+2xbxkpkZnkEnuZOBop7TCLdVflqFPJVicHxvxC7+Ima6cQvXz6d9ITiP1JfLLbZc8bSZHaPrGR/s=
X-Received: by 2002:a05:6102:1008:b0:335:e260:9ff1 with SMTP id
 q8-20020a056102100800b00335e2609ff1mr24203200vsp.32.1654002729905; Tue, 31
 May 2022 06:12:09 -0700 (PDT)
MIME-Version: 1.0
From:   Alphabet Hotel <alephhotel285@gmail.com>
Date:   Tue, 31 May 2022 09:11:59 -0400
Message-ID: <CAC12nxd9qfvoskRiP+fm6daoxKUbNO9LBH4VX_RoXRsuL-9Jmg@mail.gmail.com>
Subject: x86-32: can't create call gate in LDT?
To:     linux-kernel@vger.kernel.org
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

I was looking at emulating the lcall7 syscall interface in userspace
but it seems I can't even ask for a call gate. I did get it to work by
using a regular code segment for entry 0 and mapping my lcall7 handler
at offset 0 but now I'm in a different code segment and GCC is lost.
Could the ability to use call gates be added to the kernel? The patch
looks fairly easy and if it only allows calls into the existing CS it
should be safe. My test program works as-is but it's a hack and it
would require switching segments on every syscall.

#define _GNU_SOURCE
#include <stdio.h>
#include <err.h>
#include <sys/syscall.h>
#include <asm/ldt.h>

static int ret = 1, val = 0;

static void __attribute__ ((regparm(1))) lcall7(int call_nr) {
    val = call_nr;              // remaining args are on the stack
    asm volatile ("xor %eax,%eax;"
                  "lret;"       // far return is required
    );
}

int main() {
    struct user_desc desc = {
            .entry_number = 0,
            .base_addr = (unsigned long)&lcall7,
            .limit = 1,          // one page
            .limit_in_pages = 1,
            .seg_32bit = 1,
            .contents = 2,       // non-conforming code
    };

    if (syscall(__NR_modify_ldt, 0x11, &desc, sizeof(desc)))
        err(1, "modify_ldt");

    asm volatile ("lcall $7,$0;"
                  : "=a" (ret)
                  : "a" (42)
    );
    if (!ret && val == 42)
        printf("lcall7 worked\n");
}
