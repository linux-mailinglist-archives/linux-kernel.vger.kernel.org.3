Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CEC5854F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiG2SWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiG2SWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:22:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107C45057
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:22:46 -0700 (PDT)
Received: from zn.tnic (p57969665.dip0.t-ipconnect.de [87.150.150.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E79A1EC04CB;
        Fri, 29 Jul 2022 20:22:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659118961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GWJUI0U1W5ywU2OH1p9iE3oY+56py9fLb6+OGTHG8KU=;
        b=g7zUaw4wzmaBskwPa+ar+pwDz9DAJenFceA98+ELtTGGyv84CNMsYLpVxw9lsMogDyyq/p
        GJYeoF/tZLoZxZh2VkX/LExLgv+oH+q+S/RdcADQD3okxXi5PCf7Q9RgQCcqQDCpwINAjW
        ldAetvo8CyvuAn7gKZ4/H4jqN+TGcZA=
Date:   Fri, 29 Jul 2022 20:22:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/bugs: Do not enable IBPB at firmware entry when IBPB
 is not available
Message-ID: <YuQlbFSBC6U/yGeL@zn.tnic>
References: <20220728122602.2500509-1-cascardo@canonical.com>
 <YuKCpLOLeDOI7GII@zn.tnic>
 <CADWks+aosM99jv9WwLvFo3LPEnsqts+2bJPzMnRqJX70qz51cg@mail.gmail.com>
 <YuKoxyUdAWsTfKez@zn.tnic>
 <YuKwLnYlzC0R8xrF@zn.tnic>
 <YuLBBe2BXrC7CNiu@quatroqueijos>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuLBBe2BXrC7CNiu@quatroqueijos>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 02:01:57PM -0300, Thadeu Lima de Souza Cascardo wrote:
> I may be completely wrong here, so excuse me throwing out this idea.
> 
> But isn't it also possible that userspace attacks the kernel by leveraging
> speculative execution when in firmware? So even when firmware is trusted, it
> might not have mitigations like retpoline and rethunks. So userspace will train
> the BTB in order to make a RET in the firmware speculate to a firmware gadget
> that may spill out kernel bits to the cache.
> 
> Even though there is some limited mapping when doing the firmware calls, there
> are still some kernel pages mapped.

Yah, I dunno. That's why I raised this and added Andy. I certainly see
your point tho.

And what I know is, I don't want to be dealing with imaginary virt guest
configurations just because some cloud providers wanna do whatever they
like.

I've put this mitigation selection spaghetti on my to-give-a-stern-look
list. Because it is looking insane already and it'll get even worse with
time.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
