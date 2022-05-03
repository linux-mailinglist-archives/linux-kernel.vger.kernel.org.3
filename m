Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79516518F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbiECVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiECVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85CA53FBE9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651611738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y04Td6KiP+r9auFduzWkTtZYDSiCkdHBaufmD3fdMDw=;
        b=dPn3m2c/ogLyoycpYX29loNbPVa6mEjdUqYSn6ioSRoevz82UswfQFcqOBC5cTfTmoRHnp
        ZIH2S6p1gq4tgDqlxci+9TSeJ93h+U1zC7sgzHIdvyg3cb4eP5SOU7SzZQOcDjDCJ+zlrL
        Clnhlwi/vlmdZK9onXIA5owQ2cRLpI4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-1BvBQgb1MCqsHqe4HoiWjw-1; Tue, 03 May 2022 17:02:16 -0400
X-MC-Unique: 1BvBQgb1MCqsHqe4HoiWjw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 232F118E52FB;
        Tue,  3 May 2022 21:02:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4E7B401474;
        Tue,  3 May 2022 21:02:15 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BB3D4418871C; Tue,  3 May 2022 15:57:51 -0300 (-03)
Date:   Tue, 3 May 2022 15:57:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <YnF7L2BsWqfJ/dx7@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220317150804.GB459366@lothringen>
 <YmbMUAkOxsStAP36@fuller.cnet>
 <871qxk27gk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qxk27gk.ffs@tglx>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:12:27PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 25 2022 at 13:29, Marcelo Tosatti wrote:
> > On Thu, Mar 17, 2022 at 04:08:04PM +0100, Frederic Weisbecker wrote:
> >> 
> >> I still see a few details to sort out but overall the whole thing looks good:
> 
> >From a cursery inspection there is more than a few details to sort out.
> 
> >>   Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
> >> 
> >> Perhaps it's time to apply this patchset on some branch and iterate from there.
> >> 
> >> Thomas, Peter, what do you think?
> >> 
> >> Thanks!
> >
> > Ping ?
> 
> This does not apply against 5.18-rc1, which was released on April
> 3rd. Oh, well. You are really new to kernel development, right?

I can resend.

> Don't bother to resend before I finished reviewing the pile.

Sure, thanks!!!

