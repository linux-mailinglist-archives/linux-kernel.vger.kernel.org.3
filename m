Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ECF59709C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiHQN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiHQN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:59:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE797D50
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H3k3eKgkc5W/rypnQlEYEwtVCCUR+mQYx2LOi4yW/+Q=; b=cm+td3tAk+z+UeZIKGm2BQimMI
        G68sGwut1or1CrTRAdKSz9+i/NBYOcukgv5qMQoudP6zHuZvF7BaDfO3CVW9MBl7SNy3ULF1PpFC0
        izh2TY1oV6zthDLFaEKiKTMbW7nfE/P59wHmKyFWNtaVqZkeDnUzmFZGRpFxJx6gCYexKAXnIcX8g
        Mhcg0Bu8EGhE7s4W+3KliLVYwnPDxy2ZMibHVKqMNJwTQPJeJYVMExqs+/kixoqpLUGIa/4VRByNG
        ElenP+Webex1t6HqquAEYHcg1xFgNNbL3m52J/yJYdoMvr/tFmVAKlh9jpyrGGrpalFZO4IwZO8dO
        TwQU4yzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOJZW-005Nio-RP;
        Wed, 17 Aug 2022 13:59:02 +0000
Date:   Wed, 17 Aug 2022 14:59:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binderfs: rework superblock destruction
Message-ID: <Yvz0JkdxXwY8uDyT@ZenIV>
References: <YvzUS/7bd1mm6c/V@kroah.com>
 <20220817130306.96978-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817130306.96978-1-brauner@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:03:06PM +0200, Christian Brauner wrote:

> +static void binderfs_kill_super(struct super_block *sb)
> +{
> +	struct binderfs_info *info = sb->s_fs_info;
> +
> +	if (info && info->ipc_ns)
> +		put_ipc_ns(info->ipc_ns);
> +
> +	kfree(info);
> +	kill_litter_super(sb);
> +}

Other way round, please - shut the superblock down, *then*
free the objects it'd been using.  IOW,

	struct binderfs_info *info = sb->s_fs_info;

	kill_litter_super(sb);

	if (info && info->ipc_ns)
		put_ipc_ns(info->ipc_ns);

	kfree(info);
