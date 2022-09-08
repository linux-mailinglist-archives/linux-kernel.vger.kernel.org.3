Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F235C5B2937
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiIHWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:25:41 -0400
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56A46A3455
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:25:39 -0700 (PDT)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id 9E7A914002E; Fri,  9 Sep 2022 00:25:36 +0200 (CEST)
Date:   Fri, 9 Sep 2022 00:25:36 +0200
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kernfs: fix use-after-free in __kernfs_remove
Message-ID: <Yxpr4HSSxNw3SDrI@cae.in-ulm.de>
References: <20220907200811.654034-1-lk@c--e.de>
 <YxojA7pDe8Ur7wpd@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxojA7pDe8Ur7wpd@slm.duckdns.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Tejun,

On Thu, Sep 08, 2022 at 07:14:43AM -1000, Tejun Heo wrote:
> Hello, Christian.
> 
> On Wed, Sep 07, 2022 at 10:08:11PM +0200, Christian A. Ehrhardt wrote:
> > Concurrent calls to __kernfs_remove can race on the removal
> > of the root node: The race occurs if the root node(kn) is freed
> > during kernfs_drain. The child node(pos) is explicitly protected
> > with an additional ref count. Do the same for the root node.
> 
> I don't think this is right. We don't support parallel invocations of
> __kernfs_remove() this way. If @kn can be freed during kernfs_drain(), it
> also means that it can be freed before kernfs_rwsem is grabbed in
> kernfs_remove().

Point taken. However, the syzkaller reproducer reliably triggers
the bug without the patch and the bug is gone with the patch.

> The caller must be responsible for ensuring that @kn
> remains allocated. Otherwise, it can't be made reliable.

In this case the caller of __kernfs_remove is not kernfs_remove but
kernfs_remove_by_name_ns and it fails to take a reference for the
node that it looks up and deletes. Thus a second call to
kernfs_remove_by_name_ns can remove the node while kernfs_drain
drops the semaphore.

I'll post an updated patch tomorrow.

      regards   Christian

