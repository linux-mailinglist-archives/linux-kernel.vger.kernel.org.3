Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC14A742B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbiBBPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345293AbiBBPBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643814081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LdYe0/2yXLTD/OVAh9OHIYB9qOHTi1p5PIuVGDR2rI=;
        b=h7Jgz2QeRs8PY0XLBuohBp1W/iLVtgXdX1cNOjLx8z67sLT5y0eHXkiCoolCN+9Twu9Yx0
        YaTAefYaw5EwqOdMqYQFVa2BXdDbTERhqozAKS7U3coWL1THUsK6YYByFaptWKDZbSXMQJ
        LGZwZIqSnQ6lVsz/52vFGr/ABp+Iviw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-Ewx3BCiyOa6z_39Tp6R5sQ-1; Wed, 02 Feb 2022 10:01:20 -0500
X-MC-Unique: Ewx3BCiyOa6z_39Tp6R5sQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D03ED84BA44;
        Wed,  2 Feb 2022 15:01:18 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F24A36E1ED;
        Wed,  2 Feb 2022 15:01:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Aligning tcmalloc with glibc 2.35 rseq ABI
References: <432231420.24682.1643727496135.JavaMail.zimbra@efficios.com>
        <CAEE+ybn_Cp1-T=2uB7xJqU2gEU-PxzsaV5jqCOupNp2cx_bK-Q@mail.gmail.com>
        <87mtja1fuz.fsf@oldenburg.str.redhat.com>
        <875ypx1x0d.fsf@oldenburg.str.redhat.com>
        <1375227765.27051.1643801804042.JavaMail.zimbra@efficios.com>
        <770517862.27112.1643807335312.JavaMail.zimbra@efficios.com>
Date:   Wed, 02 Feb 2022 16:01:15 +0100
In-Reply-To: <770517862.27112.1643807335312.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 2 Feb 2022 08:08:55 -0500
        (EST)")
Message-ID: <87o83pxqh0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> More to the point: is ptrdiff_t the correct type here ? I think so.
> Do we want to revert the ABI and wait another 6 months before we
> bring back rseq into glibc just for this ? I'm not sure this limitation
> justifies it.
>
> So if there is a quick way to fix that before the official 2.35 release,
> I'm all for it, otherwise I cannot say that __rseq_offset being an "int"
> rather than a "ptrdiff_t" will make much real-life difference (unless
> I'm proven wrong). But we will be stuck with this quirk forever.

I'm going to post a patch.  It's fairly small.

Thanks,
Florian

