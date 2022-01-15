Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB75348F405
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiAOBST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiAOBSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A61C06173E;
        Fri, 14 Jan 2022 17:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7154E620CD;
        Sat, 15 Jan 2022 01:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5603EC36AE7;
        Sat, 15 Jan 2022 01:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642209496;
        bh=brmYZ4xsVJ9RXGnMsvg9QqXh7sxIldild9tW5Lgpe0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWDCninBjNgm0moqa+yAl6prAEwa+NU8DPl9Eywp98UqLKkfYMkaUMGMJ5fGL47UV
         zhnU3GceFNsbVnJHyCPAbcR9wwP1KwxovDqog6RsI16fYebjyC828eoM92vR0eNQm2
         yMbueFP5OGsUp/rgyZRkmpQ6ZpXrMi1Vt/XlkJ5ww5sJzxNook3/QHlPWeHve87hqg
         6Pp/qbzPf06l3j3DYAB8oYOKFxjHIL/6uYEP4Fj/lgc2mddk6dENyCbB4qrZiZH+xT
         QU7yOsVvXY1UwmX1Sk29amhpbYPKnJcDMoKTStGonwSZh8MAeX+yeRwYlyZhcEcM80
         2pSJoDqNXXb9A==
Date:   Sat, 15 Jan 2022 03:18:04 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YeIgzLzPu0U8s0sh@iki.fi>
References: <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com>
 <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com>
 <YeIEKayEUidj0Dlb@iki.fi>
 <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com>
 <YeIU6e6wetrifn+b@iki.fi>
 <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
> > On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette Chatre wrote:
> >> Hi Jarkko,
> >>
> >> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> >>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
> >>>> Hi Jarkko,
> >>>
> >>> How enclave can check a page range that EPCM has the expected permissions?
> >>
> >> Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
> >> that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
> >> time the enclave provides the expected permissions and that will fail
> >> if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).
> > 
> > This is a very valid point but that does make the introspection possible
> > only at the time of EACCEPT.
> > 
> > It does not give tools for enclave to make sure that EMODPR-ETRACK dance
> > was ever exercised.
> 
> Could you please elaborate? EACCEPT is available to the enclave as a tool
> and it would fail if ETRACK was not completed (error SGX_NOT_TRACKED).
> 
> Here is the relevant snippet from the SDM from the section where it
> describes EACCEPT:
> 
> IF (Tracking not correct)
>     THEN
>         RFLAGS.ZF := 1;
>         RAX := SGX_NOT_TRACKED;
>         GOTO DONE;
> FI;
> 
> Reinette

Yes, if enclave calls EACCEPT it does the necessary introspection and makes
sure that ETRACK is completed. I have trouble understanding how enclave
makes sure that EACCEPT was called.

/Jarkko
