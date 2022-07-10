Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B3E56CF35
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 15:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGJM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:58:26 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF7DFF6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=EK+6TEolrrVoFamKqlnUVwIVb1PwegRCKbfICY4Zt9I=; b=h3jLIjBMimiYDJNtTfQEyU3n/3
        2hrg2JopUlPkwPQ0uLpFUVsQtc88Tbsk9gFdZ8MOEoELPBsKlLAP1uwwAyEtmO1Sn/vzYiP5jJAYx
        ZKA0yYLudp4TYXp5OJmqpLFpWFITb3wwC1Oci+ndTOPK0aAPuaCgzUr/xCAF4iV3zOdMygvkBFhDZ
        ismiQedCsTiSl6O75E0U3e08gnkxb16ZV2tdglJN8mDlA/Uk3EQUAqVnnyEEEsUvuPuSC2COUZ/zy
        mTx/1UK/9NJuH5g8fm0j0ptQ4uAWyCmeDAe6TQ/tAmGNCVWMeGu2ku6eA7IrFfMI0lW7YaEWHqNM5
        3aWdCjvn6uEHN4ExSNwe38TlIRn9NVmj7RNuM+kFuBUvtjWhME/XUC7moG831TE6NdoZfF3xLp3hU
        fmJpqnVFrtdpBOZlWswAsAP+nC1TztMzvWLAJlbbbKgCttVedew2ltJTevKJlQJmCec8f9Ub67Srx
        9yPP9xkB/Aj75AWavmOgTk/PKvZgSKO6TkicndvNd1R6KKSxGIaSLkn899ePW6ZikRU+LNuxDQrg2
        uuEp0fOfBKYGwTAc+ktKANDF3XzXcEVF0AolIESOPf+Ap71uktbgFOxMsS8zJBWJyGLHIisS5+XOQ
        UHfTdhkNa345o5o/xnHdHjawy6TS0kFupEgTBm+JY=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Sun, 10 Jul 2022 14:57:58 +0200
Message-ID: <13813647.qg49PginWZ@silver>
In-Reply-To: <YsnqFqQodj9khp3Q@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org> <2211309.MyIe47cYEz@silver>
 <YsnqFqQodj9khp3Q@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg on CC: please correct me on false assumptions on QEMU side ...

On Samstag, 9. Juli 2022 22:50:30 CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Sat, Jul 09, 2022 at 08:08:41PM +0200:
> > Mmm, I "think" that wouldn't be something new. There is no guarantee that
> > client would not get a late response delivery by server of a request that
> > client has already thrown away.
> 
> No. Well, it shouldn't -- responding to tflush should guarantee that the
> associated request is thrown away by the server
> 
> https://9fans.github.io/plan9port/man/man9/flush.html

Yes, but that's another aspect of Tflush, its main purpose actually: client 
tells server that it no longer cares of previously sent request with oldtag=X. 
That prevents the server routines from hanging for good on things that client 
no longer cares for anyway, which otherwise evntually might lead to a complete 
server lockup on certain setups.

On QEMU side we have a dedicated 'synth' fs driver test case to ensure that 
this really works (a simulated fs I/O call that never returns -> Tflush aborts 
it -> Test Passed):

https://github.com/qemu/qemu/blob/master/tests/qtest/virtio-9p-test.c#L1234

> Order is not explicit, but I read this:
> > If it recognizes oldtag as the tag of a pending transaction, it should
> > abort any pending response and discard that tag.
> 
> late replies to the oldtag are no longer allowed once rflush has been
> sent.

That's not quite correct, it also explicitly says this:

"The server may respond to the pending request before responding to the 
Tflush."

And independent of what the 9p2000 spec says, consider this:

1. client sends a huge Twrite request
2. server starts to perform that write but it takes very long
3.A impatient client sends a Tflush to abort it
3.B server finally responds to Twrite with a normal Rwrite

These last two actions 3.A and 3.B may happen concurrently within the same 
transport time frame, or "at the same time" if you will. There is no way to 
prevent that from happening.

> But I guess that also depends on the transport being sequential -- that
> is the case for TCP but is it true for virtio as well? e.g. if a server
> replies something and immediately replies rflush are we guaranteed
> rflush is received second by the client?

That's more a higher level 9p server controller portion issue, not a low level 
transport one:

In the scenario described above, QEMU server would always send Rflush response 
second, yes. So client would receive:

1. Rwrite or R(l)error
2. Rflush

If the same assumption could be made for any 9p server implementation though, 
I could not say.

As for transport: virtio itself is really just two FIFO ringbuffers (one 
ringbuffer client -> server, one ringbuffer server -> client). Once either 
side placed their request/response message there, it is there, standing in the 
queue line and waiting for being pulled by the other side, no way back. Both 
sides pull out messages from their FIFO one by one, no look ahead. And a 
significant large time may pass for either side to pull the respective next 
message. Order of messages received on one side, always corresponds to order 
of messages being sent by other side, but that only applies to one ringbuffer 
(direction). The two ringbuffers (message directions) are completely 
independent from each other though, so no assumption can be made between them.


> There's also this bit:
> > When the client sends a Tflush, it must wait to receive the
> > corresponding Rflush before reusing oldtag for subsequent messages
> 
> if we free the request at this point we'd reuse the tag immediately,
> which definitely lead to troubles.

Yes, that's the point I never understood why this is done by Linux client. I 
find it problematic to recycle IDs in a distributed system within a short time 
window. Additionally it also makes 9p protocol debugging more difficult, as 
you often look at tag numbers in logs and think, "does this reference the 
previous request, or is it about a new one now?"

> > What happens on server side is: requests come in sequentially, and are
> > started to be processed exactly in that order. But then they are actually
> > running in parallel on worker threads, dispatched back and forth between
> > threads several times. And Tflush itself is really just another request.
> > So there is no guarantee that the response order corresponds to the order
> > of requests originally sent by client, and if client sent a Tflush, it
> > might still get a response to its causal, abolished "normal" request.
> 
> yes and processing flush ought to get a lock or something and look for
> oldtag.
> Looking at qemu code it does it right: processing flush find the old
> request and marks it as cancelled, then it waits for the request to
> finish (and possibly get discarded) during which (pdu_complete) it'll
> wake the flush up; so spurrious replies of a tag after flush should not
> be possible.
> 
> --
> Dominique


