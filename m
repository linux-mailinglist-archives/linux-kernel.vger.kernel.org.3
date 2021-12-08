Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9492A46CDF7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbhLHHDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:03:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38210 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhLHHDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:03:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75AFCB81F37;
        Wed,  8 Dec 2021 07:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE28C00446;
        Wed,  8 Dec 2021 07:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638946818;
        bh=Zo58PVhiAUB7WB93jNy6jtP1aFNBJALKU2W846/Rl1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZcNvoAeQS8zNbQTu9LT03ABs+QaZ5hQBQbes9DRkHueVIBd7OvkspMkX8tIQEfTJz
         aZ2NUkBCopYxBoJ9GzfVbZYQDLFKuzY9Mn0qkqUFmh9jYz+BzX/TsEOiTBR/1SQIJY
         Tjlhj15LRpL8QVKAljZds4bM5Z5cXtdU9aWysvaU=
Date:   Wed, 8 Dec 2021 08:00:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, quic_eberman@quicinc.com,
        quic_tsoni@quicinc.com,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [RESEND PATCHv2] tty: hvc: dcc: Bind driver to core0 for reads
 and writes
Message-ID: <YbBX+cLRhJ5T+hBq@kroah.com>
References: <20211208063847.27174-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208063847.27174-1-quic_saipraka@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:08:47PM +0530, Sai Prakash Ranjan wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
> reads/writes from/to DCC on secondary cores. Each core has its
> own DCC device registers, so when a core reads or writes from/to DCC,
> it only accesses its own DCC device. Since kernel code can run on
> any core, every time the kernel wants to write to the console, it
> might write to a different DCC.
> 
> In SMP mode, Trace32 creates multiple windows, and each window shows
> the DCC output only from that core's DCC. The result is that console
> output is either lost or scattered across windows.
> 
> Selecting this option will enable code that serializes all console
> input and output to core 0. The DCC driver will create input and
> output FIFOs that all cores will use. Reads and writes from/to DCC
> are handled by a workqueue that runs only core 0.
> 
> Link: https://lore.kernel.org/lkml/1435344756-20901-1-git-send-email-timur@codeaurora.org/
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Acked-by: Adam Wallis <awallis@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
> 
> Resending this v2 since earlier one had a typo in the variable type.
> 
> Changes in v2:
>  * Checkpatch warning fixes.
>  * Use of IS_ENABLED macros instead of ifdefs.
> 
> I also thought of making it depends on !HOTPLUG_CPU since it is broken
> in case core0 is hotplugged off, but apparently HOTPLUG_CPU kconfig
> has weird dependency issues, i.e., gets selected by CONFIG_PM and others.
> So it will be almost like this feature won't be selectable at all if
> I add !HOTPLUG_CPU kconfig dependency. Also HVC_DCC is a debug feature
> where we need Trace32 like tools to access DCC windows in which case
> these shortcomings can be expected since manual intervention is required
> anyways for attaching a core to Trace32, so it won't matter much.

But your code will break on systems when cpu 0 goes away, so this isn't
going to work well at all.  Please make this work for any cpu or handle
the case when the cpu it is running on goes away.

Also, this REALLY looks like you are trying to fix the kernel for a
crazy userspace program.  Why not fix the userspace program instead?
Isn't that easier and then that way it will work for any kernel version?

thanks,

greg k-h
