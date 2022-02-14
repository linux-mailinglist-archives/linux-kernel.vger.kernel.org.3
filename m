Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC194B4309
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiBNHfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:35:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiBNHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:35:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29A593BC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:35:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so18078460pjl.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nGe1GPQOn/zt6cMI2xANluZ+cNHKirWlYkwaEjnZGKU=;
        b=nrwkobJvHAbDr7S2N0JO/hkqenpbA+/spa6NGzhqp4A6eEt+nPh5nLx21ewUQmt6Xc
         StkFK3m+h+ANiGoPI97qYW590jbwN5ZIU1j+yJ4M5lRhcNOocjMP4voCWzxVbWSWeIUI
         XKsZD8CJHjd+JeKphGLWWSXoj4t9iG9Nz3GUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nGe1GPQOn/zt6cMI2xANluZ+cNHKirWlYkwaEjnZGKU=;
        b=XpDuHxrwG9esq3+/vr7Zf/EZPosLo+ELQ6NY8/8ZJGGQHYy5RbyEDaM5aTGaCxCFqS
         SKx8Qs1O2QQZpdm1W9KT/7kHSZvP8qB5ou/jfHEngB8SsH3lQDoWERPGoU1RieGcgQq5
         Rbk8io2+1TZUeST8TJH4qRkzmM7v8cA5euyAnTDA3yjQlUr3baq/ng+BgSFihfD6kSGc
         zQzV5GI9VmTuPqScTvoVz8sON+zNQNRGp4tSvVHpvhOpVi6GjfcCnBegYSrLg2Lx7mBr
         zMsSmo6XQ9Ivyi7So8lMTXCfQ7HlAe24MRBcquNeuo+Xjp0S68YPDmI/X/q//dCWt/hR
         njMg==
X-Gm-Message-State: AOAM531G1abuoAPdMmbeR/N4YPxuqnPCS/w5kz4e6Ngk4QInBhFkgZWW
        cVMJVtlwTGKszlWQGoQgjHKLQg==
X-Google-Smtp-Source: ABdhPJyyYgOfAyLKEq2R2MNIU3hhfWNzZUr/ZaIq47tpRHQWx8lI1JUeruJntm3HmwYJQP95vdyDrA==
X-Received: by 2002:a17:902:d502:: with SMTP id b2mr12889818plg.111.1644824123058;
        Sun, 13 Feb 2022 23:35:23 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a3d:6c6e:58a7:8903])
        by smtp.gmail.com with ESMTPSA id p2sm12529972pjo.38.2022.02.13.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:35:22 -0800 (PST)
Date:   Mon, 14 Feb 2022 16:35:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <YgoGNmYER8xni34K@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgaJZtY+EH9JIGyo@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/11 17:05), Petr Mladek wrote:
> On Mon 2022-02-07 20:49:13, John Ogness wrote:
[..]
> The problem is the commit ac25575203c11145066ea ("[PATCH] CPU hotplug
> printk fix"). It suggests that per-CPU data of slab are freed during
> hotplug.
> 
> There are many other things that are manipulated during cpu hotplug.
> And there are the two notifiers "printk:dead" and "printk:online",
> see printk_late_init(). Maybe, we should use them to decide whether
> the non-trivial consoles are callable during CPU hotplug.

Great findings. Looks like we only set __printk_percpu_data_ready to
true and never set it back to false, relying on cpu_online() in such
cases. But here's the thing: we have printk_percpu_data_ready() in
__printk_recursion_counter() and in wake_up_klogd() and in
defer_console_output(), but why we never check __printk_percpu_data_ready
in __down_trylock_console_sem()/__up_console_sem() and more importantly
in console_trylock_spinning() and those do access this_cpu() in printk safe
enter/exit. Am I missing something?
