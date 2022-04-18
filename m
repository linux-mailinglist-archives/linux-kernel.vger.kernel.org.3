Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB765504F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiDRLH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbiDRLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:07:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBC013E99;
        Mon, 18 Apr 2022 04:05:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C21C61F37E;
        Mon, 18 Apr 2022 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650279916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MXv4CCJ+s8PPXj9xZt112RURp4scFtLvmiRjw8DjDE=;
        b=jqQVK5TQAcVnxMDc24wO8sga6fhYUmXxKe/8xe6oNvirRP1ZB4/Rxosh+8BDucv1RhrfxO
        G8tyVq4hWBa3PTg43o269xNS6pw92b2yAHP1pwyCzaBWQCvazwy5o1MyLEndH8ZkMY+6fr
        gf3dF1nszgSfBB0JUNrPXQsDTOxulq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650279916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MXv4CCJ+s8PPXj9xZt112RURp4scFtLvmiRjw8DjDE=;
        b=Sbf493i94lbj90nCvsJyBOr/qQN6eXypLFmYZ+SMhgy7KBdRG+HKj/qREfbcpaGSKhjYGq
        R1qZ2lyVdA0YPOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EA8B13ACB;
        Mon, 18 Apr 2022 11:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J3MfJuxFXWIkFQAAMHmgww
        (envelope-from <iivanov@suse.de>); Mon, 18 Apr 2022 11:05:16 +0000
Date:   Mon, 18 Apr 2022 14:05:16 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: bcm2835: Round UART input clock up
Message-ID: <20220418110516.s7jxsfa3jl7aagrf@suse>
References: <20220404125113.80239-1-iivanov@suse.de>
 <20220414105656.qt52zmr5vjmjdcxc@suse>
 <0b3356c0-b4c8-91ed-dfde-9f50483ec36f@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3356c0-b4c8-91ed-dfde-9f50483ec36f@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 04-15 10:52, Stefan Wahren wrote:
> 
> Hi Ivan,
> 
> Am 14.04.22 um 12:56 schrieb Ivan T. Ivanov:
> > Hi Stefan,
> > 
> > Please, could you take a look into following patch?
> yes, but i cannot give a technical review. But from my gut feeling this
> doesn't look really elegant to me.
> > 
> > Thanks!
> > Ivan
> > 
> > On 04-04 15:51, Ivan T. Ivanov wrote:
> > > Subject: [PATCH v2] clk: bcm2835: Round UART input clock up
> > > Message-Id: <20220404125113.80239-1-iivanov@suse.de>
> > > 
> > > The UART clock is initialised to be as close to the requested
> > > frequency as possible without exceeding it. Now that there is a
> > > clock manager that returns the actual frequencies, an expected
> > > 48MHz clock is reported as 47999625. If the requested baudrate
> > > == requested clock/16, there is no headroom and the slight
> > > reduction in actual clock rate results in failure.
> > > 
> > > If increasing a clock by less than 0.1% changes it from ..999..
> > > to ..000.., round it up.
> 
> Based on this commit message this looks like a fix / workaround for an
> issue. It would be very helpful to know:
> 
> What issue should be fixed?
> 
> Why is it fixed here and not in the UART driver for instance?

The UART driver is amba-pl011. Original fix, see below Github link,
was inside pl011 module, but somehow it didn't look as the right
place either. Beside that this rounding function is not exactly
perfect for all possible clock values. So I deiced to move the hack
to the platform which actually need it.

> 
> In case it fixes a regression, a Fixes tag should be necessary.

I found the issue because it was reported that RPi3[1] and RPi Zero 2W
boards have issues with the Bluetooth. So it turns out that when
switching from initial to operation speed host and device no longer
can talk each other because host uses incorrect baud rate.

I open to better solution of the issue.

Thanks,
Ivan

> 
> In best case this is explained in the commit message.
> 
> Best regards
> 
> > > 
> > > This is reworked version of a downstream fix:
> > > https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
> > > 

[1] https://bugzilla.suse.com/show_bug.cgi?id=1188238

