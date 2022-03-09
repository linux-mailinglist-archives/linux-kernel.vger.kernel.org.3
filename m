Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1474D384A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiCIRyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiCIRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:54:21 -0500
Received: from granite.fifsource.com (granite.fifsource.com [173.255.216.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7E7666A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:53:19 -0800 (PST)
Received: from ceramic.fifi.org (107-142-44-66.lightspeed.sntcca.sbcglobal.net [107.142.44.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by granite.fifsource.com (Postfix) with ESMTPSA id 77F384076;
        Wed,  9 Mar 2022 09:53:19 -0800 (PST)
Message-ID: <427c153f2d34997e2131bdeb0fe851c74083f21a.camel@fifi.org>
Subject: Re: Bisected regression: 4287509b4d21 causes HP Spectre 14t-ea100
 to overheat while suspended
From:   Philippe Troin <phil@fifi.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Mar 2022 09:53:19 -0800
In-Reply-To: <a52f9cfb-818f-6ed9-42aa-1385584c8103@intel.com>
References: <e1b3112fd6c8c889408915e9a849301d13acf2f1.camel@fifi.org>
         <a52f9cfb-818f-6ed9-42aa-1385584c8103@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-09 at 16:21 +0100, Rafael J. Wysocki wrote:
> On 3/9/2022 4:50 AM, Philippe Troin wrote:
> > Linux 5.16.9 was working fine, but starting with 5.16.10 my main laptop
> > has been overheating while suspended.
> > I've also tried 5.16.11, 5.16.12 and 5.16.13 and they also show the
> > same issue (overheating while suspended).
> > 
> > I could not spot any difference between the dmesg messages issued
> > during suspend between a working version (5.16.9) and the the broken
> > ones (5.16.1[0-3]).
> > 
> > I've bisected the regression down to commit 4287509b4d21
> > https://lore.kernel.org/lkml/20220214092510.074083242@linuxfoundation.org/
> > 
> > I have also tried reverting that change on top of 5.16.12, and the
> > overheating behavior is gone.
> 
> OK, so it is not clear if this is a regression in -stable only or in the 
> mainline.
> 
> Would it be possible to try 5.17-rc7 and see if the issue is still there?

Tried 5.17-rc7, and the issue is not appearing when running it (the
laptop does not overheat when suspended).

So it looks like the problem only appears on the 5.16 branch, starting
on 4287509b4d21.

Phil.
