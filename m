Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D94583B43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiG1JdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiG1JdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949995722F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F5E60CA4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9498EC433D6;
        Thu, 28 Jul 2022 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659000778;
        bh=B64PNPMHo0v7zf8zYBmrD6VrCGl/TMz1fhYfdgxAAEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeKdK/L8SiQjQTFsshQcyaMCiDo5AkYAS5C0O03oRJTCn8hZuNXq2jKcimwMRDNje
         imWJREmxa9efv5C/zVG1s3XYi2cBfwGTsaYg/7Y0N8PPu90sJDEOLx6efdv0en9Tdo
         ZahlzGo18d4z9Mg7LKMLApnMhSAyB0XUgtnp6GPGdEcjkb55solA6V47kAKdklUQnj
         Pw1GZh0WbbQmxx/RKxnmszctIUOCq65Po5nUoFcBy7vef4c9Ye8vV7ars4k9UkYvUj
         eZ9nNN7Ol9xTZUBbwAfIzflzXXK2wbONZz0GJi0/NI0L1PomrNlwX5W08mS5+l/Ly4
         ClNJNUuNKun7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oGztH-0005Zx-RD; Thu, 28 Jul 2022 11:33:11 +0200
Date:   Thu, 28 Jul 2022 11:33:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] irqdomain: Fix mapping-creation race
Message-ID: <YuJX1+0GmUBOe133@hovoldconsulting.com>
References: <20220728092710.21190-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728092710.21190-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:27:10AM +0200, Johan Hovold wrote:
> Parallel probing (e.g. due to asynchronous probing) of devices that share
> interrupts can currently result in two mappings for the same hardware
> interrupt to be created.
> 
> Add a serialising mapping mutex so that looking for an existing mapping
> before creating a new one is done atomically.
> 
> Note that serialising the lookup and creation in
> irq_create_mapping_affinity() would have been enough to prevent the
> duplicate mapping, but that could instead cause
> irq_create_fwspec_mapping() to fail when there is a race.
> 
> Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
> Fixes: b62b2cf5759b ("irqdomain: Fix handling of type settings for existing mappings")
> Cc: Dmitry Torokhov <dtor@chromium.org>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Here's some more background on how I ran into this:

Link: https://lore.kernel.org/r/YuJXMHoT4ijUxnRb@hovoldconsulting.com

Johan
