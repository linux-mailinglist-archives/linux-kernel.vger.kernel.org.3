Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99B25A8575
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiHaS0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiHaSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20CE3420;
        Wed, 31 Aug 2022 11:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A390EB82221;
        Wed, 31 Aug 2022 18:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F7C433D6;
        Wed, 31 Aug 2022 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970105;
        bh=VfqWYmsroNc40aDzHJP4Oz82CrPs4tYiPBQEHE7mCHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhkKrb4viMn/yX3AS+kCL6vTqSDvaM30S6DwNJQRdsl1AgwGSn7rftwEZQo+5Ynf6
         S9E8uGrAgI4b6zDOhgZOYhsg5xkRJieNMZu2nE2UNrJq1eYooyy5tY6PNfQjsCKD/g
         9FqJ/G6gQORToNcg0qy8S/QekzXWfWMVwMYKtIwhhPigIjsdjNZCsA4ABTldm4630B
         wTH2N3fS2y+Ir0pycP4G+PJzqhfzaZ2cLpCIfpe2xnxkXMRJ4XpusK9dsQYXX+r6w8
         nCWO2IGvm/Q/heTwP7e6tZF9EtviuDO0gYzKLXk3XYj454/Av3rUqRlqAB1Rzx0P0b
         4EGgG5DzxKXzQ==
Date:   Wed, 31 Aug 2022 21:21:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] x86/sgx: Handle VA page allocation failure for
 EAUG on PF.
Message-ID: <Yw+mtfFs3dvOWOv2@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-4-jarkko@kernel.org>
 <20991fdc-1ae4-ef68-c6d4-12372b4e6f73@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20991fdc-1ae4-ef68-c6d4-12372b4e6f73@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:08:33AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> > From: Haitao Huang <haitao.huang@linux.intel.com>
> > 
> > VM_FAULT_NOPAGE is expected behaviour for -EBUSY failure path, when
> > augmenting a page, as this means that the reclaimer thread has been
> > triggered, and the intention is just to round-trip in ring-3, and
> > retry with a new page fault.
> > 
> > Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v3:
> > * Added Reinette's ack.
> 
> The ack came with a caveat related to a white space issue that
> you did not fix in this version.

Reinette, I'm sorry but I might possibly have some sort of blind
spot here.

I looked at the diff and I could not see any issues, and did not
run into issues with checkpath.

Can you point out what exactly is the whitespace issue?

BR, Jarkko
