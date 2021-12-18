Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C6479A64
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhLRKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:49:48 -0500
Received: from relay029.a.hostedemail.com ([64.99.140.29]:11094 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229480AbhLRKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:49:47 -0500
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id A989421E52;
        Sat, 18 Dec 2021 10:49:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 7B1AB20013;
        Sat, 18 Dec 2021 10:49:40 +0000 (UTC)
Message-ID: <49dbcc338213926850d61faba700241155d04fc1.camel@perches.com>
Subject: Re: [PATCH] usb: fixing some clang warnings inside usb host drivers
From:   Joe Perches <joe@perches.com>
To:     Julio Faracco <jcfaracco@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        axboe@kernel.dk, tglx@linutronix.de, damien.lemoal@wdc.com,
        dkadashev@gmail.com, paul.gortmaker@windriver.com,
        zhouyanjie@wanyeetech.com, niklas.cassel@wdc.com,
        penguin-kernel@i-love.sakura.ne.jp, macro@orcam.me.uk,
        caihuoqing@baidu.com
Date:   Sat, 18 Dec 2021 02:49:41 -0800
In-Reply-To: <20211218042420.28466-1-jcfaracco@gmail.com>
References: <20211218042420.28466-1-jcfaracco@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: x4y5x4m4x7uumopwpzo4ns4fz7ysxtfn
X-Spam-Status: No, score=-0.08
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 7B1AB20013
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Vzuds68ttDLNhXRJLB5d2AvfuT1pzSuo=
X-HE-Tag: 1639824580-479287
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-12-18 at 01:24 -0300, Julio Faracco wrote:
> Clang is reporting some issues related variable values not used and
> other issues inside some USB host drivers. This commit removes some
> trashes and adds some strategies to mitigate those warnings.
[]
> diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
[]
> @@ -903,7 +903,6 @@ static ssize_t fill_registers_buffer(struct debug_buffer *buf)
>  	temp = scnprintf(next, size, "complete %ld unlink %ld\n",
>  		ehci->stats.complete, ehci->stats.unlink);
>  	size -= temp;
> -	next += temp;
>  #endif

I think this should line not be removed as it's a code pattern
repeated multiple times above and another entry could be added
below.


