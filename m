Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B185585604
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiG2UTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37B068AEED
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659125955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMcUxcfVmJZDY60TPfwQRvZMxKHISByXx0bXXjJ9aJ0=;
        b=gvzLXWC+W1ti86WWheSGa5CGwAeIxNIRqJxf38agdVanovc0FuHSNxgtsZQ4TzFNDKXoD6
        +N9YQ+DGK7vIwnmUpXILE1RkJb7DjSxKqwJtxUuue1kLz3iQJ05U5lnKoXLO8v5rr8xKb1
        2d1E7HZnIeAxY88OB10Xatm4TkxlYTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-AFmHYHloPau7aYA-o_7sKA-1; Fri, 29 Jul 2022 16:19:09 -0400
X-MC-Unique: AFmHYHloPau7aYA-o_7sKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EA78185A7B2;
        Fri, 29 Jul 2022 20:19:09 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DE122166B26;
        Fri, 29 Jul 2022 20:19:07 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
References: <20220729145525.1729066-1-Jason@zx2c4.com>
Date:   Fri, 29 Jul 2022 22:19:05 +0200
In-Reply-To: <20220729145525.1729066-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Fri, 29 Jul 2022 16:55:25 +0200")
Message-ID: <87a68r4qpy.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld:

> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> new file mode 100644
> index 000000000000..3ffc900f31ff
> --- /dev/null
> +++ b/lib/vdso/getrandom.c

> +static struct getrandom_state *find_free_bucket(struct getrandom_state *buckets)
> +{
> +	unsigned int start = 0, i;
> +
> +	if (getcpu(&start, NULL, NULL) == 0)
> +		start %= NUM_BUCKETS;

getcpu is not available everywhere.  Userspace/libc should probably
provide a CPU number hint as an additional argument during the vDSO
call.  We can load that easily enough from rseq.  That's going to be
faster on x86, too (the LSL instruction is quite slow).  The only
advantage of using getcpu like this is that it's compatible with a libc
that isn't rseq-enabled.

> +	for (i = start;;) {
> +		struct getrandom_state *state = &buckets[i];
> +
> +		if (cmpxchg(&state->in_use, false, true) == false)
> +			return state;
> +
> +		i = i == NUM_BUCKETS - 1 ? 0 : i + 1;
> +		if (i == start)
> +			break;
> +	}

Surely this scales very badly once the number of buckets is smaller than
the system processor count?

> +static ssize_t __always_inline
> +__cvdso_getrandom(void **state, void *buffer, size_t len, unsigned long flags)

> +more_batch:
> +	batch_len = min_t(size_t, sizeof(s->batch) - s->pos, len);
> +	if (batch_len) {
> +		memcpy_and_zero(buffer, s->batch, batch_len);
> +		s->pos += batch_len;
> +		buffer += batch_len;
> +		len -= batch_len;
> +		if (!len) {
> +			WRITE_ONCE(s->in_use, false);
> +			return ret;
> +		}
> +	}

I expect the main performance benefit comes from not doing any ChaCha20
work except on batch boundaries, not the vDSO acceleration as such.
Maybe that's something that should be tried first within the system call
implementation.  (Even for getrandom with a small buffer, it's not the
system call overhead that dominates, but something related to ChaCha20.)

Thanks,
Florian

