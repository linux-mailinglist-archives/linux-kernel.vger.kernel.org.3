Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE1557062F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiGKOut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiGKOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:50:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529ED63939
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03A7DB81022
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E29EC3411C;
        Mon, 11 Jul 2022 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657551040;
        bh=MX80YwmblA+v/61UuXjnsNDDbo5cN2GQE6qtQk7/qnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OO2E9gHGUI8pAsye9LKImxPqcZ+lOe39N3fNLx7J0ta3A0hdy7u6xT3q8dxDCqr1H
         zebW4Ms/bYVlaWgX7tO8sNgaU39U8/EcVC31dgw2GjNM8fsjp6cJlG/bI565+n7Y4G
         iRoixb73TYxQV3p9oeKSpNrJ/PKy+T4b2RC1xF4c=
Date:   Mon, 11 Jul 2022 16:50:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Conor Dooley <mail@conchuod.ie>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v3 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Message-ID: <Ysw4voXuz+tcSKhf@kroah.com>
References: <20220709152354.2856586-1-mail@conchuod.ie>
 <20220709152354.2856586-2-mail@conchuod.ie>
 <20220711143542.nlq6a5nuh4nouomo@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711143542.nlq6a5nuh4nouomo@bogus>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 03:35:42PM +0100, Sudeep Holla wrote:
> On Sat, Jul 09, 2022 at 04:23:54PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > arm64's method of defining a default cpu topology requires only minimal
> > changes to apply to RISC-V also. The current arm64 implementation exits
> > early in a uniprocessor configuration by reading MPIDR & claiming that
> > uniprocessor can rely on the default values.
> > 
> > This is appears to be a hangover from prior to '3102bc0e6ac7 ("arm64:
> > topology: Stop using MPIDR for topology information")', because the
> > current code just assigns default values for multiprocessor systems.
> > 
> > With the MPIDR references removed, store_cpu_topolgy() can be moved to
> > the common arch_topology code.
> >
> 
> Looks good. FWIW,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> > CC: stable@vger.kernel.org
> 
> However, while I understand the reason why this is needed in stable trees
> for RISC-V, I am not sure if we want this for stable tree at-least on arm64.
> I leave that part to Greg and Will.

Why would it be good for one arch but bad for another?
