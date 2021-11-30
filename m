Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3B462B16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhK3DeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhK3DeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:34:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562DAC061574;
        Mon, 29 Nov 2021 19:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F881CE16EC;
        Tue, 30 Nov 2021 03:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44099C53FC1;
        Tue, 30 Nov 2021 03:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638243037;
        bh=/QlaufTl6s9jE52de02dVY+f/hePMLYIkHbd540fCIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1A03NdsgRJoM6HKJ/uTNAC64Rta4A93+R9njbc5Cq3vbtxSi0Fvy6wrjGVdIXmZv
         2/H01lUx/pRCCb6ydMJxY9m4/FSR/KBgEronNH3YKb1NNeQZgLE4j4yuW6dslXXsre
         eN3HLraqj1/J7lbzfxRgfk14/pXzcfh9zdvH/OmOwtDrvn4daoQTLBll/kiDxrwd8a
         4kl9Lay9WWOX2FQP9QmvwL8lRxmSa0nj6L8C09bFcfkRf2/owWxOgqirER0bePT8Fv
         +BLSd/w3xbCg2R+oqOsYLTgbqLUTpBVR5RcuAwBPvCHgv3BBchOMtH0pzcAPUO3LbO
         Pwrci1D1IOPKA==
Date:   Mon, 29 Nov 2021 19:30:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 08/15] x86/power/keylocker: Restore internal wrapping
 key from the ACPI S3/4 sleep states
Message-ID: <YaWa2+2eVSFXY1U3@sol.localdomain>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-9-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124200700.15888-9-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:06:53PM -0800, Chang S. Bae wrote:
> diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
> index 820ac29c06d9..4000a5eed2c2 100644
> --- a/arch/x86/include/asm/keylocker.h
> +++ b/arch/x86/include/asm/keylocker.h
> @@ -32,9 +32,13 @@ struct iwkey {
>  #ifdef CONFIG_X86_KEYLOCKER
>  void setup_keylocker(struct cpuinfo_x86 *c);
>  void destroy_keylocker_data(void);
> +void restore_keylocker(void);
> +extern bool valid_keylocker(void);
>  #else
>  #define setup_keylocker(c) do { } while (0)
>  #define destroy_keylocker_data() do { } while (0)
> +#define restore_keylocker() do { } while (0)
> +static inline bool valid_keylocker { return false; }
>  #endif

This breaks the build when !CONFIG_X86_KEYLOCKER.

- Eric
