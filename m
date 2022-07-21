Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2C57CFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiGUPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiGUPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:42:06 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5068F1BEBE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:38:23 -0700 (PDT)
Received: from lantia.sysgo.com ([172.20.1.5]:49028)
        by mail.sysgo.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <vit.kabele@sysgo.com>)
        id 1oEYFi-00083o-2H;
        Thu, 21 Jul 2022 17:38:14 +0200
Date:   Thu, 21 Jul 2022 17:38:13 +0200
From:   Vit Kabele <vit.kabele@sysgo.com>
To:     Borislav Petkov <bp@alien8.de>, Vit Kabele <vit@kabele.me>
Cc:     platform-driver-x86@vger.kernel.org, r.marek@assembler.cz,
        x86@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH v2] arch/x86: Check validity of EBDA pointer in mpparse.c
Message-ID: <Ytly5ZArTaVAIKNq@czspare1-lap.sysgo.cz>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
        Vit Kabele <vit@kabele.me>, platform-driver-x86@vger.kernel.org,
        r.marek@assembler.cz, x86@kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, mingo@redhat.com
References: <CAJZ5v0gBbdzUO9MRxbKESEnaeaNAu-+3oP6ADMretch=iHPNJA@mail.gmail.com>
 <Yk/2dh4kDobivStp@czspare1-lap.sysgo.cz>
 <YnFoIzmt1qJSucAd@zn.tnic>
 <YoIc1AHLK4pfR4AI@czspare1-lap.sysgo.cz>
 <YoP11ZNZv2/Z7B0g@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoP11ZNZv2/Z7B0g@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:21:57PM +0200, Borislav Petkov wrote:
> Why can't default_find_smp_config() simply scan the last KiB below
> 640KiB twice for the sake of simpler code?
The problem is not in scanning the last KiB twice. But when the
ebda start is between 639 and 640 KiB, we need to adjust the size of the
scan window like MIN(1024, 640 * 1024 - address), because we don't want
to bump into the memory above 640K.

This is obviously not a problem to do, but since we are talking about
+/- a few lines, I thought it is more readable like that.

> I.e., there needs to be a single get_bios_ebda() - the current one can
> be renamed to __get_bios_ebda() - and that get_bios_ebda() should give
> either a sane EBDA address or 0 if the checks don't pass. And all code
> should use that.
I can do that if you consider it better, but it is a little bit more
lines and some code has to be duplicated.  E.g. the
reserve_bios_regions() cares about MIN(bios_start, ebda_start), so it
needs to read the BIOS_RAM_SIZE_KB_PTR and check its sanity anyway.
Since this is basically the code that would be carved out to the new
get_bios_ebda() helper, we don't save anything.

-- 
Best regards,
Vit Kabele
