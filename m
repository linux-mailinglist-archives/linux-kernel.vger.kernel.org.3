Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D24A4FA1AA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiDICdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiDICdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:33:12 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70424BF308
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:31:03 -0700 (PDT)
Date:   Sat, 9 Apr 2022 11:31:24 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649471461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZZ04yhym7VwWzkRiGv3722dTlanosPffhx8rSLPO8Y=;
        b=oBQnSY/+woznrpg7QnxgUDOlYHgFxXbLrrTmfEppG1sGCqfHKixiwFOcLpq2OuDBbhHjuG
        f8RoD4S0/f/w4lqUHeoJnrju5k8EFFk7Ibiy+DhjxeIVxObfF5272f7zE6+Hrkan+0tuZ3
        rpO6pDH3B0OIsZafSEo17EK+yqMXE2o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hwpoison: fix race between hugetlb
 free/demotion and memory_failure_hugetlb()
Message-ID: <20220409023124.GA1649696@u2004>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408164755.3ef6536c1cdcb38955348a2c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408164755.3ef6536c1cdcb38955348a2c@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 04:47:55PM -0700, Andrew Morton wrote:
> On Fri,  8 Apr 2022 22:53:20 +0900 Naoya Horiguchi <naoya.horiguchi@linux.dev> wrote:
> 
> > I updated v7 (https://lore.kernel.org/linux-mm/20220407112929.1344748-1-naoya.horiguchi@linux.dev/)
> > based on the comment from Miaohe Lin.  Now I have a few additional patches.
> > Any comments and suggestions are welcomed.
> 
> As [1/3] is cc:stable I queued that for 5.18-rcX and the other two
> patches I queued for 5.19.
> 
> This plan means that [1/3] will be merged into mainline without the
> other two patches yet present, which is a combination which you may not
> have tested.  Please confirm that this will be OK?

Yes, the plan is fine to me.
I've tested the kernel with all 3 patched, but 2/3 and 3/3 are simple and
the effect should be predictable.  I'll test only with 1/3 next week.

Thanks,
Naoya Horiguchi

