Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7718151BD7D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356150AbiEEKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356246AbiEEKx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:53:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F691098
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651747817; x=1683283817;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gNXW3vYXEa87grD2dJlfiCaeJqqIzvvO2Zq+ZoNHIds=;
  b=Z/bXXGMM5KDTYokTr4uDn0hUyXLCnfnpW0w8CD7U0P1FHI0s2W6hpnso
   AcFc80SdTs/2HqeFrCvnodE/W4qL5lrvinT79aviyLMhCF5HoX7unBMIK
   VXaHKWbB7WzwbV0Z3kQcaQoBWrSpzt0Id/V6RSUGoQvY/cjYVqNwHhVbj
   331FKUNzssnNHDon1smD82auAVeVfzOvcywQLLGVbobwfvX6ouHOEYYky
   GP5ex2CdPRJFlDPQLkdBmVpa9kCsbqay+GuH0omUYq12jmWlclYd992eV
   g2t7ZI9tH0vIi1fqXMfQLrP++rozYEVPZ9tROKAAypeQc5SPwc1XQQe2l
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="255546134"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="255546134"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:50:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="599994948"
Received: from adgonzal-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.3.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:50:11 -0700
Message-ID: <1534b975275b78d61d851eb86faa226fd9be5c7a.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 May 2022 22:50:09 +1200
In-Reply-To: <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
         <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +       /* Submit GetQuote Request */
> +       ret = tdx_get_quote_hypercall(buf);
> +       if (ret) {
> +               pr_err("GetQuote hypercall failed, status:%lx\n", ret);
> +               ret = -EIO;
> +               goto free_entry;
> +       }
> +
> +       /* Add current quote entry to quote_list */
> +       add_quote_entry(entry);
> +
> +       /* Wait for attestation completion */
> +       ret = wait_for_completion_interruptible(&entry->compl);
> +       if (ret < 0) {
> +               ret = -EIO;
> +               goto del_entry;
> +       }

This is misuse of wait_for_completion_interruptible(). 

xxx_interruptible() essentially means this operation can be interrupted by
signal.  Using xxx_interruptible() in driver IOCTL essentially means when it
returns due to signal, the IOCTL should return -EINTR to let userspace know that
your application received some signal needs handling, and this IOCTL isn't
finished and you should retry.  So here we should return -EINTR (and cleanup all
staff has been done) when wait_for_completion_interruptible() returns -
ERESTARTSYS (in fact, it returns only -ERESTARTSYS or 0).

Since normally userspace application just ignore signals, and in this particular
case, asking userspace to retry just makes things more complicated to handle, I
think you can just use wait_for_completion_killable(), which only returns when
the application receives signal that it is going to be killed.

> +
> +       /* Copy output data back to user buffer */
> +       if (copy_to_user((void __user *)quote_req.buf, buf->vmaddr, 
> quote_req.len))
> +               ret = -EFAULT;
> +
> +del_entry:
> +       del_quote_entry(entry);
> +free_entry:
> +       free_quote_entry(entry);

As I (and Isaku) mentioned before, when wait_for_completion_killable() returns
with error, you cannot just convert the buffer to private and free it.  The VMM
is still owning it (IN_FLIGHT).

One way to handle is you can put those buffers that are still owned by VMM to a
new list, and have some kernel thread to periodically check buffer's status and
free those are already released by VMM.  I haven't thought thoroughly, so maybe
there's better way to handle, though.

-- 
Thanks,
-Kai


