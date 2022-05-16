Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558CD5292B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbiEPVN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349416AbiEPVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:12:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7C1025
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E15AB61507
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB3C385AA;
        Mon, 16 May 2022 21:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652735181;
        bh=Ft3I/yXXzukonb8keZt04JE4bLkRTsLc5hGPoDdn4Uo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zAjekkEBLgFVfxbiE2VjdxIw5F6h8LoiroA17MJAXyoKI72CH2w/B8BBqaxVdZ/fV
         Q/onCdq0E18mMzNhf2atxs14Lfrs8u7VtNX+ngILufMAl83aQy/5bZmIT/7BTgR2CF
         ewe38DwQI09Y1VLQ6Y9bWXWlfi2KPAYZxvwrIwu4=
Date:   Mon, 16 May 2022 14:06:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Maxim Zhukov <crazycdeveloper@gmail.com>
Cc:     chi.minghao@zte.com.cn, varad.gautam@suse.com, arnd@arndb.de,
        shakeelb@google.com, vasily.averin@linux.dev,
        manfred@colorfullife.com, dbueso@suse.de,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: Re: [RFC PATCH 1/1] ipc, sem: fix backward compatibility with
 x86-32 kernels
Message-Id: <20220516140620.85f84d560c85d01d48dae917@linux-foundation.org>
In-Reply-To: <20220515200103.1408370-2-mussitantesmortem@gmail.com>
References: <20220515200103.1408370-1-mussitantesmortem@gmail.com>
        <20220515200103.1408370-2-mussitantesmortem@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2022 23:01:03 +0300 Maxim Zhukov <crazycdeveloper@gmail.com> wrote:

> Since with commit 275f22148e87 ("ipc: rename old-style shmctl/semctl/msgctl syscalls")
> we have changed behavior:
> 
> ksys_semctl lost parse ipc version (ipc_parse_version), because the
> new syscall works with IPC_64 only, but the parse function has some
> side effect - it removes IPC_64 bit from `cmd`.
> 
> Some libc forced sends IPC_64 bit in semctl syscall[1][2][3], this leads to
> a bug - X86-32 kernel does not have compat headers and does not
> correctly parse received command (cmd) from semctl syscall: cmd have actual
> command and IPC_64 bit, thus throw EINVAL error in ksys_semctl
> 
> This commit forcibly removes IPC_64 bit from the cmd for restore
> backward compatibility.
> 
> [1]: https://elixir.bootlin.com/uclibc-ng/v1.0.40/source/libc/misc/sysvipc/sem.c#L58
> [2]: https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/semctl.c#L48 -> https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/ipc.h#L22
> [3]: https://elixir.bootlin.com/glibc/glibc-2.35/source/sysdeps/unix/sysv/linux/semctl.c#L124
> 

Thanks.

275f22148e87 was three years ago.  Can you suggest why it took so long
for this to be discovered?
