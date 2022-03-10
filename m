Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331924D538C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbiCJVV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244055AbiCJVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:21:52 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1772E5BE66;
        Thu, 10 Mar 2022 13:20:51 -0800 (PST)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9EF4610E3B36;
        Fri, 11 Mar 2022 08:20:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nSQDH-003vkq-K9; Fri, 11 Mar 2022 08:20:47 +1100
Date:   Fri, 11 Mar 2022 08:20:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: xfs_rmap_item: Add ASSERT after calling kmem_zalloc
Message-ID: <20220310212047.GD3927073@dread.disaster.area>
References: <20220310094303.2013165-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310094303.2013165-1-jiasheng@iscas.ac.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=622a6bb2
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=WoJuvwE-8NXepifrCxgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:43:03PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the kmem_zalloc() without __GFP_NOFAIL,
> it should be better to check it in order to avoid the dereference
> of NULL pointer.

kmem_zalloc() won't ever fail unless it is passed KM_MAYFAIL. i.e.
it has __GFP_NOFAIL behaviour when no flags are passed to it, as the
code in xfs_rui_init() does.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
