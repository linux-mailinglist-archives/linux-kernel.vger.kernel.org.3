Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B655E6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346642AbiF1PYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346971AbiF1PYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D02DAA3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE7761553
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F88C341CD;
        Tue, 28 Jun 2022 15:24:44 +0000 (UTC)
Date:   Tue, 28 Jun 2022 11:24:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220628112442.2b530c3b@gandalf.local.home>
In-Reply-To: <25C37F40-7D8E-41C6-961F-0774C8138CCB@oracle.com>
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
        <20220627131140.56761db9@gandalf.local.home>
        <25C37F40-7D8E-41C6-961F-0774C8138CCB@oracle.com>
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

On Mon, 27 Jun 2022 17:19:18 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > The symbol lookup problem still exists. What about the get_sockaddr() not
> > processing?  
> 
> "trace-cmd report" no longer produces the get_sockaddr warning messages,
> but tracepoints that use __get_sockaddr() still FAIL TO PARSE on my
> system:
> 
>             nfsd-1167  [005]   117.853235: nfsd_cb_probe:        [FAILED TO PARSE] state=0x1 cl_boot=1656349219 cl_id=3054917767 addr=ARRAY[02, 00, 00, 00, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
>    kworker/u24:2-985   [003]   117.853368: nfsd_cb_setup:        [FAILED TO PARSE] cl_boot=1656349219 cl_id=3054917767 authflavor=0x1 addr=ARRAY[02, 00, 00, 00, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00] netid=rdma
>    kworker/u24:2-985   [003]   117.853370: nfsd_cb_state:        [FAILED TO PARSE] state=0x0 cl_boot=1656349219 cl_id=3054917767 addr=ARRAY[02, 00, 00, 00, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
> 

I remember writing a patch to fix this, but it looks to never have been
applied. And worse yet, I can't find it :-/

Oh well, I guess I just need to write it again.

-- Steve
