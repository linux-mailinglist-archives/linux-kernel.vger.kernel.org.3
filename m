Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01B24E2166
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344914AbiCUHbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiCUHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:31:16 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02767DE07
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:29:50 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWCU5-00Ebay-SS; Mon, 21 Mar 2022 07:29:46 +0000
Date:   Mon, 21 Mar 2022 07:29:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 12:57:07PM +1100, Imran Khan wrote:

> Yes. My earlier approach is wrong.
> 
> This patch set has also introduced a per-fs mutex (kernfs_rm_mutex)
> which should fix the problem of inconsistent tree view as far as
> kernfs_get_path is concerned.
> Acquiring kernfs_rm_mutex before invoking kernfs_get_path in
> kernfs_getlink will ensure that kernfs_get_path will get a consistent
> view of ->parent of nodes from root to target. This is because acquiring
> kernfs_rm_mutex will ensure that __kernfs_remove does not remove any
> kernfs_node(or parent of kernfs_node). Further it ensures that
> kernfs_rename_ns does not move any kernfs_node. So far I have not used
> per-fs mutex in kernfs_rename_ns but I can make this change in next
> version. So following change on top of current patch set should fix
> this issue of ->parent change in the middle of kernfs_get_path.

I think it's a massive overkill.  Look at kernfs_get_target_path() -
nothing in it is blocking.  And you already have kernfs_rename_lock,
stabilizing the tree topology.  Turn it into rwlock if you wish,
with that thing being a reader and existing users - writers.
And don't bother with further scaling, until and unless you see a real
contention on it.
