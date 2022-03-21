Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005154E2197
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbiCUHyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiCUHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:54:49 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE4E7140B0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:53:21 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22L7r8hC005539;
        Mon, 21 Mar 2022 08:53:08 +0100
Date:   Mon, 21 Mar 2022 08:53:08 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()`
 and `strndup()`
Message-ID: <20220321075308.GD29580@1wt.eu>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

On Sun, Mar 20, 2022 at 04:37:50PM +0700, Ammar Faizi wrote:
> Add strdup and strndup support. These functions are only available on
> architectures that have my_syscall6() macro from nolibc.
> 
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>  tools/include/nolibc/string.h | 68 +++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
> index 4554b6fcb400..413c65f7c853 100644
> --- a/tools/include/nolibc/string.h
> +++ b/tools/include/nolibc/string.h
> @@ -9,6 +9,10 @@
>  
>  #include "std.h"
>  
> +static void free(void *ptr);
> +static void *malloc(size_t len);
> +static void *realloc(void *old_ptr, size_t new_size);

Better include the required h files here.

>  /*
>   * As much as possible, please keep functions alphabetically sorted.
>   */
> @@ -127,6 +131,70 @@ size_t nolibc_strlen(const char *str)
>  		nolibc_strlen((str));           \
>  })
>  
> +static __attribute__((unused))
> +char *strdup(const char *str)
> +{
> +	size_t allocated = 2048;
> +	size_t i;
> +	char *ret;
> +	char *tmp;
> +
> +	ret = malloc(allocated);
> +	if (__builtin_expect(!ret, 0))
> +		return NULL;
> +
> +	i = 0;
> +	for (;;) {
> +		char c = *str;
> +		if (!c)
> +			break;
> +
> +		if (i == allocated) {
> +			allocated += 2048;
> +			tmp = realloc(ret, allocated);
> +			if (__builtin_expect(!tmp, 0)) {
> +				free(ret);
> +				return NULL;
> +			}
> +			ret = tmp;
> +		}
> +
> +		ret[i++] = c;
> +		str++;
> +	}
> +
> +	ret[i] = '\0';
> +	return ret;
> +}

This version is suboptimal in terms of code size, CPU usage and memory
usage. And it even seems it contains a buffer overflow: if the string
is exactly a multiple of 2048, it seems to me that you'll write the
trailing zero past the end. Please instead use the more intuitive form
below (not tested but you get the idea):

	size_t len = strlen(str);
	char *ret = malloc(len + 1);
	if (ret)
		memcpy(ret, str, len);
	return ret;

> +static __attribute__((unused))
> +char *strndup(const char *str, size_t maxlen)
> +{
> +	size_t i;
> +	char *ret;
> +
> +	ret = malloc(maxlen + 1);
> +	if (__builtin_expect(!ret, 0))
> +		return NULL;
> +
> +	i = 0;
> +	for (;;) {
> +		char c = *str;
> +		if (!c)
> +			break;
> +
> +		if (i == maxlen)
> +			break;
> +
> +		ret[i++] = c;
> +		str++;
> +	}
> +
> +	ret[i] = '\0';
> +	return ret;
> +}

Here it can cost quite a lot for large values of maxlen. Please just use
a variant of the proposal above like this one:

	size_t len;
	char *ret;

	len = strlen(str);
	if (len > maxlen)
		len = maxlen;
	ret = malloc(len + 1);
	if (ret)
		memcpy(ret, str, len);
	return ret;

Thanks,
Willy
