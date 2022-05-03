Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1384F5186E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiECOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiECOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EA735244
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651588703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jvW9O8FtNByur9xmyT+4fDeABWXYnCsciURT7bZp4c=;
        b=dFRHK14VQdrOgdiJnTqysL19Wmxj3KNuaNJJByycrZ3/JrTJbzwxFOAh4WozQj8AZl2AB7
        6rKHKcRE0z9r86GcTDRpUoNEMzKZ2cgMFAOjOAx8IVeyc1mgiK/8wANDVgc6+aAs9XMFHe
        9b82H9k2O81tmW2EMmh/trBSzYEFRgw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659--GP6IOWzPlS2l9pIV5MeEw-1; Tue, 03 May 2022 10:38:19 -0400
X-MC-Unique: -GP6IOWzPlS2l9pIV5MeEw-1
Received: by mail-lj1-f197.google.com with SMTP id l13-20020a2e868d000000b0024f078d7ea0so4293296lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jvW9O8FtNByur9xmyT+4fDeABWXYnCsciURT7bZp4c=;
        b=SCpA2BMlYaHIprEiGOIpFNjF7clamqJIDxXOr2V+n+5cNOpviDnP8v0IXP398rhs0L
         oSrY6Ztlz8006+m9xXVvphDdZnfLh1oRMBkttK5xxQt6ZtTNdJTrqtv/fsnK6GXq5RMT
         eTvy0RPpvrmoVnMcOsXPULxAAIiynFnMRtrEUmAHmhlZogm+1QRlh9urXvHqt3pUApO4
         tSF8/rFaVc56YLy+DYDgVMKjoLmBdH4Rv9TmsJD02Tj+mUhZRm5Cg2zHyNhH5MAleRTd
         AFhRi3xO2ZlSbmeiXG2JbW12wLybSCrhz5pVrg43+te1+XLKAK/jrnGCaGvbpunNotrv
         ntpA==
X-Gm-Message-State: AOAM531BpQ3+V0xqpquAcg9hnvxaUJOuKqdgNSWl3XHiFB52A9wU59F0
        shYea4fjfOfuEbVSKpRS2DFOZLGzFrU/q/JC0fAnFEOu2SRaA14QwIsd6VMpNH1LPSPSimDDSNs
        Uiqlr7TtfPFUu9yZrWg3YTnFTUDcdG2w7fqtgXSkv
X-Received: by 2002:a2e:9889:0:b0:24f:4e49:6e71 with SMTP id b9-20020a2e9889000000b0024f4e496e71mr8179560ljj.190.1651588697217;
        Tue, 03 May 2022 07:38:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhy5xUPuEo02RrBNyg+U6WuEpzG1Gi9D+wS3+mSNyDxKVUGEkv2cnCkkhLzQA4eMUD7+l0LFiAjvCHa2ufNoo=
X-Received: by 2002:a2e:9889:0:b0:24f:4e49:6e71 with SMTP id
 b9-20020a2e9889000000b0024f4e496e71mr8179543ljj.190.1651588697029; Tue, 03
 May 2022 07:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <5473f606bd8e60dd7b8d58a540285d126a1361bd.camel@intel.com>
 <e5aed619-20ce-7eb3-22a3-64b51de9cce3@linux.intel.com> <b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com>
 <e673ea3d-ae4f-39ed-33a5-c6480e58c6d8@linux.intel.com>
In-Reply-To: <e673ea3d-ae4f-39ed-33a5-c6480e58c6d8@linux.intel.com>
From:   Wander Costa <wander@redhat.com>
Date:   Tue, 3 May 2022 11:38:05 -0300
Message-ID: <CAAq0SU=TPHQ4q8Dj583m0yfVytygN81BTEe8vU5GCOoFau+LWw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] x86/tdx: Add TDX Guest attestation interface driver
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 8:17 PM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> > [...]
>
> I don't want to pollute the dmesg logs if possible. For IOCTL use case,
> the return value can be used to understand the failure reason from user
> code. But for initcall failure, pr_err message is required to understand
> the failure reason.

How often is this call expected to fail?

