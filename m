Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4007E4B4947
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbiBNKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:03:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344288AbiBNJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:59:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A8216;
        Mon, 14 Feb 2022 01:46:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 823CDB80DBF;
        Mon, 14 Feb 2022 09:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C1CC340E9;
        Mon, 14 Feb 2022 09:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644831983;
        bh=OSVkyrM6ZHWyAjiNiE+eVqLtoVxlU5X7JMWjSKFGqCs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=md3S/d6/Die/Mp6ro9Hpc5Xc/c4F5mCuuc9SttsSVusPikCNFj+9bI7BK6miZCqJS
         /9SB3rV6RQg6ciX6+JRHl94jTeZ+d8iccILBA9f4HXg/Y2rlAhdiN3h+rG367TVZDz
         k++R6rhWqXSvOp5nvhwDr2tJUmrh8YkNqTKy10z93AMB6LYylV5sSYEgTJdUEOkyKh
         Z/fEGYwTL7ODY1UFYSLPC36vsnyc/58wC1Oyh90vqrtZbE0Bg/2W2bTp5IDd0EmSW9
         gUIg/LZkF0CxAeqkXFqFAfhwtyHbIQaT+H1Fe23oWco9YKva+PYkHjkjkqjK2UU2gA
         M0tzxsKUh/3Rw==
Date:   Mon, 14 Feb 2022 10:46:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Angela Czubak <acz@semihalf.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/12] i2c-hid: fixes for unnumbered reports and other
 improvements
In-Reply-To: <CAO-hwJK8O+yYMxCdx6DFd9cpF6McW4KC+uERQ6EsTY14JVr5-g@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2202141045240.11721@cbobk.fhfr.pm>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com> <nycvar.YFH.7.76.2202021456020.11721@cbobk.fhfr.pm> <CAO-hwJJ08vfMTEhU03VEef8Ejx=Ts+akUwGMKTUGqMWwOK3QoA@mail.gmail.com> <CAO-hwJK8O+yYMxCdx6DFd9cpF6McW4KC+uERQ6EsTY14JVr5-g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022, Benjamin Tissoires wrote:

> OK, So I applied the series on my development laptop.
> I had to apply it on top of v5.16 and then rebase on top of
> hid.git/for-next because there is a minor conflict.
> 
> I changed the register as mentioned in 5/12, and gave it a try.
> Both the Elan touchpad and the Wacom panel on my XPS-13 are behaving
> properly, suspend/resume works also as expected.
> 
> Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> I gave a quick look at the individual patches, they all seem sane to
> me, but haven't dug into enough detail to be able to formally give my
> reviewed-by.
> Note that I have a small comment on patch 2, but if you want to apply
> it nevertheless Jiri (with the change in 5/12) it should be fine.

Thanks a lot for testing. I've tested in on my I2C hardware, and haven't 
spotted any issues either.

I plan to finish going through the whole set today and tomorrow, and apply 
it right afterwards with the 5/12 change.

Thanks,

-- 
Jiri Kosina
SUSE Labs

