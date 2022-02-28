Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE34C6DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiB1NTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiB1NTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:19:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7619321824;
        Mon, 28 Feb 2022 05:18:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D962F612FE;
        Mon, 28 Feb 2022 13:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4915C340EE;
        Mon, 28 Feb 2022 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646054319;
        bh=XfIHH2mAQKwp0r1bdsldo5rQLUX2ZAbLdDoUJspHYv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vdfn/ApER9g7nrPN7jyeWPZTOfE8Dy0Mb4YhSRqtoJS7wG1p0xzAWiPChnjTNyJCv
         ZLPmy74tCxa/HkYBs6i8EVsanZ6n+7ZrcYXKSZiyoA/RDc/GnBJFW2FyBlg5lNv+/U
         QPvUXubpvWmLWk16t3DXgYCN6d+dfndkgSrdmQx9K0XjfbuM7NyoV4be67eyrRRfeL
         JZzBMcYuyT9LBXNhmxcTT93qmLWxiVCL9Cl/9u3xwPgA02UVVwqBrB9XA6wFUQ9l1L
         HC++jj67ZvV9+3z6Z3Ns+iaBG84Nb0U1PCSQJ6HHbSxNVg1yM/YomTb9mg9PV5o6ga
         6aXDlPK1mlv2A==
Date:   Mon, 28 Feb 2022 14:19:17 +0100
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
Message-ID: <YhzL1YthJCwabsj0@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhy/GvJegnTqYdq6@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 01:25:07PM +0100, Jarkko Sakkinen wrote:
> On Wed, Feb 23, 2022 at 07:21:50PM +0000, Dhanraj, Vijay wrote:
> > Hi All,
> > 
> > Regarding the recent update of splitting the page permissions change
> > request into two IOCTLS (RELAX and RESTRICT), can we combine them into
> > one? That is, revert to how it was done in the v1 version?
> 
> They are logically separate complex functionalities:
> 
> 1. "restrict" calls EMODPR and requires EACCEPT
> 2. "relax" increases permissions up to vetted ("EADD") and could be
>     combined with EMODPE called inside enclave.
> 
> I don't think it is a good idea.

I.e. in microarchitecture there is no EMODP but two different flows, 
and thus it is not sane to act like there was with that kind of ioctl.
It is as granular as the hardware is this way, and I think that is
common sense.

It would make much sense as combining ECREATE/EADD/EINIT into a single
multi-function ioctl. Often user space needs to be anyway have at least
some logically distinct flows fore these.

BR, Jarkko
