Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268214E3A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiCVIJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiCVIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:09:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F35A59E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:08:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2754210F4;
        Tue, 22 Mar 2022 08:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647936488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWWBrjD2pp3iNhrZ3GjqkzMZLE0dgi1nHcO9ba8+iIE=;
        b=GvUc0kQMo2NdirWOqVSKgpGkOiXIweWRuC7GBCQxEN65SaZ/S4HQdEtw+DtAZU5iAch+Ng
        sXbtpsOuF1g1hMRUrVIUtzFHmDwj9qEynVMYpT6g9oypKTSFfeF84QFd6nnUuLqKyN0MUv
        rbV1JSJDk+FAFkTh0fRM7lVsR0l51ZY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A7F47A3B98;
        Tue, 22 Mar 2022 08:08:08 +0000 (UTC)
Date:   Tue, 22 Mar 2022 09:08:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com,
        mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mempolicy: fix mpol_new leak in
 shared_policy_replace
Message-ID: <YjmD6BR0GiYF/j+X@dhcp22.suse.cz>
References: <20220322083456.16563-1-linmiaohe@huawei.com>
 <YjhrkDlvOnmqIP6n@dhcp22.suse.cz>
 <8c7d2ef2-08d7-ea50-a82b-9e9800c5f54c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7d2ef2-08d7-ea50-a82b-9e9800c5f54c@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-03-22 09:50:35, Miaohe Lin wrote:
> On 2022/3/21 20:12, Michal Hocko wrote:
> > On Tue 22-03-22 16:34:56, Miaohe Lin wrote:
> >> If mpol_new is allocated but not used in restart loop, mpol_new will be
> >> freed via mpol_put before returning to the caller.  But refcnt is not
> >> initialized yet, so mpol_put could not do the right things and might leak
> >> the unused mpol_new.
> > 
> > I would just add:
> > 
> > This would happen if mempolicy was updated on the shared shmem file
> > while the sp->lock has been dropped during the memory allocation.
> > 
> 
> Do you mean the below commit log?
> 
> """
> If mpol_new is allocated but not used in restart loop, mpol_new will be
> freed via mpol_put before returning to the caller.  But refcnt is not
> initialized yet, so mpol_put could not do the right things and might leak
> the unused mpol_new. This would happen if mempolicy was updated on the
> shared shmem file while the sp->lock has been dropped during the memory
> allocation.
> 
> This issue could be triggered easily with the below code snippet if
> there're many processes doing the below work at the same time:
> 
>   shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
>   shm = shmat(shmid, 0, 0);
>   loop many times {
>     mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
>     mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
>           maxnode, 0);
>   }
> """

Yes, LGTM.
Thanks!
-- 
Michal Hocko
SUSE Labs
