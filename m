Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACF56CE8F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGJKYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 06:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJKYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 06:24:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92680101F4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 03:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F2B3B80A2A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 10:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658B4C3411E;
        Sun, 10 Jul 2022 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657448686;
        bh=w7m3jDJj+v364kHW38aSZuC7EI6ALLFCYEuyEhaKXM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6LiU1gkY8U/MdYzfZYfZgeUR63DckW5+YfN89+2AqO43Il3UXalmmOyaGvbDz+BM
         nvZg+cDq/zhKx5O1za5vLP22XnJ8mJIhik+2qplliaHEubwL+Xan0sPHi+9yQ7IyO2
         KsjhRSY55Px/MJdTXSBQDCjWWiapm4JDijoys6Kg=
Date:   Sun, 10 Jul 2022 12:24:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Message-ID: <Ysqo6RjF/njUcOor@kroah.com>
References: <20220710101156.26139-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710101156.26139-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 12:11:56PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).

But that is not the case here for this kmap() instance?  If this is a
simple search/replace, why is this not just done once and be done with
it?

> Call kmap_local_page() in firmware_loader wherever kmap() is currently
> used. In firmware_rw() use the copy_{from,to}_page() helpers instead of
> open coding the local mappings plus memcpy().

Isn't that just a different cleanup than the kmap() change?  Or is that
tied to the fact that the other buffer is now allocated with
kmap_local_page() instead of kmap()?

> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/base/firmware_loader/main.c  | 4 ++--
>  drivers/base/firmware_loader/sysfs.c | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)

Did you run this through the firmware test framework?

thanks,

greg k-h
