Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FCA57A4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbiGSRMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiGSRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:12:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E004F66B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:12:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z3so177003plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bul4f/ogPJoZ7GsIsEPnLV8s8aS6eNqTZiiR3CtFKmI=;
        b=snT5Se+yuvdBC3zfM90TEFQsq1aLuAStrAnLKmhvGQIfSusy+bAUPqLvPfUN0F1ZHG
         MNf0p2TOgFgZAPJ+VMxT+2VoFFLi6BTHTtubFaHCyKwe/NcceTbD4XwjpeBGCg+TxhHj
         y2hEg5do6ERlc277ILrHKbmP9xSupIXEm9vY+3wbPAAfzr89BkjeZhxMopfoldjZZpWl
         2kQ2HK0pQ7N5nC/veoIEkv9kzx2r73SFZ6soI5hI26zO/0hkeTx6VsyQesGReHtA5BPm
         Nj9L1MWpKIWRuPqXiFf61aEBxq/7br+dqrqT6mgbmNli8dDp1WlV34Z/O9fWTGE0ygfo
         v1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bul4f/ogPJoZ7GsIsEPnLV8s8aS6eNqTZiiR3CtFKmI=;
        b=iSrrXE0jNjRWyPj8y+0Yp48wFTzbDeSQCV7D61QW7NXC82P+fCBb77ACDZcbM62JfH
         5ZSazNnxbwARLav5+7M4ldERp7iVg9ZoKcKZmDZhjfkMQTXEOd8UFkE6YYqVciyUVy6u
         2E9zwnbvf98+rVgNavh4ZSjS78IoKaokk1w4OgjqRQwHyME1SqrlDpU5Y5VA49kEmdCi
         PWYFR3Nu720Q2VWoZqwJZ2YaWoOWoVL4VM2ZZgXfhYgdyyPH1gTBM9rOlgeT/55ih/Pw
         JoCwmU3PS/Xvn+hELCKEaq5NNKW47hMjSXSvHxQuRbU1B1Zx/1Q9n1NU5XmqQ1nP6S4c
         5RCw==
X-Gm-Message-State: AJIora8zP3k5NP0fbdvdIRgs6GfduNxco0Q4WDQLNGPCkPi710nurR20
        weO+OwRQFyGs+AjI2+H89P1cRQ2gWuP83A==
X-Google-Smtp-Source: AGRyM1sV9e556lhRpcwUhf+APORGa+ltMfdmr0G41MkEFEQQWnEbHdYK60phl2OY7t7IdSUn4IdiLA==
X-Received: by 2002:a17:902:7c88:b0:16c:e485:51b1 with SMTP id y8-20020a1709027c8800b0016ce48551b1mr15607543pll.34.1658250762727;
        Tue, 19 Jul 2022 10:12:42 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027e4300b0016c500fb7bcsm5966504pln.140.2022.07.19.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:12:42 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:12:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        dave.hansen@linux.intel.com, nikunj@amd.com, hpa@zytor.com,
        Abraham.Shaju@amd.com
Subject: Re: [RFC FIX PATCH] x86/e820: Stop kernel boot when RAM resource
 reservation fails
Message-ID: <YtbmBldwL+h2X+V4@google.com>
References: <20220718085815.1943-1-bharata@amd.com>
 <E7A3FF43-C49F-415E-81C6-CD14F4107349@alien8.de>
 <be498c32-bed6-d31a-ae94-6006dd59ea1e@amd.com>
 <YtV3Ipvt96X/iO2J@zn.tnic>
 <24ccd22f-6708-3265-4012-66f01108ff22@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ccd22f-6708-3265-4012-66f01108ff22@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022, Bharata B Rao wrote:
> On 7/18/2022 8:37 PM, Borislav Petkov wrote:
> > 
> > I betcha you can generate a lot of "kernel bugs" with weird qemu
> > options. If it is not a real use case, nobody cares.
> 
> I see that we will hit this problem by default when starting
> a guest with 1T or more memory using QEMU.

That a user can create a bad configuration using QEMU's default MAXPHYADDR doesn't
change the fact that adding memory beyond MAXPHYADDR is firmly a configuration bug.

> > And even if it were a real use case, panicking the machine is not the
> > right fix.
> 
> I couldn't see a clean exit/recovery option in setup_arch()->e820__reserve_resources()
> where this happens. Any suggestions?

WARN or pr_err/warn() and move on, or just do nothing.  Adding code to try and
gracefully handle an architecturally impossible configuration is a waste of time
and effort.  Like Boris said, there's practically a limitless number of bad setups
QEMU can create, this one just happens to be easier to create than others due to
shortcomings in QEMU.
