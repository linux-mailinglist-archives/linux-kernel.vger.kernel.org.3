Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6E550C99
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 20:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiFSSvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiFSSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 14:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1CA194
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 11:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0120561229
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E208DC34114;
        Sun, 19 Jun 2022 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655664600;
        bh=TrohUoOwcycRrk8GE4fb0hnksqJfGDb/F/dRryb/8EM=;
        h=Date:From:To:Subject:From;
        b=WD3hoTkOr3+nS+0kLiXrSeSu5pJSluz8lbSk/A0qMQwzF8ieL2qK1Cwq8M6fOJA+V
         +x2QLp//dTeZ592fothOi9/Q8vs/USUDlH9dTUVSmTJjv35PuEbgHL2FNDxOfTL8+9
         EoIiQJXMT0UpBnmYQgGvh1hXc6L1ia/7Bcvu1ZWQ8cTayZ3JBCltr5KWwQlDx6Bui9
         TJAWMHxgwTvONCbP/8QMwghkuI+mTGgNgHXfkuDeRhaHiKMn6sMeF4CkEOy3yyy8t9
         Zdhlir0tbaWiB6GJH7UPvF9ADl3mFl7IaxWugruOQ7Ai4CSPCe7ML+p1UdDG8KgiT3
         aSyil1zz6Sc+A==
Date:   Sun, 19 Jun 2022 20:49:49 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Boot stall regression from "printk for 5.19" merge
Message-ID: <20220619204949.50d9154d@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Petr, John,

the series
https://lore.kernel.org/linux-kernel/YouKQw72H7y9EJQK@alley/
merged by commit 537e62c865dc ("Merge tag 'printk-for-5.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")

and in particular the commit 09c5ba0aa2fc ("printk: add kthread console
printers")

causes a regression on arm64 (Marvell CN9130-CRB board) where the
system boot freezes in most cases (and is unusable until restarted by
watchdog), or, in some cases boots, but the console output gets mangled
for a while (the serial console spits garbage characters).

The stall example:

  ...
  [    1.108141] io scheduler mq-deadline registered
  [    1.108143] io scheduler kyber registered
  [    1.163484] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
  [

Or another:

  ...
  [    1.108155] io scheduler mq-deadline registered
  [    1.108156] io scheduler kyber registered
  [    1.162991] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
  [    1.163361] armada-cp110-pinctrl f2440000.system-controller:pinctrl: registered pinctrl driver
  [    1.180827] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
  [  

The garbage example:

  ...
  [    0.920951] raid6: using neon recovery algorithm
  [    0.921228] iommu: Default domain type: Translated
  %

          gb@k+cFL/[    4.954974] DSA: tree 0 setup
  [    4.955286] cfg80211: Loading compiled-in X.509 certificates for regulatory database

I did not have time to look at the contents of the commit yet to try to
fix it myself, and won't have time for another two weeks. But I thought
I should let you know now.

Marek
