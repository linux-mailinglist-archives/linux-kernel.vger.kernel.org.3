Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F161E5385A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbiE3P6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiE3P6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:58:06 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CAA99822;
        Mon, 30 May 2022 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=nStA9lqh6i5uOfeF+xwtlFCvRjzsWn5OqHELFm3vFb4=; b=qbYhFDmDAJvgqI4LQL2tYR1y/k
        MYRLNo9sNH7/EiAVHFxRRz5EseRqS0pmDphXDMkflWot8X5kYg7hN5N3PiPbsrJVPcW/C2F5KF4w7
        hSD+ETefUAmP6Ri8JloTk2rVxcrKW4QbrX4rMx+qSu/g7jWEaTGVXlQZqH8Xx4mJZZCgciX+s60Cw
        wrpvuPD2F9oyhQu9DWE7FfUETYhhFVEAP8+08Nm8hNW4bmyOISIN1E00TK2CQtrr2WUFlSNVNcwZX
        TTpKyQTIPBklBk34bdrFzkXkLTFMx3dT6Hx7qa4ajU/DR2yWCKAUZwASonrAodZNWztqbyL9baqJt
        r8t9tJbA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nvhd9-00Bjxp-0q; Mon, 30 May 2022 09:48:31 -0600
Message-ID: <c59d233a-c0d1-a3cc-3dad-0a5af449ff83@deltatee.com>
Date:   Mon, 30 May 2022 09:48:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220526163604.32736-1-logang@deltatee.com>
 <20220526163604.32736-13-logang@deltatee.com>
 <YpRdL+2e7gngOYPa@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YpRdL+2e7gngOYPa@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@infradead.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v2 12/17] md/raid5-cache: Move struct r5l_log definition
 to raid5-log.h
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-05-29 23:59, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 10:35:59AM -0600, Logan Gunthorpe wrote:
>> Move struct r5l_log definition to raid5-log.h. While this reduces
>> encapsulation, it is necessary for the definition of r5l_log to be
>> public so that rcu_access_pointer() can be used on conf-log in the
>> next patch.
>>
>> rcu_access_pointer(p) doesn't technically dereference the log pointer
>> however, it does use typeof(*p) and some older GCC versions (anything
>> earlier than gcc-10) will wrongly try to dereference the structure:
>>
>>     include/linux/rcupdate.h:384:9: error: dereferencing pointer to
>>                  incomplete type ‘struct r5l_log’
>>
>>       typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>            ^
>>
>>     include/linux/rcupdate.h:495:31: note: in expansion of
>>                   macro ‘__rcu_access_pointer’
>>
>>        #define rcu_access_pointer(p) __rcu_access_pointer((p),
>>        __UNIQUE_ID(rcu), __rcu)
>>
>> To prevent this, simply provide the definition where
>> rcu_access_pointer() may be used.
> 
> What about just moving any code that does the rcu_access_pointer on
> conf->log to raid5-cache.c and doing an out of line call for it
> instead?

I guess we could do that. All the inline functions in raid5-log.h are
there to choose between the r5l or the ppl implementaiton. So it that
would mean the r5l implementation would probably be inlined and ppl
would be doing a second out of line call. Not sure if that matters, but
it seems a little odd.

Logan
