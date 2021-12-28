Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA8480A90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhL1OwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhL1OwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:52:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A57C061574;
        Tue, 28 Dec 2021 06:52:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05056B81229;
        Tue, 28 Dec 2021 14:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A004C36AE8;
        Tue, 28 Dec 2021 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640703121;
        bh=tjmKrnWqLW+52Q4kCwLGYUL5ywwRVZmPsTg9gL1gjxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZRpoE5hLoQ+6iHwKZ6SJ0gea41Bj1zBrotfOa3aal/NIRtS4CuMl1+cmcwGQ7Rah
         88Dp85zZf4Gy4XSunt9gUuDJklESh3zQ6192KgRui2rQiK0yUWqRr8C0w34puwrU3P
         C5z9uQvsN91dUHt/zIXdYUmD4yiso7Id6ISC9AZg8z2HH5c9hZfQXI67jntvl632+T
         4E4iAzH4luGRNnOEAxh/kZDY6YIFkfPOrdqPQEfgDdwQTIAC//ZpwpZMsiC6Eatf/9
         xW6vyRT0gSjZkmd/NAHm02EGlElW4oiQkbnjNTwDeF0hMo7dzB9RYHbss2BS7wiJsY
         0MGZfVDWhTiFA==
Date:   Tue, 28 Dec 2021 16:52:04 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YcsklLw1uFyppSji@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
 <YawAWmodeNaUbzV8@iki.fi>
 <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
 <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
 <f6a55943-13ef-41ef-609a-6406cffef513@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a55943-13ef-41ef-609a-6406cffef513@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:10:17PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 12/10/2021 11:42 PM, Jarkko Sakkinen wrote:
> > On Mon, 2021-12-06 at 13:20 -0800, Reinette Chatre wrote:
> > > > This is a valid question. Since EMODPE exists why not just make things for
> > > > EMODPE, and ignore EMODPR altogether?
> > > > 
> > > 
> > > I believe that we should support the best practice of principle of least
> > > privilege - once a page no longer needs a particular permission there
> > > should be a way to remove it (the unneeded permission).
> > 
> > What if EMODPR was not used at all, since EMODPE is there anyway?
> 
> EMODPR and EMODPE are not equivalent.
> 
> EMODPE can only be used to "extend"/relax permissions while EMODPR can only
> be used to restrict permissions.
> 
> Notice in the EMODPE instruction reference of the SDM:
> 
> (* Update EPCM permissions *)
> EPCM(DS:RCX).R := EPCM(DS:RCX).R | SCRATCH_SECINFO.FLAGS.R;
> EPCM(DS:RCX).W := EPCM(DS:RCX).W | SCRATCH_SECINFO.FLAGS.W;
> EPCM(DS:RCX).X := EPCM(DS:RCX).X | SCRATCH_SECINFO.FLAGS.X;
> 
> So, when using EMODPE it is only possible to add permissions, not remove
> permissions.
> 
> If a user wants to remove permissions from an EPCM page it is only possible
> when using EMODPR. Notice in its instruction reference found in the SDM how
> it in turn can only be used to restrict permissions:
> 
> (* Update EPCM permissions *)
> EPCM(DS:RCX).R := EPCM(DS:RCX).R & SCRATCH_SECINFO.FLAGS.R;
> EPCM(DS:RCX).W := EPCM(DS:RCX).W & SCRATCH_SECINFO.FLAGS.W;
> EPCM(DS:RCX).X := EPCM(DS:RCX).X & SCRATCH_SECINFO.FLAGS.X;

OK, so the question is: do we need both or would a mechanism just to extend
permissions be sufficient?

/Jarkko
