Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD0586690
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiHAIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiHAIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEF1432DAC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659343686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNJ0qfYYXdwgVW9QwtcOifyrJ9WJ2qkCp4TWBgANzYE=;
        b=AahoEn1XZ9JnroJnLRfg6nJSZ3P/9X2aczutwimpo8M7II/JP/qd8Kia+L5ckOFZMAvRjA
        vamiz2KCFw6FYmAmmbbzejAL7zxgjmNGFSehQ2/0bHtJ8xTvYQSbv0g+w4bP4AOYZQNau7
        h+xPbhSaNcr8/6qDLK9cT80zKUhfEsw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-cAt8bVrIN7ysxq6g8x7UFQ-1; Mon, 01 Aug 2022 04:48:05 -0400
X-MC-Unique: cAt8bVrIN7ysxq6g8x7UFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A0B03802B94;
        Mon,  1 Aug 2022 08:48:04 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD2972166B26;
        Mon,  1 Aug 2022 08:48:02 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v2] random: implement getrandom() in vDSO
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
        <20220731013125.2103601-1-Jason@zx2c4.com>
Date:   Mon, 01 Aug 2022 10:48:01 +0200
In-Reply-To: <20220731013125.2103601-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Sun, 31 Jul 2022 03:31:25 +0200")
Message-ID: <871qu0qri6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld:

> API-wise, vDSO getrandom has a pair of functions:
>
>   ssize_t getrandom(void *state, void *buffer, size_t len, unsigned int flags);
>   void *getrandom_alloc([inout] size_t *num, [out] size_t *size_per_each);
>
> In the first function, the return value and the latter 3 arguments are
> the same as ordinary getrandom(), while the first argument is a pointer
> to some state allocated with getrandom_alloc(). getrandom_alloc() takes
> the desired number of states, and returns an array of states, the number
> actually allocated, and the size in bytes of each one, enabling a libc
> to use one per thread. We very intentionally do *not* leave state
> allocation up to the caller. There are too many weird things that can go
> wrong, and it's important that vDSO does not provide too generic of a
> mechanism. It's not going to store its state in just any old memory
> address. It'll do it only in ones it allocates.

I still don't see why this couldn't be per-thread state (if you handle
fork generations somehow).

I also think it makes sense to introduce batching for the system call
implementation first, and tie that to the vDSO acceleration.  I expect a
large part of the benefit comes from the batching, not the system call
avoidance.

Thanks,
Florian

