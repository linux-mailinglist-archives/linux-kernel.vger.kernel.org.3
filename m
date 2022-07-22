Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C4657DB0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiGVHSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiGVHRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCDCDFE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658474258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G08RO3bUIoXn+xETB+rf8zimU1kgXaXolUrxmZQvvWE=;
        b=PI+qBrF7L6t4s5VdA/Mv37yugxaL1mUK66YA8G7lfvB7YlXjez9zA7uUESCHRus8joD39+
        t2vY8PQJ6meNHNHdD9LdjVV0aGpUAxReNCmoi23EeCyaaMjYU4D0vdGbYzTps1q0I/B+0U
        55Du11597v3M7kYvEfjXjRSzmVLvwfc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612--wDrOknHO0G6pi81g5cMRg-1; Fri, 22 Jul 2022 03:17:37 -0400
X-MC-Unique: -wDrOknHO0G6pi81g5cMRg-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adfab11000000b0021e4c9ca970so706518wrc.20
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=G08RO3bUIoXn+xETB+rf8zimU1kgXaXolUrxmZQvvWE=;
        b=WO7LnFFVSTwE+BqUqdkOpwdJvFNhX8AdHP1YKfi1ZQPcGXjJ756KMYypflwdlYJfnW
         QbSalPxoboahpqCET7vPumlUbvd4dxLDlaJ41/wtCU9X0CJ4uAsj/bMA1JBZHUfiGvpT
         k1+/WtHsg6trfAyTEyOPkG+JxGRohG/bOW/o2wR+qA65umZ0artyFua537qPRK1EC1d7
         J36Cl+JfFhzzYtFaJBTdRqeVekNPccT5CHXbzFWy0V7dv5Piih/YTN6uDvbckQaqL8K1
         jXGQvHkrF+5Pyav0b0Wued1IqCa3Olcg/VIerNVTVsPPU8ax8oaIjlCdFOnLY5Q2sIyJ
         Cmig==
X-Gm-Message-State: AJIora8WQaiySEBzn6S2T654SnslSA+SA/CB1vt8snYzZixEdKcaCUMa
        8D0WQkOcLW4tliA/nuqZQjNeSPW8EtAJFYxTc2P17Vdgb9fy45M68AnJz/r6TulKwFwauTftn4x
        5OhpQvo8Yt6OnllHKwugw6vVa
X-Received: by 2002:a05:600c:4f05:b0:3a3:18ed:6cda with SMTP id l5-20020a05600c4f0500b003a318ed6cdamr11373805wmq.34.1658474256347;
        Fri, 22 Jul 2022 00:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vdUsN7LkzL1q1ftyRF+SbeOAV33fGOkKuBTiMZ5/hD8VMcy2oNPqWNBsgKX/gFt96gVxO3zA==
X-Received: by 2002:a05:600c:4f05:b0:3a3:18ed:6cda with SMTP id l5-20020a05600c4f0500b003a318ed6cdamr11373768wmq.34.1658474255921;
        Fri, 22 Jul 2022 00:17:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6? (p200300cbc707cb00cd6b7964cc7db0e6.dip0.t-ipconnect.de. [2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0021d746d4820sm3773278wrz.37.2022.07.22.00.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 00:17:35 -0700 (PDT)
Message-ID: <8fbbd68f-267c-1e0d-a578-7da4551c4c19@redhat.com>
Date:   Fri, 22 Jul 2022 09:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/3] selftests: soft-dirty: Add test for mprotect
In-Reply-To: <20220721183338.27871-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.22 20:33, Peter Xu wrote:
> Add two soft-diryt test cases for mprotect() on both anon or file.

s/soft-diryt/soft-dirty/

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/soft-dirty.c | 69 ++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
> index 08ab62a4a9d0..7d93906aa43f 100644
> --- a/tools/testing/selftests/vm/soft-dirty.c
> +++ b/tools/testing/selftests/vm/soft-dirty.c
> @@ -121,13 +121,78 @@ static void test_hugepage(int pagemap_fd, int pagesize)
>  	free(map);
>  }
>  
> +static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
> +{
> +	const char *type[] = {"file", "anon"};
> +	const char *fname = "./soft-dirty-test-file";
> +	int test_fd;
> +	char *map;

Instead of fname, unlink, open, close, unlink  you can use a tmpfile

FILE *file;

file = tmpfile();
if (!file) {
	ksft_test_result_fail("tmpfile() failed\n");
	return;
}
test_fd = fileno(file);

> +
> +	if (anon) {
> +		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
> +			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +		if (!map)
> +			ksft_exit_fail_msg("anon mmap failed\n");
> +	} else {
> +		unlink(fname);
> +		test_fd = open(fname, O_RDWR | O_CREAT);
> +		if (test_fd < 0) {
> +			ksft_test_result_skip("Test %s huge page allocation\n", __func__);

Wrong copy-paste I assume :)

> +			return;
> +		}
> +		ftruncate(test_fd, pagesize);
> +		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
> +			   MAP_SHARED, test_fd, 0);
> +		if (!map)
> +			ksft_exit_fail_msg("file mmap failed\n");
> +	}
> +

Apart from that LGTM.


-- 
Thanks,

David / dhildenb

