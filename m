Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD84D0221
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiCGOzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiCGOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:55:01 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374533D1E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:54:06 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id w16so31432997ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1WW1TaJS+R8/CyGn5dq8FOoX+ZDKxtLG1Fh/dCABbw=;
        b=FhkZ4/WpTnc8WX8BdBf3A2KfyqgP+eyKWdgYbI4cn4KKfBIVBI6JvibY0Y3wHXx0IY
         eFw7D3ORnsPtom9KsLZGqLnSn9vAheD5PyQAEQJ1jOcXZWN6CgE58of/2SKgLjno9gni
         IK7TC7LASiQ2swXGLFK8H1sNwextoNOKgsctgFK1/YmoVorATnVcFywLGwq88ju5ABFd
         w8fwC/eolIPlH/V8S9IBaua46loZRQ2WSU2OlE+s00N3mUXmPyn1D4X6mbJVX8QUKOCJ
         hxpD8GnWHmdQ95Kv2R+dfjLgUYgM/wfaaSl1OtAuCEU3hBnERLJJFjveyLNPvawCa82B
         fugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1WW1TaJS+R8/CyGn5dq8FOoX+ZDKxtLG1Fh/dCABbw=;
        b=tj0Rm5lYt7YjkHtY40FE+gP2eK2DJh59sqJiWZwFqLXyaxrq9AEuRLTPX6W+phBdgP
         qIlPv3scNYkKej90+c4JDTp2cWUwMGuCKgApSryj5isqxmUM9U6r27OUazxDqh8RhDTz
         fX4A8+SFrXVIbxr5yaxLmYdMy4EE3f/CVtul5dB9w/kNsnIuycSlKnk6uil8kTPUjDYm
         hAKegzIeskFE6m8iciSjNOCKPMpkIoFZp1A3m3UU/LkERZtE0JLHhKGwS0ekbFjQLJ31
         T9aifKgFuPMB2mOvu6Ynde0gQL1xpkibR2hM6yf11+KR8j44JP4Pk51BFCpTtWyT+SDy
         CGmw==
X-Gm-Message-State: AOAM530R0BC/ndYw34IeduEHmiUdYOK71sT+OdRjBmNJpdaBbL6D5sP1
        XIsXJkhsmeux8epCg07HfW+0mhv5jzXteIUP/DHhhWYfg9d7WtSh
X-Google-Smtp-Source: ABdhPJx60j6e4OtHJLPtpBdJUHURmQYxFIJqwFDtevnuyBDts8+DdryKfSwXyn+tcqkYlaLRCnv6yGfLLVu3oNWRoCE=
X-Received: by 2002:a5b:1c5:0:b0:628:d711:7245 with SMTP id
 f5-20020a5b01c5000000b00628d7117245mr8124977ybp.376.1646664845476; Mon, 07
 Mar 2022 06:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
 <20220303035434.20471-4-jiangshanlai@gmail.com> <YiCCYrhr8zZ7Kd86@hirez.programming.kicks-ass.net>
In-Reply-To: <YiCCYrhr8zZ7Kd86@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 7 Mar 2022 22:53:53 +0800
Message-ID: <CAJhGHyBdQ4nz5zg3RS11QfUKY=gUJx8G5nuYKOfzuycrDeQ3Tw@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 4:55 PM Peter Zijlstra <peterz@infradead.org> wrote:

>
> And also, IIUC, folding that int80 thing a few patches down, right?

I don't think folding that int80 thing into idtentry requires this patch.

I didn't notice int80 is a huge ASM code in a different file until I finished
converting the entry code to C code.  So folding int80 thing is a patch later.

It is possible to move this patch of folding int80 thing as the first patch,
but several patches need to be updated respectively.  But I'm afraid of
updating ASM code without good reason which requires several days of
debugging even if there is a slight mistake, for example, forgetting to
update the offset of the stack or register name when switching two lines
of code.
