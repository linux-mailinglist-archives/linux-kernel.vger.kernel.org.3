Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09A8544E14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiFINwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiFINwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:52:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24339163
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:52:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 259DqNnL010191
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Jun 2022 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654782746; bh=LNefV/tW71cR73hpGpC9VZ4sOZNx3wCiLfgvCFbU3Kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DfEaCRNay4ubQOieWuU9rJsadw1TVmnPO//vk9EfV7XcWDuIWIAJqHxrhrY5Qt1jj
         hRDPXwk0YISz2h2qLnohVGclGbqLA77fMyP7hw7BrK0PH3RhuqvCI6u4Vjh0LERSlT
         hbeB4B+vpAT8hu+5UYjvUMd2KLDg5lt0D/KWnW5fVk1SBju3ZUo/jr0XBlryNPiCl9
         h6e3s0o55UgdOD5rtsqPIlRzIaYLWVLDrFuSuoSUvzvebNq1dNAanoMRd2L9vjBaeT
         SmdcGy1l46FxqFvtVkwlKtRu59pv0IbgNW8Idn9T04zqwB7BnNouCHRcWOuHuS9sYK
         f4GUuqBGSSKug==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7756E15C3E1F; Thu,  9 Jun 2022 09:52:23 -0400 (EDT)
Date:   Thu, 9 Jun 2022 09:52:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        horsten Leemhuis <regressions@leemhuis.info>
Subject: Re: REGRESSION 5.19-rc1: virtio: harden vring IRQ
Message-ID: <YqH7F0uBL3Jt8GGY@mit.edu>
References: <YqF9VEBah+vvCtoR@mit.edu>
 <CACGkMEtn2AKtkY_dYBiimwiKrLFHrVy16h4NR_31LzUVv66W9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtn2AKtkY_dYBiimwiKrLFHrVy16h4NR_31LzUVv66W9A@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:19:59PM +0800, Jason Wang wrote:
> 
> This seems to be the same issue as the syzbot report recently.
> 
> Would you please test this patch to see if it works?
> 
> https://www.spinics.net/lists/kernel/msg4389357.html

Yep, that fixes things for me!  (As does disabling
CONFIG_HW_RANDOM_TPM.)

Tested-by: Theodore Ts'o <tytso@mit.edu>

Thanks,

					- Ted
