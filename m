Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC750564C10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiGDDjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 23:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDDjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:39:13 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24B2622
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 20:39:09 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 7EC67C01D; Mon,  4 Jul 2022 05:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656905947; bh=N3c1eiQ7nwJJg69WAl+jbstvA3hNmOP3XxOxF8bdAH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQHyggw9mrB2lFZavRFDFOp/VP1YlvOdu3KR3ya9HuVOqE5VoDCBEBnvdSZnnEmdT
         1Hjzet1EBR5xuZHQaTydkH3PuZeJVApfAVID8z6eyDUTdcUemQL2QjGw+cFiwUF07T
         mnyAIPA6YA7T4PtMP+8WmkGUwTgiiJGI7Kj6PTHome04n4NU64Lw1pl0+H7JzXtUue
         BMEdMMV5BhCS8keKlvGDSGQ1MqkvrvDHBuP3NtvahmOr8FPKNC5A2hyaznh0lKnYNd
         +XUV7qZcYR7CumsNbI2DdAgeiMkeXHOSYibCFgxTFM8opacxnG6WC2ektQOWWrieN/
         U2KepKzupIOZg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 0E1F4C009;
        Mon,  4 Jul 2022 05:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656905946; bh=N3c1eiQ7nwJJg69WAl+jbstvA3hNmOP3XxOxF8bdAH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cdz3gC+OMwGPXDc8pOgDDCqx2HS4nAnAH46oK+3FxeA6v7z1t5Bb3yZ1//uWrfWJl
         A0l7SatELFmrCT7aNab73cqJXw0JAIKxgsLqR7f1DSjyfJkKGEH/1BejkXzrbGYPAB
         Rvoy1JWAlxT+0Wv3tnvaRgESgRhKb6tsvQhCsX7/STnyct+3W/gj8Sc4TDsfmV2D/C
         BkH1WtgKB9gLGjwf81jF4G2HMfw1QcKYUChMPuAYGy9jlu7CuLHMa4+jdiXltD477V
         gFzgUxEbDBlC0Ah2LdrHXMMArEwS2AQMCXrZNZqgA4XcAlzolEhPmJ+K6tCSzGttjm
         TK5LBzO1Npcww==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8cdbb83f;
        Mon, 4 Jul 2022 03:39:01 +0000 (UTC)
Date:   Mon, 4 Jul 2022 12:38:46 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <YsJgxoTyYxX1NwyW@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704014243.153050-1-kent.overstreet@gmail.com>
 <20220704014243.153050-3-kent.overstreet@gmail.com>
 <YsJO8gJeRwf96yTi@codewreck.org>
 <20220704030557.fm7xecylcq4z4zkr@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220704030557.fm7xecylcq4z4zkr@moria.home.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Christian, sorry I just noticed you weren't in Ccs again --
the patches are currently there if you want a look:
https://evilpiepirate.org/git/bcachefs.git/log/?h=9p_mempool 

I think it'll conflict a bit with your 8k non-read/write RPCs but I'll
take care of that when checking it this weekend.


Kent Overstreet wrote on Sun, Jul 03, 2022 at 11:05:57PM -0400:
> > We shouldn't have any user calling with more at this point (the
> > user-provided size comes from p9_client_prepare_req arguments and it's
> > either msize or header size constants); and it probably makes sense to
> > check and error out rather than cap it.
> 
> If that's the case I think we should just switch the warning to a BUG_ON() - I
> just wasn't sure from reading the code if that was really guarded against.

yes, BUG_ON is good for me.

> > > -	if (p9_fcall_init(c, &req->tc, alloc_msize))
> > > +	if (p9_fcall_init(c, &req->tc, 0, alloc_msize))
> > >  		goto free_req;
> > > -	if (p9_fcall_init(c, &req->rc, alloc_msize))
> > > +	if (p9_fcall_init(c, &req->rc, 1, alloc_msize))
> > 
> > given the two rc/tc buffers are of same size I don't see the point of
> > using two caches either, you could just double the min number of
> > elements to the same effect?
> 
> You can't double allocate from the same mempool, that will deadlock if multiple
> threads need the last element at the same time - I should've left a comment for
> that.

hmm, looking at the code as long as min elements is big enough the
deadlock becomes increasingly difficult to hit -- but I guess there's no
guarantee we won't get 8 threads each getting their first item from the
pool and starving each other on the second... Fair enough, thank you for
the comment.

> @@ -270,10 +276,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	if (!req)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (p9_fcall_init(c, &req->tc, alloc_msize))
> -		goto free_req;
> -	if (p9_fcall_init(c, &req->rc, alloc_msize))
> -		goto free;
> +	p9_fcall_init(c, &req->tc, 0, alloc_msize);
> +	p9_fcall_init(c, &req->rc, 1, alloc_msize);


mempool allocation never fails, correct?

(don't think this needs a comment, just making sure here)


This all looks good to me, will queue it up in my -next branch after
running some tests next weekend and hopefully submit when 5.20 opens
with the code making smaller allocs more common.

--
Dominique
