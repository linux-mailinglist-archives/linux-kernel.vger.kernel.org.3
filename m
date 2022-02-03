Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEA04A88C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352328AbiBCQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:43:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44844 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiBCQnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:43:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5B60CE2055;
        Thu,  3 Feb 2022 16:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C795AC340E8;
        Thu,  3 Feb 2022 16:43:04 +0000 (UTC)
Date:   Thu, 3 Feb 2022 11:43:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 3/8] rtla/osnoise_top: Fix segmentation fault when
 failing to enable -t
Message-ID: <20220203114303.575910f8@gandalf.local.home>
In-Reply-To: <20220203114126.3ec6b37d@gandalf.local.home>
References: <cover.1643033113.git.bristot@kernel.org>
        <3ef9cb911e9b51be55a874cacc847d44bca9877e.1643033113.git.bristot@kernel.org>
        <20220203114126.3ec6b37d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 11:41:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Wouldn't these four patches be more robust if you just initialized record
> (and tool) to NULL, and change osnoise_destroy_tool() to:

And if you do this, it should be one patch, not four.

-- Steve

> 
> void osnoise_destroy_tool(struct osnoise_tool *top)
> {
> 	if (!top)
> 		return;
> 
>         trace_instance_destroy(&top->trace);
> 
>         if (top->context)
>                 osnoise_put_context(top->context);
> 
>         free(top);
> }
> 
> Then you don't need these extra labels and if statements in the main code.
