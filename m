Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7A59C2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiHVP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiHVP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E3D11815
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3A661122
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B499C43470;
        Mon, 22 Aug 2022 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661182135;
        bh=SIasQlAEFjGCSRt/CEHtDDFWf9zOQKXzw2OystW7yS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T50xCBWWaV5QoBpJDmOOFH7Mff5Ib3Sev/Y9BLrJWykYJ87jo/wnqMfaMqHLHxCzO
         ebFN6eCI8NbUWyBIA8kbmOD5Etwx4FgXmHg8xoY51bRmNI6YJl7odKqs8ZbVhIHzCU
         WFKpgEVoWcaNEhC3qnnUy3FKM1/qtvzKqWbNMjVcVjH8ixbZo+fzhKUqkMN6vQh8g9
         PjfbcQgo0bV1FCdyvjRNZgkaSWCHOqDBcPBYxkDcfF8Glg17GRmEV9KyotXfRm5SwQ
         jUE1Jl6aZtBvQt7jikq9qpJ7Ee0pyKUSfviMm/G5P9sO/CaJBB5Bk9CmqfIpdhWG/Y
         VuMBeSExtUq8w==
Received: by pali.im (Postfix)
        id 63EDD97B; Mon, 22 Aug 2022 17:28:52 +0200 (CEST)
Date:   Mon, 22 Aug 2022 17:28:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Child <nick.child@ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: Add support for early debugging via Serial
 16550 console
Message-ID: <20220822152852.y5fjpmjjasbu2wab@pali>
References: <20220819211254.22192-1-pali@kernel.org>
 <35c0ff6a-387d-3c01-66b3-f659cfe67c2a@infradead.org>
 <20220819223848.lvxakjjzfdjvyqgu@pali>
 <d12435b4-0caa-ba06-f0a5-8c9268bb8dfd@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d12435b4-0caa-ba06-f0a5-8c9268bb8dfd@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 August 2022 14:13:30 Christophe Leroy wrote:
> >> CONFIG_PPC_EARLY_DEBUG_16550=y
> >> # CONFIG_PPC_EARLY_DEBUG_MEMCONS is not set
> >> CONFIG_PPC_EARLY_DEBUG_16550_PHYSADDR=
> >> CONFIG_PPC_EARLY_DEBUG_16550_STRIDE=1
> >>
> >> which then causes a kconfig prompt when starting
> >> the build...
> > 
> > Cannot we set somehow that PPC_EARLY_DEBUG_16550 would be disabled by
> > default when upgrading defconfig?
> 
> The only solution I see is to put it at the end of the list, so that the 
> previous default value which is PPC_EARLY_DEBUG_MEMCONS gets selected.

Does it work for all cases? If yes, then it looks like an elegant solution.
