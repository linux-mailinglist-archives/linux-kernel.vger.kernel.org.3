Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A150714D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353559AbiDSPIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiDSPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:08:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440CB3968B;
        Tue, 19 Apr 2022 08:05:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E46C12129B;
        Tue, 19 Apr 2022 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650380755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIeKtDiX0nw/kN8tZFnbYwbUF0osRimfD25Cqjw9rO0=;
        b=p0AkssQvCUGX2FIMw2M6305MzO023ILQ5u5IfEsBVHXyJHDV+Ebng9/Or4tm5v9ZLS2kLq
        hoWrwtxaDSJOTaOA3LVtFIwda/AweGfgvh+HYRp+GubmdbcetanPTiaxtoKJsw/GevrmpQ
        1tb0zNKv/NJqEwQgpoFNU25svmJC4qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650380755;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIeKtDiX0nw/kN8tZFnbYwbUF0osRimfD25Cqjw9rO0=;
        b=VIM4uKnDgGnQYW+y/rVChWFXlTtd7njqOyGqs9fi4c7mcZ9x9bowKajd514kd6PgEoABL8
        YF5T9AcBpjedztCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9CE2139BE;
        Tue, 19 Apr 2022 15:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kgk+MdPPXmLlMAAAMHmgww
        (envelope-from <iivanov@suse.de>); Tue, 19 Apr 2022 15:05:55 +0000
Date:   Tue, 19 Apr 2022 18:05:55 +0300
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
Message-ID: <20220419150555.igh6tdxgjb7meygx@suse>
References: <20220404125113.80239-1-iivanov@suse.de>
 <20220414105656.qt52zmr5vjmjdcxc@suse>
 <0b3356c0-b4c8-91ed-dfde-9f50483ec36f@i2se.com>
 <20220418110516.s7jxsfa3jl7aagrf@suse>
 <2a46bd1c-600b-5bd9-1c19-20c809f63945@i2se.com>
 <20220418113801.uree7rvkzxpiwyni@suse>
 <6adc9c1c-ec75-b52c-9c44-00296eaa00f6@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6adc9c1c-ec75-b52c-9c44-00296eaa00f6@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-18 18:01, Stefan Wahren wrote:
> > > 
> > > Do you use the mainline DTS or the vendor DTS to see this issue?
> > > 
> > For (open)SUSE we use downstream DTS.
> 
> This is popular and bad at the same time. We as the mainline kernel
> developer cannot guarantee that this works as expected. A lot of issues are
> caused by mixing vendor DTS with mainline kernel, so in general (not for
> this specific issue) you are on your own with this approach.
> 

Yep, I am aware of that. I am still trying to recover after recent
gpio-ranges fiasco, also still working on fixing non-exported firmware
clocks, which break HDMI output on some of the devices.

> I know this is a little bit off topic but except from overlay support, can
> you provide a list of most missing features of the mainline kernel / DTS?

Well, 260+ overlays for free is not insignificant benefit. Beside few
breakages from time to time using downstream device tree works fine.

Regards,
Ivan

