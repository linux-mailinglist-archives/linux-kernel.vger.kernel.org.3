Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310F4F60FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiDFN7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiDFN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:59:18 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E82DCCB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:51:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9JW7Mc_1649213468;
Received: from 30.225.24.86(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9JW7Mc_1649213468)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 10:51:09 +0800
Message-ID: <d776f073-c01d-9cc7-4302-c36c77409d69@linux.alibaba.com>
Date:   Wed, 6 Apr 2022 10:51:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [Linux-cachefs] [PATCH] fscache: Move fscache_cookies_seq_ops
 specific code under CONFIG_PROC_FS
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     Yue Hu <huyue2@coolpad.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com
Cc:     zbestahu@gmail.com, linux-kernel@vger.kernel.org, zbestahu@163.com
References: <20220402044728.9669-1-huyue2@coolpad.com>
 <1c6b191b-4a2e-0333-b0a3-f76bcd6b6515@linux.alibaba.com>
In-Reply-To: <1c6b191b-4a2e-0333-b0a3-f76bcd6b6515@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/22 10:45 AM, JeffleXu wrote:
> 
> 
> On 4/2/22 12:47 PM, Yue Hu wrote:
>> fscache_cookies_seq_ops is only used in proc.c that is compiled under
>> enabled CONFIG_PROC_FS, so move related code under this config. The
>> same case exsits in internal.h.
>>
>> Also, make fscache_lru_cookie_timeout static due to no user outside
>> of cookie.c.
>>
>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
>> ---
>>  fs/fscache/cookie.c   | 4 +++-
>>  fs/fscache/internal.h | 4 ++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
>> index 9bb1ab5fe5ed..9d3cf0111709 100644
>> --- a/fs/fscache/cookie.c
>> +++ b/fs/fscache/cookie.c
>> @@ -30,7 +30,7 @@ static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
>>  DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
>>  static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
>>  static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
>> -unsigned int fscache_lru_cookie_timeout = 10 * HZ;
>> +static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
>>  
>>  void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
>>  {
>> @@ -1069,6 +1069,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
>>  }
>>  EXPORT_SYMBOL(__fscache_invalidate);
>>  
>> +#ifdef CONFIG_PROC_FS
>>  /*
>>   * Generate a list of extant cookies in /proc/fs/fscache/cookies
>>   */
>> @@ -1145,3 +1146,4 @@ const struct seq_operations fscache_cookies_seq_ops = {
>>  	.stop   = fscache_cookies_seq_stop,
>>  	.show   = fscache_cookies_seq_show,
>>  };
>> +#endif
> 
> Then I'm afraid fscache_cookies_seq_stop() and
> fscache_cookies_seq_show() also need to be wrapped with "#ifdef
> CONFIG_PROC_F" ...
> 

Sorry, fscache_cookies_seq_stop() and fscache_cookies_seq_show() have
already been wrapped with "#ifdef CONFIG_PROC_F" in this patch. Please
ignore the noise...

-- 
Thanks,
Jeffle
