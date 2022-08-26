Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58E5A3012
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiHZTfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHZTfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:35:38 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF6BB93B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x+UMVnujX+X39oLXzhe/HhYNdkWkFHYnX0Mj23junlg=; b=WR6NHCgYDvvQiuvmHDFS2QjkrD
        zxpBieFdz8zXKZaTBOZ2eo3bvI8UEm6kuTHCwfdD82/ES84mG3sFgChiT3EpJztCVAh8wESBXuC7k
        sbpAKpUlPN9wYol+RqgklQi0pBZO1Mq3IThb0O4IUcQkJteSr4m+63qwc+FYQRdRztleSnIeqcCIK
        Vz82hYFQ0hRBH7Wsk4MVbxytjoAXW5MNUxLi4GkzKOQAVqKWL5rqmmHBnId0c8nkVR1cCVoUA/n5r
        Tf/PWye0IFxrahKkq+FEMOyqyGuTHR/Fq+fEew2pZdwy6OaxM0R57lZ1zia4Y1fnczYhD6mPm3NCC
        Je95WuDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRf6r-008dnk-VB;
        Fri, 26 Aug 2022 19:35:18 +0000
Date:   Fri, 26 Aug 2022 20:35:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <YwkgdYNkjNWkz+Gv@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
 <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse>
 <YwkSXZtO+i+36pXI@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwkSXZtO+i+36pXI@kbusch-mbp.dhcp.thefacebook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:35:09PM -0600, Keith Busch wrote:

> > Can you please provide further information or links to documentation?
> 
> This kvec/bvec talk is a digression from your original goal: reduce unnecessary
> kmap() usage. If anyone wants to take on the bvec optimization in this code
> path, then by all means lets do it in a separate patch.

Oh?  And why is a switch to iov_iter_bvec() *not* a reduction of kmap() usage?
ITER_BVEC methods use kmap_local() for data transfers, TYVM...
