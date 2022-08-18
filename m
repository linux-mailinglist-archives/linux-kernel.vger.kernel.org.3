Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FD598A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbiHRRRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbiHRRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7352610C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B777761645
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2644C433D7;
        Thu, 18 Aug 2022 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660842708;
        bh=Mc/teE1LL9vULZCSDU4ycYT9u3eYQsCxpUOtyauN4pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWZJlPCUjq7p7vu1Bz1r9kJMchqJkGqlekx/lzPT6Oj4nq7WfVIZWD8OhWHR2XkVX
         ZnKbvC1td2JxmqeAdI92wUok2KK0c+EGdwAkUYukMT0fkHzjx++xPTyA00oZfxDQsU
         oObrS3/4Qeb8iKzTN3NRGKr2Hqg0xImh2Zp0BOkmRMrE/lzEOtzH2nV3907a3fZRpf
         jXcDflt8dDHueJRaAPrBJ+5KerzThkqKlYnEssdtOjzTBPv+jNv7wM7iov/uUCc/Hl
         agnxm4gTMg5MrPk4VELdphBGUPn8P0x5dNqePLwdV5MNnFfetscJh8KZYrUCkUs/FV
         Cf5Qi8CnwkXOA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mm/damon/lru_sort: Move target memory region check to head of func
Date:   Thu, 18 Aug 2022 17:11:45 +0000
Message-Id: <20220818171145.51607-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818105732.34492-2-xhao@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,


On Thu, 18 Aug 2022 18:57:31 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_lru_sort_apply_parameters(), if "monitor_region_start"
> and "monitor_region_end" is not a valid physical address range,
> There no need to run the remainder codes in it.

The function, 'damon_lru_sort_apply_parameters()', checks validity of
parameters and construct the DAMON context one by one.  For example,
'damon_set_attrs()' returns an error if the parameters are invalid.  So the
intended flow is,

1. check DAMON attributes parameters,
2. apply DAMON attributes parameters,
3. check scheme parameters,
4. apply scheme parameters,
5. check target region parameters, and
6. apply target region parameters.

Therefore what this patch does is making the target regions validity check to
be done earlier than validity checks of other parameters.  There is no special
reason to check the region earlier than others.  Also, this change makes the
flow of the function a little bit weird in my humble opinion, as the flow will
be

1. check target region parameters,
2. check DAMON attributes parameters,
3. apply DAMON attributes parameters,
4. check scheme parameters,
5. apply scheme parameters, and
6. apply target region parameters.

So I'd argue this patch seems not really needed, sorry.


Thanks,
SJ

[...]
