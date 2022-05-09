Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1026251FF0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiEIOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiEIOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D1296BDA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA63F6158D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A6EC385A8;
        Mon,  9 May 2022 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652105086;
        bh=y8ZYGkkbMyz3QZYuRXnMzVpiBxq4eFVPDLsunhL+Sqk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=rfDMchSnZglYZxT/1QsriPLZqxhxQ1aX5KOwYSCSk/MMZ7uamQjYe8Pgi3gqrHm43
         rhJvHN9B+79O3D+ghpj0X2zfSbXihQDyGntJRzV1F/VV0VbNmKyagSVeOydFjpE7hP
         m0NZENoGVQ38Wh2Ua3GKQyTtx4kDTLUoQ1Hi6t9I=
Date:   Mon, 9 May 2022 16:04:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCHv2] speakup: Generate speakupmap.h automatically
Message-ID: <YnkfeyobcOOgDGkH@kroah.com>
References: <20220430003934.fkua7vwoz6heigrp@begin>
 <20220430073321.6b4lvrrt7buzh7dp@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220430073321.6b4lvrrt7buzh7dp@begin>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 09:33:21AM +0200, Samuel Thibault wrote:
> speakupmap.h was not actually intended to be source code, speakupmap.map
> is.
> 
> This resurrects the makemapdata.c and genmap.c tools to generate
> speakupmap.h automatically from the input and speakup headers, and the
> speakupmap.map keyboard mapping source file.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> ---
> difference with v1:
> - Add missing dependency between main.c and speakupmap.h
> 
>  drivers/accessibility/speakup/Makefile      |   28 ++++
>  drivers/accessibility/speakup/genmap.c      |  162 ++++++++++++++++++++++++++++
>  drivers/accessibility/speakup/makemapdata.c |  125 +++++++++++++++++++++
>  drivers/accessibility/speakup/speakupmap.h  |   66 -----------
>  drivers/accessibility/speakup/utils.c       |   92 +++++++++++++++
>  drivers/accessibility/speakup/utils.h       |   33 +++++
>  6 files changed, 440 insertions(+), 66 deletions(-)

Any reason you can't add the code in utils.c into genmap.c and then
merge into makemapdata.c to make this a single .c file that does both
things?

And when this is applied, I get the following "extra" files in the tree
that need to be properly ignored, so I couldn't take this as-is anyway:

❯ git status
On branch work-testing
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	drivers/accessibility/speakup/genmap
	drivers/accessibility/speakup/makemapdata
	drivers/accessibility/speakup/mapdata.h
	drivers/accessibility/speakup/speakupmap.h

nothing added to commit but untracked files present (use "git add" to track)

thanks,

greg k-h
