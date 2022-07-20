Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6897457ADEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiGTC1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbiGTC1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:27:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278478DF7;
        Tue, 19 Jul 2022 19:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GeLms78lLUT8hpFTWlbc91pEODSOhUovsnQLyJDAT+0=; b=F2xrDxHqnWOzlhaQsrchtLzigm
        4pfpJpmoJz7FRxEjWxr9ralmUjPdbeeaX5GZS8Xgemz2OK9yU0hUPxDrkAcYKwHZabd74PrDfevQ7
        BMVS+fSm8SHkEh1vJyy9seEqXOtIpBxCc4u26JZYIdUvueyzRrCcl9VUPr7PQa2wCHkr2d79m6svY
        WKWmt/ZuOdkVE9qTH6o/rI362gld0K+FY+0DoaO+coX5FcbdwsolpGHefsUV/HrzYFVsJX/xIQs9U
        PBsxnnyAsaZY1MXG/C8TN6c04jllBWrUDML1VFBR+cTPHM6uvd9uZuXe1Xonm2pb4DXqsR2Zmws30
        lQJDLzjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDzM6-00Dx69-6w;
        Wed, 20 Jul 2022 02:22:30 +0000
Date:   Wed, 20 Jul 2022 03:22:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Message-ID: <Ytdm5gk0zvU0pBaG@ZenIV>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <20220717113634.1552-1-hdanton@sina.com>
 <0aa365ca-a9f0-8d15-b515-adb8823f5d28@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa365ca-a9f0-8d15-b515-adb8823f5d28@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 06:32:04PM +0200, Helge Deller wrote:
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -605,8 +605,12 @@ static void __dentry_kill(struct dentry
> >  		spin_unlock(&parent->d_lock);
> >  	if (dentry->d_inode)
> >  		dentry_unlink_inode(dentry);
> > -	else
> > +	else {
> > +		if (unlikely(d_in_lookup(dentry))) {
> > +			__d_lookup_done(dentry);
> > +		}
> >  		spin_unlock(&dentry->d_lock);
> > +	}

Ugh...  If that triggers, we really have a problem.  I don't see any
way for that to happen (well, short of generally fucked refcounting -
stray dput() on wrong address and all bets are off)
