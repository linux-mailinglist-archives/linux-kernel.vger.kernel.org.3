Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D7512781
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiD0XbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiD0XbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:31:01 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5331902;
        Wed, 27 Apr 2022 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=qYpF45g7IqwmF2QX2YAhs+Nml0O9Dsi63w2rdyKZioc=; b=aosjYX/2C0rIYc1fnJA+YIlFho
        EVLuyRTIeWj8NlZcff7jik81iFW0Nsf8bSd+oAtQbHMEFZ7s72OAuPjGJAv+51U3RYhHFFTLP1bJ/
        U6XDDCKRhcXBpWqopPZx0njJ7vhXYTgBhem0yZRFus2U+Gu56mMZkcwJ5dChu/Vr+Thevmw6BO3mP
        bpw19zXhGQBBQqp0jhECaqejjcj5Hv55ZZd7e5/LUp3XH4HhfBsTRfyIGaYCv7P4dOsExAT4pwL/w
        JFlX36oGRTJyFw2RoyHjz+F80A7tTO3WIyVnVwcEtdtUhdAvVNa/M6YspiMeA/uiBum0dMlAjaM4s
        1aw37QPw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1njr4T-000PMf-SE; Wed, 27 Apr 2022 17:27:46 -0600
Message-ID: <2dd3e7b3-ac85-6de2-3130-4fdd7b366739@deltatee.com>
Date:   Wed, 27 Apr 2022 17:27:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-10-logang@deltatee.com>
 <56208e2a-5035-eb8e-c468-70b4dae66d5c@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <56208e2a-5035-eb8e-c468-70b4dae66d5c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 09/12] md/raid5: Keep a reference to last stripe_head
 for batch
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-26 19:36, Guoqing Jiang wrote:
> On 4/21/22 3:54 AM, Logan Gunthorpe wrote:
>>     /* we only do back search */
>> -static void stripe_add_to_batch_list(struct r5conf *conf, struct
>> stripe_head *sh)
>> +static void stripe_add_to_batch_list(struct r5conf *conf,
>> +        struct stripe_head *sh, struct stripe_head *last_sh)
> 
> Nit, from stripe_add_to_batch_list's view, I think "head_sh" makes more
> sense than
> "last_sh".

That made sense to me, but upon a closer look while making the change, I
think it's not a good idea:

stripe_add_to_batch_list() already has a stripe_head variable called
"head". If it now has an argument called "head_sh", it becomes very
confusing. This statement wouldn't make any sense:
+    if (last_sh && head_sector == last_sh->sector) {
+        head = last_sh;
+        atomic_inc(&head->count);
+    } else {

If it was changed to "head = head_sh" what would that even mean?

From stripe_add_to_batch_list's perspective, it is the "last" stripe
head. And it then decides whether the it is the correct stripe to use as
the head of the list to add to.

So I decline to make this change.

Thanks,

Logan



