Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6A58E759
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiHJGeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiHJGeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34FC46E2D2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660113248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8IIzlB4jensj1oGktEeyGAu5ttHJ4e1db9NKIaRaDkY=;
        b=NVJUWg0KqNnI/yRxes7RWL21R7bs+tXjjUSniyzLvTT7FWMuEU2v89D5jKapWoLpxAkpaI
        TAqilS/hmhozXSgtptJxpIXPYGzTBazdaB0Czi0Tz01+eoD1HyH7NWpl0pBRzdH61bR4t0
        sRxF7ghlznz39Z3fwDsSpp9m+PYxhs4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-ynl2zvoXMO6j_n5de7QVDA-1; Wed, 10 Aug 2022 02:34:03 -0400
X-MC-Unique: ynl2zvoXMO6j_n5de7QVDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0BB485A597;
        Wed, 10 Aug 2022 06:34:02 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D120DC15BA1;
        Wed, 10 Aug 2022 06:33:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH v3 02/23] rseq: Introduce extensible rseq ABI
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
        <20220729190225.12726-3-mathieu.desnoyers@efficios.com>
Date:   Wed, 10 Aug 2022 08:33:58 +0200
In-Reply-To: <20220729190225.12726-3-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Fri, 29 Jul 2022 15:02:04 -0400")
Message-ID: <8735e4hajt.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Introduce the extensible rseq ABI, where the feature size supported by
> the kernel and the required alignment are communicated to user-space
> through ELF auxiliary vectors.
>
> This allows user-space to call rseq registration with a rseq_len of
> either 32 bytes for the original struct rseq size (which includes
> padding), or larger.
>
> If rseq_len is larger than 32 bytes, then it must be large enough to
> contain the feature size communicated to user-space through ELF
> auxiliary vectors.

I don't think this works with the glibc extension mechanism because
__rseq_size does not change until the padding is exhausted.

I think you'll need to add the suggested flags to the auxiliary vector,
and then we can use that during registration and also communicate these
flags via __rseq_flags.

Size and alignment can be stored in a single auxiliary vector entry.

Thanks,
Florian

