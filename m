Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E7A569C43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiGGHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiGGHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:54:35 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB42616;
        Thu,  7 Jul 2022 00:54:32 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Ldpb727dYz9sp9;
        Thu,  7 Jul 2022 09:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1657180467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+yyT26kcCPIvJtlTgb0qkwB1W9jNIgrKQnDPJqABws=;
        b=VGFq8cLB6ORk/2eP9jRsUcVNi7kAJE2eSN0/j3hS5jGEWw5H3wc4XleMrxyVqP5Sxxwgwq
        oLsmpzndN6xrDwoiBT+CAR0HR/4cFZE7qpREol2H+LMy1I1ECvqsUi0d7b9piB1ituRx0x
        2K2IFKEyf3M8Uot/Fwxojb8cg8qBLvIeSQwYK2Yxk7+fpMmutbDLKO15hEoZ7L3jPq5PJt
        8r1ElP1ECLiCRRTt839ZD57ehcPKNeyKNBL4CIL2ER6e8GvoJRdl6YwW6TveUqwuUnvhpE
        eT0g9IYh7rymEvOwf0I6bkmUP1qWMCiKELXHAJhcrh7lls1ZuSOIbB6s6o7+VQ==
Date:   Thu, 7 Jul 2022 09:54:26 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>
Message-ID: <830109073.51279.1657180466311@office.mailbox.org>
In-Reply-To: <CAHk-=whfSg1FNFJXv9QfXXnWFO71YufsoTs9S8sYzonfwjm4XA@mail.gmail.com>
References: <272584304.305738.1657029005216@office.mailbox.org>
 <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
 <MN0PR12MB61015A04C6E4202B2E8E08A9E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
 <72419963.329229.1657096948079@office.mailbox.org>
 <8ee1bc75-3ecd-9d87-b7cc-37ba15133026@leemhuis.info>
 <CAHk-=whfSg1FNFJXv9QfXXnWFO71YufsoTs9S8sYzonfwjm4XA@mail.gmail.com>
Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 995ad3399b4688e71e7
X-MBO-RS-META: t1g34utnt94rj7afsxinsoojtq6b3iwq
X-Rspamd-Queue-Id: 4Ldpb727dYz9sp9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Linus Torvalds <torvalds@linux-foundation.org> hat am 06.07.2022 18:59 GMT geschrieben:
> 
>  
> On Wed, Jul 6, 2022 at 11:21 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > Wild guess, I'm not involved at all in any of the following, I just
> > noticed it and thought it might be worth mentioning:
> >
> > I heard Fedora rawhide added this patch to solve a boot problem that
> > sounded similar to yours:
> > https://patchwork.freedesktop.org/patch/489982/
> 
> Yes, this looks likely, and matches that "starts in 5.19-rc5" since
> the offending commit came in as
> 
>   ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
> removing conflicting FBs")
> 
> so that does look like a likely cause.
> 

I confirm that applying
  "drm/aperture: Run fbdev removal before internal helpers"
on top of rc5 solves this issue, computer boots normally again.
I suppose this commit will be cherry-picked for rc6.

Thanks to all!
Tor

>               Linus
