Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90BE4E382D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiCVFE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiCVFEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:04:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD412092
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:02:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so1152852pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ceVg9Fx+CO6HpYy/wk+MDCRCh737lbvU2erecgf8G/g=;
        b=mxnp8aq9c8RmSTr+e6WTFt0PYgN0OUF8B3c4CHhensbiquJ9nK8CjuOGHMbLVYFBmV
         dKvEQ1YnCIaIq16BfUfeIlmFIy0WFGCbGlEiNv9GBwh0ov8k2HxZMRQO/Tq+f3gYL6gG
         c84w/F6IWvHLE+rYj88GnBfLYuRlPh3R/Ztng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ceVg9Fx+CO6HpYy/wk+MDCRCh737lbvU2erecgf8G/g=;
        b=vOv2HI9Q8QYGDTTSzUMhR2hCnD2njdIN1yEiuJN/5lTfFrPJynUSV1knT18rG2NiFD
         WCU4+YLBspv5qWeZwBmMaciCJKjU7+bLDKL8pN6xfAnGgtU6xsj/EXKM++LX5XFcpIGk
         Cj8w+6uIThpGsIv5HHUmJHGYH7b4UhSVWP7ebNqXGntmbjhNhxLjnMRhcYnxe2NzwEP6
         w98BHpJ4f4/CNpg4d5fnc+1XgsrP1pEJGuVvcgtVablHpxWCjA1ETCVHWN1o7FY7fhZZ
         +B1ednm2OxBntmJMOdGuZtoVHXzLULthvi8/ACCkQbsIhpvb525JRtPsgURQBT/WjXkl
         gemA==
X-Gm-Message-State: AOAM533gdXScSgfn2k2ZSRpkNIohIt2qVNiAsxloTg49fLtuSdVSIpFr
        iUX8+wPlBo95zIJUGS6KWb+jR334TUDgew==
X-Google-Smtp-Source: ABdhPJxqXpXz9RuKGZvf3tsV1EyeStqE29usqEUErsYJl4nqwDkw4sq6z9LM7OiX6ejjHM0sm4Zr8Q==
X-Received: by 2002:a17:90b:4b4b:b0:1be:fd9a:c279 with SMTP id mi11-20020a17090b4b4b00b001befd9ac279mr2865792pjb.83.1647925376557;
        Mon, 21 Mar 2022 22:02:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:51af:6dff:4acd:7fa5])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090b050b00b001c741fd4890sm1058211pjz.9.2022.03.21.22.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:02:55 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:02:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     mcgrof@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, v.narang@samsung.com,
        swboyd@chromium.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        avimalin@gmail.com, atomlin@redhat.com, keescook@chromium.org,
        ndesaulniers@google.com, rdunlap@infradead.org, void@manifault.com
Subject: Re: [PATCH 1/1 module-next] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Message-ID: <YjlYeYpou9wdkcZS@google.com>
References: <CGME20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933@epcas5p2.samsung.com>
 <20220316043540.677128-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316043540.677128-1-maninder1.s@samsung.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/03/16 10:05), Maninder Singh wrote:
[..]
> +static int sprint_module_info(char *buf, unsigned long value,
> +			     int modbuildid, int backtrace, int symbol)
> +{
> +	struct module *mod;
> +	unsigned long offset;
> +	void *base;
> +	char *modname;
> +	int len;
> +	const unsigned char *buildid = NULL;
> +	bool add_offset;
> +
> +	if (is_ksym_addr(value))
> +		return 0;
> +
> +	if (backtrace || symbol)
> +		add_offset = true;
> +	else
> +		add_offset = false;
> +
> +	preempt_disable();
> +	mod = __module_address(value);
> +	if (mod) {
> +		modname = mod->name;
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +		if (modbuildid)
> +			buildid = mod->build_id;
> +#endif
> +		if (add_offset) {
> +			base = mod->core_layout.base;
> +			offset = value - (unsigned long)base;
> +		}

What if address is in module init? Shouldn't this be something like

	if (within_module_init(value, mod))
		offset = value - (unsigned long)mod->init_layout.base;
	else
		offset = value - (unsigned long)mod->core_layout.base;
