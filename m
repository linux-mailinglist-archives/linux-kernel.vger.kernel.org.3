Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7F4ACBB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiBGV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBGV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:58:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88765C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:58:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id qe15so4799348pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mawlywQJ7By+C4lydANsL5EQYZ68ANaR80UGfPWHWA0=;
        b=JKY3u6RGj9vvgxsCB65Et5hqH/ceaLcskaQckSeAySE/Be9SSTHBpBAHSNSMKL2qID
         yGadAwamLpJTUi2zzGSU6icjLOSdDbcOCBA+SWEw4GF4P86+lm0oiUXrMw/TCNWjKCU0
         LTnU7hnNvHgsPvdaq4Zj/vDsoesW+THaFJCdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mawlywQJ7By+C4lydANsL5EQYZ68ANaR80UGfPWHWA0=;
        b=a3LUndzu5PsT9tryAYQL6HowwwP1JKolhIvSobeccAHmshNhlVdQSK2UaC4LxRMhTo
         IdKyb5RC1ADjhguoHAR5fl/jNvl4mWynOFBgSnY7DKV7VvOzOwaFkoMWRFGv8MlZGq1p
         c1yREiryxv+BvWMPR5jhLj/veqo4dAazA2GNjfgNSpiqGIPf5YfcDj1X/E+9c/O9TYNW
         C2R+1KLitooibnQArws/B9mlG8YHJvcknYwje0OTlNndcq/vJcMNyvZX/JJomNIUgzk5
         y/NmHWXxhRWQ4hh6rrw8dKCpO+QQFrpCeuG8A8Xs/AiBQ+RpcwCMBDcjcsCSaOy1iyJy
         aRYQ==
X-Gm-Message-State: AOAM533CVcdNg8bN2ociYVFzYcRna2IsjuapgLj0wIlGNyuktpMZ2fqy
        EjhQTXAVDwrVVNCJRVqQSPY+lw==
X-Google-Smtp-Source: ABdhPJy0AoqQe2w9LmyyFoXpDzQSjRQbdTcBCtjF6vYZ6MgOPeiHhRHaBxTOFUOM55MRrwxO/A8k/g==
X-Received: by 2002:a17:902:b692:: with SMTP id c18mr1330327pls.85.1644271129101;
        Mon, 07 Feb 2022 13:58:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm301213pjb.42.2022.02.07.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:58:48 -0800 (PST)
Date:   Mon, 7 Feb 2022 13:58:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] x86/cpu: Remove "nosep"
Message-ID: <202202071358.2DA81D84B@keescook>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127115626.14179-3-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:56:22PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> That chicken bit was added by
> 
>   4f88651125e2 ("[PATCH] i386: allow disabling X86_FEATURE_SEP at boot")
> 
> but measuring int80 vsyscall performance on 32-bit doesn't matter
> anymore.
> 
> If still needed, one can boot with
> 
>   clearcpuid=sep
> 
> to disable that feature for testing.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
