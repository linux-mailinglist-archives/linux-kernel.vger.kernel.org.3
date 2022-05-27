Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA9F5367AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 21:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353427AbiE0Tq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiE0Tq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 15:46:58 -0400
X-Greylist: delayed 664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 12:46:56 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CEB1A380
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:46:55 -0700 (PDT)
X-ASG-Debug-ID: 1653680147-1cf43917f332c300001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id qiOcWDtUYW1E5quq; Fri, 27 May 2022 15:35:47 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=k2vVj6Z/phwSWTaZn7My3JXvUdkXdXjkEeC6vHFdl8U=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Content-Language:
        Subject:References:Cc:To:MIME-Version:Date:Message-ID; b=dqgsrg312x/7Ox/FPoTt
        4zCt2dR79yVy+1uHv8bk0MgzAYN18PJrftX/rSpKxjR/3RC7SonhOIbDZIV2ibsq05sKRPqWIvkIc
        6L7SlTa5Gp68VdN8FqwVYZCNDrTwdaXdYlXKPPx5C7vFrNbKjT/76hbaUZ1Cm0mqQEuS9+BeUk=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11825323; Fri, 27 May 2022 15:35:47 -0400
Message-ID: <156da4ae-20de-a40f-5173-3b02c779b43c@cybernetics.com>
Date:   Fri, 27 May 2022 15:35:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     kbusch@kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org
References: <20220428202714.17630-1-kbusch@kernel.org>
Subject: Re: [PATCH 0/2] dmapool performance enhancements
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 0/2] dmapool performance enhancements
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <20220428202714.17630-1-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1653680147
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1790
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I posted a similar patch series back in 2018:

https://lore.kernel.org/linux-mm/73ec1f52-d758-05df-fb6a-41d269e910d0@cybernetics.com/
https://lore.kernel.org/linux-mm/15ff502d-d840-1003-6c45-bc17f0d81262@cybernetics.com/
https://lore.kernel.org/linux-mm/1288e597-a67a-25b3-b7c6-db883ca67a25@cybernetics.com/


I initially used a red-black tree keyed by the DMA address, but then for
v2 of the patchset I put the dma pool info directly into struct page and
used virt_to_page() to get at it.  But it turned out that was a bad idea
because not all architectures have struct page backing
dma_alloc_coherent():

https://lore.kernel.org/linux-kernel/20181206013054.GI6707@atomide.com/

I intended to go back and resubmit the red-black tree version, but I was
too busy at the time and forgot about it.  A few days ago I finally
decided to update the patches and submit them upstream.  I found your
recent dmapool xarray patches by searching the mailing list archive to
see if anyone else was working on something similar.

Using the following as a benchmark:

modprobe mpt3sas
drivers/scsi/mpt3sas/mpt3sas_base.c
_base_allocate_chain_dma_pool
loop dma_pool_alloc(ioc->chain_dma_pool)

rmmod mpt3sas
drivers/scsi/mpt3sas/mpt3sas_base.c
_base_release_memory_pools()
loop dma_pool_free(ioc->chain_dma_pool)

Here are the benchmark results showing the speedup from the patchsets:

        modprobe  rmmod
orig          1x     1x
xarray      5.2x   186x
rbtree      9.3x   269x

It looks like my red-black tree version is faster than the v1 of the
xarray patch on this benchmark at least, although the mpt3sas usage of
dmapool is hardly typical.  I will try to get some testing done on my
patchset and post it next week.

Tony Battersby
Cybernetics

