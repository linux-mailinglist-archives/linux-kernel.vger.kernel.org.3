Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FE4C498F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbiBYPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242357AbiBYPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:51:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174246BDD7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7A2CB83273
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990C6C340F2;
        Fri, 25 Feb 2022 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804230;
        bh=W5kTJHtuSAdeclyGcjAyKEzb2GWn6NO23yIDCLlIycQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sShPFKynozcZM8TmToRgyPdqEJVD7nYJsGKPxYqckrvhyxd4hyyA+qmvYr/OKBkxF
         B7EcDXZIWRoaZD/QgZXyOPjwk25M0DGVwbLXvoQs1JTjaEmih85nu2gMDyBgIFqj9J
         hVuDWk43sHZaZc5vfxqUNja2jReuMwoj0Opk8x1bftjooRTHyMYJIzbaM1k8EdkSvn
         4XCVG6QY5aa89MNln/N0OlITa9W69eQJ0333wOS4Vk2GzaLGa5Y1bGAeaXxkAtnmYo
         O+6BxrgdC2LH9EmuNywLib0KaqYAnktV7t+UzES/L2hUOFjHKA36vXJvMDc4gVD+9c
         j3QbbBAgtWIOA==
From:   Will Deacon <will@kernel.org>
To:     Fangrui Song <maskray@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] arm64 module: remove (NOLOAD)
Date:   Fri, 25 Feb 2022 15:50:15 +0000
Message-Id: <164579795583.2003844.2115032608594321024.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220218081209.354383-1-maskray@google.com>
References: <20220218081209.354383-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 00:12:09 -0800, Fangrui Song wrote:
> On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
> inappropriate for .plt and .text.* sections which are always
> SHT_PROGBITS.
> 
> In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
> and (NOLOAD) will be essentially ignored. In ld.lld, since
> https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
> customize the output section type"), ld.lld will report a `section type
> mismatch` error. Just remove (NOLOAD) to fix the error.
> 
> [...]

Applied to arm64 (for-next/linkage), thanks!

[1/1] arm64: module: remove (NOLOAD) from linker script
      https://git.kernel.org/arm64/c/4013e26670c5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
