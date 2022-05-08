Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2C51EE83
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiEHP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiEHP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE167BC9F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 08:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2624E611F2
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 15:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5BBC385A4;
        Sun,  8 May 2022 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652023343;
        bh=QLvcNqSRrOP4peiOakXtQ+o1e+ref41gMxFR4ScwGME=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=k/jjN0Ep6X5SWSgt3qGSljRVJelyTo4gci2F73GH92VnDVgrbzROx1hljGM35hKPx
         FEiqkd0Y3cVVaklppEsDjxSRW/VhQaIAYdrDIMcibv8Ba3U3adDIXTiz6gbLXa8v3y
         jhsyYVCK+me6n0V8tHWT2+sFWc/HcL8i25JI1GVz2oTlsVWyBM74N6KkACY7cc9Bqd
         FZT4mWaJ6dypcFH+UEA69lMhk7kyDItxL4F2yiDMx3Y/4fxxhdnEOX6k55/VY/rmV/
         YqsPfW/ES2GhtRj9h4V2Z3A+hVZpAhrVUMKuGq1+KNGxUCTT8qH39PY6eGe+kgFGMz
         GRbG12I0wIMIA==
Message-ID: <44d184dd-ad4c-eac9-c631-98fabcc14294@kernel.org>
Date:   Sun, 8 May 2022 23:22:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: keep wait_ms if EAGAIN happens
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
 <20220506232032.1264078-3-jaegeuk@kernel.org>
 <eb8f1316-11df-ab02-1834-542ca193c17c@kernel.org>
In-Reply-To: <eb8f1316-11df-ab02-1834-542ca193c17c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/8 22:41, Chao Yu wrote:
> On 2022/5/7 7:20, Jaegeuk Kim wrote:
>> In f2fs_gc thread, let's keep wait_ms when sec_freed was zero.
> 
> sec_freed won't increase for background GC due to below statement:
> 
> 		if (gc_type == FG_GC &&
> 				get_valid_blocks(sbi, segno, false) == 0)
> 			seg_freed++;
> 
> It may cause gc thread migrates lots of segments in each round?

Please ignore this comment, I misunderstood it. :-P

> 
> Thanks,
> 
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
