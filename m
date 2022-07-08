Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF68B56B3ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiGHH6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiGHH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:58:37 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA945FDA;
        Fri,  8 Jul 2022 00:58:32 -0700 (PDT)
Received: from usmail.veeam.com (colmbx01.amust.local [172.18.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 1E7E540C7C;
        Fri,  8 Jul 2022 03:58:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1657267109;
        bh=ger7AXoipHQnVDoEh6jCczwlc3wU2JQI8RBDWadO9ds=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=arF5cObhikWiaEzbVdfPC7UubpFczJHYkoTQP+/cINVguGpJQc+wjiBwiQW5P+pA0
         LYi4T1w7CIHxwnwBmAl/ctl9yk2zPnltUYPKWqiR1tvFHx+5V2GVKifXyRK1W/S3pf
         e/ulsO8z4ZyhE8sr5WGP7XXZ5M9GLnFPuhzcbmj1oeiehjZaEowUBvWvSjRRgLRCww
         hmex/N+lXkaoI0MuLS+JLEvWh/SbJMLkb8DXlKDj2ujvHXmSMO0M1SPwzvUGCdhz/H
         SWsXuGf+k/kcTbqFc2gQYx4I0vvljk7HRBVqO98WIBFLEKl5ex3HDVjYgx4xv8kcG3
         h852isQqV1Ypg==
Received: from [172.24.11.83] (172.24.11.83) by colmbx01.amust.local
 (172.18.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 8 Jul 2022
 03:58:26 -0400
Message-ID: <f68a45b1-c986-bc77-d956-e6bafe821d52@veeam.com>
Date:   Fri, 8 Jul 2022 09:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/20] block, blksnap: snapshot image block device
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-16-git-send-email-sergei.shtepa@veeam.com>
 <YsWKhjDV18DeyEZ8@infradead.org>
 <49039d2b-e4bc-62a1-7b4a-a78001a2f430@veeam.com>
 <YscW1Byo0PQq5C84@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <YscW1Byo0PQq5C84@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.11.83]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 colmbx01.amust.local (172.18.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29078F7554657D65
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Jul 07, 2022 at 11:16:42AM +0200, Sergei Shtepa wrote:
>> The module creates a block device for each snapshot image.
>> To make a backup of a block device, the backup tool reads snapshot image.
>> This snapshot image block device allows to mount a file system on it
>> and perform the necessary preparation. If not for this requirement,
>> it would be possible to implement reading via an additional ioctl.
>> But that wouldn't be a good design, I think.
> Ok, got it.  It was just me who was confused.
> 
>> Perhaps I have implemented this block device incorrectly?
>> Processing requests of the snapshot image block device is started
>> in the function snapimage_queue_rq(). And ends in the 
>> snapimage_queue_work() in another kernel thread. Therefore, when
>> the request is initialized in snapimage_init_request(), a kernel worker
>> is prepared.
> I don't think it is wrong, but there is some potential for optimization.
> 
> Is there a reson this is implemented as a blk-mq driver vs a bio
> based driver that just implements ->submit_bio?  The latter has
> the advantage that you are always called in user context, and don't
> need the extra workqueue offload. 
> 
> The block layer also generally assumes that blk-mq drivers don't
> call submit_bio_noacct underneath, so if we can't I'd much
> prefer the bio based driver approach here.
> 

There was a goal to use the kernel innovations whenever possible.
Of course, it makes sense to return to bio based if it allows to
achieve better performance. This is not a matter of principle.
