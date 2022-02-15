Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3664B7221
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbiBOQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:07:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiBOQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:07:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F722DD9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:07:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso2557533pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyO09UbxJeRvoJPXaZeuEPEmDAtin+d+KKe2VrtUaUo=;
        b=k6dGMBXjj16JgvtRS/W1l6Q4I2nZDtQcAdycCp9Yomvd6JZnH2zqPlxIg+g+ZPVwSz
         Yd2M1LVjLDjA37krskwjCpbidnONcAVHIcSbAjYLFVZbM5iGekAEKyRZZ7xCywxW3nBM
         4HP4E451gdn725+Vgz91Q6TCzCawlBmVlldfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyO09UbxJeRvoJPXaZeuEPEmDAtin+d+KKe2VrtUaUo=;
        b=4mjL/EErecsXUefy6iv/q9jc0yxzS+EGSPqf1DlLlxtEceoP1WlGDNrBJUy0OPK/WC
         kJttf/r25NOWaDOCHiC6FU0Dr55TEh80Tk47O+OrBqCeAueLw2x3h300xzgN8LaOlUf0
         T66bnLZkdpFpVvFbVHk86UKYE7g1hmpAmYlnLoACrNA10mdUH+S5KQGRE5Ouc0sTMfYc
         qAvjt/CQJp8gyv+WX+8o5NOhY6SH53d6CIudg3Xi0sSaNMiF4O7lMV5W5mBqeFcITEmv
         TVJx5JmfHU+4B0xgu7s+fvsVFAkw1DKsWKFbpQRZ3iddqykZIzGvZhi1wZNDe3gE8qAP
         IAsg==
X-Gm-Message-State: AOAM530fNwqeabJ3uu9fvWc80ZPyLtZh9fSaRfLmc3ly2S6KrX2DD0Ca
        9opPdVfPKP2DUEAF6Q1GAdY2KQ==
X-Google-Smtp-Source: ABdhPJySTpQ67R+nuQyJJfrGZTBLhUE5/ijHpxyRKCqjoqAnDBf2qQYFgmJer9uiO3sFYsKqwhcw6g==
X-Received: by 2002:a17:902:cec5:: with SMTP id d5mr4782522plg.96.1644941220276;
        Tue, 15 Feb 2022 08:07:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i17sm3101014pgv.8.2022.02.15.08.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:06:59 -0800 (PST)
Date:   Tue, 15 Feb 2022 08:06:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 01/13] powerpc: Fix 'sparse' checking on PPC64le
Message-ID: <202202150806.66CC906@keescook>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
 <ac1312f2451aa558bb2a8806b4d0aa2020f0c176.1644928018.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1312f2451aa558bb2a8806b4d0aa2020f0c176.1644928018.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:40:56PM +0100, Christophe Leroy wrote:
> 'sparse' is architecture agnostic and knows nothing about ELF ABI
> version.
> 
> Just like it gets arch and powerpc type and endian from Makefile,
> it also need to get _CALL_ELF from there, otherwise it won't set
> PPC64_ELF_ABI_v2 macro for PPC64le and won't check the correct code.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
