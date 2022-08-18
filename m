Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B28598328
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbiHRM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbiHRM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:27:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12CC57245
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:27:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A05075BEFF;
        Thu, 18 Aug 2022 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660825664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eDIQKOW+lbVS7W8q+AYtm12149pDgcrZMmjTMK5FBv8=;
        b=XrYzmPIuXS5u/gAsg5febHUBkqX+vjRZ9y8Gm9X1g5OcdfQJ/rW8yoJhGgvKRYoPmmnsDm
        TQHEp8zxVKnujWfrFbILo3iBwAo6ycMMgW4iCtto49vAxDF7tzIXeTAl9EaI3ieA6yGg+4
        TZxY1bPIy5tXMpPTTfOykwdnbBzgD84=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FEE7133B5;
        Thu, 18 Aug 2022 12:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OKJhFkAw/mLiRAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 18 Aug 2022 12:27:44 +0000
Date:   Thu, 18 Aug 2022 14:27:43 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, tj@kernel.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] memcg: adjust memcg used to charge for new
 simple_xattrs objects
Message-ID: <20220818122743.GB19175@blackbody.suse.cz>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <f58bd7c8-0053-316c-db06-ced13ffcf867@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58bd7c8-0053-316c-db06-ced13ffcf867@openvz.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:10:45PM +0300, Vasily Averin <vvs@openvz.org> wrote:
> sys_set[f]xattr uses simple_xattr infrastructure to create a new
> extended attribute for in-memory file systems like sysfs and tmpfs.
> Number and size of allocated objects are controlled by user space,
> they are always living in memory and its lifetime is indefinitely long.
> Therefore this memory should be properly accounted.
> 
> By default new memory is accounted to memcg of creator process.

despite objects aren't bound to this process lifetime.

(I think this was the main argument for this approach and should be in
the commit message then.)

> As a result, neighboring xattrs of the same inode can be charged to
> different memcgs. This looks unexpected and makes hard the
> investigation of the memcg accounting issues.
> 
> This patch adjust memcg used for such allocations. For kernfs
> it gives memcg from kernfs node, for shmem -- from shmem_info.
> This allows to cahrge all inode-sepcific objects to the same
> memory cgroup.

IIUC you intend to inherit association from shmem_inode_info (i.e.
whoever created the inode). shmem_inode_cachep has SLAB_ACCOUNT, so it's valid.

Thanks,
Michal
