Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC06568B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiGFO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGFO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9829021831
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31CF661EA6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A0C3411C;
        Wed,  6 Jul 2022 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657117666;
        bh=AqYKdoA9FLd1G1LCk3C1+7u1lQg7N8l1i5b7UcNhb2g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W+bHK5c2gd9jzkU7diwCyrMzC+1smiCjHNYkX81108IqSzsZqkxt8iEAZc/UDg6Ts
         NFLzQBo+YZPexyYLaM/tBzCD7wZAY73J+7bYoosX8WRb24E2gxGnOr/D0uBIbU0DO6
         mJjPkr2Igm8XxD6QDbNbZ+FVuhQxEG9dXLsz0JuDrwMjH1fi4XxOUFHUOtEn3PRSfQ
         ZOM+AWHotV5kFHBCoBAXPRi26zYUpfs0CYRyog3LA7H1L0wTVjS0mjqwatqGtKFQ5Y
         gOXMCW0BILY1HTanXIDSlv6dc9uBx98CPb/a7LtO1fZss5oYJGj/4NErbWcbTVydfE
         H98jg6lW5Od2g==
Message-ID: <c181672a-faa2-2f2a-b495-b9c9fee56d50@kernel.org>
Date:   Wed, 6 Jul 2022 22:27:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] f2fs: allow compression of files without blocks
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220621064202.1078536-1-chaoliu719@gmail.com>
 <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
 <YrPq5N61W9vFGTub@liuchao-VM>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YrPq5N61W9vFGTub@liuchao-VM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/23 12:24, Chao Liu wrote:
> On Wed, Jun 22, 2022 at 08:50:33PM +0800, Chao Yu wrote:
>> On 2022/6/21 14:42, Chao Liu wrote:
>>> From: Chao Liu <liuchao@coolpad.com>
>>>
>>> Files created by truncate have a size but no blocks, so
>>
>> I didn't get it, how can we create file by truncation...
> 
> I'm sorry I didn't make it clear. We can create a file
> by passing a FILE parameter that does not exist
> to the user command truncate(1) [1].
> 
> How about using truncate(1) instead of truncate
> in the description of the change?

Fine to me, as f2fs_disable_compressed_file() uses the same check
condition. ;)

Thanks,

> 
> Thanks,
> 
> [1] truncate(1): https://man7.org/linux/man-pages/man1/truncate.1.html
