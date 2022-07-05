Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4735566798
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiGEKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiGEKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:15:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C779A14001
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657016143; x=1688552143;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3HtRUmDD4XiqNiDnisSrovnGe62Zh+fxdlcbvF4nfFQ=;
  b=EMu3qkqY4yZ3ye7VJZTXGfDTfz8mYWggn1/SIufulaew0Y8WYX/87GDl
   u4ufTPx3iA/c7l3AwivKr5OATm1imTvHTXEKG+zE9BF95uyDVi3F0dy/v
   SOvyzejsLekoX+iu7u4Oy6gwwlZbHeGcuYrEnh0FI8PwMOWeDU0X/axS9
   fwseTW+iYX6fnwGtQDKjRRkmHTYpAjv/SUcaCqoU0mfia3EisPXNeDns3
   f2hJ84vNsccH6Z3J/Sd9UsN7urnH9jZXYHsH8vlWqVoSTaf2xBZKSiUaC
   hFgX7el0mQMWwuxq1f9Hk8Ff+F/uwfshkRo6Ebq9W+Vlu58oZPNCGfPCX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263737557"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263737557"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:15:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542899935"
Received: from atornero-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.166.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:15:40 -0700
Message-ID: <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
From:   Kai Huang <kai.huang@intel.com>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com
Date:   Tue, 05 Jul 2022 22:15:38 +1200
In-Reply-To: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 11:22 -0300, Martin Fernandez wrote:
> Right now the only way to check this is by greping the kernel logs,
> which is inconvenient. This is currently checked for fwupd for
> example.
>=20
> I understand that cpuinfo is supposed to report every feature in the
> cpu but since AMD is doing the same (and it also broke backwards
> compatibility [1]) for sme/sev I think it's good to have this for
> Intel too.
>=20
> Another option to prevent greping the logs would be a file in
> sysfs. I'm open to suggestions to where to place this infomartion. I
> saw a proposal about a firmware security filesystem [2]; that would
> fit perfectly.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=
=3D08f253ec3767bcfafc5d32617a92cee57c63968e
>=20
> [2] https://lore.kernel.org/all/20220622215648.96723-3-nayna@linux.ibm.co=
m/

Leave above to others, but...=20
>=20
> Changelog since v1
>=20
> Clear the flag not only for BSP but for every cpu in the system.

... the changelog history shouldn't be in the commit message.

You can put one additional '---' after your 'Signed-off-by' and add your
changelog after it.  The content between two '---'s will be stripped away b=
y
'git am' when maintainer takes the patch:

	Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
	---
	v1->v2:
		xxx
	---
	arch/x86/kernel/cpu/intel.c | 1 +
	1 file changed, 1 insertion(+)
>=20
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index fd5dead8371c..17f23e23f911 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -570,6 +570,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
>=20
>  	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_act=
ivate)) {
>  		pr_info_once("x86/tme: not enabled by BIOS\n");
> +		clear_cpu_cap(c, X86_FEATURE_TME);
>  		mktme_status =3D MKTME_DISABLED;
>  		return;

This code change itself looks good to me.

But, TME actually supports bypassing TME encryption/decryption by setting 1=
 to
bit 31 to IA32_TME_ACTIVATE MSR.  See 'Table 4-2 IA32_TME_ACTIVATE MSR' in =
MKTME
spec below:

https://edc.intel.com/content/www/us/en/design/ipla/software-development-pl=
atforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-proc=
essors-datasheet-volume-1-of-2/002/intel-multi-key-total-memory-encryption/

When bit 31 is set, the TME is bypassed (no encryption/decryption for KeyID=
 0).

So looks userspace also needs to check this if it wants to truly check whet=
her
"TME memory encryption" is active.

But perhaps it's arguable whether we can also clear TME flag in this case.

So:

Acked-by: Kai Huang <kai.huang@intel.com>


--=20
Thanks,
-Kai


