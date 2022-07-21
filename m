Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94F57CDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiGUOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGUOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:32:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815D484ECB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB60BCE25B3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A3DC341C0;
        Thu, 21 Jul 2022 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658413917;
        bh=ffb3CPAAW0wEQHaCuTSKW7+RxX6RH1UHdDeIg1iGWPI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c9xqL2rZLAxCpXupfcOdgt4gbk4iOreUjvDIluVSp1tWt7wyeujNNXUV1cMBXMs71
         JUz+FSxnTEIiTdHZF84pQp5X2GG72FhZUTVTMfhqNZ1KogaFiLzTe91ztwpwz/GOeX
         S60AUY6T7FI3kLmRkJ92x7uJsj8IptKcSrcwDPUjw8EkyLpZFPCOGFoHNM+wmHLy1E
         w2dr6L3HZNnDWcgbql+O0fhao/C4BShHkeX6Az9IxlVQLq0kFCn+KxrRoXEk40lwRy
         UNWSEtDQ+3sC4tnKW+IQAu2646qCW/7dfxakWQhxqZxwbRxd1e+rTfhdZz/+7vpHV6
         RO5GzVcRqzRcg==
Message-ID: <3801a538-f059-2b62-6dbb-cbe67478371b@kernel.org>
Date:   Thu, 21 Jul 2022 22:31:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/16] erofs: prepare for folios, deduplication and
 kill PG_error
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/15 23:41, Gao Xiang wrote:
> Hi folks,
> 
> I've been doing this for almost 2 months, the main point of this is
> to support large folios and rolling hash deduplication for compressed
> data.
> 
> This patchset is as a start of this work targeting for the next 5.20,
> it introduces a flexable range representation for (de)compressed buffers
> instead of too relying on page(s) directly themselves, so large folios
> can laterly base on this work.  Also, this patchset gets rid of all
> PG_error flags in the decompression code. It's a cleanup as a result
> as well.
> 
> In addition, this patchset kicks off rolling hash deduplication for
> compressed data by introducing fully-referenced multi-reference
> pclusters first instead of reporting fs corruption if one pcluster
> is introduced by several differnt extents.  The full implementation
> is expected to be finished in the merge window after the next.  One
> of my colleagues is actively working on the userspace part of this
> feature.
> 
> However, it's still easy to verify fully-referenced multi-reference
> pcluster by constructing some image by hand (see attachment):
> 
> Dataset: 300M
> seq-read (data-deduplicated, read_ahead_kb 8192): 1095MiB/s
> seq-read (data-deduplicated, read_ahead_kb 4096): 771MiB/s
> seq-read (data-deduplicated, read_ahead_kb 512):  577MiB/s
> seq-read (vanilla, read_ahead_kb 8192):           364MiB/s
> 
> Finally, this patchset survives ro-fsstress on my side.

For this patchset,

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
> Changes since v1:
>   - rename left pagevec words to bvpage (Yue Hu);
> 
> Gao Xiang (16):
>    erofs: get rid of unneeded `inode', `map' and `sb'
>    erofs: clean up z_erofs_collector_begin()
>    erofs: introduce `z_erofs_parse_out_bvecs()'
>    erofs: introduce bufvec to store decompressed buffers
>    erofs: drop the old pagevec approach
>    erofs: introduce `z_erofs_parse_in_bvecs'
>    erofs: switch compressed_pages[] to bufvec
>    erofs: rework online page handling
>    erofs: get rid of `enum z_erofs_page_type'
>    erofs: clean up `enum z_erofs_collectmode'
>    erofs: get rid of `z_pagemap_global'
>    erofs: introduce struct z_erofs_decompress_backend
>    erofs: try to leave (de)compressed_pages on stack if possible
>    erofs: introduce z_erofs_do_decompressed_bvec()
>    erofs: record the longest decompressed size in this round
>    erofs: introduce multi-reference pclusters (fully-referenced)
> 
>   fs/erofs/compress.h     |   2 +-
>   fs/erofs/decompressor.c |   2 +-
>   fs/erofs/zdata.c        | 785 +++++++++++++++++++++++-----------------
>   fs/erofs/zdata.h        | 119 +++---
>   fs/erofs/zpvec.h        | 159 --------
>   5 files changed, 496 insertions(+), 571 deletions(-)
>   delete mode 100644 fs/erofs/zpvec.h
> 
