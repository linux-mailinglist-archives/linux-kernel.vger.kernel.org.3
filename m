Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8D5A2D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiHZRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344654AbiHZRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:16:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDAFB6D6A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF7E5B8320B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F61C433D7;
        Fri, 26 Aug 2022 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661534191;
        bh=iDINRuAQ4YmaJq22k2DCZ+hhEQstH3cgG8wNmEwf7RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daNeke0IhQ/wVEd02y7AL28gqaIRqwNto6VvGKWd5c4ahO5ZFNwOT2REHKTpkC550
         KR8okkektQbiFKq7NS/VmDQmDLpEF+Fz9c8vyTrbVppRif+qF0dcSUH4ZyMJJLV5CI
         wPmI0gOiQPtiWYeV2TEs0hacs8vNABhzIqOrnuTsgPtvGh2CEb862SW0+wXzG8qFT6
         SbeIDmdl6Fr/NRuCHxp1RpXE0DoKHKETm0qj21GEl5IIyX8mo+gIr1JLXdNhwZ0HIF
         lNgffucmLb4JL5s08Q93Cn/JoLbXgqJmxr/tYXIGxLRqX101R9Xlblm9H1z9b6bifB
         kIGvWEhqEGe8g==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH 2/2] mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
Date:   Fri, 26 Aug 2022 17:16:29 +0000
Message-Id: <20220826171629.50210-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1661502678-19336-3-git-send-email-kaixuxia@tencent.com>
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

Hi Kaixu,

On Fri, 26 Aug 2022 16:31:18 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The damon regions that belong to the same damon target have the same
> 'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
> objects among the damon regions in one damon target when checking accesses.

There could be multiple targets, and 'damon_va_check_accesses()' calls
'__damon_va_check_accesses()' for all the targets.  However,
'damon_va_check_accesses()' doesn't note if '__damon_va_check_accesses()' is
called with a target that same to the target it was called with for the last
time.  Hence the check is necessary.

If I'm missing something, please let me know.


Thanks,
SJ

[...]
