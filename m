Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D8651D35A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390091AbiEFI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390103AbiEFI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:27:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5705B68F9C;
        Fri,  6 May 2022 01:23:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651825434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=770rOCEglJcTn6tOCmhg2DWqxE2dENlNOc6UvMrWrn0=;
        b=SWdlPTx50Sth51PvJ895RJTrT4U24BL4jUAFpr4iLPHiAGZqSnszudzX19JIt0rBwORvW3
        ln9dKTaD7e5bdN9HhwZW5AuVU8kpBDN/Zf+Qp2D7P//NP0vxRiLhfrB55uXMNnMk95IQST
        RZzjuDfS3O3YMH65RtEkxPX821YxIClVWuMvwbBt494vVZ00B+wyWbJ/Jkv2llZsm7jDeC
        V8YIzlYWLaA5aW2RAgVsM3OMkER8elfU/FqfdJcq5hQxoo1jutEacwxDQO1JalB9NFvS05
        JWSaPxdmnw01ddtTlx+F6tx2EkpZaV5YGyXadPsrOYGJX2PC481JPpEhAYoj5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651825434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=770rOCEglJcTn6tOCmhg2DWqxE2dENlNOc6UvMrWrn0=;
        b=UhQ+wS469qIUvvXkeMoQ2z5tuJDuxrtHGkFcCGrgMQ8u1/Wh2cDAchumGeta7jwV0+SXE0
        j/73GWMjRB3BwWCA==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v6 04/11] platform/x86/intel/ifs: Add stub driver for
 In-Field Scan
In-Reply-To: <20220506014035.1173578-5-tony.luck@intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
 <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506014035.1173578-5-tony.luck@intel.com>
Date:   Fri, 06 May 2022 10:23:54 +0200
Message-ID: <87tua3gjc5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05 2022 at 18:40, Tony Luck wrote:
> +#include <asm/cpu_device_id.h>
> +
> +#define X86_MATCH(model)				\
> +	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
> +		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
> +
> +static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> +	X86_MATCH(SAPPHIRERAPIDS_X),

I still hate this with a passion. Nevertheless:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
