Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7795A8993
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiHaXtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:49:13 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6588C889D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S7jPkOYBwac8qC34nK3SY2G2LAOdWyfIUqKuxgclApY=; b=harToSvXXXtKZNY/7p0UCHiheI
        NH8Ml83jhu51qV79EUrIGtDQUZtkBPPWvSSaXPU6q6SP6G1FBRWNphPuVeRxjENgPmmAC6nWLzxgH
        cSHpuT8aLUgxu8T0QphOgQlOLMpXKz4tX7FzFgzfnw22VRQ4YWTipD6yPL6An5cu6ijaMoSGBZTg+
        pc+ym/z4ggxvkd/Kmn7MDg6Y1sajVQYNBrnE4QW7mwNnKuef4CutI+bvU3aWGc9q7d7mfY7oUprRl
        VxYamz7Z36YQMHQxlgsyZKUiBNwsgVZR+lKw2VW5TJcIyDXbNmaaaIYodxsyPdE8dVyR4CE5JAeHL
        MRpTWSgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTXRs-00AmZd-L4;
        Wed, 31 Aug 2022 23:48:44 +0000
Date:   Thu, 1 Sep 2022 00:48:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <Yw/zXJdO3/x5dGdb@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <2887364.VdNmn5OnKV@opensuse>
 <Ywkf3NJQ7/8SSV+e@ZenIV>
 <1924196.usQuhbGJ8B@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1924196.usQuhbGJ8B@opensuse>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:06:54PM +0200, Fabio M. De Francesco wrote:

> Thanks so much for the time you spent writing this detailed explanation. I 
> really appreciated that you spend time for teaching newcomers with kindness 
> and patience.

*blink*

You are welcome, but TBH answering your question took about 5 minutes.
The question had been fairly simple and reasonable, and the lack of
in-tree documentation covering that is my own fault, so...
