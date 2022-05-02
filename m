Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671B2516F7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385012AbiEBMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385009AbiEBMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66C3217A93
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651493935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3I5HkdquLYDOMv/OD9ELvVo/Z1fWN7PZJpaVV72EZHM=;
        b=iU2MCB8Xw1BsIRyNKZOPvvJlW/u6PAZIuPwZcWOdDa/yaa9mndvUdRkVK/f9+43AZY5BbZ
        6yXBtYPQu/G3cZNzzxX0grxdzYjzasJsp0c2vlKACEnIiMubrJP+m67JUlEkjSAy5RSCHX
        8J+v0WjbS+mdIWPumH+pOotqLsx8Vp0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-6BTLU6uJO0eqnwMyQnuODA-1; Mon, 02 May 2022 08:18:52 -0400
X-MC-Unique: 6BTLU6uJO0eqnwMyQnuODA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6944D803524;
        Mon,  2 May 2022 12:18:51 +0000 (UTC)
Received: from fedora (unknown [10.22.8.190])
        by smtp.corp.redhat.com (Postfix) with SMTP id CF94640D2820;
        Mon,  2 May 2022 12:18:47 +0000 (UTC)
Date:   Mon, 2 May 2022 09:18:46 -0300
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
Subject: Re: [PATCH v5 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <Ym/MJlHrDoinrxnn@fedora>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 11:34:58AM -0700, Kuppuswamy Sathyanarayanan wrote:

[snip]

> +
> +static struct miscdevice miscdev;
> +
> +static long tdx_get_report(void __user *argp)
> +{
> +	void *reportdata = NULL, *tdreport = NULL;
> +	long ret = 0;
> +
> +	/* Allocate buffer space for REPORTDATA */
> +	reportdata = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
> +	if (!reportdata)
> +		return -ENOMEM;
> +
> +	/* Allocate buffer space for TDREPORT */
> +	tdreport = kmalloc(TDX_REPORT_LEN, GFP_KERNEL);
> +	if (!tdreport) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	/* Copy REPORTDATA from the user buffer */
> +	if (copy_from_user(reportdata, argp, TDX_REPORTDATA_LEN)) {
> +		ret = -EFAULT;
> +		goto failed;
> +	}
> +
> +	/*
> +	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
> +	 *
> +	 * Pass the physical address of user generated REPORTDATA
> +	 * and the physical address of the output buffer to the TDX
> +	 * module to generate the TDREPORT. Generated data contains
> +	 * measurements/configuration data of the TD guest. More info
> +	 * about ABI can be found in TDX 1.0 Module specification, sec
> +	 * titled "TDG.MR.REPORT".
> +	 */
> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> +				virt_to_phys(reportdata), 0, 0, NULL);
> +	if (ret) {
> +		pr_debug("TDREPORT TDCALL failed, status:%lx\n",
> +				TDCALL_STATUS_CODE(ret));

Should we use pr_err instead?

[snip]

