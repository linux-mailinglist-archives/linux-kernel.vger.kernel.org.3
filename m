Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709904984B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiAXQ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbiAXQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:26:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB8AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:26:30 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643041587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jooe9jBPXibapFbfnxQ9Av5bLAmMuo5zROFe8iN25sY=;
        b=iFsT4KKmlgDvY2sYKUcXLLyhxqrq1Q7RKdyP39BiRc3sfQgRDuidwLq867y1P5clkBsry1
        00Oigt05jpcHFVOIxHBdzTeq5WBV/vwzcRZX7oMbiyS1lx/Uw3W9lwekXxtBXSyLC60GYz
        aWg+jpQz9K1bk4cRrGOWIyvYjTkzNHwmJ+2ywWUAHwYXGqWXnrBo7PbebH6h+Z9S7FJx3M
        CFyFq++qZitMkmdxD2Yts8QtjK0r7687PzKekQxUa1yA9/qiAQuGlzoTwp4YgBShiRhpOG
        7acPyNAEcttIGD9x9OJ01cgIez44A/J2vs6SeYstU+9r60Ow04i77aP54gzCwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643041587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jooe9jBPXibapFbfnxQ9Av5bLAmMuo5zROFe8iN25sY=;
        b=6dzMQhWUss8oyS0GWwz2l/IXUPpbT8WqibCSs2Oh7xUYiw43zIcmpXnPFE+jF2mIfWF2FX
        6uHGqZAG5Ztl7EDg==
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] printk: Drop console_sem during panic
In-Reply-To: <87pmoh3yf9.fsf@jogness.linutronix.de>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-5-stephen.s.brennan@oracle.com>
 <87pmoh3yf9.fsf@jogness.linutronix.de>
Date:   Mon, 24 Jan 2022 17:32:27 +0106
Message-ID: <87mtjl3xsc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-24, John Ogness <john.ogness@linutronix.de> wrote:
> Something like:
>
> @@ -2731,7 +2731,8 @@ void console_unlock(void)
>  	 * there's a new owner and the console_unlock() from them will do the
>  	 * flush, no worries.
>  	 */
> -	retry = prb_read_valid(prb, next_seq, NULL);
> +	retry = (pcpu != raw_smp_processor_id()) &&
> +		prb_read_valid(prb, next_seq, NULL);
>  	if (retry && console_trylock())
>  		goto again;
>  }

Sorry, that hunk is obviously garbage. I meant something like:

@@ -2731,7 +2731,10 @@ void console_unlock(void)
 	 * there's a new owner and the console_unlock() from them will do the
 	 * flush, no worries.
 	 */
-	retry = prb_read_valid(prb, next_seq, NULL);
+	if (panic_in_progress())
+		retry = (pcpu == raw_smp_processor_id()) && prb_read_valid(prb, next_seq, NULL);
+	else
+		retry = prb_read_valid(prb, next_seq, NULL);
 	if (retry && console_trylock())
 		goto again;
 }

I'm sure there is a cleaner way to code that.

John
