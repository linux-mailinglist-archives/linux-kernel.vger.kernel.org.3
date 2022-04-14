Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274FC500AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbiDNKVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiDNKVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:21:31 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4771EDE;
        Thu, 14 Apr 2022 03:19:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VA25ZSb_1649931543;
Received: from 192.168.193.180(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0VA25ZSb_1649931543)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Apr 2022 18:19:03 +0800
Message-ID: <f7a5642f-bfcb-865d-7039-d0b9d62a3360@linux.alibaba.com>
Date:   Thu, 14 Apr 2022 03:19:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220413213917.711770-1-keescook@chromium.org>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <20220413213917.711770-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kees,
Thanks for the rewrite. I tested this patch, and it works fine for
me except for a few minor comments below :)

On 4/13/22 14:39, Kees Cook wrote:
> +/* The ultimate ROP gadget. */
> +static noinline __no_ret_protection
> +void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
> +{
> +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> +
> +	/* Make sure we've found the right place on the stack before writing it. */
> +	if(*ret_addr == expected)
> +		*ret_addr = (addr);
> +	else
> +		/* Check architecture, stack layout, or compiler behavior... */
> +		pr_warn("Eek: return address mismatch! %px != %px\n",
> +			*ret_addr, addr);
> +}
> +
> +static noinline
> +void set_return_addr(unsigned long *expected, unsigned long *addr)
> +{
> +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> +
> +	/* Make sure we've found the right place on the stack before writing it. */
> +	if(*ret_addr == expected)
> +		*ret_addr = (addr);

When PAC is enabled, I get a mismatch as follows:

/kselftest_install/lkdtm # ./CFI_BACKWARD.sh
[  182.120133] lkdtm: Performing direct entry CFI_BACKWARD
[  182.120665] lkdtm: Attempting unchecked stack return address redirection ...
[  182.122543] lkdtm: ok: redirected stack return address.
[  182.123521] lkdtm: Attempting checked stack return address redirection ...
[  182.123964] lkdtm: Eek: return address mismatch! bfff800008fa8014 != ffff800008fa8030
[  182.124502] lkdtm: ok: control flow unchanged.
CFI_BACKWARD: saw 'call trace:|ok: control flow unchanged': ok

We may need to ignore the pac high bits of return address according
to TCR.T1SZ (or simply remove the high 16 bits before comparing).

> +	else
> +		/* Check architecture, stack layout, or compiler behavior... */
> +		pr_warn("Eek: return address mismatch! %px != %px\n",
> +			*ret_addr, addr);

According to the context, it might be "expected" here?

		pr_warn("Eek: return address mismatch! %px != %px\n",
			*ret_addr, expected);

I simply ignored the upper 16 bits, and tested it separately
in gcc/llvm 12 with SCS/PAC and all the four cases worked fine for me.

Thanks,
Dan.
