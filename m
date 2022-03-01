Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A333E4C8F88
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiCAQAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCAQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:00:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862878BE01;
        Tue,  1 Mar 2022 08:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=AgNYZtZNAmOKXj24WWg1pA/uw9HzH1g2htzJ4XQkn9o=; b=IDc4H3+9TDjIlSZLD3ksJ1bXSE
        ILWdAWoZzkZ7Wss1bNGA0cTq2wtYDNTN3i2lG+sM/5d53qKWBP1R4SyyVTrovdx+EvZq1v3r7MX26
        Lfq6ZjGIAWcsIsaxMK28DtBoku1+Z4nlyCJM8oe7CDG78MiavMchFxabARMrj12dmBtBIW1q6dgJu
        iE1pqGXiH/F4K9yq89OfwSSQc9VG1pAgq0b+egaXFwbWTfytbbXDE6T1pkzyafqTtl+jxv6x4A8rx
        zTsPoAzVPD5G4nIjAcZ3XPa9Kark+YpzP72W/oIXVNdo6zM7eGA0UZCsv76Nk9ZIVv33BZAxVbxUO
        piUBXRPg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP4uu-00HSOc-Sy; Tue, 01 Mar 2022 16:00:00 +0000
Date:   Tue, 1 Mar 2022 08:00:00 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
Subject: Re: [PATCH v9 00/14] module: core code clean up
Message-ID: <Yh5DAJxyaULX6p/L@bombadil.infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
 <6b6e02be-2d0a-31df-8375-baf79714d5b7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b6e02be-2d0a-31df-8375-baf79714d5b7@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 07:07:30AM +0000, Christophe Leroy wrote:
> Hi Luis,
> 
> Le 01/03/2022 à 01:21, Luis Chamberlain a écrit :
> > On Mon, Feb 28, 2022 at 11:43:08PM +0000, Aaron Tomlin wrote:
> >> Hi Luis,
> >>
> >> As per your suggestion [1], this is an attempt to refactor and split
> >> optional code out of core module support code into separate components.
> >> This version is based on Linus' commit 7993e65fdd0f ("Merge tag
> >> 'mtd/fixes-for-5.17-rc5' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").
> >>
> >> Petr,
> >>
> >> I decided to use preempt_disable() instead to remain consistent with the
> >> rest of the file. Unfortunately, I did not make time to boot test etc.
> > 
> > Aaron, thanks so much for doing this!
> > 
> > Since no boot tests are performed yet, I just pushed this to modules-testing
> > for now, after we get some boot test results I'll push to modules-next.
> > 
> > We should run kmod tests as well.
> > 
> 
> 
> My Kconfig patch and my two series still cleanly apply on v9. I don't 
> need to rebase/resend them.
> 
> 
> boot test is OK for me with Aaron's v9.

Great thanks yes, I intend on applying them as soon as I get some test
confirmations on modules-testing. It's all about testing now.

  Luis
