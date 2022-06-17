Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9A54F660
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381909AbiFQLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381744AbiFQLJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:09:05 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D0D6C557
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:09:04 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id r12so3747036vsg.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iIEeHvBevRYx5KHGWEwipfYQCoE5aCyjLy4vD88fcbo=;
        b=d0BqO6jBx7MutG6zvxgG2JmgODDAHDAeCBF0YIyl66fjeAA35Iw6j0wz8I7ySubg0x
         ERihgcoAK/3tZXHnNLS4uq/EmODS0C8r9CRmJ34p1FLblp4RvKmK9jsYKNL/dxbVjfQg
         ZeCOX6qJkiNS9TCuUltTiizUeaXp29/QSv+Ny0nnXTIdVE56BoDEZmmpzX9/GDjjmAjC
         Dr/6XoqmKktN0GtUAyl5iWSVkZai3S0Y6jjguOlKyIXmdwmhMu0/4BtSbJ9TFf1HYEBH
         uXN266rusJwlrGuAFlUqtwHOp8ugV8DO/Ow4zUvzdBpQ9Y1M2T2G6YYOxVOZEnBUyMPt
         wjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iIEeHvBevRYx5KHGWEwipfYQCoE5aCyjLy4vD88fcbo=;
        b=6YeSeVd/XjAv8Rs1V2/CeMIzaBEV3TJDf0wEtvA0jRWhnM+PQ0N8PgSM1rs5lc3tf/
         zsG58GS9iorNSmu91TavP6hqPNViCP7XVCX2TBMDFZMIiy6TqN6vhEK0VbkPPekk+H3K
         uS85e6FvO/sSnhjpN+C6ro3+yiDVe1tZrjtYnJ+49WmbyxyISrABNHuYkqtjeaBVWwTS
         0Alpxx3wCHinLQGMzthGe34Wwmo9JDCEAlhTY5pYGJBFt8uKeCHomcQsDabS1wHDC9Tk
         +U7v1GcEhcGpKa/gdkR7h0Bs5BxQET3XHkBCeOhSIzX8Vd8nqCreFtkqjdHASbFPdZgB
         1duw==
X-Gm-Message-State: AJIora+EQHZMwUMKE1okgAfztY5l78X4Cz0Osxcu8VxiPzuaNJ+CdkfI
        BW1Z8o6rwb/42I4dCC5gGarepvVFnZRTWvGUDSySUQ==
X-Google-Smtp-Source: AGRyM1s+HZ+wmktJSd1qw0a1Y/fQutOX1arYz/VAV7ymqfu7MND0PP6mt1+DLEuWU0eqpBSLGzr+ljGrJ/bGmCcXyeg=
X-Received: by 2002:a05:6102:30ab:b0:349:eab0:fda1 with SMTP id
 y11-20020a05610230ab00b00349eab0fda1mr3829487vsd.14.1655464143892; Fri, 17
 Jun 2022 04:09:03 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 17 Jun 2022 14:08:52 +0300
Message-ID: <CABPqkBRVF9qmxKFgmjZpzN3tx=U+_8udECMLHs7BrtzfPwmuhQ@mail.gmail.com>
Subject: [RFC] pr_warn_once() issue in x86 MSR extable code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, jpoimboe@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>
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

Hi,

Some changes to the way invalid MSR accesses are reported by the kernel is
causing some problems with messages printed on the console.

We have seen several cases of ex_handler_msr() printing invalid MSR
accesses once but
the callstack multiple times causing confusion on the console.

The last time the exception MSR code was modified (5.16) by PeterZ was:

  d52a7344bdfa x86/msr: Remove .fixup usage:

  if (!safe && wrmsr &&  pr_warn_once("unchecked MSR access error: ..."))
               show_stack_regs(regs);

Note that this code pattern was also present, though in a different
form, before this commit.

The problem here is that another earlier commit (5.13):

a358f40600b3 once: implement DO_ONCE_LITE for non-fast-path "do once"
functionality

Modifies all the pr_*_once() calls to always return true claiming that
no caller is ever
checking the return value of the functions.

This is why we are seeing the callstack printed without the associated
printk() msg.

I believe that having the pr_*_once() functions return true the first
time they are called
is useful especially when extra information, such as callstack, must
be printed to help
track the origin of the problem.

The exception handling code seems to be the only place where the
return value is checked
for pr_warn_once(). A minimal change would be to create another
version of that function
that calls DO_ONCE() instead of DO_ONCE_LITE(), e.g., pr_warn_once_return().

I can post a patch to that effect if we all agree on the approach.

Thanks.
