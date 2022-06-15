Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7F54C402
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiFOIzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiFOIzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:55:12 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660332CDCF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:55:10 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4LNJzJ618wz4xVnK;
        Wed, 15 Jun 2022 16:55:08 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 25F8sl4a001444;
        Wed, 15 Jun 2022 16:54:47 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 15 Jun 2022 16:54:47 +0800 (CST)
Date:   Wed, 15 Jun 2022 16:54:47 +0800 (CST)
X-Zmail-TransId: 2b0762a99e57ffffffffef800a0c
X-Mailer: Zmail v1.0
Message-ID: <202206151654471905256@zte.com.cn>
In-Reply-To: <CAAH8bW_GCviYSadmf5CUxgJixkXbq+SfL63ZJt7Lsm9OAmPjVQ@mail.gmail.com>
References: CAAH8bW8wD_hsOqtWa-g_1SNWNi7GHzsu9RvL8feY069JPKFWBA@mail.gmail.com,202206141145339651323@zte.com.cn,CAAH8bW_GCviYSadmf5CUxgJixkXbq+SfL63ZJt7Lsm9OAmPjVQ@mail.gmail.com
Mime-Version: 1.0
From:   <wang.yi59@zte.com.cn>
To:     <yury.norov@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <xue.zhihong@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <Liu.Jianjun3@zte.com.cn>,
        <yury.norov@gmail.com>
Subject: =?UTF-8?B?UmU6W1BBVENIXSBiaXRtYXA6IGZpeCBhIHVucHJvcGVyIHJlbWFwIHdoZW4gbXBvbF9yZWJpbmRfbm9kZW1hc2soKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 25F8sl4a001444
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 62A99E6C.000 by FangMail milter!
X-FangMail-Envelope: 1655283308/4LNJzJ618wz4xVnK/62A99E6C.000/10.30.14.239/[10.30.14.239]/mse-fl2.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 62A99E6C.000/4LNJzJ618wz4xVnK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 13, 2022 at 8:45 PM <wang.yi59@zte.com.cn> wrote:
> >
> >
> > - change the bitmap_remap() as this patch did, but this changed the
> > behavior of this routine which looks does the right thing. One good
> > news is this function is only called by mpol_rebind_nodemask().
> 
> There are users of bitmap_remap() in drivers/gpio/gpio-xilinx.c
> 
> > - don't change the bitmap_remap(), to be honest, I didn't figure out
> > a way. Any suggestions?
> 
> I haven't had a chance to play with it (because of my dayjob), but I
> have a strong feeling that the proper solution should come from
> existing functionality.
> 
> Did you experiment with MPOL_F_{STATIC,RELATIVE}_NODES?
> Those flags enable nodes_and() and mpol_relative_nodemask()
> paths correspondingly.
> 

You are right, adding MPOL_F_STATIC_NODES can fix this situation. So it
seems that we don't need to do anything in kernel now.

Many thanks for your time :)


> What I suggested is:
> 
>  328                 node_clear(1, pol->w.cpuset_mems_allowed);
>  329                 node_clear(3, pol->w.cpuset_mems_allowed);
>  330                 nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_allowed,
>  331                                                                 *nodes);
>  332                 pol->w.cpuset_mems_allowed = *nodes;
> 
> > In the example above, if set cpuset.mems to 0,2 firstly, the nodes
> > binds will change from 1 to 2. And then set cpuset.mems to 1,3, it will
> > change from 2 to 3 again.


---
Best wishes
Yi Wang
