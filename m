Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1945507B5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiFSAbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 20:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiFSAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:30:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C2B1D9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=lLxnm06YU/KD4+hvWKrGE9860wPKXqoTSVyTdvAai+g=; b=KR6KabbISHDmsGDqgJ2jeL/RIZ
        oQhAD+S77lfaHzFIWOs9hFugqWcvT/TGlb6l42Xb+hpLfSp+Y0qmegUSLaUbYQTRxJb2jKv11fQyK
        cCkNu8rO8C2JkIz/69A748GJrbqFSw7DK18ByC2k2bhGfuHVoX/15MYZDvjlb9/C1lAMOEUec2IC5
        9CrlwKVeDYHnHV4T8MhZgAVy930gzie483Qa6sofH6dX5f6SPtwCg3TafhGH0x1eGM9L3PDRLf9K4
        CAPJK6T9JU+Jw7wi2ne2vHgzoGH7Lz/P1S4w35rB+GMRxNartTw74zY9hA3tiF+gj6VQKzWCz16WW
        pm5cVgmw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2iq0-0094OU-J5; Sun, 19 Jun 2022 00:30:49 +0000
Message-ID: <f1eb20d1-6762-dc82-058a-cf27936bc0c6@infradead.org>
Date:   Sat, 18 Jun 2022 17:30:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] printk: allow direct console printing to be enabled
 always
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org
References: <YqyDqMAPHIxjA/xZ@zx2c4.com>
 <20220617133847.27517-1-Jason@zx2c4.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220617133847.27517-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/22 06:38, Jason A. Donenfeld wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 8090130b544b..a960c47a2002 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4389,6 +4389,14 @@
>  	printk.time=	Show timing data prefixed to each printk message line
>  			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
>  
> +	printk.always_direct=
> +			Rather than using kthreads for printk output, always
> +			write to the console immediately. This has performance
> +			implications, but will result in a more faithful
> +			ordering and interleaving with other processes writing
> +			to the console.
> +			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)

or:

+			Format: <bool>  (1/Y/y/T/t/on=enable, 0/N/n/F/f/off=disable)

-- 
~Randy
