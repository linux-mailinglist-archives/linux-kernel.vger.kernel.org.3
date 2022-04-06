Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7C4F664A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiDFQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiDFQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:56:21 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F3169B1E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B10soQAROjAGizcB6m2pLuc7Finz9LgnWyDNUbVwfpU=; b=s8u2iS/ajJ1VZ9L7k+uht6nJDO
        SwmRpLob6jYtHNIkDhCMhqnuoURinLawIE2e0DjSoVXDo8ZWiOfJ3Nh0lZHZBcNOflk6u/D6zUhoX
        bO0/lVcCBbrlUO446gLWOdEiZTi28yYI4GjA20LhHoqdXfdGSeeV3GcYM6y1+orn2JtGLz6L1PAvC
        BWKxhNIVp2dVgBFSPeWpQAbKEZJDU1viVyBqZJGjwZ3z18eBuMJDl+euvHe3IywGjOiL7RiZIbBaf
        8Lnr/7Vin+8c6q4lzklSTzloqHiy1M0XPhmEm1PPE4kh/JgKC7PhQ58OE/gWRCQkjAJvHvyFYBkRy
        0u6m2nnw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nc73U-003AgN-Io; Wed, 06 Apr 2022 14:54:44 +0000
Date:   Wed, 6 Apr 2022 14:54:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Message-ID: <Yk2ptLIKdpvgL3QY@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
 <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
 <10b5d071-7f69-da59-6395-064550c6c6cb@oracle.com>
 <YkxRDJ2ynEHGdjeT@zeniv-ca.linux.org.uk>
 <0dfe1056-3dc5-4d31-698e-e2c075ffd6ee@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dfe1056-3dc5-4d31-698e-e2c075ffd6ee@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 02:54:19PM +1000, Imran Khan wrote:

> > BTW, speaking of kernfs_notify() - can calls of that come from NMI handlers?
> > If not, I'd consider using llist for kernfs_notify_list...
> 
> I see it gets invoked from 3 places only: cgroup_file_notify,
> sysfs_notify and sysfs_notify_dirent. So kernfs_notify should not be
> getting invoked in NMI context. I will make the llist transition in next
> version.

Er...  Are you sure neither of those is ever called from something that is
called from .... from NMI?

It might never happen, but there's a plenty of callchains leading to that
thing and no obvious obstacles for some of those to come from NMI context;
I don't see it documented anywhere either.

Tejun, could you comment on that one?
