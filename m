Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16E94C5F4E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiB0WGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiB0WGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D864C6C909
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645999533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuFojt0UoLu2n/1rvzU9Xb50Ocehlc4c8D5HnYsAZOE=;
        b=fXpRKAz9FX5/LgB1PLcQP7H78eHTvqZl6Rv4zxIAchmDaT8Mj38yoVQPX1hBhYwNI5nfu5
        d1+hBc0AS/bVOpELYMow+A1UskqjJiAoj2ySCC734nazqWW3Fx7XPHV6VqQwQJk3yIyCYh
        +8Cnxn6eQjSEuYhcyw16HiUWblTtIBU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-lpZHXHdfPauGqtuV83NhTg-1; Sun, 27 Feb 2022 17:05:31 -0500
X-MC-Unique: lpZHXHdfPauGqtuV83NhTg-1
Received: by mail-qv1-f72.google.com with SMTP id v16-20020a0ce1d0000000b00432bb204b3dso7793966qvl.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AuFojt0UoLu2n/1rvzU9Xb50Ocehlc4c8D5HnYsAZOE=;
        b=WeN5x733GNodWuEpvsLVK6Z5XU8QxRC8uZrCNTDRKyceSSHHHn5xpR3cL91tb/T/p6
         g5c4fBV0mWLi/Ap7DpAcGxkeGGXe4EbJ4IeiJY9bd+nTlPVbvyeuy0nHqP6pl/jm1UhG
         2kZQQT5+h1wgCqLIlwKeKVyad7jsJe94n9rqTjZmUGrK8gxcgy9UmeQFuLPUZSNoGcW9
         wzjqZ126Hb1pY2drOEyAd+jOyVkGOkrDsAYOEDejGRrlUjJnCPsuubKpH4W/tQyTVKWy
         naiy9s+DdivqZZ1uDULubIwOSMryDjtTGZRuogoLqOxxrfpTeLVECn6lYplnhREd5LLH
         3/Tw==
X-Gm-Message-State: AOAM532CQi2BIBOsed5gmltBlQcFXrRMzeWTVL/FaNHx8zXDTI7aGQdX
        WZjifER/fTU0Lv6D4FX8A34mYZjLkY2q+9DiCj+UTRnv5qE575gud50NTe+7E8frmSd+nx1vFG4
        dMF1uEbfQxF5VFuholFyoZ0V0
X-Received: by 2002:a37:a397:0:b0:508:1e24:e2e0 with SMTP id m145-20020a37a397000000b005081e24e2e0mr10077170qke.168.1645999531207;
        Sun, 27 Feb 2022 14:05:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/lMmFXa/6ydY0WmSPd5WFnbH4+TSmFAvIBjo4CQ3nypMcQrjLdijNyUCicOAtWgXxn39bAQ==
X-Received: by 2002:a37:a397:0:b0:508:1e24:e2e0 with SMTP id m145-20020a37a397000000b005081e24e2e0mr10077146qke.168.1645999530935;
        Sun, 27 Feb 2022 14:05:30 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id h17-20020ac87d51000000b002de919e3187sm6101925qtb.28.2022.02.27.14.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:05:30 -0800 (PST)
Date:   Sun, 27 Feb 2022 14:05:26 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 29/30] ACPICA: Avoid cache flush on TDX guest
Message-ID: <20220227220526.3rrmy3u7j2xpelcn@treble>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-30-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224155630.52734-30-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 06:56:29PM +0300, Kirill A. Shutemov wrote:
> +/*
> + * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
> + * It is required to prevent data loss.
> + *
> + * While running inside TDX guest, the kernel can bypass cache flushing.
> + * Changing sleep state in a virtual machine doesn't affect the host system
> + * sleep state and cannot lead to data loss.
> + *
> + * TODO: Is it safe to generalize this from TDX guests to all guest kernels?
> + */
> +#define ACPI_FLUSH_CPU_CACHE()					\
> +do {								\
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))	\
> +		wbinvd();					\
> +} while (0)

If it's safe, why not do it for all VMs?  Is there something specific
about TDX which makes this more obviously known to be safe than for
regular VMs?

The patch description and the above comment make it sound like "we're
not really sure this is safe, so we'll just use TDX as a testing ground
for the idea." Which doesn't really inspire a lot of confidence in the
stability of TD sleep states.

-- 
Josh

