Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2A52D592
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiESOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbiESOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:05:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6DA959A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:05:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p12so5298685pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y986+ZdOckPzlJLXnwDbvrNORPQJ9hBww73y7LpLMPI=;
        b=cSPr5PM/WyUmap+iM0KLutmdQ44fhG8oUl6rtz2CtZvLyKXw2Ax1ypdwik2OVPGWPZ
         9OtYgovB/0k2KitlgP6hokdD/5iVBiCSfEQSo8tVa56jYPRvcUeLABUdvrDyZ+y6HsAb
         8PbDL2S1P5jl+66HzLznx2V1z9a2LoxlWKkVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y986+ZdOckPzlJLXnwDbvrNORPQJ9hBww73y7LpLMPI=;
        b=6gLyzbMUY1yFBcjP9l1p2KQqSnyhcg8MftonCNpY0dDwDQ1pYoB2PsPfapiSWeyT2L
         DHi3JY4fpqWO6+maxGl5VKVAYB3ivWOQyvdd/ebIfyRMlNtnkPKxK32h7xi0R/VfR0Mj
         wrIBAmV4ib+NLhJVq1gO6HB2OSIFyO44jYW24oFJRfNU2IeDZmubGZRbeqFBzTkxSFoO
         knKSocxYQjDX/vhQaq/tdRCPvoNqwA7WY5fQlKc5hLvfvCv6t69YV4rkt1frNsJjUM+y
         g4xrF71Jj7cnrhbRPx5d60VKnRX6ipsyODcM3EfGSi0FN+XdkpE82wwtsZlDbGW44Z/x
         HqHw==
X-Gm-Message-State: AOAM5302xPG/l/5YUphiPqM+JDJ4MgNJI0m9agyW77XX+8kphaPIAfE2
        QhY5Q2r4bmyqRb23959bl2G0Eg==
X-Google-Smtp-Source: ABdhPJwMigcttytqn51A8Stz9WgyRJpRz32o96ysMbkIOFG3N7lbCf8x6SeG3faP33vhjYsJ7UVViQ==
X-Received: by 2002:a63:fb02:0:b0:3c1:9513:2e11 with SMTP id o2-20020a63fb02000000b003c195132e11mr4183986pgh.258.1652969150525;
        Thu, 19 May 2022 07:05:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0015e8d4eb2afsm3855534plk.249.2022.05.19.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:05:49 -0700 (PDT)
Date:   Thu, 19 May 2022 07:05:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevek@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix gcc-12 warning by embedding vfs inode in
 netfs_i_context
Message-ID: <202205190704.1DC660E5E@keescook>
References: <165296786831.3591209.12111293034669289733.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165296786831.3591209.12111293034669289733.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 02:44:28PM +0100, David Howells wrote:
> While randstruct was satisfied with using an open-coded "void *" offset
> cast for the netfs_i_context <-> inode casting, __builtin_object_size() as
> used by FORTIFY_SOURCE was not as easily fooled.  This was causing the
> following complaint[1] from gcc v12:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./include/linux/ceph/ceph_debug.h:7,
>                  from fs/ceph/inode.c:2:
> In function 'fortify_memset_chk',
>     inlined from 'netfs_i_context_init' at ./include/linux/netfs.h:326:2,
>     inlined from 'ceph_alloc_inode' at fs/ceph/inode.c:463:2:
> ./include/linux/fortify-string.h:242:25: warning: call to '__write_overflow_field' declared with attribute warning:
> detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   242 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by embedding a struct inode into struct netfs_i_context (which
> should perhaps be renamed to struct netfs_inode).  The struct inode
> vfs_inode fields are then removed from the 9p, afs, ceph and cifs inode
> structs and vfs_inode is then simply changed to "nic.inode" in those
> filesystems.
> 
> Most of the changes were done with:
> 
>   perl -p -i -e 's/vfs_inode/nic.inode/'g \
> 	`git grep -l 'vfs_inode' -- fs/{9p,afs,ceph,cifs}/*.[ch]`
> 
> Kees suggested doing it with a pair structure[2] and a special declarator
> to insert that into the network filesystem's inode wrapper[3], but I think
> it's cleaner to embed it - and then it doesn't matter if struct
> randomisation reorders things.
> 
> Fixes: bc899ee1c898 ("netfs: Add a netfs inode context")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Kees Cook <keescook@chromium.org>
> cc: Jonathan Corbet <corbet@lwn.net>
> cc: Eric Van Hensbergen <ericvh@gmail.com>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Steve French <smfrench@gmail.com>
> cc: William Kucharski <william.kucharski@oracle.com>
> cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> cc: linux-doc@vger.kernel.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-afs@lists.infradead.org
> cc: ceph-devel@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: samba-technical@lists.samba.org
> cc: linux-fsdevek@vger.kernel.org
> cc: linux-hardening@vger.kernel.org
> Link: https://lore.kernel.org/r/d2ad3a3d7bdd794c6efb562d2f2b655fb67756b9.camel@kernel.org/ [1]
> Link: https://lore.kernel.org/r/20220517210230.864239-1-keescook@chromium.org/ [2]
> Link: https://lore.kernel.org/r/20220518202212.2322058-1-keescook@chromium.org/ [3]

Works for me! :) Thanks for building the alternative.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
