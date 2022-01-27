Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3810749E6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbiA0PxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:53:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50362 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbiA0PxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:53:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 779451F3A9;
        Thu, 27 Jan 2022 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643298782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXU4cZ9WW2zkBTqrANOGu3UWjiXuqFw5EYsSQEt8+Gw=;
        b=aVQBXKX1clYr/hkiQ8Tq87+/TQd3kPHWkdjbZOTvUJVEMe0u+EGCp7Wxevz61bymgnYP36
        4gZdDW15wTHQQo/kemfK5Ql3oFilPX6SmbZAS1aDrfcTHMq70rL/gAHyB/Wg4QGcnupXaH
        2OIUtZEmbmbXwRmAddp1feZHEHcKryc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643298782;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXU4cZ9WW2zkBTqrANOGu3UWjiXuqFw5EYsSQEt8+Gw=;
        b=GH2ipUdLCgRkmV/VuhI1iSYsH7YKxM0/e3IR9Dj1mB8J1hqkiqfRgLnqn5KoFdvepiBskP
        qeiMS9t11hcV0PDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA37813BE5;
        Thu, 27 Jan 2022 15:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HBeBN92/8mHTbgAAMHmgww
        (envelope-from <ptesarik@suse.cz>); Thu, 27 Jan 2022 15:53:01 +0000
Message-ID: <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
Date:   Thu, 27 Jan 2022 16:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.cz>
Subject: Re: [RFC PATCH] kdump: Add support for crashkernel=auto
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-GB
In-Reply-To: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu Yang,

I'm afraid the whole concept is broken by design. See below.

Dne 27. 01. 22 v 10:31 Tiezhu Yang napsal(a):
> Set the reserved memory automatically for the crash kernel based on
> architecture.
> 
> Most code of this patch come from:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-8/-/tree/c8s

And that's the problem, I think. The solution might be good for this 
specific OS, but not for others.

>[...]
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6d..32c51e2 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char *cmdline,
>   	if (suffix)
>   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>   				suffix);
> +
> +	if (strncmp(ck_cmdline, "auto", 4) == 0) {
> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> +		ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
> +#elif defined(CONFIG_ARM64)
> +		ck_cmdline = "2G-:448M";
> +#elif defined(CONFIG_PPC64)
> +		char *fadump_cmdline;
> +
> +		fadump_cmdline = get_last_crashkernel(cmdline, "fadump=", NULL);
> +		fadump_cmdline = fadump_cmdline ?
> +				fadump_cmdline + strlen("fadump=") : NULL;
> +		if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) == 0))
> +			ck_cmdline = "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
> +		else
> +			ck_cmdline = "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
> +#endif
> +		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> +	}
> +

How did you even arrive at the above numbers? I've done some research on 
this topic recently (ie. during the last 7 years or so). My x86_64 
system with 8G RAM running openSUSE Leap 15.3 seems needs 188M for 
saving to the local disk, and 203M to save over the network (using 
SFTP). My PPC64 LPAR with 16G RAM running latest Beta of SLES 15 SP4 
needs 587M, i.e. with the above numbers it may run out of memory while 
saving the dump.

Since this is not the first time, I'm trying to explain things, I've 
written a blog post now:

https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel-auto.html

HTH
Petr Tesarik
