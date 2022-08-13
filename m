Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED85919EE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiHMKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiHMKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:48:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CC93AB34;
        Sat, 13 Aug 2022 03:48:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dc19so5821096ejb.12;
        Sat, 13 Aug 2022 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=mMWgQnVhxyKG7itB8lVZQwS2syLLp6WBoeNq+Oay1xY=;
        b=ZKPgQ4mxaY6YwrzzNZFxzYe72YJVNF8lEUtStRtdapl4QnuFuUvesb910Z3T1ZfFs7
         HAGgulQ/yWNHqrJGmd1r5rQCU2RMZrzMQ4CfEMOmPXyLykk3JTWhssMQ0fEA0xJbzxmY
         Sf8/739aU4qH0O+5WtXnB1pS6uVkRkRHpRVCLvqZYaGGrM23EbdFO22eSIRcPvT8ObJG
         8kv6swFgbmLRpfaPugi3BadXAr5Pz88oVzVzbN+HnmmHB5rBEg7F6gMzAEXZd8tCtUYm
         QKrvDgATDMj6/lRlgHjW43OH4/RZC/BDTiMNCc1r6K7f8dQEABVUhzU+C1TjFREKymr+
         DaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=mMWgQnVhxyKG7itB8lVZQwS2syLLp6WBoeNq+Oay1xY=;
        b=fVK9jN3sTK4VaId8YI0o3Y2OiTXQcg1k1ftvrXc11GOwJ0YFwnko+9iAMiDAmggvif
         J18ayHY7aXd69ZyGoMmOW7k7mZaY/dAhO4WK5MU4J4Pw+0eh+k5uYEKex2z7Z/PW3kDW
         baPrzLxaANuNJA2Skw1rFAj20MdSFJJbDdNpIoSFI916fbds8+Qje5Ihffw92/jD8Jkn
         Zbr0VpwJxIHHKkopl1RzbgH9RCE5CFBf+gBmZ2dACDk7ovRkYlYjeQfJesMGfVMBxLyE
         aSZn1i29kEKmZnFR482/0s0/4PCGFdxN/EZOybXOUS2nHzoFUav7gNYQdm+z9rrNmFPU
         bvFw==
X-Gm-Message-State: ACgBeo12kmiATKxnuWERWzU6erNGDsbSkAy9GLW/3kb2bfsOd/4gVmZu
        ZCYtjD+ZdapwD/aNZNF+Ua0=
X-Google-Smtp-Source: AA6agR42RFziShLmuVcrMSrxYhxU9/TeAw/SX9/7q8bSPbdWwMxFMsnU7Xdm8UhOhj8QCnVt+FeOmA==
X-Received: by 2002:a17:907:a056:b0:730:ce15:842d with SMTP id gz22-20020a170907a05600b00730ce15842dmr5184843ejc.275.1660387717009;
        Sat, 13 Aug 2022 03:48:37 -0700 (PDT)
Received: from gmail.com (84-236-113-143.pool.digikabel.hu. [84.236.113.143])
        by smtp.gmail.com with ESMTPSA id p22-20020a056402045600b00435a62d35b5sm2828661edw.45.2022.08.13.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 03:48:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 13 Aug 2022 12:48:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH 3/7] hwmon/coretemp: Handle large core id value
Message-ID: <YveBgsVINyKjXW9g@gmail.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
 <20220812164144.30829-4-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812164144.30829-4-rui.zhang@intel.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhang Rui <rui.zhang@intel.com> wrote:

> The coretemp driver supports up to a hard-coded limit of 128 cores.
> 
> Today, the driver can not support a core with an id above that limit.
> Yet, the encoding of core_id's is arbitrary (BIOS APIC-id) and so they
> may be sparse and they may be large.
> 
> Update the driver to map arbitrary core_id numbers into appropriate
> array indexes so that 128 cores can be supported, no matter the encoding
> of core_ids's.

Please capitalize 'ID' consistently throughout the series.

> -	attr_no = pkg_flag ? PKG_SYSFS_ATTR_NO : TO_ATTR_NO(cpu);
> +	if (pkg_flag)
> +		attr_no = PKG_SYSFS_ATTR_NO;
> +	else {
> +		index = ida_alloc(&pdata->ida, GFP_KERNEL);
> +		if (index < 0)
> +			return index;
> +		pdata->cpu_map[index] = topology_core_id(cpu);
> +		attr_no = index + BASE_SYSFS_ATTR_NO;
> +	}

Unbalanced curly braces.

> -	int err, attr_no;
> +	int err, index, attr_no;

So it's 'index' here.

> @@ -524,6 +538,8 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)

But 'indx' here.

> -	int indx, target;
> +	int i, indx = -1, target;

And 'indx' again. Did we run out of the letter 'e'? Either use 'index' 
naming consistently, or 'idx' if it has to be abbreviated.

Thanks,

	Ingo
