Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3750B8D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447952AbiDVNpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiDVNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:45:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3279C57146;
        Fri, 22 Apr 2022 06:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1631B82D82;
        Fri, 22 Apr 2022 13:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29452C385A8;
        Fri, 22 Apr 2022 13:42:09 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:42:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: document the boot requirements for MTE
Message-ID: <YmKwrs3dJ09ybBJa@arm.com>
References: <20220404211858.968452-1-pcc@google.com>
 <Ykv39KMpKXb2Mr6p@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykv39KMpKXb2Mr6p@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:04:04AM +0100, Mark Brown wrote:
> On Mon, Apr 04, 2022 at 02:18:58PM -0700, Peter Collingbourne wrote:
> 
> > +  For CPUs with the Memory Tagging Extension feature:
> > +
> > +  - If EL3 is present:
> > +
> > +    - SCR_EL3.ATA (bit 26) must be initialised to 0b1.
> > +
> > +  - If the kernel is entered at EL1 and EL2 is present:
> > +
> > +    - HCR_EL2.ATA (bit 56) must be initialised to 0b1.
> 
> Very nitpicky but this is only required for FEAT_MTE2 and above, plain
> FEAT_MTE doesn't have these traps.  I don't know that this is a thing
> that anyone's actually implemented

I think that's a valid point. CPUs may implement FEAT_MTE2 but downgrade
it to FEAT_MTE if the SoC does not provide allocation tag storage. So we
should make it clear here that only from FEAT_MTE2 we should set those
bits (ID_AA64PFR1_EL1.MTE >= 2), otherwise they should be 0 or
hyp/firmware risks the OS triggering random external aborts.

> and from v8.7 on it's not permitted but the above isn't strictly true
> if someone did for some reason have the most basic version.

The wording is tricky: "This feature is mandatory from Armv8.7 when
FEAT_MTE2 is implemented". So one can still implement FEAT_MTE (or none
at all).

-- 
Catalin
