Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347B04652A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbhLAQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhLAQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:22:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8ABC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 08:19:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 44894CE1FB5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4F2C53FCC;
        Wed,  1 Dec 2021 16:19:23 +0000 (UTC)
Date:   Wed, 1 Dec 2021 11:19:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        zhangyue <zhangyue1@kylinos.cn>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH] kprobes: Limit max data_size of the kretprobe instances
Message-ID: <20211201111922.2c52047d@gandalf.local.home>
In-Reply-To: <163836995040.432120.10322772773821182925.stgit@devnote2>
References: <163836995040.432120.10322772773821182925.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Dec 2021 23:45:50 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> The kretprobe::data_size is unsigned (size_t) but it is
> used as 'data_size + sizeof(struct kretprobe_instance)'.
> Thus, it can be smaller than sizeof(struct kretprobe_instance)
> while allocating memory for the kretprobe_instance.

The above doesn't make sense.

data_size is unsigned but it is used as
 'data_size + sizeof(struct kretprobe_instance)'. 

What does that mean?

What can be smaller than sizeof(struct kretprobe_instance) and why does it
matter?

-- Steve


> 
> To avoid this issue, introduce a max limitation of the
> kretprobe::data_size. 4KB per instance should be OK.
> 
