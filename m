Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63B4EE988
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbiDAILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245087AbiDAILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:11:47 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817704DF6B;
        Fri,  1 Apr 2022 01:09:57 -0700 (PDT)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4KVCWk4SMWz5B13f;
        Fri,  1 Apr 2022 16:09:54 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4KVCWg2Zfxz4y3ZP;
        Fri,  1 Apr 2022 16:09:51 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl2.zte.com.cn with SMTP id 23189eDM017032;
        Fri, 1 Apr 2022 16:09:40 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 1 Apr 2022 16:09:40 +0800 (CST)
Date:   Fri, 1 Apr 2022 16:09:40 +0800 (CST)
X-Zmail-TransId: 2b046246b3447fd-f3269
X-Mailer: Zmail v1.0
Message-ID: <202204011609406223339@zte.com.cn>
In-Reply-To: <20220331212152.GG1544202@dread.disaster.area>
References: 20220331053340.GE1544202@dread.disaster.area,202203311632074775168@zte.com.cn,20220331212152.GG1544202@dread.disaster.area
Mime-Version: 1.0
From:   <wang.yi59@zte.com.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xue.zhihong@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <cheng.lin130@zte.com.cn>
Subject: =?UTF-8?B?UmU6W1BBVENIXSB4ZnM6IGdldGF0dHIgaWdub3JlIGJsb2NrcyBiZXlvbmQgZW9m?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 23189eDM017032
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6246B352.001 by FangMail milter!
X-FangMail-Envelope: 1648800594/4KVCWk4SMWz5B13f/6246B352.001/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6246B352.001/4KVCWk4SMWz5B13f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Mar 31, 2022 at 04:32:07PM +0800, wang.yi59@zte.com.cn wrote:
> > > We do not, and have not ever tried to, hide allocation or block
> > > usage artifacts from userspace because any application that depends
> > > on specific block allocation patterns or accounting from the
> > > filesystem is broken by design.
> > >
> > > If your application is dependent on block counts exactly matching
> > > the file data space for waht ever reason, then what speculative
> > > preallocation does is the least of your problems.
> > >
> >
> > Thanks for your explaination.
> >
> > Unfortunately, the app I'm using evaluates diskusage by querying
> > the changes of the backend filesystem (XFS) file before and after
> > the operation.
>
> What application is this?
>
> What is it trying to use this information for?

Thanks very much, Dave.

I'm trying to use a new xlater(module) named 'simple-quota' in
glusterfs, which collects file's diskusage by stat, for quota function.

>
> I'm trying to understand why someone thought this was a good idea,
> and without actually being able to look up the code and see what it
> is using the information for, I can't really say much more than
> "this seems broken by design".
>
> > Without giving up the benefits of preallocation, the
> > app's statistics will become obsolete and no chance to correct it
> > at a small cost, because of the silence reclaim of posteof blocks.
> > That is the app's problem.
