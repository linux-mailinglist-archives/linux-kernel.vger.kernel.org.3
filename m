Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1287153AFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiFAWmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiFAWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:42:17 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C1192C56;
        Wed,  1 Jun 2022 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=2f0BHsBpq85ivP1dIKJ0uio8fENOzyRfwTPQnpZYJRg=; b=E8t1tTnSSJXVJy3I2k7upgMPeH
        0w8So78p5JydBzf/h8IBbidTNc3H3InOcEay072ojxPnVkdJMjZtr7ZGoYIa99SC+aStt8zhnrraS
        2bE+hAgI/cZhrYTv27dMhr2OmjDqVj8WeXhylMakQcWmGgfpfaPYMNx2Ipp+kHGts1gGhT4SCqx6M
        7V1w6zsIuTqmimpvydCSqyzD8GYYQEkTfEz9xhlkrr/bE+jUn6K6RVG2OXBZ86SxDIcxs30REEmae
        5hRkaroXlHnJ3rTWCAqrWUJdSXMfbUBg76T3iTbRSe5PxSOm+pfENCg41Ptz7fr2U3E5STY1y6MBI
        u8SmnH8Q==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nwX2T-00DcNy-Hz; Wed, 01 Jun 2022 16:42:06 -0600
Message-ID: <6605fb80-47c4-3a42-1fde-fbb42886ebc3@deltatee.com>
Date:   Wed, 1 Jun 2022 16:42:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220526163604.32736-1-logang@deltatee.com>
 <20220526163604.32736-13-logang@deltatee.com>
 <YpRdL+2e7gngOYPa@infradead.org>
 <c59d233a-c0d1-a3cc-3dad-0a5af449ff83@deltatee.com>
 <CAPhsuW56YAwByRKnYDpkbBk1pi01Wdx3NL9yLY2sADWfMmTMeQ@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPhsuW56YAwByRKnYDpkbBk1pi01Wdx3NL9yLY2sADWfMmTMeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: song@kernel.org, hch@infradead.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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



On 2022-06-01 16:36, Song Liu wrote:
>> I guess we could do that. All the inline functions in raid5-log.h are
>> there to choose between the r5l or the ppl implementaiton. So it that
>> would mean the r5l implementation would probably be inlined and ppl
>> would be doing a second out of line call. Not sure if that matters, but
>> it seems a little odd.
> 
> I like the current version better. raid5-log.h is not used in many files anyway.

It's a moot point now. v3 will follow Christoph's other feedback which
essentially removes the RCU access altogether and adds an appropriate
lock in a couple places.

Logan
