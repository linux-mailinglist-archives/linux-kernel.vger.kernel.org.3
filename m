Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753CB5A0216
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiHXT2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiHXT2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:28:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C60641C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:28:05 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A9F71EC0409;
        Wed, 24 Aug 2022 21:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661369280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dm3Hsyqhu+/OJtBwmhJVKQwWetTjCukNAgy1fehtnus=;
        b=AkBdvDqrjowua+GfOIr2z2+syDHmJV4rVQmZWs1GX1wtzBQvsGxnmd85KcHxlwsuh1t2qI
        Inwz7of6DV9zz13asJPg6DodotS6WRXjf6pWL3EHLzMY8zJIOzfKJGy1bvJHl/iOFTm0f6
        jaPDG0xFvGV64zOK9OLYpIZYcg3ReAw=
Date:   Wed, 24 Aug 2022 21:27:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <YwZ7u0ljd+AW1P9d@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
 <Yv9k6fqRANu4ojK6@zn.tnic>
 <YwS2SXBN2J5FQflG@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwS2SXBN2J5FQflG@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:13:13AM +0000, Ashok Raj wrote:
> > > patch1:
> > > fms3 <--- header FMS
> > > ...
> > > ext_sig:
> > > fms1
> > > fms2
> > > 
> > > patch2: new
> > > fms2 <--- header FMS
> > > 
> > > Current code takes only fms3 and checks with patch2 fms2.
> > 
> > So, find_matching_signature() does all the signatures matching and
> > scanning already. If anything, that function should tell its callers
> > whether the patch it is looking at - the fms2 one - should replace the
> > current one or not.
> > 
> > I.e., all the logic to say how strong a patch match is, should be
> > concentrated there. And then the caller will do the according action.
> 
> I updated the commit log accordingly. Basically find_matching_signature()
> is only intended to find a CPU's sig/pf against a microcode image and not
> intended to compare between two different images. 

Err, what?

find_matching_signature() looks at fmt3 - your example above - and then
goes and looks at ext_sig. Also your example above.

So you can teach that function to say with a *separate* return value
"replace current patch with this new patch because this new patch is a
better fit."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
