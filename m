Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BE48E9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiANMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:33:27 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:39980 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiANMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/NvGTibXKnDsobyXNWko6aneOg6oKQpNQdSX+maUGS0=; b=VtEhyN8jX/pu8u7XlPDcOAwwbb
        hEwciKWEP03f0Bnfwjvjgy1ZSmxuVWPymR9QxTdEcaPgw4+0A4qi1iAUhF+yllEB9C0L86iSNOzZX
        0Q2lQ28I8f5rhqGBwcD4gfCVlgp205pOJdCairG2Wl8J92aJC9OZPkfgK4suf218JikyRsMba7Mpo
        gjMLNjcuphDN6RKC2+X23be8CV7URHGQVQ80+WcxSF0J4XXu3CF+OxQLRUfq1y9pTLOSm35Jw7Mb3
        U2Xxa77VIdVA72BoxEA0fAarhT3Jn7YUk3zQ1VLvcXTM0+jExIy/Y1ogHMEIfCCdg2VKcKL4pFcUi
        sqBoSRZQ==;
Received: from [177.215.76.11] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n8Llg-0003p1-Kr; Fri, 14 Jan 2022 13:33:21 +0100
Message-ID: <811109b0-ada6-83b4-6d6d-b26b156d279d@igalia.com>
Date:   Fri, 14 Jan 2022 09:32:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V2] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley> <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
 <YeA1pXz7f0wqSnah@alley> <f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com>
 <20220114122651.GB17817@pathway.suse.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220114122651.GB17817@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 09:26, Petr Mladek wrote:
> [...]
> I see. OK, it makes sense to call it after the panic notifiers when
> they are used. It would be nice to mention the above in the commit
> message and explain why the 2nd call is there.
> 
> Just an idea. It might be better to move the 1st call below
> if (!_crash_kexec_post_notifiers). It would make it more
> clear that it is intended for this code path. I mean:
> 
> 	if (!_crash_kexec_post_notifiers) {
> 		/* ... */
> 		if (kexec_crash_loaded())
> 			panic_print_sys_info(false);
> 
> 		__crash_kexec(NULL);
> 	...
> 
> Best Regards,
> Petr

Perfect Petr, thanks again for the very good ideas! I'll work on V3 and
submit today.
Cheers,


Guilherme
