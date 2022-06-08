Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDC542F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiFHLcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiFHLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D5414E976;
        Wed,  8 Jun 2022 04:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE90B82724;
        Wed,  8 Jun 2022 11:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BACC34116;
        Wed,  8 Jun 2022 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654687967;
        bh=1uftfzM/OH3g6hsphmAGcj+g53TBb2xEn+h7XD8wIXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzW80vMVeferu94vUepvuAucLkezHIfAfxN2yMrfCPBKV8HV2Y3ivQOJ1AREemXht
         04JlnpPqgpdkk3CqUpmmSHXyR07zaydqN9EoxOvhF1oQr1sQTpYtJU9jt3PTh7MHsd
         yMcgpoF9LRKxIcWn3fSA3ltUasCkel/vhPLt9Ge0=
Date:   Wed, 8 Jun 2022 13:32:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child()
 helper
Message-ID: <YqCI3N6+fRtoK66D@kroah.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:20:57PM +0300, Andy Shevchenko wrote:
> There are several places in the kernel where this kind of functionality is
> being used. Provide a generic helper for such cases.

This feels really wrong/broken.

There should not be any specific ordering of children in the tree.  What
subsystem relies on this such that they require this?

thanks,

greg k-h
