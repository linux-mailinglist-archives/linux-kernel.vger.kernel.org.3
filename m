Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91849E2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiA0MqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiA0MqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:46:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C09C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:46:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0CDEB82234
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E47C340E4;
        Thu, 27 Jan 2022 12:46:02 +0000 (UTC)
Date:   Thu, 27 Jan 2022 07:46:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        keescook@chromium.org
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
Message-ID: <20220127074601.41a3773d@rorschach.local.home>
In-Reply-To: <YfKPmFJ2MGsem4VB@FVFF77S0Q05N>
References: <944D10DA-8200-4BA9-8D0A-3BED9AA99F82@linux.ibm.com>
        <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com>
        <20220124114548.30241947@gandalf.local.home>
        <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
        <YfFclROd+0/61q2d@FVFF77S0Q05N>
        <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
        <yt9dy231gzae.fsf@linux.ibm.com>
        <YfKPmFJ2MGsem4VB@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 12:27:04 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Ah, so those non-ELF relocations for the mcount_loc table just mean "apply the
> KASLR offset here", which is equivalent for all entries.
> 
> That makes sense, thanks!

And this is why we were having such a hard time understanding each other ;-)

I started a new project called "shelf", which is a shell interface to
read ELF files (Shelf on a ELF!).

It uses my ccli library:

   https://github.com/rostedt/libccli

and can be found here:

   https://github.com/rostedt/shelf

Build and install the latest libccli and then build this with just
"make".

  $ shelf vmlinux

and then you can see what is stored in the mcount location:

  shelf> dump symbol __start_mcount_loc - __stop_mcount_loc

I plan on adding more to include the REL and RELA sections and show how
they affect symbols and such.

Feel free to contribute too ;-)

-- Steve
