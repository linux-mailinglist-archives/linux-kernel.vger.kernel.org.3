Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB26D4DCC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiCQRMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiCQRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:12:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE31575AF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA95761517
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E86EC340E9;
        Thu, 17 Mar 2022 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647537045;
        bh=X39R4FQ/x4nZo2jv1DIbnYCKF4y0knuFmpo5vgzXrE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdxHC5os8oZCBIRCvPA/pv82YQvkB4QM4R3ZeV2+8yGKaNIUN7wFH4w5bqsnbFLkc
         gKVTo6jJpYOna3TlhMQXzQ8p40uqlq/VA1V6vWruCIoXE+UlCbl5WCixqf2aojSvrW
         x1Q62Qo05y1uZ1yKi37i8FCPSwMWweOWLBhJcYuw9ajTog1r1Vtd+LQY62+MVkf8GW
         i2rWsDeEJQfPG0JsXbcgrhMZSaMzeeQFOu+glU8xpKCUvxMz5NMu+KAa9odlHBh0l4
         X9Ks70MPZ8aAnssLbeCKC3PL5L5+U6EwUFD67bnZ1vqE+W0obVUHqOktk+wmrYivX/
         bxP10nA5f6QRg==
Date:   Thu, 17 Mar 2022 11:10:42 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mark Hsieh/WHQ/Wistron <Mark_Hsieh@wistron.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@fb.com" <axboe@fb.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Message-ID: <YjNrkknvwFYhW3ME@C02CK6Q3MD6M>
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
 <20220315132202.GA12452@lst.de>
 <TY2PR02MB2752B1742028968B3DAE02EBEA129@TY2PR02MB2752.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR02MB2752B1742028968B3DAE02EBEA129@TY2PR02MB2752.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:03:52AM +0000, Mark Hsieh/WHQ/Wistron wrote:
> Sorry late reply as it take a while to confirm with Micron engineering team.
 
It would help keep the thread readable if you send mailing list messages in
plain text. 
 
> But more importantly something seems really broken here if the device claims to support Write Zeroes but then doesn't claims it is not supported.
> 
>   *   We support write zero command indeed, but if host send too much write zero commands in due to the architecture design, we need spend lots of time to handle it, so we want to add 2450 in the google check list to resolve this issue.
>   *   2450 doesn't violate the write zero command spec, but total write zero command handle time will be too long for host point of view.
> 
> Can you see if this only happens with some I/O size?  With our without the nounmap flag?  Does the device report non-MDTS command limits?
> 
>   *   If the LBA range of each write zero command is quite small, it will let drive spend more time to handle it.
>   *   With noun-map flag (Deallocate = 0)
>   *   We report MDTS as 256KB, but write zero command doesn't take it as a reference.

The driver already limits Write Zeroes to MDTS if it doesn't report non-MDTS
limits. The spec doesn't require a driver do that, but we do out of an
abundance of caution.

So you are saying that sending many small Write Zeroes is taking more time on
the drive side compared to a single larger Write Zeroes? Would it be successful
if we weren't splitting these?
