Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE854EFCB1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353285AbiDAWQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353290AbiDAWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:16:19 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E74E666AC6;
        Fri,  1 Apr 2022 15:14:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CFE5153427D;
        Sat,  2 Apr 2022 09:14:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1naPXE-00CdxP-0g; Sat, 02 Apr 2022 09:14:24 +1100
Date:   Sat, 2 Apr 2022 09:14:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     wang.yi59@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, cheng.lin130@zte.com.cn
Subject: Re: [PATCH] xfs: getattr ignore blocks beyond eof
Message-ID: <20220401221424.GN1544202@dread.disaster.area>
References: <20220331212152.GG1544202@dread.disaster.area>
 <202204011609406223339@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202204011609406223339@zte.com.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62477942
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=IkcTkHD0fZMA:10 a=z0gMJWrwH1QA:10 a=1RTuLK3dAAAA:8 a=7-415B0cAAAA:8
        a=PNVk_V5aYQPfWbkZ830A:9 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 04:09:40PM +0800, wang.yi59@zte.com.cn wrote:
> > On Thu, Mar 31, 2022 at 04:32:07PM +0800, wang.yi59@zte.com.cn wrote:
> > > > We do not, and have not ever tried to, hide allocation or block
> > > > usage artifacts from userspace because any application that depends
> > > > on specific block allocation patterns or accounting from the
> > > > filesystem is broken by design.
> > > >
> > > > If your application is dependent on block counts exactly matching
> > > > the file data space for waht ever reason, then what speculative
> > > > preallocation does is the least of your problems.
> > > >
> > >
> > > Thanks for your explaination.
> > >
> > > Unfortunately, the app I'm using evaluates diskusage by querying
> > > the changes of the backend filesystem (XFS) file before and after
> > > the operation.
> >
> > What application is this?
> >
> > What is it trying to use this information for?
> 
> Thanks very much, Dave.
> 
> I'm trying to use a new xlater(module) named 'simple-quota' in
> glusterfs, which collects file's diskusage by stat, for quota function.

So a company (kadalu) has forked gluster, then removed the gluster
quota implementation because of undefined "major performance
problems" and then implemented their own quota thing that stores
disk usage information in extended attributes. And:

	Advised method is adding quota limit info before writing any
	information to directory. Even otherwise we don’t need quota
	crawl for updating quota-limit, but do a du -s -b $dir and
	write the output into xattr.

Yeah, that's broken by design.

Oh, look at that:

	Just run statfs() on all dirs which has Quota set, and send
	a flag to update status of quota xlator through internal
	xattr mechanism if quota limit exceeds for a directory! This
	can run once in 5 or 10 seconds, or even lesser frequency if
	the quota limit is huge!

That's pretty broken, too. Doesn't scale out, either...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
