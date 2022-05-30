Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB97538599
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiE3P5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiE3P4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:56:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34983BF9A;
        Mon, 30 May 2022 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=lKFjGkfiY5hj8TVOJmM8ePrAfnXREdxwvXu9WgIHH+8=; b=LMRmtAAbxl5vyMFY+WDJQk6iM7
        31JS8R6+Bf/KCzns5KZsWVt1Z9U8fQ2PQXoV9kHg20O77HsWgErlwLsGtyUJWlWEOZNoSq2p+plBV
        VkH0N7WrSGZ4SfGXdk2ak1Feme28gDTlRmVgEnTd9QHRb0yO3M6BPrcHTPk4+3+6mLtTV5sDrEzjD
        qg4P8GS9TG3fTauVrKO8dkR3klu5WF3JWfe1uHgT4ixp5q/WwrVgcFazSGZ4y9ray+coWtWtsRE/M
        qRw7Js+J0gTA6Cd8d87alSGclu70XyU3XAqXPEeMvz4s4692eljdzZ44yVT15/SLuwzBLAg7hV4YV
        dOcc7OtA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nvhYS-00Bju3-Gx; Mon, 30 May 2022 09:43:41 -0600
Message-ID: <f0738580-f6c2-7043-1561-45a1cd51363e@deltatee.com>
Date:   Mon, 30 May 2022 09:43:36 -0600
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
 <20220526163604.32736-16-logang@deltatee.com>
 <YpRd13d/pXVEWlrE@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YpRd13d/pXVEWlrE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Subject: Re: [PATCH v2 15/17] md: Use enum for overloaded magic numbers used
 by mddev->curr_resync
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-05-30 00:01, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 10:36:02AM -0600, Logan Gunthorpe wrote:
>> Comments in the code document special values used for
>> mddev->curr_resync. Make this clearer by using an enum to label these
>> values.
>>
>> The only functional change is a couple places use the wrong comparison
>> operator that implied 3 is another special value. They are all
>> fixed to imply that 3 or greater is an active resync.
> 
> This already looks good, but shouldn't the curr_resync also be changed
> to the new enum type?

I thought not, seeing curr_resync actually represents a sector_t except
for these handful of special values.
 Thanks,

Logan
