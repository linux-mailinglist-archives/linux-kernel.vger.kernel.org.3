Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020394B0B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiBJKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:42:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiBJKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:42:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A1C39
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC044B824B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E8EC004E1;
        Thu, 10 Feb 2022 10:42:27 +0000 (UTC)
Date:   Thu, 10 Feb 2022 10:42:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/migration: Define arm64_hugetlb_valid_size()
Message-ID: <YgTsD4+8lAUjwAK1@arm.com>
References: <1644197468-26755-1-git-send-email-anshuman.khandual@arm.com>
 <YgQJPVUWMruiq74O@arm.com>
 <88ebbd30-2fcf-fef3-077c-1b8163cb7409@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ebbd30-2fcf-fef3-077c-1b8163cb7409@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:17:17AM +0530, Anshuman Khandual wrote:
> On 2/10/22 12:04 AM, Catalin Marinas wrote:
> > On Mon, Feb 07, 2022 at 07:01:08AM +0530, Anshuman Khandual wrote:
> >> +bool __init arch_hugetlb_valid_size(unsigned long size)
> >> +{
> >> +	return arm64_hugetlb_valid_size(size);
> >> +}
> > 
> > What's wrong with keeping the arch_hugetlb_valid_size() name and just
> > removing __init?
> 
> When arch_hugetlb_migration_supported() calls arch_hugetlb_valid_size(),
> 
> With __init for arch_hugetlb_valid_size(), there is a build problem.
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0xf18): Section mismatch in
> reference from the function arch_hugetlb_migration_supported() to the
> function .init.text:arch_hugetlb_valid_size()
> The function arch_hugetlb_migration_supported() references
> the function __init arch_hugetlb_valid_size().
> This is often because arch_hugetlb_migration_supported lacks a __init 
> annotation or the annotation of arch_hugetlb_valid_size is wrong.

This is expected.

> Without __init for arch_hugetlb_valid_size(), there is the same problem.
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0xf18): Section mismatch in
> reference from the function arch_hugetlb_migration_supported() to the
> function .init.text:arch_hugetlb_valid_size()
> The function arch_hugetlb_migration_supported() references
> the function __init arch_hugetlb_valid_size().
> This is often because arch_hugetlb_migration_supported lacks a __init 
> annotation or the annotation of arch_hugetlb_valid_size is wrong.
> 
> This might be because generic prototype for arch_hugetlb_valid_size() has
> __init attribute, which arch_hugetlb_migration_supported() does not have.
> 
> Hence a local static helper arm64_hugetlb_valid_size() which both these
> generic functions can call into, looked appropriate.

Ah, I did not realise the generic prototype is __init already. So fine
by me but maybe just use __hugetlb_valid_size() as it's a local function
only (static).

-- 
Catalin
