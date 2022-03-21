Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032314E254D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346791AbiCULiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiCULiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:38:08 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D38B2478
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:36:43 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.38.58])
        by gnuweeb.org (Postfix) with ESMTPSA id E22227E2DA;
        Mon, 21 Mar 2022 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647862603;
        bh=shXz+PPwGv/jCiUSvqesE15IVm1U37j4KlhDNrdLfUQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=R70bbJObaaNyygAkbHkYtcBndeLDF77NhHVi1QDM8QlNyL/sOqXPzGz1MYEt20DKv
         SIqb3bD+Xc+oaMvTvsoNPSswy6h96MATz1kFBRmy3tfT4kCjWs0zsr8853KdzkrK8T
         TDEZrBnSIQfwi7MI/DscH0LwhbYuyd4OvDxuqpggNJejbysoTpZfZ+gUKYGYsEqXC0
         PQS5EsXSFypTbNqMHzUYgUV85GOep3mApWeF58SB3e2QvsWLFdIvyYgcBzO4DrjObC
         wKUVbFZaONWzpaKU9twK2catacPghOhzJsdxP9n8h4/l8scVJqye9PbMvgM8Gua2Gn
         oLbxbIZ66WF0Q==
Message-ID: <bdc75a04-6807-290b-72c0-dc44ddeea0a1@gnuweeb.org>
Date:   Mon, 21 Mar 2022 18:36:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
 <20220321075308.GD29580@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()` and
 `strndup()`
In-Reply-To: <20220321075308.GD29580@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 2:53 PM, Willy Tarreau wrote:
> Hi Ammar,
[...]
>> +static void free(void *ptr);
>> +static void *malloc(size_t len);
>> +static void *realloc(void *old_ptr, size_t new_size);
> 
> Better include the required h files here.

I can't do that, in nolibc.h, we have something like this:

```
   #include "stdlib.h" <--- We inlcude string.h from here
   #include "string.h" <--- This is a no-op.
```

Note, stdlib.h is included first before string.h, next, in stdlib.h, we
have this:

```
   #include "string.h"

   // malloc, calloc, free here
```

If I include "stdlib.h" in "string.h", it will just be a no-op, and the
declarations will not be taken, because the declarations happen after
#include "string.h". So it doesn't work. It's somewhat circular dependency.

   stdlib.h needs string.h
   string.h needs stdlib.h

One of them must fully see the other before they can use the defined functions
in another header.

Suggestion welcome...

I am thinking of creating a new header just for the forward declarations
where all function declarations live there, we just split off the real
functions' body.

[...]
> 
> This version is suboptimal in terms of code size, CPU usage and memory
> usage. And it even seems it contains a buffer overflow: if the string
> is exactly a multiple of 2048, it seems to me that you'll write the
> trailing zero past the end. Please instead use the more intuitive form
> below (not tested but you get the idea):
> 
> 	size_t len = strlen(str);
> 	char *ret = malloc(len + 1);
> 	if (ret)
> 		memcpy(ret, str, len);
> 	return ret;

Ah right, that's indeed overflow. Will fold this in as you suggested.

[...]
> Here it can cost quite a lot for large values of maxlen. Please just use
> a variant of the proposal above like this one:
> 
> 	size_t len;
> 	char *ret;
> 
> 	len = strlen(str);
> 	if (len > maxlen)
> 		len = maxlen;
> 	ret = malloc(len + 1);
> 	if (ret)
> 		memcpy(ret, str, len);
> 	return ret;

Will take the Alviro's suggestion for this part...

-- 
Ammar Faizi
