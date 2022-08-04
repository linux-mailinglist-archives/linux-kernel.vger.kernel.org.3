Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E44589D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiHDNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiHDNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8EC641E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08EAC61856
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB939C433D6;
        Thu,  4 Aug 2022 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659621043;
        bh=ypCEvGSbXL+VemXY0bh4lxvSFLUZsXpyG4Kso6XHBJc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WRakjXtJ5ZXQJIkhgx2mOUgfrRZBCkvoIq3nQUz3a9f1Q6oJoSwZ0AbkpARn71wK4
         emOWCy5YOP5Kx0LpQ85HCccSBmYzNRnGZMGKEOC3oOqNHfVjDXw5bd0RWRz5qLIV+x
         jU8P0fMHEsIm3hvmRQp7QKx0YNf2ednnLW4IJZw2FqdrG2e1Bqa/v8irCb53Hui29X
         atdRrol9TxRUTO6+B3sb8czwx6k6gOv2QHs3Gz9t71UHyXSEvhnfKL0c7Wv23hnI0l
         KK1JsEusNxXUar+oejPLpdvHnoX56iaAswopaDGAr0ja10Ob3jp0+rz7aBahsyImDB
         x3zPqr3VNqZNw==
Message-ID: <a6c31e43-76eb-fefb-b197-c44537cb45af@kernel.org>
Date:   Thu, 4 Aug 2022 21:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Joe Perches <joe@perches.com>
Cc:     Christoph Hellwig <hch@infradead.org>, studentxswpy@163.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Hacash Robot <hacashRobot@santino.com>
References: <20220801092202.3134668-1-studentxswpy@163.com>
 <YugaBtQcoR4XhXiQ@infradead.org>
 <b43b3babb8aea836add289245c640688bec87829.camel@perches.com>
 <YutC7yUo/mTfty9q@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YutC7yUo/mTfty9q@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/4 11:54, Jaegeuk Kim wrote:
> On 08/01, Joe Perches wrote:
>> On Mon, 2022-08-01 at 11:23 -0700, Christoph Hellwig wrote:
>>> On Mon, Aug 01, 2022 at 05:22:02PM +0800, studentxswpy@163.com wrote:
>>>> From: Xie Shaowen <studentxswpy@163.com>
>>>>
>>>> replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.
>>>
>>> For that removing f2fs_kmalloc entirely would be way better.
>>
>> Dunno, maybe doubtful as there's a specific "fault injector" test
>> built around f2fs_<foo>alloc. (CONFIG_F2FS_FAULT_INJECTION)
> 
> Yes, it's very useful to run the test checking the ENOMEM case.

It's useful to cover more error paths for xxx_alloc functions in f2fs
with common testcases.

> 
>>
>> For a student lesson, it would significantly better to compile any
>> patch, especially to avoid broken patches, before submitting them.
>>
