Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19B153502E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbiEZNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiEZNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E63552E6A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653572954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DKyzE80Pc48cMDLiFmE/M6F8vHHIcOjbw+ucouph1XQ=;
        b=HOCUx+sXMHIqVP//aIUFhzAJwloSzQkGYSkUFz5KkJ9S/mcy2eoi6YrSShBytUrlfnyU1C
        BQDqVGGHuAhu84OYqxakcA3zufThLuGEjsJeCU0UsbtgBFsVZm47y3bABXUaD4vRHoPW++
        G5jR+IrrlZIcIs9815xYI/WOoCMlN8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-QIUMd_NUPGiulMcamOuHuw-1; Thu, 26 May 2022 09:49:10 -0400
X-MC-Unique: QIUMd_NUPGiulMcamOuHuw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 915158BEE80;
        Thu, 26 May 2022 13:48:45 +0000 (UTC)
Received: from fedora (unknown [10.22.16.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3751841638B;
        Thu, 26 May 2022 13:48:41 +0000 (UTC)
Date:   Thu, 26 May 2022 10:48:39 -0300
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
Subject: Re: [PATCH v7 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Message-ID: <Yo+FN8Utbrn5FYlT@fedora>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524040517.703581-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:05:14PM -0700, Kuppuswamy Sathyanarayanan wrote:
>  
> -#define LOCAL_TIMER_VECTOR		0xec
> +#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
> +/* Vector on which TDX Guest event notification is delivered */
> +#define TDX_GUEST_EVENT_NOTIFY_VECTOR	0xec
> +#endif

We can simplify this a bit by removing the #if conditional without harm
to the code.

> +
> +#define LOCAL_TIMER_VECTOR		0xeb
>  
>  #define NR_VECTORS			 256
>  

