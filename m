Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB347585F19
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiGaNSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGaNSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88FFEE38
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FFA2601D8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA0C433C1;
        Sun, 31 Jul 2022 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659273489;
        bh=ichplVNGiaHrZIY/a1eWBNo4Tl6r9s/ES+a8P+0lvBw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o9gWy2KUYZIu6bfaDuVgb6irAcGAn9MN/l6Rf4iniDHW+WN7T2pqBY8lpOYKZ6Ldj
         3/oi9Ey9T8XwTq8f2E19xiWtDjKkkkz+lGqz+e19YUVnxLHqqbwJib6D6rUWdO2Vyz
         fQ067Un84Hz71RlieYSk3+euAOkqQRHQwsProCBZ3MCi8dkXtoGRZM68kM0B57APFu
         blJxmz9AYyDhpztA6DeruXjTHGq2BM//G5DSIk+ZRQ9CjnX4pYPL+ZlhHHgOzhgwWL
         SZU11WrbZ/W+K+KFLKabWVYT2Gt/5Gt8/qf1Hpj1qNfsRUd3ppxl737ZevOt/jp/T5
         Vt0d4Q3U5WlGQ==
Message-ID: <368e99d1-bc41-976a-094b-816e80ef6367@kernel.org>
Date:   Sun, 31 Jul 2022 21:18:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20220722082732.30935-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220722082732.30935-1-jefflexu@linux.alibaba.com>
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

On 2022/7/22 16:27, Jeffle Xu wrote:
> From: Hongnan Li <hongnan.li@linux.alibaba.com>
> 
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Also fix the update of ctx->pos when the initial file position has
> exceeded nameoff.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
