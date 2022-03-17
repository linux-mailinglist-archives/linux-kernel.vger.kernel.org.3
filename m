Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4A74DBB78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbiCQADP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiCQADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:03:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FBA1C109
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:01:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647475314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2ksdiCQd8Isy85s8UATjgMhxSbCAMBPP9J4+Oelrzg=;
        b=bW49l+ZBXDhg2pEAaiiiFVKyIDI2KftUjO2JTKZjT8GVAd1BqFTkjQWAdu4UV8FRhuWDg9
        X6k5gYBtf+X4uuc8u+xDcj5fUCN1Djf7EWU3oi/GgjhXSRJHMSFOzad2fB1SAAnkwdihaG
        tNRHEnYeyMw86nz5bnPoZlimduCCKp8JYjeuYiu5jgeJQdVLM7y1wT9vnVkwot0IgFxyb9
        l57RT8dxGtY2Kijp4w1vN7ng/ptb47oFkMn4ij2MwVDJATqEyUG4eqXuICS57Dq2VOBzLF
        NgYmwulEHwKO83Sx8nOHrVCdexhY3iWpj6fLH7bn123C4wz43V/kYae+BWCeUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647475314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2ksdiCQd8Isy85s8UATjgMhxSbCAMBPP9J4+Oelrzg=;
        b=LDRwmRkBWl91etYRlYovqHliMdLDGlDyUVI2aD2HaK6MQHOL/UkDOze7RGpO4F0EdRyC82
        FrDr2k9iRZ4XLNBA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCHv6 04/30] x86/tdx: Extend the confidential computing API
 to support TDX guests
In-Reply-To: <20220316020856.24435-5-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-5-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 01:01:54 +0100
Message-ID: <87fsnh30r1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> +
> +static void get_info(unsigned int *gpa_width)

get_info() is really not a descriptive function name. Also why does this
need a pointer and does not return gpa_width?

>=20=20
>  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>=20=20
> +	get_info(&gpa_width);
> +
> +	cc_set_vendor(CC_VENDOR_INTEL);
> +
> +	/*
> +	 * The highest bit of a guest physical address is the "sharing" bit.
> +	 * Set it for shared pages and clear it for private pages.
> +	 */
> +	cc_set_mask(BIT_ULL(gpa_width - 1));

The code ordering here is silly:

    1) Retrieve gpa width
    2) Set CC vendor
    3) Use gpa width

static u64 get_cc_mask(void)
{
        gpa_width =3D magic();

        /*
         * Comment explaining the return value
         */
        return BIT_ULL(gpa_width - 1);
}

and

        cc_set_vendor(CC_VENDOR_INTEL);
        cc_set_mask(get_cc_mask());

would be too intuitive, right?

Thanks,

        tglx

---

=E2=80=9CMy tastes are simple: I am easily satisfied with the best.=E2=80=9D
                                     =E2=80=95 Winston S. Churchill=20
