Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0059EFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiHWX2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHWX2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:28:18 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430948035C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:28:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3378303138bso379119557b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9gUcNwwoI1We4/BZdL5lGf0kg357WN6NLzm+6DIPfiE=;
        b=FdPXdB5nRB8XQbCYc2FLN9mKm1ZtF3/3Xx+rl1Kzz9rEhs5tIpy+cYyUIhJjEx/9ZN
         GAN8xZJ34HR8MR1b/zvAlyef2sxtNrQEC/lkB8HqYxd4d64BlTnXLVK1qPRSIs+H33Vs
         orQ74sd7BQR69ZLV4kccgWjWnehdx06FEvq40j1PtzDuDzrza4IO8mi+8Mld8kM0+KUN
         ALoIOl6fF4RDRzeISBziqde5njpHoATTMqtd+uhG+3+/FxcKYuNWcN6iQVA3k8PSUHn/
         2uS44dq3a2I7hG9L6ErzLcZEAzaVakDqLBBLIlU9y4NHOlwyZy9y2J7GxYNxZ74s+YKn
         7VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9gUcNwwoI1We4/BZdL5lGf0kg357WN6NLzm+6DIPfiE=;
        b=gsfFMONey5l5DzH1sUYp7oH3vWFq7iECi2lNgnvNHOJw9DzJQvr//RRAVycb3/JUJw
         icNp0CI4fT8339ItI3eKdBFVMqGb0icl5Fg3tiKb9I2pIuq7n/9XLKxLQCTw9Zj9rHym
         4Rw+zbV4vG5bySx8ueb/a2hkF5ILMkASVLP74ivarddZxbcn7s9BT/AhrxAGJkR5O2wI
         14fdI9BO7ah85ZKs/wlAerC2ZtbRLWzJhJeEGg6UOEXxhGvDp9wnFCBCw77ctmP49xV2
         XodXkAv0RFWBaj2gZVnvmqXfD+Q5puPJ7cEkOG4YnNyPPtY7Tg47QEIeoF9h70TI4bkS
         hvwg==
X-Gm-Message-State: ACgBeo3qQj/OA19UnQ1nopx9C559LkTkZMRUsr2ZnQC6Lx4iaGOarg9+
        a0qkSBw9ufZvIFwl2NA5+tr844ucx6Sdfg6ZdmGpAygYuWIyKg==
X-Google-Smtp-Source: AA6agR6nXfeIzEr0hu46UpnUMI3xi9C8zbGJW8/FY5r6kiZBARlrv/K/wdX6nkmeVU6Bm/7/GcndQsDdbbMfNdNSwjA=
X-Received: by 2002:a81:6f43:0:b0:335:9e7e:ad25 with SMTP id
 k64-20020a816f43000000b003359e7ead25mr28234253ywc.518.1661297297433; Tue, 23
 Aug 2022 16:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com> <44495aa8acb666b447a08a1c3af80987aa3cea3a.1659103274.git.thomas.lendacky@amd.com>
In-Reply-To: <44495aa8acb666b447a08a1c3af80987aa3cea3a.1659103274.git.thomas.lendacky@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 23 Aug 2022 16:28:06 -0700
Message-ID: <CAAH4kHbMh4uDyCJHPt=_K9KeHc3AN2F4GDK2m-Preqqe=eoBng@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] x86/sev: Add SNP-specific unaccepted memory support
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1553,6 +1553,7 @@ config AMD_MEM_ENCRYPT
>         select INSTRUCTION_DECODER
>         select ARCH_HAS_CC_PLATFORM
>         select X86_MEM_ENCRYPT
> +       select UNACCEPTED_MEMORY
>         help
>           Say yes to enable support for the encryption of system memory.
>           This requires an AMD processor that supports Secure Memory

At the risk of starting another centithread like on Kirill's patches
for unaccepted memory, I think this needs to be brought up.

By making unaccepted_memory on option rather than a dependency, we get
into an inescapable situation of always needing to know whether or not
the guest OS will support unaccepted memory, from within the firmware.
I think that makes a UEFI specification change necessary.
If we don't make this configurable, and indeed make it a dependency,
then we can say SEV-SNP implies that the firmware should create
unaccepted memory. We can work around the short gap of support between
kernel versions.

What are your thoughts on dependency versus UEFI spec change to allow
this configuration to be negotiated with the firmware?

-- 
-Dionna Glaze, PhD (she/her)
