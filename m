Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5126C4B8083
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbiBPGAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:00:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiBPGAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19063108BE2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644991199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4bAer3HSV5x3IdbNWT8+fRZbFKo5/BXNXQDMtZkdgJY=;
        b=CcXYdc7VOrXTdp8h6h9l7ivvITPfLYg4pzgf4mfRGqTHvNSZSzc7Bkuuqmeposl8pnT89J
        5V9zv/ktf2soAPjM1J8rkhbP9ZlbqsqaSBy4OSJwyz6i0sKcSqkMahyyFToN73PP3EEXVD
        vSdj6Uu3AeXDiNihRIk1Gy/5u8FyD6g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-KNlTUVVqO7q1cY0Z9AkynQ-1; Wed, 16 Feb 2022 00:59:57 -0500
X-MC-Unique: KNlTUVVqO7q1cY0Z9AkynQ-1
Received: by mail-qk1-f199.google.com with SMTP id bi17-20020a05620a319100b0050850bdcbb2so600231qkb.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4bAer3HSV5x3IdbNWT8+fRZbFKo5/BXNXQDMtZkdgJY=;
        b=wiaMd2J6+HX+C6un1YOmlQWl8H/QMHRcpOcEJogZ+3fXnK/iK9d7CC//6DZrpDBKkz
         x2jteQVdejImC7tZY/0ZQOe0RX360UOk+Y7e3H0d8vNDgS8QG4CR7umWXdABVx583Jn7
         S7fsc9fmhLBPq9U9psYiX7Utqi7BkcQk7R6T0JzACcckYv6z2pGUxs8jmOcNTb9L+HTZ
         ddsf9PorXBMu94U3Br50XJTE92jZ0RNbfaok5VNV83YGLFq1qOuEjw4nq6uG8rROeiqX
         VmboMNPFgB9jJkJYX0/jQiCzjXEMsQw55Itgq2MuBe1euBBLxHpym61/HnbbcvgL1Wt0
         P/kA==
X-Gm-Message-State: AOAM532xlv8vZ39VZ/v8VPwFf2cb+Vlt2IHvlkA5sZqE6qov2bzBxl8g
        E6TK37qYVEy2dC2O5WNfTgMZhUB+04qbR2tPIU2ywS3+ICZPwZFKK4vcuefkBcobrExuaiotmAY
        DpbsSMt14GlnsgDMJaPNciY3/
X-Received: by 2002:a05:6214:21e9:b0:42c:dede:56f5 with SMTP id p9-20020a05621421e900b0042cdede56f5mr705403qvj.127.1644991196719;
        Tue, 15 Feb 2022 21:59:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxU4UfWc1LfGl7vFBNRVVFbMV3zk++PhWdSPuz5Q5v5m4SYJ9ytfXRVzalBUhnbYOtdBxldNQ==
X-Received: by 2002:a05:6214:21e9:b0:42c:dede:56f5 with SMTP id p9-20020a05621421e900b0042cdede56f5mr705393qvj.127.1644991196506;
        Tue, 15 Feb 2022 21:59:56 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::e])
        by smtp.gmail.com with ESMTPSA id q12sm18841677qkl.78.2022.02.15.21.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 21:59:55 -0800 (PST)
Date:   Tue, 15 Feb 2022 21:59:52 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, ardb@kernel.org,
        bp@alien8.de, broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        ndesaulniers@google.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH v3 5/5] tools: update x86 string routines
Message-ID: <20220216055952.ovrswb22lm53x5ns@treble>
References: <20220211151445.2027553-1-mark.rutland@arm.com>
 <20220211151445.2027553-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211151445.2027553-6-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:14:45PM +0000, Mark Rutland wrote:
> When building the perf tool the build system complains that the x86
> string routines are out-of-date:
> 
> | Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
> | diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
> | Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs from latest version at 'arch/x86/lib/memset_64.S'
> | diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
> 
> This is due to the way the asm-annotations for symbol aliasing were
> reworked, which should have no functional/performance impact.
> 
> Import the latest versions, adding the new style SYM_FUNC_ALIAS(),
> SYM_FUNC_ALIAS_LOAD(), SYM_FUNC_ALIAS_WEAK() macros into the perf
> <linux/linkage.h> header. The old style SYM_FUNC_START_ALIAS() and
> SYM_FUNC_END_ALIAS() macros are removed.
> 
> Other than removing the build-time warning, there should be no
> functional change as a result of this patch.

These changes should probably be squashed with their corresponding
original kernel changes to avoid breaking bisection for the warnings.
And it helps to keep the interdependent changes together.

-- 
Josh

