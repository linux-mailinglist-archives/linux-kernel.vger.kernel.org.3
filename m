Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7E49A6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3421421AbiAYC0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:26:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58342 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357333AbiAXTtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:49:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5FBE42113A;
        Mon, 24 Jan 2022 19:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643053790;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSB/HKbk/o697vERtOHKC1oUxFtTGY1mq5Ymy+OsCfE=;
        b=sgK3GhGtwEfItF5vh2VmPhgD5Rf6JoYXxVsyPpGa4H5jbV3KcRkfF6+m441azdLepOhK9H
        WWuld4kkv5AZ0A0Mu00FrhN3sysxmihLFRW8mzZ5yxht0d/LDr/QOphQhOHV6Xw9wEWlRN
        CO0CWWluK3q09C17/l4nGp+09CPS0rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643053790;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSB/HKbk/o697vERtOHKC1oUxFtTGY1mq5Ymy+OsCfE=;
        b=AczkhFgdVZQppvz1h4XFkKufdIxGYT/bVxpC3BgLrXUwiOKCsKE9YjBYtHCniBCq5RxkU/
        XnEGb2Jq6i5IuUAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 45D07A3B83;
        Mon, 24 Jan 2022 19:49:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D6ECDA7A3; Mon, 24 Jan 2022 20:49:10 +0100 (CET)
Date:   Mon, 24 Jan 2022 20:49:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     trix@redhat.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] btrfs: initialize variable cancel
Message-ID: <20220124194910.GF14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, trix@redhat.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, nathan@kernel.org,
        ndesaulniers@google.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220121134522.832207-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121134522.832207-1-trix@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 05:45:22AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this problem
> ioctl.c:3333:8: warning: 3rd function call argument is an
>   uninitialized value
>     ret = exclop_start_or_cancel_reloc(fs_info,
> 
> cancel is only set in one branch of an if-check and is
> always used.  So initialize to false.
> 
> Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
> Signed-off-by: Tom Rix <trix@redhat.com>

Added to misc-next, with the updted subject line, thanks.
