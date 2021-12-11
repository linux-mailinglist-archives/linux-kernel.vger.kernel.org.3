Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997AC47128D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhLKHmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 02:42:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46832 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 02:42:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D578DB80769;
        Sat, 11 Dec 2021 07:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0F0C004DD;
        Sat, 11 Dec 2021 07:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639208535;
        bh=frS+r5MMas9k975K/4mPS7Qz7AA7HIUz/puin1SQrBQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a49FnbCI4Cwy/H7Pve+hZlfmL3L12KO0PA6ljPSI6e+FWQwM1QODTeRs5COymPIRv
         GTqc+V/5dz+AfwqGUErNJKuAih+DWJS5sIQfP+VFhQ/9i/bHOuFfOU9jCShX5eijTS
         qoNkfcXA8AwYTFGAEAdvFiLHdGNZQ14f7Ufng2uc8A1bnZo6R/hsUanc7TEdjFj+FU
         fpnH7x+M/GqwwR8mNJALzdZs49rM8h2tv8tonbJF8Jo2BlExI6oTaKiQvIRzElwBBl
         y0Vaw6JAouazMk+gblSBc51QzQEbn1cdr+WViPMK2ki7yaolJVo68RD4+dF9WCjg6e
         5z4oX1aXDv0NA==
Message-ID: <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, linux-sgx@vger.kernel.org, x86@kernel.org,
        seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 09:42:11 +0200
In-Reply-To: <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
         <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org> <YawAWmodeNaUbzV8@iki.fi>
         <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:20 -0800, Reinette Chatre wrote:
> > This is a valid question. Since EMODPE exists why not just make things =
for
> > EMODPE, and ignore EMODPR altogether?
> >=20
>=20
> I believe that we should support the best practice of principle of least=
=20
> privilege - once a page no longer needs a particular permission there=20
> should be a way to remove it (the unneeded permission).

What if EMODPR was not used at all, since EMODPE is there anyway?

This could be achieved e.g. by having ioctl to change protection
bits in encl->page_tree.

This would simplify things a lot given that there would be only
two, instead of three, EACCEPT code paths.

/Jarkko
