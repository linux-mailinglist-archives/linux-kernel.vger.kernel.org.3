Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCB502548
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiDOGI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDOGI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:08:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E061AAB6A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDC48B82C38
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7C1C385A5;
        Fri, 15 Apr 2022 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650002757;
        bh=9EJhFefwP87g2Uo3Oggk8GnCc1MvRsQNaYRMX+E6OlI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nJvO+I+kj0S28xHKtAtzlaDSeUgXcZ6vY7yXZdc/I7E2R70uRoE2BMsXVX58+Q58x
         BGhdCFyT8dsdwesoXTxMh4tRo298oG3419M4ussseOy8xQdpzzQuhKX8LhQFkjSnnt
         UoW+2i6zPFW0HfPFmm1lmde3ZrAnstA9FUAqO6xDWhzPMCOUJnflapK0LFUdpIDOjH
         SQmLkbA9ThmO6M6dXAnPKJ97F7sr3Vg8aTbXmPqZpIwyOVsmLT55sDm5Dn1Hd5JgG6
         e+JAABNTasxIHVzld23/0w3TMUtTF6hFwJG4vd7Tm8HZ9fdCNu/kzcEV+P3pDLqBgk
         TqKJmb3hJ1e2w==
Message-ID: <a81d5949-e775-f15b-1800-2736d0a3ccd6@kernel.org>
Date:   Fri, 15 Apr 2022 14:05:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] f2fs: Remove usage of list iterator pas the loop
 for list_move_tail()
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220412122040.3555423-1-jakobkoschel@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220412122040.3555423-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 20:20, Jakob Koschel wrote:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, the usage of the list iterator variable 'next' should
> be avoided past the loop body [1].
> 
> Instead of calling list_move_tail() on 'next' after the loop, it is
> called within the loop if the correct location was found.
> After the loop it covers the case if no location was found and it
> should be inserted based on the 'head' of the list.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
