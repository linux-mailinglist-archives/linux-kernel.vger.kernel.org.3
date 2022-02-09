Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BBC4AE620
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbiBIAgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIAgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:36:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229BEC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:36:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t9so747444plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 16:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyW8p7EJ4pYdsF0v2XpOO4VdWGuUNyllm2/CQuuk14s=;
        b=G2/gUi+XKMqWl1gxAIpjH8wkNS/yRe2lYltDO1boW13Nlu0THZ4F85NUCDnKx9ph9p
         N1sD/5iakv74WkNT3jYiDo2J3N31ZFf9BuhpCC0Lab7ZSS4kZ/hODzSalKjK0KAVnKnf
         PoINJM43hWB2VslI03Qztpb1kNp6xu+ISkaOskkgE/MWmL1EGBvxQBx0tbdyibCv+1xE
         v4iJ1ABQz1ksREbQTiRIrgB5gKK+vuXGssPARqBC29c0CnQLs24upy/FoLN+J3fy4RpE
         etwEcFH80bCPAKqDKPOmjiCh8dZDfWTS+7aMFlYh6ZWlXNXPso1jyNMo8D4t/9RxkhdE
         iaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyW8p7EJ4pYdsF0v2XpOO4VdWGuUNyllm2/CQuuk14s=;
        b=hTfBOwOLoaOQZdAzFA5mk+oK9/z8nZawD3xWQKDIrLS33dEj9sZuRzIivCF0ChRBHf
         Fg9zjmCtifKV6aJZcDhQ5+JnLCB+1jHUi+6l26oZTVY/2wfN6ZoQXJjE6NIpyLKlKA2+
         hoi0TEChDaBjSLvX6gyTzZLLDMmlRRkXyirSJ3lf6TSC9eXZym//Z9+otUHYQTXWVid3
         n66DDopOsbKbWnWL/n3Q8om7JoTZ8StRZc8LnRTpXlVzoPK3HXMRCI+V5sjKIeBUQ/A1
         xHWIWTm5DBXAN6elUVo6VsOjtdgH+nPSkzq8gNTWPkGJ4DrANfrFS3/2FVi+wOGqw/Sa
         /upw==
X-Gm-Message-State: AOAM532PRrvx77qMmU0LxtnYHBfvevh7nYK2AX+c7NZgDcvpZhwK8Hav
        7gqJw+GRhWuDl+IXcIq7qCfOjQ==
X-Google-Smtp-Source: ABdhPJw2HQcqc2cB2/DN76nqL4GUhsCuWhr3sDBQ+AusvTv2A73qenSTL+nr92Tz6QggDkjwZR5Ztw==
X-Received: by 2002:a17:902:e851:: with SMTP id t17mr4359441plg.54.1644367001434;
        Tue, 08 Feb 2022 16:36:41 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id pi9sm4261855pjb.46.2022.02.08.16.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:36:40 -0800 (PST)
Date:   Wed, 9 Feb 2022 00:36:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] KVM: Do compatibility checks on hotplugged CPUs
Message-ID: <YgMMlaMnjQRqwW6w@google.com>
References: <20220118064430.3882337-1-chao.gao@intel.com>
 <20220118064430.3882337-5-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118064430.3882337-5-chao.gao@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022, Chao Gao wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 528741601122..83f87fb1fa0a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4858,7 +4858,13 @@ static void hardware_enable_nolock(void *junk)
>  
>  static int kvm_online_cpu(unsigned int cpu)
>  {
> -	int ret = 0;
> +	int ret;
> +
> +	ret = kvm_arch_check_processor_compat();
> +	if (ret) {
> +		pr_warn("kvm: CPU%d is incompatible with online CPUs", cpu);

Hmm, I'd say omit the pr_warn() here too and instead add a pr_err() for the
setup_vmcs_config() path in vmx_check_processor_compat().

> +		return ret;
> +	}
