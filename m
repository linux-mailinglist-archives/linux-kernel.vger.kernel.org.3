Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636694ED500
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiCaHuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiCaHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:50:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED31EDA39
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:48:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id DE82D1F46109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648712898;
        bh=dKukK4EBMwxE2myPn4rShH4hfKp0m6xFnh6R3X3W3b0=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=iu1aarbzkBjGD81V2pMM9JRRUx0OzSDknx+bsgdZuaMwhNmXWgA355oXZGFb5l82P
         Xrv/9F0c6hf4lS56XDS0vC3VFouBipEmW0Wsu55CpXD9MSQCFHIBDjc5MCuKbFXEEH
         bNQHRWqubyoU3gV8i4ksD3FQEjl/mcz2bOfZi8DsTMwSYpmlEL+r7yS1Uvcu51OvRp
         5i+dMKRY9kHXL+XZJArvo+zdiZJ6vp/pWjZk/h/H1DcYVzzxYK0t3bZfi3iocoZPNu
         5HrAZNslIWBp6CMSd8g0p57iqqX3Pt5Ls8D6Xksv4pmy9Q9rYYzhwslwnRXqeWTjIj
         Kbk+U3l6aIHFA==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation off when not supported
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com> <YkS3OKLS1Cixs9up@zn.tnic>
In-reply-to: <YkS3OKLS1Cixs9up@zn.tnic>
Date:   Thu, 31 Mar 2022 09:48:14 +0200
Message-ID: <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> So we could also do the below to denote what the situation is and
> therefore clear the bug flag for such CPUs.
>
> The thing is: I want this to be as clear as possible because bugs.c is
> already a nightmare and just slapping more logic to it without properly
> thinking it through is going to be a serious pain to deal with later...

Thanks Boris,

I agree that the more explicit the better, I'll give this a try. I saw
Pawan's suggestion as well but that one is similar to the originally
proposed patch in that the logic/checks are split between two functions,
this solution based on clearing the bug flag seems clearer considering
the comment just before the code block:

	/*
	 * Check to see if this is one of the MDS_NO systems supporting
	 * TSX that are only exposed to SRBDS when TSX is enabled.
	 */

Cheers,
Ricardo
