Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9A481B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 10:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhL3J3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 04:29:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41028 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbhL3J3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 04:29:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB639B81B07;
        Thu, 30 Dec 2021 09:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF786C36AEA;
        Thu, 30 Dec 2021 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640856578;
        bh=8keFIgM9gG/JfDdWdR91uJTuOB2XraXPViDwP7Bjytk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dt/6BqZqWOtMRkJTjPRDNlTtecG9ROdkLTzGq/pPNJfgJDE0Zb6mA5UGioecHE/uX
         gwNUORLP9VqWaWG3n5PLngR4f4ySZ+6JkOaKesBcTs8ggoj02SoM2fbdZPFth7xvZq
         5h/H2rGx4KviapEFLh+rq8OScQwuOut/dDMXXc08=
Date:   Thu, 30 Dec 2021 10:29:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: use the proper name CONFIG_FW_LOADER
Message-ID: <Yc17/mHjtoqpilqm@kroah.com>
References: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
 <Ycy4q2OhwTdLl+2S@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycy4q2OhwTdLl+2S@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 08:36:11PM +0100, Borislav Petkov wrote:
> On Wed, Dec 29, 2021 at 12:15:53PM +0100, Lukas Bulwahn wrote:
> > Commit c8dcf655ec81 ("x86/build: Tuck away built-in firmware under
> > FW_LOADER") intends to add the expression regex only when FW_LOADER is
> > built-in, not a module or disabled.
> > 
> > The config is called CONFIG_FW_LOADER when it is built-in; and
> > CONFIG_FW_LOADER_MODULE when it is a module.
> 
> $ git grep FW_LOADER_MODULE
> include/linux/firmware.h:37:#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
> 
> So either I'm not grepping right or that FW_LOADER_MODULE thing belongs
> to the past...
> 
> Greg, Luis, what's up?

Looks like a pre-git thing, it is obviously not a valid config option,
so it can be removed.  I'll go make a patch for it...

thanks,

greg k-h
