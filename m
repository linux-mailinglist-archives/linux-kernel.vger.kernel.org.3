Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B34C4777
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbiBYObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbiBYObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0584A2325EA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645799431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31ddj2FGbLXm1jpn+KxL0nZeHBs+QByAvpjKBS8rBxM=;
        b=bAbFITOEn0K7yvglkV1TV1z6/LUkMGj8BU/bl6Y3zkNCT2BcYMW9uXHbRXaIJb30PRaXwo
        wGHjxBpOGjWgpwvD/kiPQrX+NVsc2yu6Tm4Pgs/nKy64qRpSaL3RYoq/PmaG2FqiXsUmtt
        FluwhGpv9ezXTnWhWQQpEm1k4yVDCNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-sviDcEc-OXO9S9jHIznklg-1; Fri, 25 Feb 2022 09:30:25 -0500
X-MC-Unique: sviDcEc-OXO9S9jHIznklg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25E061006AA6;
        Fri, 25 Feb 2022 14:30:24 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 010EF7C5B8;
        Fri, 25 Feb 2022 14:30:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 73F492237E9; Fri, 25 Feb 2022 09:30:23 -0500 (EST)
Date:   Fri, 25 Feb 2022 09:30:23 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
Message-ID: <Yhjn/zmdlAFtvRR0@redhat.com>
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com>
 <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
 <YhjYSMIE2NBZ/dGr@redhat.com>
 <YhjeX0HvXbED65IM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhjeX0HvXbED65IM@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 01:49:19PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 25, 2022 at 08:23:20AM -0500, Vivek Goyal wrote:
> > What about local events. I am assuming you want to supress local events
> > and only deliver remote events. Because having both local and remote
> > events delivered at the same time will be just confusing at best.
> 
> This paragraph confuses me.  If I'm writing, for example, a file manager
> and I want it to update its display automatically when another task alters
> the contents of a directory, I don't care whether the modification was
> done locally or remotely.
> 
> If I understand the SMB protocol correctly, it allows the client to take
> out a lease on a directory and not send its modifications back to the
> server until the client chooses to (or the server breaks the lease).
> So you wouldn't get any remote notifications because the client hasn't
> told the server.

So we will get remote notifications when client flushes changes to server,
IIUC. But in this case, given changes are happening on same client, local
events will make sense because we will come to know about changes much
sooner.

But if another client was watching for changes too, it will not come to
know about these events till first client flushes these changes to
server.

Anyway, it is a good point. This is a good example of where we might want
local events too. 

This raises question how applications will handle the situation, if we allow
both local and remote events, then there will be too many duplicate events.
One event for local change and another will be sent by server when server
notices the change.

May be there needs to be a way to supress remote event if we already
generated local event. But not sure how would one figure that out. If
server can somehow not send remote events to the client which triggered
the event (and send remote events to all other clients), may be that will
help.

Havid said that, it might not be easy for server to figure out which
client triggered the event and not send remote event back to that client.

May be we should allow both local and remote events. And probably event
should carry additional property which says whether event was local or
remote. And then let application deal with it?  I am not sure, just
thinking loud. 

Thanks
Vivek

