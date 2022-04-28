Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14880513B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350653AbiD1Rx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiD1Rx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FCC2E0E0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651168210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJTOY5+nbwDhRLBfUSH+EDSjAOUuXCma4WR8yoxN0tI=;
        b=gIQZTg1hJk6Ykr9aI6vvp3WKHFjENcxuoeKnmHJGWOTr7KxNpcJpgengLYchMXH+YOLDBk
        bwp4oisV+58en2+sIstLlPOvRZcOvUGJgWZnTqJe6Z+C7zC/UI6J2mjx6rHMql3in8Owtw
        RtJfsGljv27g+QVDoicI/M26+mV8Uwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558--bDOhBJkO6-c5HGBVRRtLw-1; Thu, 28 Apr 2022 13:50:04 -0400
X-MC-Unique: -bDOhBJkO6-c5HGBVRRtLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96E06101AA46;
        Thu, 28 Apr 2022 17:50:03 +0000 (UTC)
Received: from fedora (unknown [10.22.33.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 351A7C27E90;
        Thu, 28 Apr 2022 17:50:01 +0000 (UTC)
Date:   Thu, 28 Apr 2022 14:50:00 -0300
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
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Message-ID: <YmrTyPtrIBNM0ICk@fedora>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422233418.1203092-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:34:17PM -0700, Kuppuswamy Sathyanarayanan wrote:

[snip]

>  
> +/*
> + * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
> + *
> + * @vector        : Vector address to be used for notification.
> + *
> + * return 0 on success or failure error number.
> + */
> +static long tdx_hcall_set_notify_intr(u8 vector)
> +{
> +	u64 ret;
> +
> +	/* Minimum vector value allowed is 32 */
> +	if (vector < 32)
> +		return -EINVAL;
> +
> +	/*
> +	 * Register callback vector address with VMM. More details
> +	 * about the ABI can be found in TDX Guest-Host-Communication
> +	 * Interface (GHCI), sec titled
> +	 * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
> +	 */
> +	ret = _tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0);
> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Just "return _tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0);" does the job, doesn't it?
And we can remove the declaration of ret.

[snip]

>  
> +#ifdef CONFIG_INTEL_TDX_GUEST

Just for consistency, can we change to "#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)"?

> +DECLARE_IDTENTRY_SYSVEC(TDX_GUEST_EVENT_NOTIFY_VECTOR,	sysvec_tdx_event_notify);
> +#endif
> +

[snip]

