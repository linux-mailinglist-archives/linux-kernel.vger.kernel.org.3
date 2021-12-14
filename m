Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8782D4748C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhLNRD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:03:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhLNRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:03:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DE36210FE;
        Tue, 14 Dec 2021 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639501434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZRIDGZMBcaEYmJlHvnMlVWcu4Ss2HGVBXYGYwnsDiA=;
        b=IYiCw47fhWTVhnBpyAtGCXxu5IdlQzBJw0vVvCtE9+kzHITloK7BzkFIFuFJuuOXC9R5qJ
        NOHRbEFZKWKw3tNIHL1hV4SLDjcLPMt/c0pd7LdtSl1/+2AG4IfL6dnWhrLDglLSv+0Xzi
        4OogBbqbjKzH7KlrL8v/9cMwmKyYV6Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 400F413D17;
        Tue, 14 Dec 2021 17:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X08iD3rOuGE9FQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Dec 2021 17:03:54 +0000
Date:   Tue, 14 Dec 2021 18:03:52 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        axboe@kernel.dk, keescook@chromium.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, jnewsome@torproject.org,
        legion@kernel.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for
 kernfs_open_file->priv
Message-ID: <20211214170352.GA7969@blackbody.suse.cz>
References: <20211213191833.916632-1-tj@kernel.org>
 <20211213191833.916632-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213191833.916632-3-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:18:29AM -1000, Tejun Heo <tj@kernel.org> wrote:
>  static int cgroup_file_open(struct kernfs_open_file *of)

IIUC, this is common to v1 files too, i.e. cgroup_pidlist_start too.

>  static void cgroup_file_release(struct kernfs_open_file *of)
>  {
>  	struct cftype *cft = of_cft(of);
> +	struct cgroup_file_ctx *ctx = of->priv;
>  
>  	if (cft->release)
>  		cft->release(of);
> +	kfree(ctx);

Here it could free a pointer to pidlist that has different lifecycle.

Perhaps add one more slot into cgroup_file_ctx for the pidlist pointer?
