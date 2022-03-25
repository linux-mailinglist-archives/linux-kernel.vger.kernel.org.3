Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8662D4E79BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346701AbiCYRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiCYRRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:17:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E04E7F56
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:15:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z12so662616lfu.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j61R5L89u+/vfXXexWezMtO01q4KBgFfkSQElj7/TZs=;
        b=bXxcEdoQ56AMcT9jO4mrCLjfMCMwff7lkz1uyivOhsc1yVQywFalef59YfGE+40Ib/
         AvHTYwxImBGmO4Ft12aNmlHycRr7AUduqbdV6LHsmJuV/SmEUJm28rTySzOe4/2Z0R8o
         vPpd9hHe8xTR+nRcALipQSmiYly4gC1NcO6w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j61R5L89u+/vfXXexWezMtO01q4KBgFfkSQElj7/TZs=;
        b=688iyNLCMG2LF6yDwdjZPF0I/MUe3WxDgeGzurIap396gsWTz8n42QbqLOGKA1jxcr
         6ZM1ra46Og6ov/Lctvm9LIHoL6Jj92wpLSkFAAPlJ3fF8mM+vjdvoZcoyocrOOYvU5vK
         Ancb1/G42vhUF+11Pw9avHDv8+6UJcf0L+OSbWluNLVkp+LGvDojHVDu7kcKnSXiawCH
         Wq7rt4PDq2KVRn5JMrO8D571+VDuXXMTP/NCgYuxR48mmF0EkTpzM+ww/zz6UBb0meE1
         NglsON4cT80DtVsy3PlSVJqEHwr/3or6u84WKdS5Gh8USBlAVKQN3h2EQomg/Ei8cj9L
         fE6g==
X-Gm-Message-State: AOAM533jAextvXWi3lwNmAMv4jUaAr3IxA3BKxMobC1jBXHrq6mA8xYW
        +HnA6wVbe9QXx6OlwcYdLnsPadheyesXpvWTxiM=
X-Google-Smtp-Source: ABdhPJylM/T9xqRRwcUqh2mI0GZGWqbjVNgMEp440YPHlAMruCU5YZGp0hNikaBGGkXfTDF5ZPHHEQ==
X-Received: by 2002:ac2:4315:0:b0:448:2bb9:f11d with SMTP id l21-20020ac24315000000b004482bb9f11dmr8361583lfh.212.1648228531509;
        Fri, 25 Mar 2022 10:15:31 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id d20-20020ac241d4000000b004484fcc5d2csm766388lfi.36.2022.03.25.10.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:15:30 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r22so11167574ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:15:29 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr8695253lji.152.1648228529533; Fri, 25
 Mar 2022 10:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220325171059.111208-1-jcmvbkbc@gmail.com>
In-Reply-To: <20220325171059.111208-1-jcmvbkbc@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 10:15:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBTJccj3i5u1LQ5JtUvdmgcG40HNT+XSOyGxCa3Gtc5w@mail.gmail.com>
Message-ID: <CAHk-=wiBTJccj3i5u1LQ5JtUvdmgcG40HNT+XSOyGxCa3Gtc5w@mail.gmail.com>
Subject: Re: [PULL v2 00/18] xtensa updates for v5.18
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:11 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
>   https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220325

Oh, I had already taken the "git@github.com" one and fixed it up
manually, but thanks for re-sending anyway ;)

                 Linus
