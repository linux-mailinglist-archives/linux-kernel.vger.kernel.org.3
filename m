Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7454B52B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351114AbiFNP5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244927AbiFNP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD12CC98
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8A4B6146E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC9DC3411B;
        Tue, 14 Jun 2022 15:57:05 +0000 (UTC)
Date:   Tue, 14 Jun 2022 16:57:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/kmemleak: Use _irq lock/unlock variants in
 kmemleak_scan/_clear()
Message-ID: <YqivzfKoptxz2CMX@arm.com>
References: <20220612183301.981616-1-longman@redhat.com>
 <20220612183301.981616-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612183301.981616-2-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:32:59PM -0400, Waiman Long wrote:
> The kmemleak_scan() function is called only from the kmemleak scan
> thread or from write to the kmemleak debugfs file. Both are in task
> context and so we can directly use the simpler _irq() lock/unlock calls
> instead of the more complex _irqsave/_irqrestore variants.
> 
> Similarly, kmemleak_clear() is called only from write to the kmemleak
> debugfs file. The same change can be applied.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
