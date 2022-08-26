Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABBD5A2EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344892AbiHZSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbiHZSiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951B1BCCFE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319F961DCB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C483FC433C1;
        Fri, 26 Aug 2022 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661538912;
        bh=4HUfpEyIMPwZm9Or4pnF3GVjJGYp1+pAFmXsSIh30bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz/BkQsdEAmhdTTQza5Ci8Es3mjzFfX887yxuqUhW52uNbRLBj+/v2yv3MTwOMbHp
         75lF3i7rTvblIAzVVe9C15I8Z5jYCUWvmQeiBFaRB2/o8nN2yXoo4qlQhbno+dciXY
         57CrqHke+Iz4k9bF5RwQ7blldARpTNhTUJk6N0p9L369vHEmyqbTTSodVZjNG1b3tv
         y0Uc4HcBmCtLoBX1Hym9BsjeFV7E2Hy3vnj5OqXLHc9Y41tZfm9/+FdUvoL77LZs6h
         m1vGjZEDowAtgPvWae6X86jGkwbNKDIjWHrqyqYS++xLeTwFmPF8wtFmsl4qFle59+
         cTF5uA/PDGUIg==
Date:   Fri, 26 Aug 2022 12:35:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <YwkSXZtO+i+36pXI@kbusch-mbp.dhcp.thefacebook.com>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
 <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2887364.VdNmn5OnKV@opensuse>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:16:59PM +0200, Fabio M. De Francesco wrote:
> On mercoledì 24 agosto 2022 01:32:53 CEST Al Viro wrote:
> > On Mon, Aug 22, 2022 at 04:24:38PM +0200, Fabio M. De Francesco wrote:
> > > Therefore, replace the kmap() of sg_page(sg) with a page_address() and
> > > delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
> > > local variable to iov_iter_kvec() from the call site in
> > > nvmet_tcp_map_pdu_iovec().
> > 
> > I'd suggest looking into switching to ITER_BVEC...
> 
> Hello Al,
> 
> It's interesting that, for the second time in a few days, I've been suggested 
> to switch to the use of BVEC. Christoph asked for first[1]
> 
> I responded to Christoph and, in the same email, I also asked Sagi
> (the author of nvmet_tcp_map_pdu_iovec()) if he wanted to add something to 
> that discussion.
> 
> As you may have already read, I'm so new to kernel development that I still
> know very little about many subsystems and drivers. I am not currently
> able to tell the difference between BVEC and KVEC. I could probably try to 
> switch from one to the other (after learning from other code), however I won't 
> be able to explain in the commit message why users should better use BVEC in 
> this case.
> 
> My task is to remove as many kmap() call sites I can from the entire kernel, 
> and this is all I did in nvmet-tcp. After doing many tens of call sites 
> removals or conversions to kmap_local_page(), I learned to not go deep into 
> those details which aren't needed to accomplish the task I've been given.
> 
> However, since you and Christoph suggested doing more (I suppose in a separate
> patch), I did some research which seems to confirm that iov_iter_kvec() may be 
> good for what it is supposed to do.
> 
> Since you are talking again about BVEC, soon after Christoph did the same, I'd
> like to understand better which improvements do we expect from BVEC and why
> and when should developers prefer this or KVEC.
> 
> Can you please provide further information or links to documentation?

This kvec/bvec talk is a digression from your original goal: reduce unnecessary
kmap() usage. If anyone wants to take on the bvec optimization in this code
path, then by all means lets do it in a separate patch.
