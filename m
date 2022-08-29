Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2D5A4517
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiH2Icy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiH2Icw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:32:52 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0582757257
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:32:50 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:56878.266017777
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id F26B61001F8;
        Mon, 29 Aug 2022 16:32:48 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-84fc4d489d-2xtjd with ESMTP id cfadb1fba75e4e5c839080c542a553f1 for rppt@kernel.org;
        Mon, 29 Aug 2022 16:32:49 CST
X-Transaction-ID: cfadb1fba75e4e5c839080c542a553f1
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <520fb512-8d2f-15e1-fd00-a7343e136d1c@189.cn>
Date:   Mon, 29 Aug 2022 16:32:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] tools/testing/memblock: define pr_warn_ratelimited
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     karolinadrobnik@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1661755140-3331-1-git-send-email-chensong_2000@189.cn>
 <Ywx32C4/kE2WgR75@kernel.org>
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <Ywx32C4/kE2WgR75@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


在 2022/8/29 16:24, Mike Rapoport 写道:
> On Mon, Aug 29, 2022 at 02:39:00PM +0800, Song Chen wrote:
>> Commit 14d9a675fd0d("mm: Ratelimited mirrored memory related warning
>> messages") introduced pr_warn_ratelimited in memblock.c, which breaks
>> tools/test/memblock, below is the message:
>>
>> /usr/bin/ld: memblock.o: in function `memblock_find_in_range.constprop.0':
>> memblock.c:(.text+0x4603): undefined reference to `pr_warn_ratelimited'
>> /usr/bin/ld: memblock.o: in function `memblock_alloc_range_nid':
>> memblock.c:(.text+0x786a): undefined reference to `pr_warn_ratelimited'
>> collect2: error: ld returned 1 exit status
>>
>> A fake pr_warn_ratelimited needs to be defined in printk.h like other
>> prink functions.
> 
> This is fixed by commit 0a7e91528202 ("memblock tests: fix compilation errors")

Is there a commit taking care of 902c2d91582c(mirrored_kernelcore) ? it 
brakes memblock test too. If not, i have fixed it and will send a patch 
soon.

Song

>   
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> ---
> 
