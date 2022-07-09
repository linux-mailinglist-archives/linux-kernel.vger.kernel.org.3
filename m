Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8002056CA2B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGIOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGIOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:43:18 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2921F624
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:43:15 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D3A42C009; Sat,  9 Jul 2022 16:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657377793; bh=Aw3ipmbfX7HeLppcMOKDUFXLlpt4/DN5yWy0NUdSWr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V19aw6m+IhT5CXd4C2FkkNHbsOLZE6eTdbj6/oqtQLlJ34AWsr25i1NA86VGcOTxN
         k5zlJCtWOa9FlFPQuyCWd6ureanl/m0kRr/b/02uKaAyAZ1EL0Me4zwvqVRrMfgkRv
         ppgz+z5gY3vS21TH3mQuyHPC16SCpHoNzr8GiVDLnCZImGdcPJc2PS1lig+ozkyCEi
         CHNkFysRZoKhdN0R4T+pE67KUOdMIQFeBucfEV8N7rFnlyIC2GsjuejZZAEEf8W8x6
         n6SMZkZ6849+5wJoY7LDaiXRnjy0DfhNrG/RgxZcSDr2nJeP4Zjo1SMnIP12PL7J8Z
         SrUYn9T5LJt5Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 5396BC009;
        Sat,  9 Jul 2022 16:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657377793; bh=Aw3ipmbfX7HeLppcMOKDUFXLlpt4/DN5yWy0NUdSWr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V19aw6m+IhT5CXd4C2FkkNHbsOLZE6eTdbj6/oqtQLlJ34AWsr25i1NA86VGcOTxN
         k5zlJCtWOa9FlFPQuyCWd6ureanl/m0kRr/b/02uKaAyAZ1EL0Me4zwvqVRrMfgkRv
         ppgz+z5gY3vS21TH3mQuyHPC16SCpHoNzr8GiVDLnCZImGdcPJc2PS1lig+ozkyCEi
         CHNkFysRZoKhdN0R4T+pE67KUOdMIQFeBucfEV8N7rFnlyIC2GsjuejZZAEEf8W8x6
         n6SMZkZ6849+5wJoY7LDaiXRnjy0DfhNrG/RgxZcSDr2nJeP4Zjo1SMnIP12PL7J8Z
         SrUYn9T5LJt5Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id bf5b7337;
        Sat, 9 Jul 2022 14:43:08 +0000 (UTC)
Date:   Sat, 9 Jul 2022 23:42:53 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <YsmT7WHDh9NXZ/nV@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <72042449.h6Bkk5LDil@silver>
 <Yskxs4uQ4v8l7Zb9@codewreck.org>
 <1690934.P4sCSNuWZQ@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1690934.P4sCSNuWZQ@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Sat, Jul 09, 2022 at 04:21:46PM +0200:
> > The best thing to do would probably to just tell the client it can't use
> > the mempools for flushes -- the flushes are rare and will use small
> > buffers with your smaller allocations patch; I bet I wouldn't be able to
> > reproduce that anymore but it should probably just forbid the mempool
> > just in case.
> 
> So the problem is that one task ends up with more than 1 request at a time, 
> and the buffer is allocated and associated per request, not per task. If I am 
> not missing something, then this scenario (>1 request simultaniously per task) 
> currently may actually only happen with p9_client_flush() calls. Which 
> simplifies the problem.

Yes that should be the only case where this happens.


> So probably the best way would be to simply flip the call order such that 
> p9_tag_remove() is called before p9_client_flush(), similar to how it's 
> already done with p9_client_clunk() calls?

I don't think we can do that safely without some extra work - because
until we get the reply from the flush, the legitimate reply to the
original request can still come. It's perfectly possible that by the
time we sent the flush the server will have sent the normal reply to our
original request -- actually with flush stuck there it's actually almost
certain it has...

For trans fd for example the reads happen in a worker thread, if that
buffer disappears too early it'll fail with EIO and the whole mount will
break down as I think that'll just kill the read worker...
(actually how does that even work, it checks for rreq->status !=
REQ_STATUS_SENT but it should be FLSHD at this point .... erm)

In theory we can probably adjust the cancel() callback to make sure that
we never use the recv/send buffers from there on but it might be tricky,
still for tcp that's this 'm->rc.sdata' that will be read into and can
point to a recv buffer if we're mid-reading (e.g. got header for that
reply but it wasn't done in a single read() call and waiting for more
data); and that operatres without the client lock so we can't just take
it away easily...

Well, that'll need careful considerations... I think it'll be much
simpler to say flush calls are allocated weird and don't use the
mempool, even if it's another bit of legacy that'll be hard to
understand why we did that down the road...



> > Anyway, I'm not comfortable with this patch right now, a hang is worse
> > than an allocation failure warning.
> 
> As you already mentioned, with the pending 'net/9p: allocate appropriate 
> reduced message buffers' patch those hangs should not happen, as Tflush would 
> then just kmalloc() a small buffer. But I would probably still fix this issue 
> here nevertheless, as it might hurt in other ways in future. Shouldn't be too 
> much noise to swap the call order, right?

I definitely want to fix this even with your patches, yes.

--
Dominique
