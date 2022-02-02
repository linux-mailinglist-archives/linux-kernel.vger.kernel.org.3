Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1A4A726E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbiBBN4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:56:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45408 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiBBN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:56:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E290EB830CE;
        Wed,  2 Feb 2022 13:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74964C004E1;
        Wed,  2 Feb 2022 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643810195;
        bh=i3Wl1PIcI1R8gZONAXMRTX8wXCIK09GZNAlBvHC4fQ8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=T/ZSDiJe218DWQXungnNozQ68nnU0HzrBOnMFfY1WSWexVnpBIsRZkBJrXqvTfn3Y
         Op8O+tz8t3dyHq9+LOytosMmxPQ0mTRCIoBNyIHUzzd+wL/lKBJ1CFJeqvlH4JBvX5
         C2y7WM5Vqjlx+EWliW4ocLVrRVu1E4/ysaA+FT/4sZpheVi5pjooZQVB+k+pBLmXpX
         2/5Qohkx6k5oZdlh9tBKvZ2/mCAADiayQO2G9wvXgL87PFx84Jln5+qnhPt3DNgf+h
         gTB4kgAnaFs+bIkcsHjNYrMztZ58TT7vJA3V3qDKyXsD1ph7rqnTDT3GBgCYvtlmB+
         v+tMNkPXqTSjA==
Date:   Wed, 2 Feb 2022 14:56:32 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] i2c-hid: fixes for unnumbered reports and other
 improvements
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202021456020.11721@cbobk.fhfr.pm>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022, Dmitry Torokhov wrote:

> Hi,
> 
> This series came about after I reviewed Angela's patch that fixed issues
> with incorrect handling of high-numbered reports (15 and above) in
> i2c-hid driver:
> 
> - it appears to me that the driver did not handle unnumbered reports
>   correctly as the kernel internally expects unnumbered reports to be
>   still prepended with report number 0, but i2c_hid_get_raw_report() and
>   i2c_hid_output_raw_report() only expected report ID to be present for
>   numbered reports.
> 
> - the driver tried to consolidate both command handling and sending
>   output reports in __i2c_hid_command() but the rules for different
>   commands vary significantly and because of that the logic was hard to
>   follow and it bled out from __i2c_hid_command() to callers. I decided
>   to introduce a few simple helpers and have the data encoding for
>   individual commands done at the call site. I believe this made it
>   easier to validate the rules and the logic and allowed to remove
>   special handling for the HID descriptor retrieval, among other things.
> 
> - the driver does too many copying of data; encoding the data for
>   commands at the call site allowed to only copy data once into the
>   transfer buffers.
> 
> I tested this on a couple of Chromebooks with i2c-hid touchscreens, but
> it would be great if other folks tried it out as well.

Benjamin,

is this something you could feed into your testing machinery as well? (not 
sure whether it's handling i2c-hid specifics).

Thanks!

-- 
Jiri Kosina
SUSE Labs

