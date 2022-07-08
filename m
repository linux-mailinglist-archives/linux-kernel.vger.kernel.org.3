Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E165D56B27B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiGHGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGHGA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:00:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0256796B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 863A4B82180
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF28C341C0;
        Fri,  8 Jul 2022 06:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657260053;
        bh=dXI0ydkI0gH5Adp5AZuZsBLs8S1C1HOzZ5FfOEitHg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iui1rLlTqQNl1NjhHrLveNP6jtEVbIE6T2vQBdQ2GgTvzGUyqSVOFuWCZ5Kcqeaor
         vBHW5gAEknOZ44MQm9gMT6fziEmhfr5ACBXxjKuB4wc59yjaLnsypqZL2hBeEVsGHj
         K8zwimve+NHPCeyKMB6QZJhRUHLL+vp9ua6+lohs=
Date:   Fri, 8 Jul 2022 08:00:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] binder: fix redefinition of seq_file attributes
Message-ID: <YsfIEibU3xVafMVg@kroah.com>
References: <20220701182041.2134313-1-cmllamas@google.com>
 <YsMRtGg8xQ2Qicr2@kroah.com>
 <YsdOcFxGTGkYvtd4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsdOcFxGTGkYvtd4@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:21:52PM +0000, Carlos Llamas wrote:
> On Mon, Jul 04, 2022 at 06:13:40PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 01, 2022 at 06:20:41PM +0000, Carlos Llamas wrote:
> > > +	binder_for_each_debugfs_entry(db_entry) {
> > > +		dentry = binderfs_create_file(binder_logs_root_dir,
> > > +					      db_entry->name,
> > > +					      db_entry->fops,
> > > +					      db_entry->data);
> > > +		if (IS_ERR(dentry)) {
> > > +			ret = PTR_ERR(dentry);
> > > +			goto out;
> > > +		}
> > 
> > I know this is a copy of what is there already, but there is never a
> > need to check the result of a debugfs_create_* call.  Just call it and
> > move on, never "abort" based on the result of a debugfs call, that's not
> > a good idea.
> 
> This is true, none of these debugfs files seem critical for mounting a
> binderfs instance. I'm thinking init_binder_logs() should just return
> void. I'm only a bit hesitant to completely ignore the return code as
> users specifically ask for these files to be created via mount option
> "stats". So probably a pr_warn is what is actually needed here.

That would just be too noisy, just let it go, no one cares :)

> > So can you change this here, or want to send a follow-on patch that
> > removes these checks?
> 
> Sure, I'll send a follow-on patch. I'm currently AFK so setting ETA for
> next week until I can actually test this change.
> 
> > 
> > >  	}
> > >  
> > >  	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");
> > 
> > Also there's never a need to save a directory, you can always look it up
> > when you want to remove it.
> 
> It seems this is a convenient way to share this path with binder which
> otherwise doesn't know where binderfs was mounted. From having a quick
> look it doesn't seem that we need to share all the details in struct
> binderfs_info though. Maybe there is a better way to handle all this.

Why would you need to share this internally with anything, again, it can
always be looked up if you need it.

thanks,

greg k-h
