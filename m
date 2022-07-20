Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3A57AD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiGTCAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiGTCAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:00:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5941D22;
        Tue, 19 Jul 2022 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8OZOCeLP5CBGvaVjO2gsJvfT/Ajw507MB0pX4X8/nA=; b=qO5Dit/llh4/p0+KMpkJSKLmFL
        Do5KMnrHnidSkgu3WfczDCQklbBiivUrAOgYxxpaqDhzore0+cObHGZyOfD3H3cbY9fbo46j4ddqg
        7A1x2SIMakdlX1PjmgoiZbgY8Wy9B+FZWpLxo7AuyN6uj8x6mDo7dOe0ASZUc405AvxD83u+iARF3
        +lhIrixVqL6QKIsajAF2pHk/wA9YKmfeh/t8NcOQJ2nTuhzfes9YSen/hUA+BfMRlY0/B47us9yLZ
        BCraDg+IZe5LMpXPlwpPDAbdWzW4qEq/azI5L1PhEpZ9Sj580rzcD9g0nKLNX+x5YMtAt4yV/dch5
        Ls413SPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDz0h-00DwnJ-JA;
        Wed, 20 Jul 2022 02:00:23 +0000
Date:   Wed, 20 Jul 2022 03:00:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     John David Anglin <dave.anglin@bell.net>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Message-ID: <YtdhtyiEOGFhYdfP@ZenIV>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <20220717113634.1552-1-hdanton@sina.com>
 <0aa365ca-a9f0-8d15-b515-adb8823f5d28@gmx.de>
 <7d53692b-6ac8-e1bd-4d0d-7e97aa01b18d@bell.net>
 <76e47f90-bcc2-caab-50c5-6bff7fdc5c1d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76e47f90-bcc2-caab-50c5-6bff7fdc5c1d@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:25:07PM +0200, Helge Deller wrote:
> On 7/19/22 22:59, John David Anglin wrote:
> > Hi Helge,
> >
> > I hit this warning with the patch below building ghc on mx3210:
> 
> As I wrote, I didn't faced it yet on my buildd server, but that could
> just have been luck...
> Hillf, should we try if this second hunk triggers?
> 
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -616,6 +618,7 @@ static void __dentry_kill(struct dentry
>  		dentry->d_flags |= DCACHE_MAY_FREE;
>  		can_free = false;
>  	}
> +	BUG_ON(!hlist_unhashed(&dentry->d_u.d_alias));
>  	spin_unlock(&dentry->d_lock);
>  	if (likely(can_free))
>  		dentry_free(dentry);

Would you gentlemen mind Cc'ing the entire thing to fsdevel?  Or at
least forwarding it my way...
