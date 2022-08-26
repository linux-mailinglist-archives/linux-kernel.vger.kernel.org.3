Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF25C5A1E64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiHZByh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiHZByf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00E5C990E;
        Thu, 25 Aug 2022 18:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3271E61E02;
        Fri, 26 Aug 2022 01:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE4AC433D7;
        Fri, 26 Aug 2022 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661478873;
        bh=VTjuvuwwT8hjNkX+GFhxYEDBgRdC7heutl3noSay0e0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7eF5pNNk5QUj5hGtC4x0UikOal/VegR4RcuD+wErd5QxfUtkoXR3NRgBK2b6UQKK
         GSMeE6NWXsBziP2leBBzUD+HOds5jTv74SLBw3jqIUhL3MKS6gvSviWsDNfuItFRFe
         hyvIjR9oWkJuxxw2mvHcknHcttiSM+0CX6JnhGmETmnPMe6eXX/cTev6OQK1JDHVzp
         7byUkQ6kS5YT6Kni1XJ3xSj6ztCsWh7sZpxYGURK0Xhv2ANYehA3ZzqZYLRh+HiGW6
         kP0UJV+G2OtEhoSenjO5qIZ6GD12SbVonmYPfuHk36mw4Cg9hs7iJVnMQBV6hV6ngs
         05b487EAGrUcg==
Date:   Fri, 26 Aug 2022 04:54:26 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Ywgn0mj942ouebj1@kernel.org>
References: <20220826014126.291156-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826014126.291156-1-jarkko@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 04:41:26AM +0300, Jarkko Sakkinen wrote:
> In sgx_init(), if misc_register() for the provision device fails, and
> neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> prematurely stopped.
> 
> This triggers WARN_ON() because sgx_dirty_page_list ends up being
> non-empty. Ultimately this can crash the kernel, depending on the kernel
> command line, which is not correct behavior because SGX driver is not
> working incorrectly.
> 
> Print simple warning instead, and improve the output by printing the
> number of unsanitized pages.
> 
> Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Speaking of non-inlining __eremove(). On a second thought, I think it
would make sense to non-inline all of __e*(). Then you can attach kprobe
to any of e-opcodes, which would be also sometimes useful for user space
debugging.

You can attach kprobe and kretprobe for each of them, and grab all
the info required.

Thoughts?

BR, Jarkko
