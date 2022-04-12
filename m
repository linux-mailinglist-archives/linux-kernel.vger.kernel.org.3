Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01374FDD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiDLK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355786AbiDLKyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:54:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EB4830B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1152B81BBF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E2CC385A5;
        Tue, 12 Apr 2022 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649756962;
        bh=gYR2YBHwwyx9GaI6f6MK1uifVDe1QgQzsrtQ7laIKeU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OD5yENxhrqinRZ28NRL3z3M2cXMflFjo7rdvdCtxSCxp424qOJ4xZBCXY7G3h7jan
         gFAvOtajyghA11u56CcEIv0q8QqJ+sukQWtvPmf4/5LJJFEv/d9j7s6d12Ol7j47FA
         bxc3w6gRwbsOI4teqsdV5BgoVZErwUPu5JEnsRVDJPo+fjAtKOdYqJWTv4b0lkLKt8
         Kx/X43PP/NTMuNR/1iO2Xrmkx/vO+waCU6oeNucMOsDa8OMvV3v1l1gupRnFCNqS9K
         UlWSjoljm81z5ZemS8x2D9hsf+6S+sevNUTgv1TFLMgP5SXchUa9fiQYh5ZrwwZfcG
         AN+RmMmYdZXow==
Message-ID: <8b62a788-d5ba-b244-d9f1-2edecba9769f@kernel.org>
Date:   Tue, 12 Apr 2022 17:49:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] f2fs: fix dereference of stale list iterator after loop
 body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yunlei He <heyunlei@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331223414.901960-1-jakobkoschel@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220331223414.901960-1-jakobkoschel@gmail.com>
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

On 2022/4/1 6:34, Jakob Koschel wrote:
> The list iterator variable will be a bogus pointer if no break was hit.
> Dereferencing it (cur->page in this case) could load an out-of-bounds/undefined
> value making it unsafe to use that in the comparision to determine if the
> specific element was found.
> 
> Since 'cur->page' *can* be out-ouf-bounds it cannot be guaranteed that
> by chance (or intention of an attacker) it matches the value of 'page'
> even though the correct element was not found.
> 
> This is fixed by using a separate list iterator variable for the loop
> and only setting the original variable if a suitable element was found.
> Then determing if the element was found is simply checking if the
> variable is set.
> 
> Fixes: 8c242db9b8c0 ("f2fs: fix stale ATOMIC_WRITTEN_PAGE private pointer")
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
