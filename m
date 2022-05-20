Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C552E3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiETEho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbiETEhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:37:38 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDF3A8CCFD;
        Thu, 19 May 2022 21:37:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9EEF9534526;
        Fri, 20 May 2022 14:37:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nruOL-00E7Sy-70; Fri, 20 May 2022 14:37:33 +1000
Date:   Fri, 20 May 2022 14:37:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove the redundant assignment
Message-ID: <20220520043733.GK1098723@dread.disaster.area>
References: <20220520040518.73957-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520040518.73957-1-jiapeng.chong@linux.alibaba.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62871b0e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=SRrdq9N9AAAA:8 a=7-415B0cAAAA:8
        a=P0sVBlT4rgpVDXflfFAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:05:18PM +0800, Jiapeng Chong wrote:
> Variable 'ifree','freeblks' and 'itotal' set but not used.
> 
> Eliminate the follow clang warning:
> 
> fs/xfs/xfs_log_recover.c:3534:12: warning: variable 'freeblks' set but
> not used [-Wunused-but-set-variable].
> 
> fs/xfs/xfs_log_recover.c:3535:12: warning: variable 'itotal' set but not
> used [-Wunused-but-set-variable].
> 
> fs/xfs/xfs_log_recover.c:3536:12: warning: variable 'ifree'
> set but not used [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks like it's been that way since 2010 - commit 1414a6046ab4
("xfs: remove dead XFS_LOUD_RECOVERY code") removed the prints that
dumped the differences between the in memory counters and the
calculated values....

IOWs, this entire function is dead code and has been for 12 years
now. Can you just remove it, please?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
