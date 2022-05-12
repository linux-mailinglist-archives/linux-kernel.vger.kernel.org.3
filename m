Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3F525566
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357920AbiELTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357906AbiELTLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:11:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECAE3915C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:11:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ch13so12037195ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLT11SGZSlspM3ztqa+Z4xJFeyllWtbNbH4XI/ki7KQ=;
        b=Akos8r1uW3mKq93eO2Gh+RThomTvKQVXEIPNJLgU4e/OsWiyliXUyDvXM1KCZowBG5
         iB8r5GxgdwJONwg8JLTbxiugmdxYSNQ3UZHr+t/+uKRqH4lkyjc4uv95+s+5+nQlfzSG
         6pdmK4AOO1sJl6dZGjA/eOhr2a7EqbPThcB8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLT11SGZSlspM3ztqa+Z4xJFeyllWtbNbH4XI/ki7KQ=;
        b=3kg1p7Kn0vfiO7Ys+V1WPmTt4dsgL1M6Qwf6aMTTt2OL8bTcGsRbSi4nNUsZ3WOr2B
         1rjM8vdd1LmKSgPjsxue+5gKbOmBT4ww1XJilCSLebxzSqJZnFTm66/Wv0ZMEEsM0JBi
         +XHo9+BznWvomlCLM8AzcRB5vSOQMuST+ILj8CoCpDNchViM82yIqtV3rD0/Lwc29evF
         5uIXPoKuum2RB9uyANx9IsBk9mtQfGfGE0J9AooSgF/2nvwPr04sDOdvRYAPcoEWDBTS
         ixNPGxnffkrAn0EQzkWmtDRER0KOxIWQJ5I0Zd6k5/+HgT7WvDpVBs8r412t6FL1OVlS
         AkUQ==
X-Gm-Message-State: AOAM530oHRym90pWIECXqNi+xXMqvYfDZe0NUlFq+qETKxoW+xHUOVuG
        7m3+VhfU+XURsiFONQutCqqjFsEFMBtDOlZTu/c=
X-Google-Smtp-Source: ABdhPJwSbUSyhpB/7pv3MC68HiBaX8TYqh4f+VuEUlFhsFphHpZfuxcVfzfVW2TLqf30q8YCZmaQDw==
X-Received: by 2002:a17:907:3f8c:b0:6fa:8b15:66fe with SMTP id hr12-20020a1709073f8c00b006fa8b1566femr1264444ejc.142.1652382674266;
        Thu, 12 May 2022 12:11:14 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id p8-20020aa7cc88000000b0042617ba63d6sm33506edt.96.2022.05.12.12.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 12:11:12 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso5709023wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:11:12 -0700 (PDT)
X-Received: by 2002:a1c:4c06:0:b0:394:65c4:bd03 with SMTP id
 z6-20020a1c4c06000000b0039465c4bd03mr1229662wmf.8.1652382672075; Thu, 12 May
 2022 12:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFRbGmGr2Z_sbYmE0SZT48CFkNAWVABnC_4V6x9PzZw-LJO4w@mail.gmail.com>
In-Reply-To: <CAOFRbGmGr2Z_sbYmE0SZT48CFkNAWVABnC_4V6x9PzZw-LJO4w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 May 2022 12:10:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5E-xdc5P6SfN-ey6zvVri43rTj0g8kjUBWD3hhE-jiw@mail.gmail.com>
Message-ID: <CAHk-=wh5E-xdc5P6SfN-ey6zvVri43rTj0g8kjUBWD3hhE-jiw@mail.gmail.com>
Subject: Re: ERROR: drivers: iscsi: iscsi_target.c
To:     Test Bot <zgrieee@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>
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

On Thu, May 12, 2022 at 11:42 AM Test Bot <zgrieee@gmail.com> wrote:
>
> void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
> {
>         int ord, cpu;
>         cpumask_t conn_allowed_cpumask;

Yeah, that's not how you are supposed to use 'cpumask_t'

This is why we have CONFIG_CPUMASK_OFFSTACK and 'cpumask_var_t', so
that the pattern is

        cpumask_var_t mask;

        if (!alloc_cpumask_var(&mask, GFP_KERNEL))
                return -ENOMEM;
        ... use 'mask' here as a  ...
        free_cpumask_var(mask);

and if the cpumask is small, it's allocated on the stack (and that
'alloc_cpumask_var()' becomes a no-op) and if it's huge, it has a real
allocation so that the stack frame doesn't grow too big.

The problem seems to have been introduced in this merge window by
commit d72d827f2f26 ("scsi: target: Add iscsi/cpus_allowed_list in
configfs"), but I didn't really look any closer than a plain "git
blame", so it might have happened before that too.

I also didn't check whether there was some explicit reason why the
code couldn't allocate the cpumask this way.

Btw, it's worth noting that 'cpumask_t' is always the full static
compile-time NR_CPUS bits in size, but a dynamically allocated
'cpumask_var_t' is only nr_cpumask_bits in size (ie the actual maximum
on that machine, as opposed to the theoretical maximum size). So they
are *not* exactly the same kind of 'cpumask_t' pointer in the end, but
no sane code should care (ie you have to do something else wrong for
the alloc_cpumask_var() pattern to not work).

           Linus
