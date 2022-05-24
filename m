Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9E532E05
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiEXP7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbiEXP7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:59:39 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48845986DA;
        Tue, 24 May 2022 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=IlWWOeHUyxI87/ZUi6NS9TFLsUJi3lbfeazdE29uhPk=; b=imemdAQIiSRD+gdiClRe4DzWb/
        YiHPsg+seb3ku5EAdgvOL0M0uJXCBJMn0HD6abbC/k2c3FzHpAWoJruiwsP1lumXw2uAh0yzmvD2M
        OSij1AM/47VXlq9dxn/9kN63aufFLnEVFLFBmrleegqL9RotRZ0cT3VQIj0aWyAtyd4ScIEL5Rjms
        p6626v6FHEzo9lXf9Uy5zwo5ubha/PFBevop7luQPA0eY1MOLnwKX8N5JWfuu4w86T2fiGk3UuAPR
        VuvtbU+XESWfe2k3axgOH3BtOIqkaC3YWY7yWAcdmN7eFSwrgTGgeo5CRuaB1vgySJQQxS/RH2ROr
        YyiNEW4w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ntWwV-006RAB-Da; Tue, 24 May 2022 09:59:32 -0600
Message-ID: <f270d92d-7c34-2f58-89c5-ccb7a8a37872@deltatee.com>
Date:   Tue, 24 May 2022 09:59:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To:     Song Liu <song@kernel.org>, Donald Buczek <buczek@molgen.mpg.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220519191311.17119-1-logang@deltatee.com>
 <20220519191311.17119-13-logang@deltatee.com>
 <62b09487-9223-db3d-2165-789a51230060@molgen.mpg.de>
 <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: song@kernel.org, buczek@molgen.mpg.de, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v1 12/15] md/raid5-cache: Add RCU protection to conf->log
 accesses
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-05-23 00:47, Song Liu wrote:
>> A problem here is that `struct r5l_log` of `conf->log` is private to raid5-cache.c and gcc below version 10 (wrongly) regards the `typeof(*p) *local` declaration of __rcu_access_pointer as a dereference:
>>
>>    CC      drivers/md/raid5.o
>>
>> In file included from ./include/linux/rculist.h:11:0,
>>
>>                   from ./include/linux/dcache.h:8,
>>
>>                   from ./include/linux/fs.h:8,
>>
>>                   from ./include/linux/highmem.h:5,
>>
>>                   from ./include/linux/bvec.h:10,
>>
>>                   from ./include/linux/blk_types.h:10,
>>
>>                   from ./include/linux/blkdev.h:9,
>>
>>                   from drivers/md/raid5.c:38:
>>
>> drivers/md/raid5-log.h: In function ‘log_stripe’:
>>
>> ./include/linux/rcupdate.h:384:9: error: dereferencing pointer to incomplete type ‘struct r5l_log’
>>
>>    typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>
>>           ^
>>
>> ./include/linux/rcupdate.h:495:31: note: in expansion of macro ‘__rcu_access_pointer’
>>
>>   #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
>>
>>                                 ^~~~~~~~~~~~~~~~~~~~
>>
>> drivers/md/raid5-log.h:61:6: note: in expansion of macro ‘rcu_access_pointer’
>>
>>    if (rcu_access_pointer(conf->log)) {
>>
>>        ^~~~~~~~~~~~~~~~~~
>>
>> make[2]: *** [scripts/Makefile.build:288: drivers/md/raid5.o] Error 1
>>
>> make[1]: *** [scripts/Makefile.build:550: drivers/md] Error 2
>>
>> make: *** [Makefile:1834: drivers] Error 2
> 
> This is annoying.. And there are a few other cases in raid5-log.h and
> raid5.c.
> 
> Maybe we should move the definition of r5l_log to raid5-log.h?

That's the only solution I can think of, and what I'll likely do for v2.
If anyone has a better solution I'm open to it.

Logan
