Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C415798A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiGSLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiGSLlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:41:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4793F304
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D2C615C9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2822BC341C6;
        Tue, 19 Jul 2022 11:41:06 +0000 (UTC)
Date:   Tue, 19 Jul 2022 12:41:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v4 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Message-ID: <YtaYTgFDpGSsG+H0@arm.com>
References: <20220715175155.3567243-1-mail@conchuod.ie>
 <20220715175155.3567243-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715175155.3567243-2-mail@conchuod.ie>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:51:55PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> arm64's method of defining a default cpu topology requires only minimal
> changes to apply to RISC-V also. The current arm64 implementation exits
> early in a uniprocessor configuration by reading MPIDR & claiming that
> uniprocessor can rely on the default values.
> 
> This is appears to be a hangover from prior to '3102bc0e6ac7 ("arm64:
> topology: Stop using MPIDR for topology information")', because the
> current code just assigns default values for multiprocessor systems.
> 
> With the MPIDR references removed, store_cpu_topolgy() can be moved to
> the common arch_topology code.
> 
> CC: stable@vger.kernel.org

I'd quantify how far back you want this to go. IIUC based on the Fixes
tag in the other patch, it should stop at 5.4. If you send a pull
request instead and have a fixed commit id, you could add it as a
prerequisite on the following patch without a cc stable here.

Either way:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
