Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33E24BC2EF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiBRXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:42:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiBRXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:42:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6513631B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9ky6bOP7YFVh6foVcUF1YeeuY8obj715TbvsyHewfII=; b=N7WR+J8AoqD7izCvDtyn5W4gNn
        KHX0HPoY2Ql20FgrRqLm6+hvX+VBnPHhxoQzs5X9bKAaMYgmPHZ6LYemiDNLFIyNAN/y7RIEJRPSW
        DkbpoZmYtTE9l1BvfAmjdGFh+hW5sjM+IP1vI7w1xWAgu26Y7WyeSIlPsf3ZuSsIoUoXy/CjuSWkl
        zYGVdd9LWtp9clFJTNQlS8Qnbi2UIDAk1dNCkX4R051Qi83JdbWHHH0hYwAB4yVlRVxQQb1Er//W0
        uXplh0wTcjYq+CwAMZip2qY/kGGqM13bQCp2/e5igFIwPbUlEa8qbKkOC6esBrSzFsvjnb4GCT9/n
        3Hl0yf5g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLCsV-00AwPx-3j; Fri, 18 Feb 2022 23:41:54 +0000
Message-ID: <2daf8fd4-0789-fdf0-c38c-2237c0a8d9f3@infradead.org>
Date:   Fri, 18 Feb 2022 15:41:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: fallthrough question
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <858a2b13-64e1-99bc-e2f7-5b2477bb1126@infradead.org>
 <20220218231516.GA1091555@embeddedor>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220218231516.GA1091555@embeddedor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/22 15:15, Gustavo A. R. Silva wrote:
> Hi there,
> 
> On Fri, Feb 18, 2022 at 01:57:58PM -0800, Randy Dunlap wrote:
>> Hi,
>>
>> I expected this to produce a fallthrough warning, but it doesn't
>> (with gcc 11.1.0):
>>
>> from sound/oss/dmasound/dmasound_core.c:#1481, when falling from case 1
>> into case 0: (in arch/m68k/ selected builds only)
>>
>> 	case 1:
>> 		if ((size = ints[2]) < 256) /* check for small buffer specs */
>> 			size <<= 10 ;
>>                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
>>                         printk("dmasound_setup: invalid write buffer size, using default = %d\n", writeBufSize);
>>                 else
>>                         writeBufSize = size;
>> 	case 0:
>> 		break;
>> 	default:
>>
>> Can you tell me what is going on here?
> 
> As you can see the warning is suppressed when a case label falls through to
> a case that merely breaks... or returns, or continues (continue statement)
> or that goes to (goto statement) some other place.
> 
> However, Clang disagrees with this. See below for more:
> 
> https://github.com/ClangBuiltLinux/linux/issues/636
> https://godbolt.org/z/xgkvIh

I see. Thank you.

-- 
~Randy
