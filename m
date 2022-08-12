Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A2590D17
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiHLH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiHLH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AD2DA74DE
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660291119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB9VejbuR5ze7FfPP0W1PFrmHALsvu1Qjkp8cIXk/lY=;
        b=GU5OI1AJuO1r11m9jMNVNKoJIoOtYwPY09FTVc5tLrG09UYe6UkXB/VsUnNk7nRvAlbVZv
        BhTxm2QIrUOmHa/FW9TGi2cEacw9x91pmk9ctP/HJegFGmVupJ6BD8Gi2HzURyKj3lar7U
        bggzUpqnMzCZzYGk7qL4hXvRuP+FylI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-0kkeMI6kPLK_CuRSA0zKOg-1; Fri, 12 Aug 2022 03:58:38 -0400
X-MC-Unique: 0kkeMI6kPLK_CuRSA0zKOg-1
Received: by mail-lj1-f197.google.com with SMTP id z7-20020a2ebe07000000b0025e5c7d6a2eso72162ljq.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gB9VejbuR5ze7FfPP0W1PFrmHALsvu1Qjkp8cIXk/lY=;
        b=zfWHIskt8+X7RNsP8NlBl7AYcLgzuPiUwB+fwMLiTzafjurX2sveGJ+XUv210Exfbk
         RlRVqMTno4HW20Cl8D1OBUq0qjCCGJ0HzBALJLk8gFmTJy2P0myyPOqRnaZ0gTx0Y1zW
         ynTDCH6kug2OL0In7/Mo04fAsg499DvvdtHB2ec3gmUjixc+C/LxIA8OEGnIdZScxr2M
         YaLE17KX97R9evkJfNjgep9vMsVyHZZXLgNwzniLHSVECRdQ5s36en8VITsfY5gx6YJT
         tnp15FIAjnciYDg6SyDU4XxzLCI1qWfmJ3OHGDpZom4hAqyzflAHk8vy1bQ9HeSzSgSn
         ESmA==
X-Gm-Message-State: ACgBeo230f68MD9/gaWVKH+3oo5+vU/+qjIA/2JWIKIQMWCZBhb7joYK
        mQ6+OQEnFx2Kp6eVJNdhvrucYf4WwUOAAXjJltdBTGeKw6Fpa2KQBRWtdJhxaNrFI6FDQxiI9as
        JboKcaU+BV5qAhgdBSUe3gJ4=
X-Received: by 2002:a2e:9e43:0:b0:25d:d8e9:7b15 with SMTP id g3-20020a2e9e43000000b0025dd8e97b15mr829928ljk.234.1660291116707;
        Fri, 12 Aug 2022 00:58:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6jh6soL8VpWSUMnuHR+/1pcmp0+/QJpEfvWmTsHRXQc5cyvyw5cxuGCYjok2bFWQKL8izBdg==
X-Received: by 2002:a2e:9e43:0:b0:25d:d8e9:7b15 with SMTP id g3-20020a2e9e43000000b0025dd8e97b15mr829915ljk.234.1660291116474;
        Fri, 12 Aug 2022 00:58:36 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id q16-20020a2eb4b0000000b0025d75995a07sm268015ljm.24.2022.08.12.00.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:58:36 -0700 (PDT)
Message-ID: <1ec090fa-f93b-c197-e5b3-ff2b0d5862ef@redhat.com>
Date:   Fri, 12 Aug 2022 10:58:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] selftests/hmm-tests: Add test for dirty bits
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <8f19b172d32be2e889b837f88b1ba070bf2c97ee.1660281458.git-series.apopple@nvidia.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <8f19b172d32be2e889b837f88b1ba070bf2c97ee.1660281458.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair!

On 12.8.2022 8.22, Alistair Popple wrote:
> We were not correctly copying PTE dirty bits to pages during
> migrate_vma_setup() calls. This could potentially lead to data loss, so
> add a test for this.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   tools/testing/selftests/vm/hmm-tests.c | 124 ++++++++++++++++++++++++++-
>   1 file changed, 124 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
> index 529f53b..70fdb49 100644
> --- a/tools/testing/selftests/vm/hmm-tests.c
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -1200,6 +1200,130 @@ TEST_F(hmm, migrate_multiple)
>   	}
>   }
>   
> +static char cgroup[] = "/sys/fs/cgroup/hmm-test-XXXXXX";
> +static int write_cgroup_param(char *cgroup_path, char *param, long value)
> +{
> +	int ret;
> +	FILE *f;
> +	char *filename;
> +
> +	if (asprintf(&filename, "%s/%s", cgroup_path, param) < 0)
> +		return -1;
> +
> +	f = fopen(filename, "w");
> +	if (!f) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	ret = fprintf(f, "%ld\n", value);
> +	if (ret < 0)
> +		goto out1;
> +
> +	ret = 0;
> +
> +out1:
> +	fclose(f);
> +out:
> +	free(filename);
> +
> +	return ret;
> +}
> +
> +static int setup_cgroup(void)
> +{
> +	pid_t pid = getpid();
> +	int ret;
> +
> +	if (!mkdtemp(cgroup))
> +		return -1;
> +
> +	ret = write_cgroup_param(cgroup, "cgroup.procs", pid);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int destroy_cgroup(void)
> +{
> +	pid_t pid = getpid();
> +	int ret;
> +
> +	ret = write_cgroup_param("/sys/fs/cgroup/cgroup.procs",
> +				"cgroup.proc", pid);
> +	if (ret)
> +		return ret;
> +
> +	if (rmdir(cgroup))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Try and migrate a dirty page that has previously been swapped to disk. This
> + * checks that we don't loose dirty bits.
> + */
> +TEST_F(hmm, migrate_dirty_page)
> +{
> +	struct hmm_buffer *buffer;
> +	unsigned long npages;
> +	unsigned long size;
> +	unsigned long i;
> +	int *ptr;
> +	int tmp = 0;
> +
> +	npages = ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
> +	ASSERT_NE(npages, 0);
> +	size = npages << self->page_shift;
> +
> +	buffer = malloc(sizeof(*buffer));
> +	ASSERT_NE(buffer, NULL);
> +
> +	buffer->fd = -1;
> +	buffer->size = size;
> +	buffer->mirror = malloc(size);
> +	ASSERT_NE(buffer->mirror, NULL);
> +
> +	ASSERT_EQ(setup_cgroup(), 0);
> +
> +	buffer->ptr = mmap(NULL, size,
> +			   PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS,
> +			   buffer->fd, 0);
> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +	/* Initialize buffer in system memory. */
> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
> +		ptr[i] = 0;
> +
> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
> +
> +	/* Fault pages back in from swap as clean pages */
> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
> +		tmp += ptr[i];
> +
> +	/* Dirty the pte */
> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
> +		ptr[i] = i;
> +

The anon pages are quite likely in memory at this point, and dirty in pte.



> +	/*
> +	 * Attempt to migrate memory to device, which should fail because
> +	 * hopefully some pages are backed by swap storage.
> +	 */
> +	ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));


And pages marked dirty also now. But could you elaborate how and where 
the above fails in more detail, couldn't immediately see it...



> +
> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
> +
> +	/* Check we still see the updated data after restoring from swap. */
> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
> +		ASSERT_EQ(ptr[i], i);
> +
> +	hmm_buffer_free(buffer);
> +	destroy_cgroup();
> +}
> +
>   /*
>    * Read anonymous memory multiple times.
>    */


--Mika

