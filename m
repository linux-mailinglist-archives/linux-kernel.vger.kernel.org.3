Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1036516CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383974AbiEBJJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354638AbiEBJJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42A1965B1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651482366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnxLMDZpimSJvf7sCwd+c/i6sHfHGWF3GvvV71348bQ=;
        b=VBoyU85kIjvg/rJBFLNmH/ldIvNEjvtDDRziXB49FtOS3UNyXW9g1UH9hdkRQzqVfTBQYK
        rAtNJyBuw3Ta3+qJLO1EtnMrS47Vl9yi0ntCr9OFt9oqYj4rjhYbP7ZD2jFuL6rYFv9//R
        TNkIZ/CukHnu/zDyVwqoZokyA9zY06M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-1HEnjXepNDi8fKSdmHrwiw-1; Mon, 02 May 2022 05:06:05 -0400
X-MC-Unique: 1HEnjXepNDi8fKSdmHrwiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E261B800186;
        Mon,  2 May 2022 09:06:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id D8F8914C3018;
        Mon,  2 May 2022 09:06:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 May 2022 11:06:01 +0200 (CEST)
Date:   Mon, 2 May 2022 11:06:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Shuzhi Zu <zushuzhi@h3c.com>
Cc:     brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal/ptrace: Fix the bug of ptrace attach and signal
 handling concurrency
Message-ID: <20220502090559.GA17276@redhat.com>
References: <20220430165556.29739-1-zushuzhi@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220430165556.29739-1-zushuzhi@h3c.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuzhi,

On 05/01, Shuzhi Zu wrote:
>
> Example 1：
>     A                             B
>     get_signal
>     dequeue_signal (SIGCHLD）
>                                   ptrace_attach ( A->ptrace |= PT_PTRACED)
>
>     ptrace_signal
>     ->ptrace_stop(TASK_TRACED)
>                                   ptrace_attach ( Send SIGSTOP to A)
>                                   ptrace_waitpid( return 0)
>                                   ptrace_detach (A->ptrace=0, wakeup A)
>     dequeue_signal(SIGSTOP)
>     sig_kernel_stop(SIGSTOP)
>     do_signal_stop (TASK_STOPPED)
>
> then：
> A (other threads of the process received signal)
> get_signal-> do_signal_stop(0))->TASK_STOPPED

Yes, there are a lot of known problems with send_sig_info(SIGSTOP) in
ptrace_attach(). This one of the reasons for PTRACE_SEIZE which doesn't
abuse SIGSTOP. Please use it instead of PTRACE_ATTACH, PTRACE_SEIZE has
more features.


As for your particular example, this is an application bug. Debugger (if
it uses PTRACE_ATTACH) should not detach until the tracee reports SIGSTOP
sent by PTRACE_ATTACH.

This can lead to other problems, say we can miss a "real" SIGSTOP from
another application, but again PTRACE_ATTACH is hopeless wrt SIGSTOP,
please consider PTRACE_SEIZE.

Oleg.

