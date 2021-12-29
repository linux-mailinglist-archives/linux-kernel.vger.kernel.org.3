Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB04813FE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhL2OQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhL2OQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:16:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB80C061574;
        Wed, 29 Dec 2021 06:16:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8036B81980;
        Wed, 29 Dec 2021 14:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF6DC36AE9;
        Wed, 29 Dec 2021 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640787391;
        bh=+9JSWhnM/st3WyI+0cdaa71F5A8Jqr+ywwKFXLDZLLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goKu5b7ygoUi580FJifzPW37sjedfPc4xic0oysl8r0zok+pZTrm3Gi1sER7dQJgC
         tdL/P1RUAzn33pk6hZ2uDzhEAiXh2koLmzs/i8M0WaVs5G2n6ENGYWgVLh1lBeGZR4
         fG6AtkRCf9fthcDUlgYZQieAduarw1N1yIR4NCZw=
Date:   Wed, 29 Dec 2021 15:16:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: use the proper name CONFIG_FW_LOADER
Message-ID: <YcxtvObu4Uofn208@kroah.com>
References: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 12:15:53PM +0100, Lukas Bulwahn wrote:
> Commit c8dcf655ec81 ("x86/build: Tuck away built-in firmware under
> FW_LOADER") intends to add the expression regex only when FW_LOADER is
> built-in, not a module or disabled.
> 
> The config is called CONFIG_FW_LOADER when it is built-in; and
> CONFIG_FW_LOADER_MODULE when it is a module.
> 
> So, adjust the condition to the actual name of the config.
> 
> Fixes: c8dcf655ec81 ("x86/build: Tuck away built-in firmware under FW_LOADER")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> 
> I am wondering if this regular expression needs to be made differently
> depending on the build configuration at all.
> 
> Could this not just be added unconditionally anyway or is not needed at all?
> It seems that is was broken since its initial inclusion and nobody ever noticed.

Very few people use built-in firmware, which is why no one probably ever
noticed this :(

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
