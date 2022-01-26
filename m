Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF149C05C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiAZAye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiAZAyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:54:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85561C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:54:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f17so22896464wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+IOoaRUwhDB/ZqwgFNNRRG4Ny5wg307a8+t9aOYBrUQ=;
        b=0CuYLuzgiRGoZNpAu+eYDScbPYOzihHunayLSRb/l//xtYxe4ln/nXHmpVVZOi0JQl
         2x5eBLsAh3l+QfirSUYL5pDXqxagi5V4CY0Wi+qQcqjEgBH8JciZS9XI9bLsFg7GG1tU
         itBcHi4JumL5Dfog5x7jKprleRIPCY6JznS1q+p3/YcfpDZnP/dsLEpcldIiZ15gbJrR
         zFw64mvwc/85+1Z1pB0QTYcQ6KdwM/05sxJOLjXWyRytL2ht+fqvFcKoQRljWC8xh/ws
         tsLR+Kjjt4jE7sgqSlEeDRb+hslKKpvC3E0Sr7MtM6mtCjTxdWNuPRWMxksziKEe7ms0
         0MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+IOoaRUwhDB/ZqwgFNNRRG4Ny5wg307a8+t9aOYBrUQ=;
        b=HTtgNFDCKKiK+3bWz6Lk2JA18cZoTsIr8fuSra5CuSYQLROY83z3lENUqM3IuMx6RP
         SFze+TJSSAlcyfh9wZpmUJcqbTFYjbkQviujuwoHbfg9B0vxk0uO+TbelxjQigWeyKqC
         7ZVi/OhNP3S3vPywJaMWg4aaW2SbzqNnGdIV4gg2X/YRAlzQ9QdG2wJuFJYbZvLOIRmy
         RoNtY7F/sGXx4AzI1p8dzd+kM/dO7cdJyvdiF3VKJyCAFt/opzCWJ7EUWycOPDikoEpV
         87+DhSCRKIxZ+tRpmHj1U5hNy7gZ2ekkxFfY+s+19wO1T5K9E/xWOxOUwVqe7OCzBPeG
         hlZg==
X-Gm-Message-State: AOAM532Ve3VB/P17y8UgzScFufVl1wI9wVQc4fvtm/RxJRfBuXRPLgcN
        pffA3mSP6m0VZhwnRVBnQYlmrA==
X-Google-Smtp-Source: ABdhPJyuM9Xk+t8vJ2QLgBto0c4RcBf5cwFgcEnswrQQigRFhA1BXy1t4YNV++HnERnh3MfkGkZXdQ==
X-Received: by 2002:a5d:6d07:: with SMTP id e7mr14553139wrq.53.1643158469963;
        Tue, 25 Jan 2022 16:54:29 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id w6sm1691611wmi.15.2022.01.25.16.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:54:29 -0800 (PST)
Date:   Wed, 26 Jan 2022 00:54:27 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: Re: [PATCH 02/10] staging: r8188eu: remove smaller sets of DBG_88E
 calls from core dir
Message-ID: <YfCbw3ENI/1tEdwi@equinox>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-3-phil@philpotter.co.uk>
 <20220125090233.GR1978@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125090233.GR1978@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:02:33PM +0300, Dan Carpenter wrote:
> On Mon, Jan 24, 2022 at 10:44:07PM +0000, Phillip Potter wrote:
> >  void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
> >  {
> >  	if (*sctx) {
> > -		if (rtw_sctx_chk_waring_status(status))
> > -			DBG_88E("%s status:%d\n", __func__, status);
> > +		rtw_sctx_chk_waring_status(status);
> 
> In a follow on patch, can you just remove the rtw_sctx_chk_waring_status()
> function?
> 
> Looking through these warnings, a mass delete is the right thing.  The
> debugging messages are garbage.  Use ftrace.  Some of the errors are
> debug level so they will never be seen.  If you enable printing error
> messages, it print a debug information but at error level so that's
> useless.  Forget about it.  Just delete it.
> 
> You're going to need to redo these again because kbuild found some
> build warnings...
> 
> Normally we would say if you're deleting a printk() and that makes the
> curly braces unnecessary, then you have to delete the curly braces in
> the same patch.  But in this case, you're changing a ton of code and
> deleting the curly braces makes it hard to review.  I would prefer it
> if you just deleted the printks and fixed up the curly braces in a
> follow up patch.  And please don't fix long line warnings either.  Do
> that in another even later patch if you want.
> 
> You do need to fix any build warnings about unused variables etc, but
> don't worry about checkpatch until the end.
> 
> Basically as much as possible I'd prefer to only see deleted lines in
> this patch.  No insertions.
> 
>  12 files changed, 66 insertions(+), 472 deletions(-)
> 
> There was one function where you removed the padatper argument because
> it wasn't necessary.  That's great but do it in a follow on patch.
> Keep a notepad app next to your vim and write down notes as you go:
> 
> 0) Re-run checkpatch and delete unnecessary curly braces
> 1) Delete rtw_sctx_chk_waring_status()
> 2) padatper not needed for frob_whatever()
> 3) Fix long lines
> 
> regards,
> dan carpenter

Hi Dan,

Thank you for the feedback - reason I removed the padapter arg is
because I was the one that added it. To be clear, you're happy with this
and the brace changes etc. as long as I take them out within a separate
patch at the end of the series?

I had quite a few unused variable errors along the way, but evidently
with the way my build system is setup it doesn't currently show set but
unused variables. I will fix this and deal with the kernel test robot
warnings. Many thanks.

Regards,
Phil
