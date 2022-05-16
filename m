Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA36B528C92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbiEPSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbiEPSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90C263D492
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652724505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vqmTBe2+t+Tjj9J0vBMumJxxtuKzLpjmXcH4EsIylls=;
        b=aNdJAsqJxRdAP4LK57AaGdRymWVTV3Hg5eSGtDsdhmMGIjLHChYu5aKLnWqW8BBFhFpTQE
        zTf2Hl9fHaSpRsY0h6B4LcgaDd/UcReq9kjFQPOwQp6GUOwkpk+Tl5la3cQlM78KhYXc7U
        hLBM61DXiqJx78SRV9uISrKmhghcG1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-Vc74oDrIPK-275XSFfYMtg-1; Mon, 16 May 2022 14:08:23 -0400
X-MC-Unique: Vc74oDrIPK-275XSFfYMtg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9752101A52C;
        Mon, 16 May 2022 18:08:22 +0000 (UTC)
Received: from ovpn-116-50.gru2.redhat.com (ovpn-116-50.gru2.redhat.com [10.97.116.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E816492C14;
        Mon, 16 May 2022 18:08:14 +0000 (UTC)
Date:   Mon, 16 May 2022 15:08:12 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <YoKTDAeQPs5nQkg3@ovpn-116-50.gru2.redhat.com>
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220512221952.3647598-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512221952.3647598-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:19:48PM -0700, Kuppuswamy Sathyanarayanan wrote:

[snip]

> +
> +static int __init tdx_attestation_init(void)
> +{
> +	long ret;
nit: the type of ret should be int
> +
> +	/* Make sure we are in a valid TDX platform */
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EIO;
> +
> +	miscdev.name = DRIVER_NAME;
> +	miscdev.minor = MISC_DYNAMIC_MINOR;
> +	miscdev.fops = &tdx_attest_fops;
> +
> +	ret = misc_register(&miscdev);
> +	if (ret) {
> +		pr_err("misc device registration failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[snip]

