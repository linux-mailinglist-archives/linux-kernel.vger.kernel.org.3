Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8021F57AAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiGTAHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiGTAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE461114
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91DE1615B6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3013C341C6;
        Wed, 20 Jul 2022 00:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658275616;
        bh=iL1lKdPd+RoT6HvvkQJrCUMnSlqTwBsUbf0xJgnrRRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gw7Fu0x/WGf1Re1DfcZzj6vwzqn3eQgmyXuG75zmI6dJy8IehUQic6niduRZNYct1
         MZU6VfLxYz0rtFb7Cvm4/HvPJgdeu43YIlsHBaAkZnjCkiepIRNgWoXMguPhEXxyRE
         Sibkq/7rHm7pxkq9sIOEp3ahdYBNgQKy0QzbQROM8kTYGBcMKiObzWfnjZ/Sd4Sl0c
         B8XeRYB5ZFPrOW4s8tWz10mvS745UKwcpTySQd1ykL8xCy7Irl776MQHtpstYmjVAD
         xxTmxZcuQks99HCf3EC6xANn70yVZsbOUqDux8pTernw6oO+eqVDjjIZ6ZiHJFFWaK
         0zHhKZeh0LCDg==
Date:   Tue, 19 Jul 2022 17:06:54 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     keescook@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faddr2line issue
Message-ID: <20220720000654.yospyvbrfliy3lrn@treble>
References: <09df26a9-27af-1276-34c6-820bf7e27da8@huawei.com>
 <3492d341-a681-f344-f5cd-5b1ea3725f31@huawei.com>
 <20220714164136.n2ycc5axt7vtctgs@treble>
 <64da0019-4816-a409-be93-b1cf7021c584@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64da0019-4816-a409-be93-b1cf7021c584@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:24:42PM +0100, John Garry wrote:
> On 14/07/2022 17:41, Josh Poimboeuf wrote:
> > On Thu, Jul 14, 2022 at 10:57:51AM +0100, John Garry wrote:
> > > On 08/07/2022 15:47, John Garry wrote:
> > > 
> > > +
> > > 
> > > JFYI, This issue is caused by CONFIG_DEBUG_INFO now being default off in my
> > > .config from commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable
> > > from a choice").
> > > 
> > > By enabling that config faddr2line now looks ok again.
> > > 
> > > BTW, Could we add a check for any kernel dependency in this tool?
> > Hi John,
> > 
> > The script doesn't know how to reliably find the .config file, but it
> > should be able to check for missing DWARF in the binary itself.
> 
> Hi Josh,
> 
> So adding config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT to v5.19-rc2 got it
> working again for me on arm64. However commit dcea997beed6 ("faddr2line: Fix
> overlapping text section failures, the sequel") seems to be broken for me,
> below - this first appeared in rc3. Any idea what the issue could be?
> 
> $./faddr.sh hisi_sas_sata_done+0x8/0x38
> hisi_sas_sata_done+0x8/0x38:
> fs mm ??:0

Hm, what does faddr.sh do?  Does addr2line also fail?

Can you run

  bash -x scripts/faddr2line <vmlinux or .ko file> hisi_sas_sata_done+0x8/0x38

and share the output?

-- 
Josh
