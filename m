Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F104B502E84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345106AbiDOSCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344138AbiDOSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:02:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C995C343
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:59:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so15021777lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZACS5WHiI7gChdgJhb6L8E+uQLLjhDmU2/Qe3HsDIMI=;
        b=XQQwxdMI0ImldHNKxqFX00q9oRU1fpELODiuK1zpOXyGiFAA6kL6FzgSrRjxqWF2kr
         G6KnStB6LrWLi5u2nj0ZFxquM++LK7WmvUJdKQXIS7lTDBZEGVDbsWTnZ5Eiuv10FaP8
         KaPcpZxl1ajQdG7+9VV8k/GqAQt9XWrZv48TeiU+tE4JFodOiEXjZaxeIQwzbZ2+GcH/
         q5C5ucF+7rf3V86RvyRv0EPmB2SNHtd3QqApleeTKWdssO7BHf0iPc/wHBYrC8XZ9xeX
         gkyEeQSLF30o5vbg9vrQgQMtu1EnI4oQll6paq473qT5ZpAMAjbvCmuVCXOpZsx/Ogzw
         NEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZACS5WHiI7gChdgJhb6L8E+uQLLjhDmU2/Qe3HsDIMI=;
        b=w9oLLTqCZ+UIz6KPUnEmTZK34ZWi4vln+m22rAKIVFaKjT0mX2wxPFN4/oyKXMTXv3
         0icN06Y/3aB7WrKBa/ZQIixfZirBxk9j6nk4lOmR2YY0akoSSu19fu7JSV25Kv1Gyrez
         QjOALUVuCtwgaWJ4fE2BvRJnb6hSyIX3NaJtucr0T1pnMj5nA8jdYQS9PoYIf+rT1y7I
         cUGkl4bWD8VkxtgtRhKehefFxlnwnl/BzzOaQ9MxKGfpiDfll2rjbpTiDEReeWIrMYq6
         1CzcnZb68Al3RH++5zrTLAyJ80TL04CTAs1LhR6CE4Zsyt/oti16QGjQuNxs1s7XnEra
         crVw==
X-Gm-Message-State: AOAM533gXsa7A6UtZOriMUSy4N5Oj+fSuPF0UTr5uieKoJVrdF3ZCU7v
        UVNrqZBbnnaXd5GImJ8cVNfu+U81PlNJnKGUIbsHXaO5EdNlFA==
X-Google-Smtp-Source: ABdhPJzF5rxX6OUHjiotcRapiD2RkG7bHsp2HuJ5fZGDPasXccrqlA8FxWBntopJ7Rrb4fF5JAPkvKMRINBnBQuqPTc=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr111228lfl.87.1650045586873; Fri, 15 Apr
 2022 10:59:46 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Apr 2022 10:59:35 -0700
Message-ID: <CAKwvOd=_ihOghnaWCmGs3xx1Tyn4qaEpZ1bpXvbGJhjGJR2K-w@mail.gmail.com>
Subject: plumbers session on drgn and GDB+poke?
To:     osandov@fb.com, "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Omar and Jose,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

We'd be curious if you both could lead a session on kernel debugging,
and maybe show off drgn and GNU poke GDB integration?
-- 
Thanks,
~Nick Desaulniers
