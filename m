Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A44900AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiAQED5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:03:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45760 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiAQEDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:03:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BD85CE0B80
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6525FC36AE3;
        Mon, 17 Jan 2022 04:03:49 +0000 (UTC)
Subject: Re: [PATCH v2 RESEND] m68k/kernel: array out of bound access in
 process_uboot_commandline
To:     Hangyu Hua <hbh25y@gmail.com>, geert@linux-m68k.org
Cc:     schwab@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
References: <20220113015854.9326-1-hbh25y@gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <95d91f5f-c5e1-0750-ebb9-b6839aecdc7c@linux-m68k.org>
Date:   Mon, 17 Jan 2022 14:03:45 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113015854.9326-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

On 13/1/22 11:58 am, Hangyu Hua wrote:
> When the size of commandp >= size, array out of bound write occurs because
> len == 0.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   arch/m68k/kernel/uboot.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
> index 928dbd33fc4a..63eaf3c3ddcd 100644
> --- a/arch/m68k/kernel/uboot.c
> +++ b/arch/m68k/kernel/uboot.c
> @@ -101,5 +101,6 @@ __init void process_uboot_commandline(char *commandp, int size)
>   	}
>   
>   	parse_uboot_commandline(commandp, len);
> -	commandp[len - 1] = 0;
> +	if (len > 0)
> +		commandp[len - 1] = 0;
>   }
> 

I am not convinced this is wrong for the reason you think it is.
Looking at the code in its entirety:

__init void process_uboot_commandline(char *commandp, int size)
{
         int len, n;

         n = strnlen(commandp, size);
         commandp += n;
         len = size - n;
         if (len) {
                 /* Add the whitespace separator */
                 *commandp++ = ' ';
                 len--;
         }

         parse_uboot_commandline(commandp, len);
         commandp[len - 1] = 0;
}


"commandp" is moved based on the return of the strnlen(). So in the
case of commandp actually being full of valid characters (so n == size,
and thus len == 0) the commandp technically points outside of its
real size at that point. But "command[[len - 1]" would actually be
pointing to the last char in the original commandp array (so the original
commandp[size - 1]). Well at least if you are happy with the use of
negative array indexes.

Clearly this could be structured better. There is no point in calling
parse_uboot_commandline() if len == 0, or even if len == 1, since you
cannot add anymore to the command line, it is full.

Regards
Greg
