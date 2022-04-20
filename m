Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12634507E15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbiDTBXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiDTBXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:23:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8FA32EC3;
        Tue, 19 Apr 2022 18:20:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k14so166059pga.0;
        Tue, 19 Apr 2022 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kt0BA6E2YVz9rnggJc+TiKb9bbmdQfz/mieF7YR0eTY=;
        b=nPetD018frdQiGN1xpLyv+3uSuUXRlLIAw/Q2KO+NA8JE5r19ZuBQk/jLrNcWqqZ63
         4scmHiHLF7HRFSJdnuMnu0kxHqR1NBDB/BjgaTd2MGeJeJVfif1KuFpr56WYX2zPkoXt
         nqDXLPKPYbYwkd+qIyX52w7J6VoPrs4npeBZA7LXWI11yUTodroygKZgwnTbu2AJNPb9
         wdJ8eowa9aeo0ndzSoMBhrwyp3TeYcvR6OK5kjw1omdyCvVC6ODyIcl33JgyxE05ZPGF
         YM/QNmt9fYwSMfXrmBDi4iGW2DtDY5Ox9Ca3sz6iURzrpk+wzTLxzIxCJXp5bU3h4XmP
         lYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kt0BA6E2YVz9rnggJc+TiKb9bbmdQfz/mieF7YR0eTY=;
        b=AQWeQppUFrbJPQXVdSaiX1IHNsyaPLtz0TSubAhaRb/45xTKy043kHTUQmIhDdoF0Z
         xFStVtGztVoarkZazSOKQeVtM4bKtYMIbTifEbG0rJWkzKJToevASl5A2YkbYYo0dEqF
         Ze3fDA6TDxL0t5agw9aXSAycwhWjGy1ss5oY84RocUql4cwIRFaZt50St5/b+mDgWRMt
         Vg8Sd/zz48cDsJOO5v9fZtW75lSe0q1CnEBB9J1J0rJ3bTcvbsVYJSzVnve3XOk+hNx0
         sqivCcWAG57wEBMoHb1shJZ7iXTFxPdJ/q5phFTG80qiJlCi2HR4eBNjY0Edb74jCoWd
         ropg==
X-Gm-Message-State: AOAM532Ojd4oizQuUqS1pIxFw7q3pRV6IlvWY2Jzwjnl7TcdcwiPdmUI
        L7PDuWw5EHtuUB0h3SIMwUM=
X-Google-Smtp-Source: ABdhPJxZ2jY+wMDYjTy7G8OoBSAEtjGieq42V1SbbKU98nxxVnPAyKFImwL4eXny0f4+7V1WbEHmHA==
X-Received: by 2002:a63:5421:0:b0:3aa:5717:fadb with SMTP id i33-20020a635421000000b003aa5717fadbmr2259402pgb.422.1650417634718;
        Tue, 19 Apr 2022 18:20:34 -0700 (PDT)
Received: from localhost ([192.55.54.52])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090a674f00b001cba1008a3csm17225172pjm.51.2022.04.19.18.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 18:20:34 -0700 (PDT)
Date:   Tue, 19 Apr 2022 18:20:32 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, isaku.yamahata@gmail.com
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Message-ID: <20220420012032.GA2224031@ls.amr.corp.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 03:01:09PM -0700,
Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
...
> diff --git a/drivers/platform/x86/intel/tdx/intel_tdx_attest.c b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
> new file mode 100644
> index 000000000000..9124db800d4f
> --- /dev/null
> +++ b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
...
> +static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct attest_dev *adev = platform_get_drvdata(pdev);
> +	void __user *argp = (void __user *)arg;
> +	struct tdx_gen_quote tdquote_req;
> +	long ret = 0, err;
> +
> +	mutex_lock(&adev->lock);
> +
> +	switch (cmd) {
> +	case TDX_CMD_GET_TDREPORT:
> +		if (copy_from_user(adev->report_buf, argp,
> +					TDX_REPORT_DATA_LEN)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		/* Generate TDREPORT_STRUCT */
> +		err = tdx_mcall_tdreport(adev->tdreport_buf, adev->report_buf);
> +		if (err) {
> +			ret = put_user(err, (long __user *)argp);
> +			ret = -EIO;
> +			break;
> +		}
> +
> +		if (copy_to_user(argp, adev->tdreport_buf, TDX_TDREPORT_LEN))
> +			ret = -EFAULT;
> +		break;
> +	case TDX_CMD_GEN_QUOTE:
> +		reinit_completion(&adev->req_compl);
> +
> +		/* Copy TDREPORT data from user buffer */
> +		if (copy_from_user(&tdquote_req, argp, sizeof(struct tdx_gen_quote))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		if (tdquote_req.len <= 0 || tdquote_req.len > GET_QUOTE_MAX_SIZE) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (copy_from_user(adev->tdquote_buf, (void __user *)tdquote_req.buf,
> +					tdquote_req.len)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		/* Submit GetQuote Request */
> +		err = tdx_hcall_get_quote(adev->tdquote_buf, GET_QUOTE_MAX_SIZE);
> +		if (err) {
> +			ret = put_user(err, (long __user *)argp);
> +			ret = -EIO;
> +			break;
> +		}
> +
> +		/* Wait for attestation completion */
> +		ret = wait_for_completion_interruptible_timeout(
> +				&adev->req_compl,
> +				msecs_to_jiffies(GET_QUOTE_TIMEOUT));

If timeout occurs, the state of adev->tdquote_buf is unknown.  It's not safe
to continue to using adev->tdquote_buf.  VMM would continue to processing
getquote request with this buffer.  What if TDX_CMD_GEN_QUOTE is issued again,
and tdquote_buf is re-used?
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
