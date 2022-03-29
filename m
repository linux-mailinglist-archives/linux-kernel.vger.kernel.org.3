Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1714EAC20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiC2LWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiC2LWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:22:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53415EBDD;
        Tue, 29 Mar 2022 04:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47BECB816A6;
        Tue, 29 Mar 2022 11:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54472C2BBE4;
        Tue, 29 Mar 2022 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648552817;
        bh=E81FCPi+Etf2KmbN+C+QAdZBuClJvLMOc181kxYJPsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz+Kd0s/9vrTVFOgTh1uAWSxsnoIpwVrXNlL32M860pAOi+hhtVTVoRzNrZ9+vfCp
         x0qFxBzHLuriHlkenMPW8UUeJhURGkhqF/N1LmgC6AaTww0XsT+dkVisuFq4t4oNhf
         cSKTVWLcjRUrwMr7OKGWalzGrmWlE/IQewyPF86MZ448rYV1sgDYlf7ycfR0o7b41W
         vuqr3Ui23iQfMB27ST3Q4mE6HqFhjHCKRCcJzjmDrPOXZwplttPLbqvuQWCY8vD0W6
         Ls/6d2akoY6sC6/f1DAZV9RBAOI3Nf5SxgevP9Mb3s8rQXNvtfquB/Q8PQ+H50Zlb1
         NfgHElF6fZLTQ==
Date:   Tue, 29 Mar 2022 13:20:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binderfs: Fix the maximum minor value in
 binderfs_binder_device_create() and binderfs_binder_ctl_create()
Message-ID: <20220329112011.j4xf2qjktfqokkyn@wittgenstein>
References: <ba880255b91b4682c21c62ae0bc5673e34a119aa.1648379891.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba880255b91b4682c21c62ae0bc5673e34a119aa.1648379891.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 01:18:17PM +0200, Christophe JAILLET wrote:
> ida_alloc_max(..., max, ...) returns values from 0 to max, inclusive.
> 
> So, BINDERFS_MAX_MINOR is a valid value for 'minor'.
> 
> BINDERFS_MAX_MINOR is '1U << MINORBITS' and we have:
> 	#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
> 
> So, When this value is used in MKDEV() and it will overflow.
> 
> Fixes: 3ad20fe393b3 ("binder: implement binderfs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is completely speculative.
> 
> The 'BINDERFS_MAX_MINOR_CAPPED - 1' is here only for symmetry with the
> BINDERFS_MAX_MINOR case. I'm not sure at all that is is needed and, more
> importantly, that it is correct.

Hm, since we're "removing" one alloctable device for the initial ipc
namespace, I think we need the -1 for the capped value.

Though I wonder if the simpler fix wouldn't just be to:

#define BINDERFS_MAX_MINOR MINORMASK

since include/linux/kdev_t.h has:

#define MINORBITS	20
#define MINORMASK	((1U << MINORBITS) - 1)
