Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456C14ED373
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiCaFuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCaFuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:50:00 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D48717ECEA;
        Wed, 30 Mar 2022 22:48:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A78C410E53FD;
        Thu, 31 Mar 2022 16:48:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nZnfH-00Byb3-6A; Thu, 31 Mar 2022 16:48:11 +1100
Date:   Thu, 31 Mar 2022 16:48:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     wang.yi59@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, cheng.lin130@zte.com.cn
Subject: Re: [PATCH] xfs: getattr ignore blocks beyond eof
Message-ID: <20220331054811.GF1544202@dread.disaster.area>
References: <20220331003826.GL27690@magnolia>
 <202203311128598207170@zte.com.cn>
 <20220331053340.GE1544202@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331053340.GE1544202@dread.disaster.area>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6245409c
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=1RTuLK3dAAAA:8 a=7-415B0cAAAA:8
        a=1LhttCzMsrBsiKW95H4A:9 a=CjuIK1q_8ugA:10 a=kRpfLKi8w9umh8uBmg1i:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:33:40PM +1100, Dave Chinner wrote:
> On Thu, Mar 31, 2022 at 11:28:59AM +0800, wang.yi59@zte.com.cn wrote:
> > The above problems can be explained by fs preallocation.
> > If the impact of preallocation are closed in fs, not visible to
> > the outside, the result is stable and real for the application.
....

> If your application is dependent on block counts exactly matching
> the file data space for waht ever reason, then what speculative
> preallocation does is the least of your problems.

That said, if you have written an application that cannot handle
this behaviour, then you can *turn it off* by using the allocsize
mount option. But then subsequent file fragmentation issues are your
own problem to solve, not ours.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
