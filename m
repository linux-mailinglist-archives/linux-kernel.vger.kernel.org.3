Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CC4C6C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiB1MZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbiB1MZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:25:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8C76E1E;
        Mon, 28 Feb 2022 04:24:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1133061122;
        Mon, 28 Feb 2022 12:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B0C340F5;
        Mon, 28 Feb 2022 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646051059;
        bh=oZOcgtYrh8yNZbOLHL9TFee3Kx3uN+kaijUMv7n/GjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1ozI60qUTEXbDm9LxZvDcalgB+3gC1zwMOCspsbav5qRX79FLyCmF9dorUbugH1S
         H8kD16eDTvFLzufdtzdgJQKaOH+iZPSZg83IyzL/PIFYf6gOYN6JjeMskxaQ/ie5LW
         Gns9aq7Rlyb9TUAmQjRgdUj7LpM3IJApBa9anvphQEU95ATdA9DX5uiUlWf4GJidik
         u0FLKj77hUGQm59BroDX9/hFklHGvrGtWXAUfsJJi4SRnfS1qLY+v/WShuE9Agm34V
         TKXpUWdMF+PrCWmGyFHcPekbDBtFeP4VcRB4DiRof5rWvcf3mr8SvUFexxnczdLmwa
         4WXzTjgcRS85Q==
Date:   Mon, 28 Feb 2022 13:24:58 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <Yhy/GvJegnTqYdq6@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:21:50PM +0000, Dhanraj, Vijay wrote:
> Hi All,
> 
> Regarding the recent update of splitting the page permissions change
> request into two IOCTLS (RELAX and RESTRICT), can we combine them into
> one? That is, revert to how it was done in the v1 version?

They are logically separate complex functionalities:

1. "restrict" calls EMODPR and requires EACCEPT
2. "relax" increases permissions up to vetted ("EADD") and could be
    combined with EMODPE called inside enclave.

I don't think it is a good idea.

BR, Jarkko
