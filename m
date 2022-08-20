Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5610859B09E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiHTVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiHTVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 17:44:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF92250A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 14:44:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w19so14762542ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=06NQ9qvzyXzYoYplFrOhB+72ycso6mDcQFEFIouUsIs=;
        b=TiSoGPMyV1LXSCZFi8l6Fsp9Lx33NzdCRlgqIpt5daXToYuKj+wLIuuUFnGtuKdw7g
         riKhvm29kVdcouqs9IG1aTvUsVR7ES8KPs2aYmFK7sEf/fkP8EjOxt/dO1YOuBYABPb/
         qzljmN+krG1Hvt43ZDKG4bo5espvLX+1tJPCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=06NQ9qvzyXzYoYplFrOhB+72ycso6mDcQFEFIouUsIs=;
        b=g99LEZ2V6JIre6StebLMJo6eqGPjs5ajcmfvdmVlrG5NVah3kIUEzg+SF0ihiAQ957
         WSmS8lUqJyYhAbiqiqQ9KxChibD+HMw69QjPz0spZJIsBN0s0EmM6hqqlOsHDt1/X3SI
         UUpBgifUXlCftgcaONvfhPpZm5DAN3T8FAWcx7mFI9sgl8V+gYQcPMn76pQTGk+H3U6X
         jYuTRt+H1385z2B5Dv83T+nPLBF+sZRmzKS+WF4hWEBfPsngoZnoMlHPFlTNmDK0yVMt
         JD4hprOPLqNLIPf4YJdUx8mq0KI8Kh1zgmYV0zV1FoxTJcZlXo3lew9X9bjTcTBp6ufy
         bYwA==
X-Gm-Message-State: ACgBeo19QEaYa0gwn8RK4qLrCo7O3SnYGIsjgdKrBOYx8LrUlrYQCnke
        Wxa1F9gg7qznnTjvDHABXYFuUuc27I229YVt
X-Google-Smtp-Source: AA6agR4dkp4UFyr8S6vUQxFflfGlcb67iuB3e8fCPKKCwKpm2+/12Ff0FIkNqVqqtDHmfCce4HFgiw==
X-Received: by 2002:a17:906:730d:b0:73d:74dc:ba8f with SMTP id di13-20020a170906730d00b0073d74dcba8fmr398233ejc.177.1661031867316;
        Sat, 20 Aug 2022 14:44:27 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id fi22-20020a056402551600b0043e581c30eesm5290708edb.31.2022.08.20.14.44.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 14:44:26 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so5773733wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 14:44:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr11227293wmq.154.1661031865955; Sat, 20
 Aug 2022 14:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <YwBWJYU9BjnGBy2c@ZenIV> <CAHk-=whL7nCkQLwWG29c-ojeCPqbaHPsRzOxEoxO0HzLuZV+sw@mail.gmail.com>
 <YwErb9MnfTFCmOcA@ZenIV>
In-Reply-To: <YwErb9MnfTFCmOcA@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Aug 2022 14:44:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh91JqnMU+aN9NEy4vB9hePFEYLtiAVtS+U6VE-17pDBg@mail.gmail.com>
Message-ID: <CAHk-=wh91JqnMU+aN9NEy4vB9hePFEYLtiAVtS+U6VE-17pDBg@mail.gmail.com>
Subject: Re: [RFC][PATCHES] termios.h cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Sat, Aug 20, 2022 at 11:44 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Umm...  Might as well, I guess...  Where to put those, though?
> drivers/tty/tty_ioctl.c is not an option, unfortunately - it'll pick
> the local definitions, __weak or no __weak.

IThat bug is ancient history, and tty_ioctl.c is just fine.

Yes, we used to have the "you can't have __weak function definitions
in the same file that uses them" rule.

But it was due to a bug in gcc-4.1, which would inline weak functions.

But we long since gave up on gcc-4.1, and we have __weak functions
declarations in the same file as the use in multiple places. See for
example arch_release_task_struct() in kernel/fork.c.

                 Linus
