Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2643565AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiGDQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiGDQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9360C4A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B2361166
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 16:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24786C3411E;
        Mon,  4 Jul 2022 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656951223;
        bh=RA5+nJVfyyxORQFFFt6cc+rkcFqdB9b06K8VFwbLg4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ny57otLLk69XK/SfQxDvP6w01zcE3ARJvIfVOjz65diQmAEvDlapBV+QpEHmBeIiQ
         dJ0Vp3b0yjMwrT/Q2kW32vjEDrYvvRi14g4hgM5EVw/37qOpw/exH+DDIftoV1lXpI
         G4BmSjVFYpMeoR6kdarV2Xx9JXg8TvsS2GGtnDKE=
Date:   Mon, 4 Jul 2022 18:13:40 +0200
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
Message-ID: <YsMRtGg8xQ2Qicr2@kroah.com>
References: <20220701182041.2134313-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701182041.2134313-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 06:20:41PM +0000, Carlos Llamas wrote:
> +	binder_for_each_debugfs_entry(db_entry) {
> +		dentry = binderfs_create_file(binder_logs_root_dir,
> +					      db_entry->name,
> +					      db_entry->fops,
> +					      db_entry->data);
> +		if (IS_ERR(dentry)) {
> +			ret = PTR_ERR(dentry);
> +			goto out;
> +		}

I know this is a copy of what is there already, but there is never a
need to check the result of a debugfs_create_* call.  Just call it and
move on, never "abort" based on the result of a debugfs call, that's not
a good idea.

So can you change this here, or want to send a follow-on patch that
removes these checks?

>  	}
>  
>  	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");

Also there's never a need to save a directory, you can always look it up
when you want to remove it.

thanks,

greg k-h
