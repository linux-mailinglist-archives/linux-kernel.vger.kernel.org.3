Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB534D99E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbiCOLFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347586AbiCOLFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:05:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDBB4AE34;
        Tue, 15 Mar 2022 04:04:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHrBt2JSBz4xvg;
        Tue, 15 Mar 2022 22:04:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1647342262;
        bh=LxlvTOPlI5AK+PwnQwM7jyZc0uSmf3N9i0BEu9kcyYY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iPh5FAtdHT+j0m1zHUUIVHhA222aj0CCumeztBSdnL5LtgzBy312S2hdhw5R8VQLq
         c4Gu9Clfn5wHtOK96UmS6jd8b7CW7FTOfE1bXYzm8wXwIEHwdPws82aOBSs487giXq
         bFRi0x8zcUG2gEKIDqyqG4tTnznezFi0oDmD7etPWxU0GPDvVs8c7zbF+sIhpILqE0
         Uwyg9VApkVABZ+4hXhkJjXwOOz7EYyUdIQ1HYKcRKuEjX88cHc05DUEfo1qRIbjBwi
         l8Qsc5RlXenv3OAziscApY6BXN0zIEFmPPAli0DdM3YMJSGXqwz8W0OwSFjdIIT6c7
         YyEOPcm0AX7Ug==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: linux-next: manual merge of the nvdimm tree with the powerpc tree
In-Reply-To: <20220315191538.323eefbb@canb.auug.org.au>
References: <20220315191538.323eefbb@canb.auug.org.au>
Date:   Tue, 15 Mar 2022 22:04:20 +1100
Message-ID: <874k3z4guj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's linux-next merge of the nvdimm tree got a conflict in:
>
>   arch/powerpc/platforms/pseries/papr_scm.c
>
> between commit:
>
>   bbbca72352bb ("powerpc/papr_scm: Implement initial support for injecting smart errors")
>
> from the powerpc tree and commit:
>
>   4c08d4bbc089 ("powerpc/papr_scm: Add perf interface support")
>
> from the nvdimm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, resolution looks obviously correct.

Dan, this seems benign to me, I don't think any further action is
required other than mentioning it to Linus. But if you disagree let me
know.

cheers

> diff --cc arch/powerpc/platforms/pseries/papr_scm.c
> index 1238b94b3cc1,4dd513d7c029..000000000000
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@@ -121,9 -124,8 +124,11 @@@ struct papr_scm_priv 
>   	/* length of the stat buffer as expected by phyp */
>   	size_t stat_buffer_len;
>   
>  +	/* The bits which needs to be overridden */
>  +	u64 health_bitmap_inject_mask;
>  +
> + 	 /* array to have event_code and stat_id mappings */
> + 	char **nvdimm_events_map;
>   };
>   
>   static int papr_scm_pmem_flush(struct nd_region *nd_region,
