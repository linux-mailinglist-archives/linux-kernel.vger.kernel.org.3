Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590DE5A18CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbiHYS2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiHYS2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF676B7EC1;
        Thu, 25 Aug 2022 11:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3393461D49;
        Thu, 25 Aug 2022 18:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEAEC433D6;
        Thu, 25 Aug 2022 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661452081;
        bh=FiEweROp+F0v4WN5aEo/fYg+dHXR3+spNrH2xA8zdZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrspMc76fO+PFMu9jpbPS263Jzf8KlcopVxJxXNcrPuleMeOU/sbIsKJnsd/Peh82
         CSrQEXDQiRT2nBKvBBa6qY60fmHcmAUZVGpEqWkfNU1bF8huKOsCChIhfbDFK5ONwR
         Y9BJuVL2NBXHkiWsU/1+lYyHt3EIsVUBc/tPg8S7K5HLD5OykP/m9oxd/fFfP/03lm
         yj3NtqV6norJI04n2R3lWB320F+Lo6KESBvhMnjzacKz0fxNmYPxv1Y+siVn4xBOUx
         MuUOyHHEeEVi1WyzRTey/6G3xl9YfXsmCSOQAp5nuB2q9dS80zbfUkw275CrJTrhQO
         txkPT+FSkCOMA==
Date:   Thu, 25 Aug 2022 21:27:54 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-sgx@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Ywe+Zw4NgLrwvEo7@kernel.org>
References: <20220825080802.259528-1-jarkko@kernel.org>
 <c63e554e-e433-b088-280c-aa1a185ade61@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63e554e-e433-b088-280c-aa1a185ade61@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 07:07:44AM -0700, Dave Hansen wrote:
> On 8/25/22 01:08, Jarkko Sakkinen wrote:
> > However, if the SGX subsystem initialization is retracted, the sanitization
> > process could end up in the middle, and sgx_dirty_page_list be left
> > non-empty for legit reasons.
> 
> What does "retraction" mean in this context?

Rest of the initialization failing or features not detected (-ENODEV).

BR, Jarkko
