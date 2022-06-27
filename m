Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2955D169
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiF0RLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiF0RLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:11:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890A13DD1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBBA0B818E3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03066C3411D;
        Mon, 27 Jun 2022 17:11:41 +0000 (UTC)
Date:   Mon, 27 Jun 2022 13:11:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220627131140.56761db9@gandalf.local.home>
In-Reply-To: <308F6A3B-1FB9-42CD-8239-12B0FD0F5FDB@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
        <20220616113400.15335d91@gandalf.local.home>
        <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
        <20220617155019.373adda7@gandalf.local.home>
        <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
        <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
        <20220624190819.59df11d3@rorschach.local.home>
        <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
        <20220625134552.08c1a23a@rorschach.local.home>
        <0bf1d366-348c-0f91-8f0a-fc9cc6228783@kernel.org>
        <12417afa-331b-e0f6-a3b0-19623e38590b@eaglescrag.net>
        <308F6A3B-1FB9-42CD-8239-12B0FD0F5FDB@oracle.com>
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

On Mon, 27 Jun 2022 17:08:03 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> Updated from your copr repo. The problem persists.

The symbol lookup problem still exists. What about the get_sockaddr() not
processing?

Would you be able to send me a trace.dat file that has this issue?

Thanks,

-- Steve

> 
> [root@manet ~]# trace-cmd version
> 
> trace-cmd version 3.1.1 (not-a-git-repo)
> 
> usage:
>   trace-cmd [COMMAND] ...
> 
>   commands:
>      record - record a trace into a trace.dat file
>      set - set a ftrace configuration parameter
> 
>   ...
> 
>      dump - read out the meta data from a trace file
>      convert - convert trace file to different version
> 
> [root@manet ~]# ls -l /usr/lib64/libtrace*
> lrwxrwxrwx 1 root root     20 Jul 22  2021 /usr/lib64/libtracecmd.so.1 -> libtracecmd.so.1.0.0
> -rwxr-xr-x 1 root root 142032 Jul 22  2021 /usr/lib64/libtracecmd.so.1.0.0
> lrwxrwxrwx 1 root root     22 Jun 25 14:28 /usr/lib64/libtraceevent.so.1 -> libtraceevent.so.1.6.1
> -rwxr-xr-x 1 root root 153944 Jun 25 14:29 /usr/lib64/libtraceevent.so.1.6.1
> lrwxrwxrwx 1 root root     19 Jun 25 17:53 /usr/lib64/libtracefs.so.1 -> libtracefs.so.1.4.1
> -rwxr-xr-x 1 root root 133384 Jun 25 17:53 /usr/lib64/libtracefs.so.1.4.1
> [root@manet ~]#
