Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9368853C8FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbiFCLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFCLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:01:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC053A726
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEF57CE231B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE193C385A9;
        Fri,  3 Jun 2022 11:01:37 +0000 (UTC)
Date:   Fri, 3 Jun 2022 12:01:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v2 0/4] mm: kmemleak: store objects allocated with
 physical address separately and check when scan
Message-ID: <YpnqDlI0nRJA0gtg@arm.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:54:11AM +0800, Patrick Wang wrote:
> Patrick Wang (4):
>   mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical
>     address
>   mm: kmemleak: add rbtree for objects allocated with physical address
>   mm: kmemleak: handle address stored in object based on its type
>   mm: kmemleak: kmemleak_*_phys() set address type and check PA when
>     scan

This looks fine at a very quick look but I'll do a in-depth review next
week. One more thing needed is to remove the min_count argument to
kmemleak_alloc_phys() and assume it's always 0. After this series we
can't track them for leaking anyway.

Thanks for putting this together.

-- 
Catalin
