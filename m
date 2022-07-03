Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418BA564783
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiGCNXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiGCNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:23:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926F63E9;
        Sun,  3 Jul 2022 06:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FEA360B63;
        Sun,  3 Jul 2022 13:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86856C341C6;
        Sun,  3 Jul 2022 13:23:07 +0000 (UTC)
Date:   Sun, 3 Jul 2022 09:23:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703092305.1e5da4c2@rorschach.local.home>
In-Reply-To: <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
        <20220310102413.3438665-10-atomlin@redhat.com>
        <20220628000526.11c57cd8@gandalf.local.home>
        <20220628081906.jln2ombfej5473xi@ava.usersys.com>
        <Yr92YtG12f+II+ea@bombadil.infradead.org>
        <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 09:33:24 +0100
Aaron Tomlin <atomlin@redhat.com> wrote:

> On Fri 2022-07-01 15:34 -0700, Luis Chamberlain wrote:
> > Poke, did you get to implement this yet?  
> 
> Hi Luis, Steve,
> 
> Firstly, apologies for the delay.
> 
> I believe I found the issue:
> 
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 1b0780e20aab..84808706af5c 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -197,7 +197,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
>                             mod->kallsyms->typetab[i];
>                         dst[ndst] = src[i];
>                         dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
> -                       s += strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
> +                       s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
>                                      KSYM_NAME_LEN) + 1;
>                 }
>         }
> 
> That being said, I need to examine the precise differences between each
> implementation; albeit, I believe we can revert this particular change. I
> will send a patch for a wider discussion shortly.
> 
>  - Before
> 
>       $ grep -a -E '^[0-9a-f]{16} [^a-z].*\[virtio_console\]' /proc/kallsyms
>       0000000000000000  notifier_del_vio      [virtio_console]
>       0000000000000000  show_port_name        [virtio_console]
>       0000000000000000  port_debugfs_open     [virtio_console]
> 
>  - After the above modification
> 
>       $ grep -a -E '^[0-9a-f]{16} [^a-z].*\[virtio_console\]' /proc/kallsyms
>       $ grep -a -m 3 -E '^[0-9a-f]{16} [a-z].*\[virtio_console\]' /proc/kallsyms
>       0000000000000000 t notifier_del_vio     [virtio_console]
>       0000000000000000 t show_port_name       [virtio_console]
>       0000000000000000 t port_debugfs_open    [virtio_console]
> 
> 

BTW, *NEVER* modify code that you are moving. Really, *NEVER* do that!

It makes debugging much more difficult, like in this very case.

*ALWAYS* have the moving of code be a separate patch. Keep as most
identical as humanly possible. Even keep white space errors the same!
You can add a clean up patch before or after the move. But never do it
as one patch!

You even stated "no functional change" which was a lie. Converting
strlcpy() to strscpy() *is* a functional change!

-- Steve
