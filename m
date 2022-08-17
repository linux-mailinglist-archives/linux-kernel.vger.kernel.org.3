Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678FF596A93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiHQHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiHQHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:43:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF53614B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:43:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so15197409wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=zLLlDxWY1ZbgrX8NpGBCB8sUZ5zGgiZGyIWtQwkp0OA=;
        b=gqXUq1XPEIEhCRg07vPqzYAnTxDGM1px1zk2qHB4n49AzVZXVwNh0pdF7nlfwj8Txi
         471iZyjttQf7q1pHISAmjK5xjeBndOEUtBAbNW+0yGpW06a/lBXR786W66lr4mVREPAG
         IZuoprahf0K9LIhhWH3dwpF/QZmHZIb1V9YuTCyQh+XnoiYTVR5VYoxDuxAjSDsgqRXo
         ucFGnczaQhw3A+C1f/PkYDaJh2dVz+16Tts7rySd4aVcesM5jXezaO17F19GBLQgT9Dy
         OdRGlt5HRuhro42MfHxOUYdTKwUrfwJ9pxN51u+yeA5a7mqWSXquSI4p8lffToPoI4EF
         14Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=zLLlDxWY1ZbgrX8NpGBCB8sUZ5zGgiZGyIWtQwkp0OA=;
        b=yORhrk3dq2OGqGqQjRHQDAPiVtqNNnI+NqbFyp9H8YKpp2cPCuxYitHoRs6CmaAGno
         ySKwe7Ql+Bw4BOg14E67OCYUpE7mMwormGhgigNP3ZO3I/coUbp3vaokI82/ARGCsvCG
         tpPQ7MtYFuV9xHKfku9ucgTGoaLHc3+MNljJoQ+rrSOvpAlw9q3tS+BmOk1RDNU3U/s9
         ZJXuLrNWI+qATESnqp54TazuGctJaCQ/naZHgKZ6M8Z/G38iYo5LfncyI03S9t5grTEX
         N+8XWOjsgFDDKo+QuxM1U4iwb6vwqxxU+4EwvqInidxZ/x9m1OEW7QgnRRDjvq/UGmLu
         2N1g==
X-Gm-Message-State: ACgBeo15YnknjWVccVTa133bY4A3QvSPiRbsdQV4gdxWnWkKQ3eMgb9I
        44U+umXTI7Fs9PiblvPfolE=
X-Google-Smtp-Source: AA6agR7aELdcavrzLLOFMb60XRXEAyFKHKVTeRNYKqVTjPIhqtGHM7MgAJmrrnaeybg9c3zmLSyO0w==
X-Received: by 2002:adf:dc01:0:b0:21e:28ea:5d41 with SMTP id t1-20020adfdc01000000b0021e28ea5d41mr13406980wri.440.1660722190049;
        Wed, 17 Aug 2022 00:43:10 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id bk13-20020a0560001d8d00b0022511d35d5bsm4576519wrb.12.2022.08.17.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:43:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Aug 2022 09:43:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <YvycC5cwBKJFgefV@gmail.com>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817051127.3323755-2-ashok.raj@intel.com>
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ashok Raj <ashok.raj@intel.com> wrote:

> Cc: stable@vger.kernel.org

Not sure the series justifies stable - there's like a ton of things that 
could go wrong with a series like this & we want to have some serious 
testing first.

>  	list_for_each_entry_safe(iter, tmp, &microcode_cache, plist) {
>  		mc_saved_hdr = (struct microcode_header_intel *)iter->data;
> -		sig	     = mc_saved_hdr->sig;
> -		pf	     = mc_saved_hdr->pf;
>  
> -		if (find_matching_signature(data, sig, pf)) {
> +		sig = uci->cpu_sig.sig;
> +		pf  = uci->cpu_sig.pf;
> +
> +		/*
> +		 * Compare the current CPUs signature with the ones in the

s/CPUs
 /CPU's

Thanks,

	Ingo
