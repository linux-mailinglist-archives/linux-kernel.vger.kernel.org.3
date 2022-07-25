Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BCD5800B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiGYO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiGYO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 493EADEA0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658759292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8qUcwH3m8y+zN+ipPSVgiWBq6UiorsdAzJX2yubs9Y=;
        b=HzMncxW66r72xqIQIo4O/ryfvU4YmTAO8w1cFRVUUld3ShyEk3X+TcCIW1xBQaN3QH03av
        icqLNVzT+Cp2RExs/8TY3HjB09pTCAPFKGEZLxRo/coLGTUFuGmM+VoYk/IKTWTqIiVyue
        VddQNymJH3IWxzek0NCqkP3xiIBO39s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-dIAqhYdrO9e0XiW-v61MMA-1; Mon, 25 Jul 2022 10:28:11 -0400
X-MC-Unique: dIAqhYdrO9e0XiW-v61MMA-1
Received: by mail-wm1-f70.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so4149967wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=B8qUcwH3m8y+zN+ipPSVgiWBq6UiorsdAzJX2yubs9Y=;
        b=O1ey7/IUG+be2XKLYzxuE3yxyzuB/quKr3d5nwa3uKYWGgZG9rS7w1dJxeG6tEqJ9g
         zF/3Hf9gC23lpR4BLqnrkcESwBVgCvO0TDY8i9orpAzGB+akgnoq8daHK/xRRTACjopK
         N9Rtvu3N8r5jQXpYHztcBSbYMz0EadIxJp4HKoy7rYN/Bpt5VEJ18O8wrXZs6GZ13+3Z
         A/CquAFpau2ByukKkz8+4spWIqf2gkkOknluTtq81BXXSCAGvhx31NIoPEZvGwtL5P2v
         lHwDzgf1Pz1RbOlZcGTDYAaq2MDi47qioTfIRLzOOP+alC6NeD3q1xchmJjM60rTVyav
         /+kQ==
X-Gm-Message-State: AJIora96SUyrPJttXcses2ulmSUZRPFd9qK2HRPpbKU++JQDUOFoULEa
        CcLCpxgc25aOwB4YmZA31VCQt5oWhFKtDooJWg+HA1gIYQDT4+TBGZ7CDSlFs3SiwgPaKQ7Sf0t
        hX2nwqkZJZ4LrvhbN2X2Kb1dn
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr7664504wrb.466.1658759289352;
        Mon, 25 Jul 2022 07:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uWK+gDi8Y9cYa3Fq+hzZ2Ca6yCvNRZcmXHipnk9cmDimUYuuoouiW2jcYiUC/HjaTTGykKHQ==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr7664476wrb.466.1658759288799;
        Mon, 25 Jul 2022 07:28:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8c00:eee4:63f0:cef2:5ac0? (p200300cbc7048c00eee463f0cef25ac0.dip0.t-ipconnect.de. [2003:cb:c704:8c00:eee4:63f0:cef2:5ac0])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c22c900b003a3270735besm14580518wmg.28.2022.07.25.07.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 07:28:08 -0700 (PDT)
Message-ID: <3b85bf1f-2383-7e26-c123-f300027bada0@redhat.com>
Date:   Mon, 25 Jul 2022 16:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/3] selftests: soft-dirty: Add test for mprotect
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220725142048.30450-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.22 16:20, Peter Xu wrote:
> Add two soft-dirty test cases for mprotect() on both anon or file.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/soft-dirty.c | 67 ++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
> index 08ab62a4a9d0..e3a43f5d4fa2 100644
> --- a/tools/testing/selftests/vm/soft-dirty.c
> +++ b/tools/testing/selftests/vm/soft-dirty.c
> @@ -121,13 +121,76 @@ static void test_hugepage(int pagemap_fd, int pagesize)
>  	free(map);
>  }
>  
> +static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
> +{
> +	const char *type[] = {"file", "anon"};
> +	const char *fname = "./soft-dirty-test-file";
> +	int test_fd;
> +	char *map;
> +
> +	if (anon) {
> +		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
> +			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +		if (!map)
> +			ksft_exit_fail_msg("anon mmap failed\n");
> +	} else {
> +		test_fd = open(fname, O_RDWR | O_CREAT);
> +		if (test_fd < 0) {
> +			ksft_test_result_skip("Test %s open() file failed\n", __func__);
> +			return;
> +		}
> +		unlink(fname);
> +		ftruncate(test_fd, pagesize);
> +		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
> +			   MAP_SHARED, test_fd, 0);
> +		if (!map)
> +			ksft_exit_fail_msg("file mmap failed\n");
> +	}
> +
> +	*map = 1;
> +	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
> +			 "Test %s-%s dirty bit of new written page\n",
> +			 __func__, type[anon]);
> +	clear_softdirty();
> +	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 0,
> +			 "Test %s-%s soft-dirty clear after clear_refs\n",
> +			 __func__, type[anon]);
> +	mprotect(map, pagesize, PROT_READ);
> +	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 0,
> +			 "Test %s-%s soft-dirty clear after marking RO\n",
> +			 __func__, type[anon]);
> +	mprotect(map, pagesize, PROT_READ|PROT_WRITE);
> +	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 0,
> +			 "Test %s-%s soft-dirty clear after marking RW\n",
> +			 __func__, type[anon]);
> +	*map = 2;
> +	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
> +			 "Test %s-%s soft-dirty after rewritten\n",
> +			 __func__, type[anon]);
> +
> +	munmap(map, pagesize);
> +
> +	if (!anon)
> +		close(test_fd);
> +}
> +
> +static void test_mprotect_anon(int pagemap_fd, int pagesize)
> +{
> +	test_mprotect(pagemap_fd, pagesize, true);
> +}
> +
> +static void test_mprotect_file(int pagemap_fd, int pagesize)
> +{
> +	test_mprotect(pagemap_fd, pagesize, false);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int pagemap_fd;
>  	int pagesize;
>  
>  	ksft_print_header();
> -	ksft_set_plan(5);
> +	ksft_set_plan(15);
>  
>  	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
>  	if (pagemap_fd < 0)
> @@ -138,6 +201,8 @@ int main(int argc, char **argv)
>  	test_simple(pagemap_fd, pagesize);
>  	test_vma_reuse(pagemap_fd, pagesize);
>  	test_hugepage(pagemap_fd, pagesize);
> +	test_mprotect_anon(pagemap_fd, pagesize);
> +	test_mprotect_file(pagemap_fd, pagesize);
>  
>  	close(pagemap_fd);
>  

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

