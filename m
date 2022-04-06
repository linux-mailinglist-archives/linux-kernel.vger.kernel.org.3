Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDF4F57EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiDFI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359202AbiDFIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:24:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA21FAA2D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:23:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w21so887001pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=het7xQEY6AiunexNVt3R9JrRc+WqABKqnLlFmve94Cc=;
        b=itRW2E0kExcc0Xbaqr5Rh6BbC+cbZkZDFpK9xbhZMF0juee9my0sm58u9xyFrLsprz
         ot2kFFHJ1bTgUg/fkR0IR5ACSG3O2kY3wbGZKsfnHPRgqglv6F20nLcOqRJYT6abN+b/
         XUJnGOA9Pkr8343tkubrNfuBP3p0OT+EyRVXTb43d3x+xb9/TdGS7afMW/Ax8Qo/pUJj
         /CkF2+7+R+QXIikz7cnO0nvZHX2zpv6hjyWAHgQSjiCrAqBOMM1nv1aRMn4TW+KAl1cm
         H1HVHdBs+dCQa9JdCslDgZkoOj6P5HsLWe+AkWTDb0ClwzJ5EsIyIwJvQzH8Gy+hoUBN
         956Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=het7xQEY6AiunexNVt3R9JrRc+WqABKqnLlFmve94Cc=;
        b=43IMJqRNGyLGvyWgkMQ+Y1a9YGg+JbhfQv4cp+UnPKRBHC1B2Q39V9LCIuUvZxxnHg
         O1hVnC0BFC4p5NaQOMv30gNWzHrsM4RveU7d7yRgoHIhuAfxIQ7RKRB1+l5yZCRXW5Uc
         jtdFzgoDEjOY0QxKoyFJ/UMYZzVZEolDgO1apDIrABbd5Zn2ftizO/HsDEntGx4YdlX4
         7Fs9NMBgW4LMLpFMhP2NBVkInWgPRaRfrbe9JEJ8MCYmfQbSin11pC847j7HJdMbguVw
         113Cj3w6+EH7WKeccKrNSc/8gGlkG2zjJDurY/YNsknwXcc42K9puXkn/9ZbZNgBoS4u
         IblA==
X-Gm-Message-State: AOAM5324QDFS07EkpUBX/hTqcWh0Bh5XT90jP0LC+tUOpLCB3cOSo4UD
        Z4J7GWfg3Two8WwSRefuotq+CQ==
X-Google-Smtp-Source: ABdhPJzL8bboghyNu1DtoVv4HWrIhBJdeVZOAv1DNCUs8URWTJG38gLEY45sMuuz7zbtkBkVvRIltg==
X-Received: by 2002:a05:6a02:28a:b0:385:f767:34f4 with SMTP id bk10-20020a056a02028a00b00385f76734f4mr5163616pgb.299.1649208179490;
        Tue, 05 Apr 2022 18:22:59 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm3663556pjl.39.2022.04.05.18.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 18:22:58 -0700 (PDT)
Date:   Wed, 6 Apr 2022 01:22:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vasant Karasulli <vkarasulli@suse.de>
Cc:     linux-kernel@vger.kernel.org, jroedel@suse.de, kvm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com,
        varad.gautam@suse.com
Subject: Re: [PATCH v6 2/4] x86/tests: Add tests for AMD SEV-ES #VC handling
 Add KUnit based tests to validate Linux's VC handling for instructions cpuid
 and wbinvd. These tests: 1. install a kretprobe on the #VC handler
 (sev_es_ghcb_hv_call, to access GHCB before/after the resulting VMGEXIT). 2.
 trigger an NAE by executing either cpuid or wbinvd. 3. check that the
 kretprobe was hit with the right exit_code available in GHCB.
Message-ID: <Ykzrb1uyPZ2AKWos@google.com>
References: <20220318094532.7023-1-vkarasulli@suse.de>
 <20220318094532.7023-3-vkarasulli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318094532.7023-3-vkarasulli@suse.de>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shortlog and changelog are all messed up.  Ditto for the other patches in this
series.

On Fri, Mar 18, 2022, Vasant Karasulli wrote:
> Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
> ---
>  arch/x86/tests/Makefile      |   2 +
>  arch/x86/tests/sev-test-vc.c | 114 +++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 arch/x86/tests/sev-test-vc.c

...

> +int sev_es_test_vc_init(struct kunit *test)
> +{
> +	int ret;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
> +		kunit_info(test, "Not a SEV-ES guest. Skipping.");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	memset(&hv_call_krp, 0, sizeof(hv_call_krp));
> +	hv_call_krp.entry_handler = hv_call_krp_entry;
> +	hv_call_krp.handler = hv_call_krp_ret;
> +	hv_call_krp.maxactive = 100;
> +	hv_call_krp.data_size = sizeof(unsigned long);
> +	hv_call_krp.kp.symbol_name = "sev_es_ghcb_hv_call";
> +	hv_call_krp.kp.addr = 0;
> +
> +	ret = register_kretprobe(&hv_call_krp);
> +	if (ret) {
> +		kunit_info(test, "Could not register kretprobe. Skipping.");
> +		goto out;
> +	}
> +
> +	test->priv = kunit_kzalloc(test, sizeof(u64), GFP_KERNEL);

Allocating 8 bytes and storing the pointer an 8-byte field is rather pointless :-)

> +	if (!test->priv) {
> +		ret = -ENOMEM;
> +		kunit_info(test, "Could not allocate. Skipping.");
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +void sev_es_test_vc_exit(struct kunit *test)
> +{
> +	if (test->priv)
> +		kunit_kfree(test, test->priv);
> +
> +	if (hv_call_krp.kp.addr)
> +		unregister_kretprobe(&hv_call_krp);
> +}
> +
> +#define check_op(kt, ec, op)			\
> +do {						\
> +	struct kunit *t = (struct kunit *) kt;	\
> +	op;					\
> +	KUNIT_EXPECT_EQ(t, (typeof(ec)) ec,	\
> +		*((typeof(ec) *)(t->priv)));		\
> +} while (0)
> +
> +static void sev_es_nae_cpuid(struct kunit *test)
> +{
> +	unsigned int cpuid_fn = 0x8000001f;
> +
> +	check_op(test, SVM_EXIT_CPUID, native_cpuid_eax(cpuid_fn));

Are there plans to go beyond basic checks?  Neat idea, but it seems like it will
be prone to bitrot since it requires a somewhat esoteric setup and an opt-in config.
And odds are very good that if the kernel can make it this far as an SEV-ES guest,
it's gotten the basics right.
