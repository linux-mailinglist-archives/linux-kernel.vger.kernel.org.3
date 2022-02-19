Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221AA4BC488
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiBSBWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:22:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiBSBWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 145643B285
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645233721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKNuU6T0+CgHInxcOtBxN9jDk/rXumbRGkWZ7rGGpH8=;
        b=CGb7ljFFJ6pZ7r/ECLxYtuGa5/l5lH2i4PYS2PMQZGFq9fpiemIGFl8u5KrZ41HltkZGwC
        mDHQdW+fstPwbsNKnPxi3NyplHA2omy+sKFzptqikcQ7hSgUTr/ODS7WuJ1PBR8kjIQptM
        mugSTlvgZSyk7oQ89h+NE6n0rIdKZwc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-RUHg1i0POLu3wraNJzZa8w-1; Fri, 18 Feb 2022 20:22:00 -0500
X-MC-Unique: RUHg1i0POLu3wraNJzZa8w-1
Received: by mail-qv1-f70.google.com with SMTP id o6-20020a0562140e4600b0042cf952661bso10652993qvc.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NKNuU6T0+CgHInxcOtBxN9jDk/rXumbRGkWZ7rGGpH8=;
        b=6kZahylozOhagbo4ueiaAmrmhN2BBHTzd55C5xR3H8KGkK681+M0Sz9mhz7wpsMCmS
         5kMxxi5EImgcVMvpwEomQCWaRXCiBJheKJONTbYtgID+7J3Uzc7YK4Y4K21QF+1llXvC
         lfbqhdpCTerUdecib1uSPqHBl6tjy+P1lFsCkwK/5z0wAQvENRURpI7dJ/kiG7+rYvAz
         KSjEu3TUPVRCPwayjabDQMqyfpBG0zOMVuggNaMSSmM61Chf9ATKiJH6O/JUewthXaCk
         oJ4lP0+EdW2gO/V+o3yktRvaogAvU+4834eds4mv2u028LmQBdU3obw52JIRUFBIiGHS
         9QZg==
X-Gm-Message-State: AOAM531xVUKcJPciWSYQpjPHn9wdrxPq1VsSg357WGbDtCItcTc9uwJe
        S/9RrLbjYpaTcDXK5hzoaD9nofD6MGan/SDpG1RTAsKCV8EfU7lneqYL6gF/+E7/Qx624K3qHd+
        iOlhrfveTNExWD/pliAcs/MO9
X-Received: by 2002:ac8:5c4e:0:b0:2cb:9724:8b21 with SMTP id j14-20020ac85c4e000000b002cb97248b21mr9242196qtj.544.1645233719566;
        Fri, 18 Feb 2022 17:21:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRni3V2rINh2mu0p+1lIHNNRGvbQyoiDfj6ZyQYSg7zwdZjdUFXldPTpjwYIVPc1enbzm1kQ==
X-Received: by 2002:ac8:5c4e:0:b0:2cb:9724:8b21 with SMTP id j14-20020ac85c4e000000b002cb97248b21mr9242189qtj.544.1645233719327;
        Fri, 18 Feb 2022 17:21:59 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id x17sm2584234qtr.69.2022.02.18.17.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 17:21:58 -0800 (PST)
Date:   Fri, 18 Feb 2022 17:21:55 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220219012155.z24prt3yj25ytacs@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.395399333@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171409.395399333@infradead.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:16PM +0100, Peter Zijlstra wrote:
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
> +		pr_err("Whaaa?!?!\n");
> +		return;
> +	}

Might want to upgrade that to a proper warning :-)

> +bool ibt_selftest(void)
> +{
> +	ibt_selftest_ok = false;
> +
> +	asm (ANNOTATE_NOENDBR
> +	     "1: lea 2f(%%rip), %%rax\n\t"
> +	     ANNOTATE_RETPOLINE_SAFE
> +	     "   jmp *%%rax\n\t"
> +	     "2: nop\n\t"
> +
> +	     /* unsigned ibt_selftest_ip = 2b */
> +	     ".pushsection .data,\"aw\"\n\t"
> +	     ".align 8\n\t"
> +	     ".type ibt_selftest_ip, @object\n\t"
> +	     ".size ibt_selftest_ip, 8\n\t"
> +	     "ibt_selftest_ip:\n\t"
> +	     ".quad 2b\n\t"
> +	     ".popsection\n\t"
> +
> +	     : : : "rax", "memory");

Can 'ibt_selftest_ip' just be defined in C (with __ro_after_init) and
passed as an output to the asm doing 'mov $2b, %[ibt_selftest_ip]'?

-- 
Josh

