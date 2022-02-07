Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766E24AB443
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiBGFuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350622AbiBGDjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:39:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B73C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 19:39:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so5866604pjv.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 19:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TE4Fcz5LUDXq9tJfptglh1I9oeIlQep8aAPqHvx1w3w=;
        b=IncxP+N43XXu2TlRPOutUe1pYH5qBDSw6Z+0xd5vBPbCSAHb5Od2YWGc748wQBkNWb
         jVH/6e3mz7CsRauNlnmvDvDDcT+YrJQv3x4bdgfjrgVBk55s5D1Eqfw+xeOe4MHdwiMq
         1bggp6Q6bDkfbuEVHA5rVaDDonQcVLHho6ujY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TE4Fcz5LUDXq9tJfptglh1I9oeIlQep8aAPqHvx1w3w=;
        b=PTuxyY2hxoJ1wgn+HQhBMyjXbAy2JjEEXiZO+n7DkjmtbAbAcuYTqDepyz258fvSpa
         wrkO6WHIiPMUTWw76D5mbpFmO3VO9ghj8DEFLcR7f2MnZ+aNRKc0JXQUFS8EiM8IDciX
         jhQ919oDj1Tw+bpKDmuwxPBzjwgRARCFR1WrzsuP8cXGcl8TpXAby0XUwZ4xAvKEtNb9
         3SRWd7CcC58Qdrt7peCFA4eBQIJSKbIAV61RlOG7rwY1nw5HFx36YFryzzut0Zp0Ri+K
         /yxBAqUYFtXunuHoVAfc/r577WIgjHWAxjdFmkpjia2KTn3jaTUySVJ71hdxbu+t1u7h
         LeFg==
X-Gm-Message-State: AOAM530unp/DG6AALavmj5XcA+4kn3Qqf2y0nJIs5bZI9LhZMGwZMXWO
        toV90x5PdZ7pMzAEgx86EPGG7Q==
X-Google-Smtp-Source: ABdhPJw3IFxdke4ePmbOOI4seyzSXmrKv4qKoP0CweR3VbpMgmkaTmSB9utEO6FmUwhC7baQPPZ2gQ==
X-Received: by 2002:a17:903:11c9:: with SMTP id q9mr14587074plh.144.1644205187326;
        Sun, 06 Feb 2022 19:39:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y41sm9964701pfa.213.2022.02.06.19.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 19:39:46 -0800 (PST)
Date:   Sun, 6 Feb 2022 19:39:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <202202061924.6A2D278@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
 <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com>
 <Yf1UO6jF91o9k4jB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf1UO6jF91o9k4jB@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 05:28:43PM +0100, Borislav Petkov wrote:
> Then we should clear that "sme" flag if memory encryption is not
> enabled. Like we do for all other flags.

Oh, this seems weird to me, as I'd expect it to show up since the CPU is
_capable_ of it, even if it's not in use. (Am I really using avx512vl,
e.g.?)

But as you point out later, it does work that way for a lot of things
and boot params. If this is the way things are supposed to be done,
it looks like we should wire up "nx" vs "noexec=off" boot param to do
the same (separate from this series), though it would need special
care since that bit needs very very early handling both and boot
and resume. Maybe kernel/cpu/common.c should check for _PAGE_NX in
__supported_pte_mask? (And would that break KVM's NX, etc?)

Hmmm.

-- 
Kees Cook
