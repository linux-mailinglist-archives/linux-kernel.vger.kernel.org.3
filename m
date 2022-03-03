Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F114CBDD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiCCMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiCCMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:33:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363F1768D2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:33:08 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 631D21F381;
        Thu,  3 Mar 2022 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646310787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yT9w4xnsVmNFCoRZzcwyGELh280VIWKMsPKWSrgdRDI=;
        b=WSChO2tEGJvFrwVeNWo7mykbBkxiDI0+n2g4Ze8J5069Cl9FTb4AxyQod05LRq+2lvBKJP
        FzFpA1hJvX8nAQBxQAxh1sIkEqODYd3BRbtbf5chpgSRpk2GJKYH38VYKscrF9HlNjkq7a
        s/hbryKLWH1q4nBYEh4WiFyg8CjXC3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646310787;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yT9w4xnsVmNFCoRZzcwyGELh280VIWKMsPKWSrgdRDI=;
        b=W0X4ThWJtdBhiYbB8f4OV8UIo23X8nomlfft51HlTh8lcIv/Q6ZeWAbJlJJ1auPXpsxJfr
        elhO6uSCm6xXtXAQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EB576A3B83;
        Thu,  3 Mar 2022 12:33:06 +0000 (UTC)
Date:   Thu, 3 Mar 2022 13:33:06 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 33/39] objtool: Add IBT/ENDBR decoding
In-Reply-To: <aa6076af-0f7c-ae48-4eb4-8bf2e3f0ed06@citrix.com>
Message-ID: <alpine.LSU.2.21.2203031330530.704@pobox.suse.cz>
References: <20220224145138.952963315@infradead.org> <20220224151323.959862564@infradead.org> <alpine.LSU.2.21.2203031138040.704@pobox.suse.cz> <aa6076af-0f7c-ae48-4eb4-8bf2e3f0ed06@citrix.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1678380546-1847834621-1646310787=:704"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678380546-1847834621-1646310787=:704
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 3 Mar 2022, Andrew Cooper wrote:

> On 03/03/2022 10:53, Miroslav Benes wrote:
> > Hi,
> >
> > On Thu, 24 Feb 2022, Peter Zijlstra wrote:
> >
> >> Decode ENDBR instructions and WARN about NOTRACK prefixes.
> > I guess it has been already mentioned somewhere, but could you explain 
> > NOTRACK prefix here, please? If I understand it right, it disables IBT for 
> > the indirect branch instruction meaning that its target does not have to 
> > start with ENDBR?
> 
> CET-IBT has loads of get-out clauses.  The NOTRACK prefix is one; the
> legacy code bitmap (implicit NOTRACK for whole libraries) is another.
> 
> And yes - the purpose of NOTRACK is to exempt a specific indirect branch
> from checks.
> 
> GCC can emit NOTRACK'd calls in some cases when e.g. the programmer
> launders a function pointer through (void *), or when
> __attribute__((no_cf_check)) is used explicitly.
> 
> 
> Each of the get-out clauses has separate enable bits, as each of them
> reduces security.  In this series, Linux sets MSR_S_CET.ENDBR_EN but
> specifically does not set NOTRACK_EN, so NOTRACK prefixes will be
> ignored and suffer #CP if encountered.

Thanks for the explanation. I would be nice to include it somewhere so 
that it is not lost.

Miroslav
--1678380546-1847834621-1646310787=:704--
