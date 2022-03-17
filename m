Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC17D4DC764
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiCQNSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiCQNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:17:52 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77019E0BE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:16:35 -0700 (PDT)
Received: from [192.168.1.101] (unknown [88.235.220.59])
        by gnuweeb.org (Postfix) with ESMTPSA id 6419E7E2F3;
        Thu, 17 Mar 2022 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647522994;
        bh=5fmrA3PukZjwJ+KCbiuPihtvucTo0WoBkiBojIPQC+E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TjwkIQZGniiLHugynrg1EpLzHpECUGp9+Uk1nazx14oOaJ2DXbgoCwuxWZU2PB43F
         IaE6QWBf4NsGt4gPtE6XDtlmDRXiRgo7Zk8bFLwpIY18ZXz5FvUbz6Psjp7igY3YkI
         lqzx7MTw6qUhehgi62SHNsT3iFuSwresujmjTfQL9N4GOdOkFrrvw3D5c/r9m3QbOB
         /PdST/HM95MId091Zn24isCbFCMuQjcMJURVTL5VhXLPkOSs8oWDL/qD6wJKkY5TcC
         dFWt1OOrV766r21SG4orJKV6NbbTD7LIiueIe+1tANKEXuEOKh/2qXnlP3u9rXsS+3
         hwc/KQB9mhtXg==
Message-ID: <7b4f98d92a57af35c927aef6c85373f8eeeab29c.camel@gnuweeb.org>
Subject: Re: [PATCH] boot install: Partially refactor the logic for
 detecting bootloader
From:   Beru Shinsetsu <windowz414@gnuweeb.org>
To:     Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Thu, 17 Mar 2022 16:16:26 +0300
In-Reply-To: <2E28CA0C-34F2-4985-86CC-B1823AF8D747@alien8.de>
References: <20220316173221.5937-1-windowz414@gnuweeb.org>
         <2E28CA0C-34F2-4985-86CC-B1823AF8D747@alien8.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-17 at 12:36 +0000, Boris Petkov wrote:
> On March 16, 2022 5:32:21 PM UTC, Beru Shinsetsu
> <windowz414@gnuweeb.org> wrote:
> > While running `make install` after building the kernel and
> > installing
> > modules on several distros like EndeavourOS, there would be a
> > pretty
> > little output (To be exact, "Cannot find LILO") due to lack of LILO
> > bootloader, which is really uncommon for a user to have it while
> > GRUB is there. 
> 
> As a matter of fact I saw this yesterday on one of the test boxes
> here and was wondering why I am even seeing this.

I guess I had pure luck having this patch seen? xd

> So before we do anything, it'd be prudent to know what has changed
> recently to cause this error message to happen. Because we would have
> to backport a fix to some kernels probably.

To be honest with you, nothing has changed _just recently_ to cause
this error message to come up. It was a long living thing (since the
time LILO check has appeared and the last change to it was in 2007. I
can't find when did the check appear for the first time as Linus
apparently ripped off the whole history from before 2.16.12-rc2.), just
was unseen as most of Linux distros love to ship their own ways to
install kernels... except Arch Linux and distros based on it, as they
have Arch User Repository to automatically compile the kernel locally
and make a PacMan package out of the artifacts using some external
package manager like Yay or Aura. And if you have checked the
ServerFault forum thread I have appended in original commit message,
you can see it was there for really long and has been happening only on
Arch Linux or distros based on it, like EndeavourOS. I have also tested
this out on my environment (I have EndeavourOS on my laptop's HDD and
Ubuntu Budgie on my USB HDD). I get the error message on Endeavour
while I don't on Ubuntu Budgie if I run `make install` without this
patch I made applied. But if I apply this patch then run it, it works
on both.

TL;DR, this was something that has been there since 2.x and wasn't
patched ever since, so here I do as I figured out how it's handled
without requirement of user interaction, through this patch.

Commit ripping off the history from before 2.16.12-rc2: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (Linux-2.6.12-rc2)
Last commit towards LILO check: 47f82189b185bf4b0de4ebce237850e8d3b1d0b6 (broken lilo check on make install)

> Thx.

And I thank you for your attention! :)
-- 
Beru Shinsetsu
