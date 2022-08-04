Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9BB589C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiHDNTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiHDNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:19:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A03F1EED8
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A5561791
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678FEC433D7;
        Thu,  4 Aug 2022 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659619164;
        bh=M0SSFMxlayeE6mZzPAIICF05y2jkpLApZw26vek9YE4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZMvfGHS22xVkhKiTJb+5h6DTHWe1QefEScOOEvNovwJCmBF1/XIAgD8qg14agOg1E
         hwgak0W2BzFiDo7AHru6LWmsxcVoyjdwFAh7C7hhTBkUZNaZPfNq2YZR2t4wlSUvPT
         g5nJorOtnozHTdU4WumucyudengNnRbVbyrQbF0Xcz3on1ko1e4UgWh6M6WUUg2XSC
         ogD8xbYAgtF5dQ+IbeU1NcTwg51A8n9vWsNZN9jwEVbj2aj8FsqwwLbZQMChQB8QSx
         V8zBgEsd0oWkPY6RLOlrFToaLyMTQxMRQmLHTRLD6jDM0Qr6vXXATscaVUfujsSMHy
         UYf7qK0Kvvdcw==
Message-ID: <0d33f658-a678-530d-0377-1ee6af091309@kernel.org>
Date:   Thu, 4 Aug 2022 21:19:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: handle decompress only post
 processing in softirq
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220802192437.1895492-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220802192437.1895492-1-daeho43@gmail.com>
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

On 2022/8/3 3:24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now decompression is being handled in workqueue and it makes read I/O
> latency non-deterministic, because of the non-deterministic scheduling
> nature of workqueues. So, I made it handled in softirq context only if
> possible, not in low memory devices, since this modification will
> maintain decompresion related memory a little longer.
> ---
> v1: fixed build errors reported by kernel test robot <lkp@intel.com>
> v2: enhanced readability and removed a redundant code
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
