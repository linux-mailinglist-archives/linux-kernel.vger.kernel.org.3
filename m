Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369084AD99D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358793AbiBHNVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbiBHMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:12:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D2C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:12:58 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC6C31EC02B9;
        Tue,  8 Feb 2022 13:12:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644322373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y/e2GhBcXzHymJgRHX3UzkyGtFMTu3KEOpP5+yH5sGI=;
        b=sFeWiz2Wkl3Ujq/1CRN9aZeFQY8lvHEBQd5WzF9YEu28REyBhrAwJqpu8nyM7cTEfrBTpu
        R5xu0eUjuYiH8YFQ0v8VI16iNYPAL8+2CfrCfMB6pNlbNd+JtJ4Zrel3uri6pg7zKHhrRR
        Ki2MEP8chAEJrpKWIUi7ONPgDXEekUA=
Date:   Tue, 8 Feb 2022 13:12:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 23/29] x86/tdx: Add helper to convert memory between
 shared and private
Message-ID: <YgJePUqMEzHNqrsR@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-24-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-24-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:02:09PM +0300, Kirill A. Shutemov wrote:
> +static bool tdx_accept_page(phys_addr_t gpa, enum pg_level pg_level)

accept_page() as it is a static function.

> +int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end, bool enc)
> +{
> +	u64 ret;
> +
> +	if (end <= start)
> +		return -EINVAL;
> +
> +	if (!enc) {
> +		start |= tdx_shared_mask();
> +		end |= tdx_shared_mask();
> +	}
> +
> +	/*
> +	 * Notify the VMM about page mapping conversion. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> +	 * sec "TDG.VP.VMCALL<MapGPA>"
> +	 */
> +	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0, NULL);
> +


^ Superfluous newline.

> +	if (ret)
> +		ret = -EIO;
> +
> +	if (ret || !enc)

Is the second case here after the "||" the conversion-to-shared where it
only needs to notify with MapGPA and return?

Of all the places, this one needs a comment.

> +		return ret;
> +
> +	/*
> +	 * For shared->private conversion, accept the page using
> +	 * TDX_ACCEPT_PAGE TDX module call.
> +	 */
> +	while (start < end) {
> +		/* Try 2M page accept first if possible */
> +		if (!(start & ~PMD_MASK) && end - start >= PMD_SIZE &&
> +		    !tdx_accept_page(start, PG_LEVEL_2M)) {

What happens here if the module doesn't accept the page? No error
reporting, no error handling, no warning, nada?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
