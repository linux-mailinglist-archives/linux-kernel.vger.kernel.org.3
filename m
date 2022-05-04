Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89F519D4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348277AbiEDKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiEDKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:52:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838C41E3C7;
        Wed,  4 May 2022 03:48:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651661324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gse6ZyFtiTkctjQAWRHeBSPf14TvnJ2nc5QZOsLjx8k=;
        b=lbJvplHHyN0WtQuVpu1E8Tgq+Nmvv38AtnIlKnSwvvbO7nwtnoic+LlbTJSp/gPjld2oqp
        S+SbhlrxQnURvbCl5cEqXb2U6YC85xK+LFCNoFv+64lj/hzST8K1ELo7Zpss0X57K57dQd
        aOgJXt7b7hbp5NnL2vuu68b7WRlVfj8NtuXxvlaGN0SoDGze70mQ9SVf0iAAMbzaX5gfM/
        8Tv8n8fFYtwjRG632N7kUkNtIaS+nqvNaXzkEiAYAiruJm8DKFmOHaTjMcjaJ8ZFXOuiXd
        hSNbXLqN0KPV0kY3I6H2bsP0bOkS47mSL4g6YdH0+5XZNo1L4e1nu8ydHticaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651661324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gse6ZyFtiTkctjQAWRHeBSPf14TvnJ2nc5QZOsLjx8k=;
        b=3NLlWMvWQO80kMeVrTyz1icM1GCZMA7nxF6m5u047fQutvMTDwEHsCrTQ4Aic7Ay2TOPtj
        7UCMBphWcZiq1pBg==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 06/10] platform/x86/intel/ifs: Authenticate and copy
 to secured memory
In-Reply-To: <20220428153849.295779-7-tony.luck@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-7-tony.luck@intel.com>
Date:   Wed, 04 May 2022 12:48:43 +0200
Message-ID: <87tua5k1ys.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28 2022 at 08:38, Tony Luck wrote:
> The IFS image contains hashes that will be used to authenticate the ifs
> test chunks. First, use WRMSR to copy the hashes and enumerate the number
> of test chunks, chunk size and the maximum number of cores that can run
> scan test simultaneously.
>
> Next, use WRMSR to authenticate each and every scan test chunk which is
> also stored in the IFS image. The CPU will check if the test chunks match

s/also// ?

> +
> +/* MSR_CHUNKS_AUTH_STATUS bit fields */
> +union ifs_chunks_auth_status {
> +	u64	data;
> +	struct {
> +		u32	valid_chunks	:8;
> +		u32	total_chunks	:8;
> +		u32	rsvd1		:16;
> +		u32	error_code	:8;
> +		u32	rsvd2		:24;
> +	};
> +};
> +
>  /**
>   * struct ifs_data - attributes related to intel IFS driver
>   * @integrity_cap_bit - MSR_INTEGRITY_CAPS bit enumerating this test
> + * @loaded_version: stores the currently loaded ifs image version.
> + * @loaded: If a valid test binary has been loaded into the memory
> + * @loading_error: Error occurred on another CPU while loading image
> + * @valid_chunks: number of chunks which could be validated.
>   */
>  struct ifs_data {
>  	int integrity_cap_bit;
> +	int loaded_version;
> +	bool loaded;
> +	bool loading_error;
> +	int valid_chunks;

The above struct is nicely tabular. Can we have that here too please?

> +/*
> + * IFS requires scan chunks authenticated per each socket in the platform.
> + * Once the test chunk is authenticated, it is automatically copied to secured memory
> + * and proceed the authentication for the next chunk.
> + */
> +static int scan_chunks_sanity_check(struct device *dev)
> +{
> +	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	bool *package_authenticated;
> +	char *test_ptr;
> +
> +	package_authenticated = kcalloc(topology_max_packages(), sizeof(bool), GFP_KERNEL);
> +	if (!package_authenticated)
> +		return ret;
> +
> +	metadata_size = ifs_header_ptr->metadata_size;
> +
> +	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
> +	if (metadata_size == 0)
> +		metadata_size = 2000;
> +
> +	/* Scan chunk start must be 256 byte aligned */
> +	if ((metadata_size + IFS_HEADER_SIZE) % 256) {
> +		dev_err(dev, "Scan pattern offset within the binary is not 256 byte aligned\n");
> +		return -EINVAL;
> +	}
> +
> +	test_ptr = (char *)ifs_header_ptr + IFS_HEADER_SIZE + metadata_size;
> +	ifsd->loading_error = false;
> +
> +	ifs_test_image_ptr = (u64)test_ptr;
> +	ifsd->loaded_version = ifs_header_ptr->blob_revision;
> +
> +	/* copy the scan hash and authenticate per package */
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		curr_pkg = topology_physical_package_id(cpu);
> +		if (package_authenticated[curr_pkg])
> +			continue;
> +		package_authenticated[curr_pkg] = 1;

Setting the authenticated indicator _before_ actually doing the
authentication is just wrong. It does not matter in this case, but it's
still making my eyes bleed.

> +		ret = smp_call_function_single(cpu, copy_hashes_authenticate_chunks,
> +					       dev, 1);

Why has this to be a smp function call? Just because it's conveniant?
This is nothing urgent and no hotpath, so this really can use
queue_work_on().

Thanks,

        tglx
