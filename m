Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B841952B2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiERGo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiERGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF2A56771
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9E760B59
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3902BC385A9;
        Wed, 18 May 2022 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652856293;
        bh=txZ4z5P32rfkA6Qk2rJ6GxCKmY0Sp1SypywZSzeV0iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyNzP+QXv4E8NGBYrVExSrcrfy/AG8MOTmHfU+SHQWuxtDlZCyH8MRidSFNd30g0G
         yNFoGkGvDEYKh4D8r20z1KlSqQH7bSAU1cbKBujM3QGMHrzy399hmoHskSMm4/fu5G
         OmEopLm7xURtxDkTQdP6EcwYFHRjjUQA8OkBk6mE=
Date:   Wed, 18 May 2022 08:44:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
        mchehab+huawei@kernel.org, eugenis@google.com, tony.luck@intel.com,
        pcc@google.com, peterz@infradead.org, marcos@orca.pet,
        conor.dooley@microchip.com, nicolas.ferre@microchip.com,
        marcan@marcan.st, linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/8] x86: Add hardware prefetch control support for x86
Message-ID: <YoSV4CPBXbNlj0Cq@kroah.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-7-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518063032.2377351-7-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:30:30PM +0900, Kohei Tarumizu wrote:
> Adds module init/exit code to create sysfs attributes for x86 with
> "hardware_prefetcher_enable", "ip_prefetcher_enable" and
> "adjacent_cache_line_prefetcher_enable".
> 
> This driver works only if a CPU model is mapped to type of register
> specification(e.g. TYPE_L12_BASE) in pfctl_match[].

How will the driver be automatically loaded if this is the case or not?
You can not rely on userspace knowing to load a driver on its own,
please tie into the proper device discovery.

thanks,

greg k-h
