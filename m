Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8AC4BEF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiBVB0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:26:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiBVB0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C469725C48
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645493150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erH6D9r4ohPrplaR+ZZ1qFAgSmKt6DXXVKtw1IUMRT8=;
        b=VfVWHu51Z0PsTDjBW1NfySrzQsqV2iJpUMrp6X4GJxXyloC582oyGtojQR/Yjyfp+2mtz/
        h2yWOfFZ7anfWTWFnzejf17vhPTgeHZGMYVN4BvZpjW6QKY3mbIrjaPZR1WyfZf1By8dgm
        YI0kiy4cb63BVFJD8PeZKaFCOF604ck=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-bbSyPg4BO5OcKSF8THVQyQ-1; Mon, 21 Feb 2022 20:25:49 -0500
X-MC-Unique: bbSyPg4BO5OcKSF8THVQyQ-1
Received: by mail-qv1-f70.google.com with SMTP id cg14-20020a05621413ce00b0042c2706a4beso19056295qvb.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erH6D9r4ohPrplaR+ZZ1qFAgSmKt6DXXVKtw1IUMRT8=;
        b=I/TMuDTQOLT201tvJu2MBDA0ItvM4WXi4VEtBFeqcifMDZrC7lKjfaCaWfnUv2y2bt
         hYS+MY8IOS4r6ZIMe4qTwcKwSo7axEQMje4WXT78ec1TaHt0Ip9MqA9vVwhZ/9fdI6in
         ly3hWpfws1p5St+9gPKKy6Uk+GTUUpKgrwNJtHqa1eOriJWuA7brhUh7eXrQ/y2YeViA
         4/ku4bHuUI8hS0W7vKuM+WqWrxdn+ig5E15henHXpcdz1WTy9ZJtm+KnwJqRec7aqFNv
         M4+bOM9duuRgjyvV1i/ssZMBEliDckY9VPPUkY5/uL1RW/ZePJQpxmd6oRYZj0h0Y2w6
         2vAg==
X-Gm-Message-State: AOAM532cpE7IiJ0/qhxOJv1ACaUWf3G4XD2FXuZhKSFdVVWUi8lXEBaF
        ewICuZ7sxfO6PtAIGIW1ZfTeLnmy8w/X8/UpI6vNbhqkphTNjtKZUH1/sbePeTgOSqGgk/bYM2Y
        MAJRbcqVHoXFzcPH2emPZI2KT
X-Received: by 2002:a37:a903:0:b0:648:c9b4:7718 with SMTP id s3-20020a37a903000000b00648c9b47718mr6251032qke.71.1645493148908;
        Mon, 21 Feb 2022 17:25:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjscKgAimHhGxi2jkUGBjFGLMw0Zd15t/9Ns2HnIQHfcvvQx8yQGYXGgTi0U9cpStDFwJ+Mg==
X-Received: by 2002:a37:a903:0:b0:648:c9b4:7718 with SMTP id s3-20020a37a903000000b00648c9b47718mr6250996qke.71.1645493148594;
        Mon, 21 Feb 2022 17:25:48 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id 17sm7182752qkr.60.2022.02.21.17.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 17:25:47 -0800 (PST)
Date:   Mon, 21 Feb 2022 17:25:43 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 16/32] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220222012543.emeoqt4sppwurycj@treble>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-17-kirill.shutemov@linux.intel.com>
 <8bb2e660-f92d-a501-57ea-61138dafed28@amd.com>
 <20220221220233.mbntv342fg2wp7dp@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221220233.mbntv342fg2wp7dp@black.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 01:02:33AM +0300, Kirill A. Shutemov wrote:
> On Mon, Feb 21, 2022 at 02:04:33PM -0600, Tom Lendacky wrote:
> > On 2/18/22 10:17, Kirill A. Shutemov wrote:
> > > Port I/O instructions trigger #VE in the TDX environment. In response to
> > > the exception, kernel emulates these instructions using hypercalls.
> > > 
> > > But during early boot, on the decompression stage, it is cumbersome to
> > > deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> > > handling.
> > > 
> > > Add a way to hook up alternative port I/O helpers in the boot stub.
> > 
> > This seems like a lot of churn in order to get this all working without
> > taking a #VE.
> 
> Well, it evolved from more concise (but also more hacky) implementation:
> 
> https://lore.kernel.org/all/20211214150304.62613-11-kirill.shutemov@linux.intel.com
> 
> > How cumbersome is it to get #VE handling working in the decompression
> > stage? Can you build on any of the support that was added to handle #VC?
> 
> We definitely can.
> 
> But I still think exception-based implementation is inherently more
> fragile. I would rather stick with this.

At least from reading the commit message it's not self-evident why #VE
handling would be worse, especially since there's already #VC support in
boot.  It would help to give more info about that in the commit message.

The current approach also seems fragile, doesn't it require all future
code to remember to not do i/o directly?  How do we make sure that
doesn't happen going forward?

How does it fail if some code accidentally does i/o directly?  Or
triggers #VE some other way?  Is the error understandable and
actionable?

-- 
Josh

