Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08F46925E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhLFJbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbhLFJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:31:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090CAC061746;
        Mon,  6 Dec 2021 01:27:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C53B611C3;
        Mon,  6 Dec 2021 09:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92C1C341C1;
        Mon,  6 Dec 2021 09:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638782866;
        bh=+KEH1wyCTVQV8yYlRLefpheJ5q0/Kh2n/Ai79tQXaW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a2lc2BOU6NKqfzUGKCy4Mjr96l6xPg6Nt2qTZsyliv7rrHouWQgq5sdXqv5MRDynh
         Jk/SyZ+ePSUg7i/cCv7K8k4ICdBaHdr8kZkCWX075IsHPMC7jjlKmerS7B3nVSykGg
         Falvkn7scIl2ykEeu6HS/n2/7yEg5UNdWXkQPyr7XFpdi/wbJAq+RzEObYjS0QfNR1
         394blKn414PL7DrwunsXpF7hEz+qyVA7ZEbnKtREzyOFyN5frS7NiCeSTQLKga4WmX
         PtwGkgRvfmGc0PqPHuaSaJN43C9fF/msEeg51EUcHxo4wX6DMaOA+t0WxWlkb1SFDB
         9QW+9ETp884AA==
Date:   Mon, 6 Dec 2021 10:27:41 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <20211206102741.209d1e94@coco.lan>
In-Reply-To: <20211206200639.203bcea3@canb.auug.org.au>
References: <20211206200639.203bcea3@canb.auug.org.au>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 6 Dec 2021 20:06:39 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> In commit
> 
>   c1c95d709941 ("media: uvcvideo: Increase UVC_CTRL_CONTROL_TIMEOUT to 5 seconds.")
> 
> Fixes tag
> 
>   Fixes:
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
Thanks! This is not actually a fixes tag, just a text to tell what
runtime errors were addressed. 

So, I'm changing the description to:

    media: uvcvideo: Increase UVC_CTRL_CONTROL_TIMEOUT to 5 seconds.
    
    Some uvc devices appear to require the maximum allowed USB timeout
    for GET_CUR/SET_CUR requests.
    
    So lets just bump the UVC control timeout to 5 seconds which is the
    same as the usb ctrl get/set defaults:
    USB_CTRL_GET_TIMEOUT 5000
    USB_CTRL_SET_TIMEOUT 5000
    
    It fixes the following runtime warnings:
       Failed to query (GET_CUR) UVC control 11 on unit 2: -110 (exp. 1).
       Failed to query (SET_CUR) UVC control 3 on unit 2: -110 (exp. 2).


in order to make it clearer.

Thanks,
Mauro
