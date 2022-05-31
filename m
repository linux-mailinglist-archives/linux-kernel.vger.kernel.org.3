Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24237538B83
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbiEaGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbiEaGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:45:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008B6D87E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4445B80FCD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347DC385A9;
        Tue, 31 May 2022 06:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653979542;
        bh=JWUY8gLxM6a8ecx+oeq5zIpOkvxaRWMyrTnL80aNhrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q2s0wXvb1We+8wZiL1fkROY36DyyMvj3B2eBxjLz6YmUXaSWPe7MVHp1jlGa3v0fZ
         5jokGDyjHhNcEWsOf1F9QB1hGE7bgtq8GPa2cWne4UxloGPLUFIc1eWlcoAb/cefwl
         julBU61N4wGG+hX+3qi4APZbkEmepBPP1zBfRaxAcBwEZSUpI6iA1CLY06P9ve8fDT
         PvgW32xRed4cnsDVRrvJjKg15EcAh4KJXK9RfdRTF8zE6LH2pdHexVIuhVn8xh3l4I
         +soMQYIrlMxJVWDbnJYfU+GOMLiCSTIOKaubwd2lPiholP+Akk6sSKn2d+J9YPIcHX
         4ru1RWs21QaJQ==
Message-ID: <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
Date:   Tue, 31 May 2022 14:45:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] erofs: random decompression cleanups
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220529055425.226363-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220529055425.226363-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

On 2022/5/29 13:54, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Hi folks,
> 
> Now I'm working on cleanuping decompression code and doing some
> folio adaption for the next 5.20 cycle, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/folios
> 
> This cleanup work completely gets rid of PageError usage finally
> and tries to prepare for introducing rolling hashing for EROFS
> since EROFS supports compressing variable-sized data instead of
> fixed-sized clusters.
> 
> Therefore, EROFS can support rolling hash easily and our mechanism
> can make full use of filesystem interfaces (byte-addressed) naturally.
> 
> Before that, I'd like to submit some trivial cleanups in advance for
> the 5.19 cycle. All patches are without any logical change, so I can
> have a more recent codebase for the next rework cycle.
> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (3):
>    erofs: get rid of `struct z_erofs_collection'
>    erofs: get rid of label `restart_now'
>    erofs: simplify z_erofs_pcluster_readmore()
> 
>   fs/erofs/zdata.c | 165 +++++++++++++++++++----------------------------
>   fs/erofs/zdata.h |  50 +++++++-------
>   2 files changed, 88 insertions(+), 127 deletions(-)
> 
