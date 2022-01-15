Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D348F805
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiAOQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:49:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49550 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiAOQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:49:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A835DB801B8;
        Sat, 15 Jan 2022 16:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97BEC36AE3;
        Sat, 15 Jan 2022 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642265389;
        bh=CLLfm9z4AHVfy39p3/9aWoBxWNIR8mlJbzJzJMB4pGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fT2BoyLg2sMw1ZkvgyyXgU/zckpUzC9vWesoXeQxZxHb4P+njNTe2XErZfUHI5Olh
         YE8ISfpYQ/6+KR7+Z9PSTAiztDm3WNAndhUWHICkAqTaKq3yPGy3BxFLoNtFWVs/bW
         FCLE1wS7F5CW6eRhzg7RYMebwA6hEeBpcGACogLQGSezs49RY9XO0K9dl/3UPp/DF8
         mL0lb0L9mZ1btelK1h2wSRcrNe5fxIT2T7xtkqepaJdjfnk2JYoL1+3NmLlwqRAiMj
         6cvLs19sakmx/SARIAulVloqt8P3RUnDL2UXdTM7OEt+ZlGJhrS60s+u236Ut+Onq0
         U6s2wNz4sry7A==
Date:   Sat, 15 Jan 2022 18:49:36 +0200
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
Message-ID: <YeL7ID70Wg22MGCY@iki.fi>
References: <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
 <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com>
 <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com>
 <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com>
 <YeIEKayEUidj0Dlb@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeIEKayEUidj0Dlb@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 01:15:53AM +0200, Jarkko Sakkinen wrote:
> > After running ENCLU[EMODPE] user space uses SGX_IOC_ENCLAVE_MOD_PROTECTIONS
> 
> OK, great.
> 
> A minor nit: please call it SGX_IOC_ENCLAVE_MODIFY_PROTECTIONS. 

I'm not confident after looking through the test case and ioctl
about EMODPE support but I do not want disturb this anymore. Bunch
of things have been nailed and I'm now running the code, which is
great.

The obviously wrong implementation choice in this ioctl is that
it is multi-function. It should be just split it into two ioctls:
sgx_restrict_page_permissions and sgx_extend_page_permissions.

They are conceptually different flows and I'm also basing this on earlier
discussion in this mailing list from which I conclude that it is also
consensus to not have such ioctls.

Might sound clanky but it is much easier to comprehend what is going
on "in the blackbox" by doing that split.

/Jarkko
