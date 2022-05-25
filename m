Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8340533656
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiEYFSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiEYFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:18:18 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93991D337
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:18:16 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2BE4A40D403D;
        Wed, 25 May 2022 05:18:11 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 25 May 2022 08:18:11 +0300
From:   baskov@ispras.ru
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] x86: Add strlcat() to compressed kernel
In-Reply-To: <YnzrO8O4Q66SFED0@zn.tnic>
References: <20220505103224.21667-1-baskov@ispras.ru>
 <20220505103224.21667-2-baskov@ispras.ru> <YnzrO8O4Q66SFED0@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <cf76c29a662b8c31b155db305b0e1736@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delayed reply.

On 2022-05-12 14:10, Borislav Petkov wrote:
> On Thu, May 05, 2022 at 01:32:23PM +0300, Baskov Evgeniy wrote:
>> Subject: Re: [PATCH v3 1/2] x86: Add strlcat() to compressed kernel
> 
> The tip tree preferred format for patch subject prefixes is
> 'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
> 'genirq/core:'. Please do not use file names or complete file paths as
> prefix. 'git log path/to/file' should give you a reasonable hint in 
> most
> cases.
> 
> The condensed patch description in the subject line should start with a
> uppercase letter and should be written in imperative tone.
> 
> In your case, that would be x86/boot: Add...

Thank you, I'll fix that in v4.

> 
> You can add the BUG_ON() check from the kernel proper version like 
> this:
> 
> diff --git a/arch/x86/boot/compressed/string.c
> b/arch/x86/boot/compressed/string.c
> index b0635539b6f6..643fcd957527 100644
> --- a/arch/x86/boot/compressed/string.c
> +++ b/arch/x86/boot/compressed/string.c
> @@ -46,6 +46,10 @@ size_t strlcat(char *dest, const char *src, size_t 
> count)
>  	size_t len = strlen(src);
>  	size_t res = dsize + len;
> 
> +        /* This would be a bug */
> +        if (dsize >= count)
> +		error("strlcat(): destination too big\n");
> +
>  	dest += dsize;
>  	count -= dsize;
>  	if (len >= count)
> diff --git a/arch/x86/purgatory/purgatory.c 
> b/arch/x86/purgatory/purgatory.c
> index 7558139920f8..65f0cedb65ae 100644
> --- a/arch/x86/purgatory/purgatory.c
> +++ b/arch/x86/purgatory/purgatory.c
> @@ -57,3 +57,4 @@ void purgatory(void)
>   * arch/x86/boot/compressed/string.c
>   */
>  void warn(const char *msg) {}
> +void error(char *m) {}

Ok, will do.
