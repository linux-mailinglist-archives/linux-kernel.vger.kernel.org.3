Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55997546F86
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348464AbiFJWJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiFJWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:09:27 -0400
X-Greylist: delayed 204 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 15:09:24 PDT
Received: from h4.fbrelay.privateemail.com (h4.fbrelay.privateemail.com [131.153.2.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D56182BAC;
        Fri, 10 Jun 2022 15:09:24 -0700 (PDT)
Received: from MTA-05-3.privateemail.com (mta-05-1.privateemail.com [198.54.122.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id AD18D1807864;
        Fri, 10 Jun 2022 18:05:59 -0400 (EDT)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id 186E71800305;
        Fri, 10 Jun 2022 18:05:58 -0400 (EDT)
Received: from [192.168.0.10] (unknown [10.20.151.151])
        by mta-05.privateemail.com (Postfix) with ESMTPA id C2F1A180030F;
        Fri, 10 Jun 2022 18:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gunth.ca; s=default;
        t=1654898757; bh=DR8am5N0Dx+vMZi+MWJL78P1Ie0vBDWngxeqWCdY3Xc=;
        h=Date:To:Cc:From:Subject:From;
        b=bqVIB44CwpptD16TNQiOnqYeuc6ANa0lCvhzXqueQMMZJLF8QmDemuqt5dKnsHWhT
         neXEeucQDb3wb9hwPylFuW/63R9ftrQ2hyKIQj5lX3bMVs1Xk4h5/GBVMsT6UDNqm2
         t1GNNYevID0HqPi4aTEv6h/oI4dU+b5fgY+rgNfPzao+eUzcj3cbYwA9YdDgNFvXKm
         kyRaDrYcgnit6vkWEbSA6NNorTSSkYgMmWl8rzVr4J6nryvuOiufg+9I6wd9+i8d9I
         xxyalFkJ0dsingC2849Z44/yo9Im817g773sRT2lQa181WH0FhbWSdn9AAJDRQXgOR
         ie2vzJl3py5yA==
Message-ID: <f79f67ff-abb0-123d-064b-a826ec2c6666@gunth.ca>
Date:   Fri, 10 Jun 2022 16:05:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <song@kernel.org>
Cc:     Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
From:   Logan Gunthorpe <logan@gunth.ca>
Subject: Raid5 Reshape Data Corruption Bug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

I've diagnosed a bug in the reshape code that corrupts data, however I
don't have a good solution to the problem and a solution may be quite
complicated. I suspect this is the cause of random failures I see with
01r5integ and 01raid6integ. (Though I can't say for certain as I have a
quicker reproduction method.)

The bug is that during reshape: EXPAND_SOURCE stripes are not in the
correct order when the data comes back from the disk and if a latter
stripe comes back sooner than an earlier EXPAND_SOURCE stripe has read
the disk then an EXPAND_READY stripe might write a block before the
source block was able to read it; so it overwrites data before that data
has been moved and result in corrupt data on the disk. This happens
reasonably frequently.

I suspect this is made worse with modern SSDs and spinning disks would
be less likely to exhibit this problem as it would naturally try to
order the reads by sector.

So somehow there needs to be a way to prevent an EXPAND_READY stripe
from writing the data for a specific device block before the
corresponding EXPAND_SOURCE block has read the data. And I don't see an
trivial way to get that done.

If anyone has any clever solutions it would be good to hear that.
Otherwise, I don't think I'll have time to find a solution myself.

Logan
