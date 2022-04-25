Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989350EBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiDYW0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbiDYV3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:29:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F1220CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:26:08 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B81DA1EC04A6;
        Mon, 25 Apr 2022 23:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650921961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzCRn9yN2ByyCFR5QKv9+K8B8VcoQwcA3ZVz2Ifi7JQ=;
        b=fNnh8YiUMApB0I9iM+V6r0nvmh8FA7oNdMa5U7S15/LCpqbI1/jM6tKwfyZ0aDGbo5ZAAv
        UISb+73NpqVJqWCi+Fa1hLJKqxhd+c42n4JjVcHL1lptzDXi9IsAxaLj9BDartlz8vh+99
        YmQB5O8tl20QGO/Fbc7aZfQyJMnzDYU=
Date:   Mon, 25 Apr 2022 23:25:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Oleksandr <olekstysh@gmail.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
Message-ID: <YmcR5bfaYh1z7VUq@zn.tnic>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
 <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
 <YmZUpua3hkCPdbfx@infradead.org>
 <147f68f6-7d67-1884-bd14-5040639b3396@suse.com>
 <67c7460a-3001-35a6-8e5b-f367270b257a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67c7460a-3001-35a6-8e5b-f367270b257a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:38:36PM +0300, Oleksandr wrote:
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index efd8205..d06bc7a 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -72,6 +72,19 @@ enum cc_attr {
>          * Examples include TDX guest & SEV.
>          */
>         CC_ATTR_GUEST_UNROLL_STRING_IO,
> +
> +       /**
> +        * @CC_ATTR_GUEST_MEM_ACCESS_RESTRICTED: Restricted memory access to
> +        *                                       Guest memory is active
> +        *
> +        * The platform/OS is running as a guest/virtual machine and uses
> +        * the restricted access to its memory. This attribute is set if
> either
> +        * Guest memory encryption or restricted memory access using Xen
> grant
> +        * mappings is active.
> +        *
> +        * Examples include Xen guest and SEV.

Wait, whaaat?

The cc_platform* stuff is for *confidential computing* guests to check
different platform aspects.

From quickly skimming over this, this looks like a misuse to me.

Why can't you query this from the hypervisor just like you do your other
querying about what is supported, etc? Hypercalls, CPUID, whatever...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
