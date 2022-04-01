Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2140E4EE7D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245130AbiDAFkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiDAFkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D8193157
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 761AF61B46
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FAFC340EE;
        Fri,  1 Apr 2022 05:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648791531;
        bh=idRurwlZhLY56xIhw05sesud6IxCOS559aOyQIT4ofY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jw/LLZTkEvakWoDSp1NQe8eAwdydMnAdUSdDxeQO4xijVb7dg07E4puORFyTPG9HL
         vOQLgWLn9HBFgZ+KO+6ZFRSoF9NOldy6Rz00Pz3KSvZp3za1R+onauIra4k9nCTeI+
         zUvHc5AvLYDz+reuH49yAQSIRCbSiEmdhwLzs/+s=
Date:   Fri, 1 Apr 2022 07:38:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] staging: android: ashmem: remove usage of list iterator
 after the loop body
Message-ID: <YkaP6UWmSZjxO/oA@kroah.com>
References: <20220331213934.866804-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331213934.866804-1-jakobkoschel@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:39:34PM +0200, Jakob Koschel wrote:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element
> [1].
> 
> Before, the code implicitly used the head when no element was found
> when using &pos->list. Since the new variable is only set if an
> element was found, the head needs to be used explicitly if the
> variable is NULL.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

What tree did you make this against?  This file is no longer in Linus's
tree.

thanks,

greg k-h
