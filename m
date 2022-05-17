Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09401529C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiEQIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiEQIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:25:42 -0400
Received: from mail1.fsfe.org (mail1.fsfe.org [217.69.89.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F631DC7;
        Tue, 17 May 2022 01:25:39 -0700 (PDT)
Date:   Tue, 17 May 2022 10:25:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fsfe.org; s=2021100501;
        t=1652775937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAxw8aWlu/LUZ5JLpxzuteI1viXYrIoRdyP/NaQqL5c=;
        b=Nfeae+QvFsmneXKolwYLwwLjpMRY/7ruwwhQ3AUXseItA4peX9kJmoGJDGGsca2AzTDuDV
        bukifL35mbRGTxrXBux2vhQW6tAyKJP9sSVjjB0TmgDvPOAIhN0yFlNjWdX9qv6f8UaDJo
        PO0bXKRGah1JumlcRWiGrWswKYafV/k=
From:   Max Mehl <max.mehl@fsfe.org>
Subject: Re: [patch 0/9] scripts/spdxcheck: Better statistics and exclude
 handling
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org
References: <20220516101901.475557433@linutronix.de>
        <1652706350.kh41opdwg4.2220@fsfe.org> <87zgjhpawr.ffs@tglx>
        <87wnelpam3.ffs@tglx>
In-Reply-To: <87wnelpam3.ffs@tglx>
MIME-Version: 1.0
User-Agent: astroid/0.13
Message-Id: <1652775347.3cr9dmk5qv.2220@fsfe.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

~ Thomas Gleixner [2022-05-16 20:59 +0200]:
> On Mon, May 16 2022 at 20:52, Thomas Gleixner wrote:
>>> Unfortunately, excluding files (i.e. not adding machine-readable
>>> license/copyright information to it) would also block reaching full
>>> compliance with the REUSE best practices. Have you considered making
>>> them available under GPL-2.0-only or a license similar to public domain
>>> [^2]?
>>
>> The LICENSE directory is already handled by spdxcheck as the license
>> information is read from there. And no, we cannot add a GPL-2.0-only
>> identifier to all of the files under the LICENSE directory for obvious
>> reasons.

Absolutely. REUSE obviously also ignores this directory, as well as
e.g. zero-length files, symlinks, submodules, or .git directory.

> There is also an argument to be made whether we really need to have SPDX
> identifiers on trivial files:
>=20
> #include <someheader.h>
> <EOF>
>=20
> Such files are not copyrightable by any means. So what's the value of
> doubling the line count to add an SPDX identifier? Just to make nice
> statistics?

We agree that such files are not copyrightable. But where is the
threshold? Lines of code? Creativity? Number of used functions? And how
to embed this threshold in tooling? So instead of fuzzy exclusion of
such files in tools like spdxcheck or REUSE, it makes sense to treat
them as every other file with the cost of adding two comment lines.

This clear-cut rule eases maintaining and growing the effort you and
others did because developers would know exactly what to add to a new
file (license + copyright) without requiring looking up the thresholds
or a manual review by maintainers who can interpret them.

Best,
Max

--=20
Max Mehl - Programme Manager -- Free Software Foundation Europe
Contact and information: https://fsfe.org/about/mehl -- @mxmehl
The FSFE is a charity that empowers users to control technology
