Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68548F37C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiAOA1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:27:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49344 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiAOA1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:27:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814F4620A6;
        Sat, 15 Jan 2022 00:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A30C36AE9;
        Sat, 15 Jan 2022 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642206454;
        bh=hlK7A7JLCpy3UKbMBHbhsr7ctTmoSDrVLCFh2Sh/GyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pytUqLhCXWQsEp8FfU5STjvL+hX2lEn98MyYCGwuZbaKM3A6qtL+/xHSytHPRm197
         j48DzhjGTM6fcmrVFK4EJHX+vu0VfBUbCqEU3TdbG+ug2vzbXzlJcp5Qo/2PQU1hVs
         A93NizF8LralQTbwYKSNreIZnPvCZGLP9Z2pDnNrtHVgUshX62/tRdJoRy0Vjpv0IC
         H3dwUrmMbiParYuCsgKUamZ5TsRfu1BZOdW8XwVsZyXykg3dl6pEdS4mD59j4+TbUd
         92MQGNaPVxNZSGpTdEwcoqYAVB8zCOJzvyfsIY7ORyamt1dvJ3SpJwfgsoTOtn+C/T
         0jhBr9lrGAedQ==
Date:   Sat, 15 Jan 2022 02:27:21 +0200
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
Message-ID: <YeIU6e6wetrifn+b@iki.fi>
References: <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com>
 <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com>
 <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com>
 <YeIEKayEUidj0Dlb@iki.fi>
 <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> > On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
> >> Hi Jarkko,
> > 
> > How enclave can check a page range that EPCM has the expected permissions?
> 
> Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
> that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
> time the enclave provides the expected permissions and that will fail
> if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).

This is a very valid point but that does make the introspection possible
only at the time of EACCEPT.

It does not give tools for enclave to make sure that EMODPR-ETRACK dance
was ever exercised.

/Jarkko
