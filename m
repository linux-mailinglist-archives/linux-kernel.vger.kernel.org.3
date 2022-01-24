Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F68497922
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiAXHLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAXHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:11:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F44C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 23:11:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02CC1B80CCF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90202C340E1;
        Mon, 24 Jan 2022 07:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643008299;
        bh=qWez0wGob8vUCQuD2t7DHnXvuj3jt1kWScf2tXdwuFA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hGBRrWiEj5quo0WjhP2nfBn6wWQKfe7oJ6Aw8P8ZvvVBo1r5MQpB/uP2CnWbnFDyx
         EExcWEqhDJksWvlgML+F4OLcsNhiaDW3J/0f15MgGYV5AbtMD23Wru8UDiP6xj2qnN
         he/RCQsZSFYm9FRU/PMMCmU1nw7kE8BY0DtJJfuMVa3WWnqgX28E5z9pzhaES1vR/y
         WJZO9ZlFdqfHicxsFyc0eqvEsydrM21U/VQJgTuhXL+cbA4a8pOPGrzg7sYCaaFQJL
         hgpZkv9eXXMqBb/VUHFj6AUhPbixTy5akR4R2cB7YmuZm9eiYgD2yJ69KJBV01V2uG
         uvcmCUDv8eU5g==
Message-ID: <d424369b-c559-bf63-bbb3-71886f1799c9@kernel.org>
Date:   Mon, 24 Jan 2022 15:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] erofs: fix fsdax partition offset handling
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/13 13:18, Gao Xiang wrote:
> After seeking time on testing today upstream fsdax, I found it
> actually doesn't work well as below:
> 
> [  186.492983] ------------[ cut here ]------------
> [  186.493629] WARNING: CPU: 1 PID: 205 at fs/iomap/iter.c:33 iomap_iter+0x2f6/0x310
> 
> The problem is that m_dax_part_off should be applied to physical
> addresses and very sorry about that I didn't catch this eariler.
> 
> Anyway, let's fix it up now. Also, I need to find a way to set up
> a standalone testcase to look after this later.
> 
> Fixes: de2051147771 ("fsdax: shift partition offset handling into the file systems")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
