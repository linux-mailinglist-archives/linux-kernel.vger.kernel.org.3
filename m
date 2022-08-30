Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A3D5A65D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH3OAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiH3N7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:59:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953C9F770;
        Tue, 30 Aug 2022 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661867949; x=1693403949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tt3B7cRVLxseqIjnbKX6MRn1+KJVsxS6Zcsb8miRjlg=;
  b=KGM9NpEwVpE0OJToUTbAB7kQEEWd4l0RnVeIuxmINCl5jDvqwRPQIvIO
   GUU60Uuu0AW+MoGWbaACPqzpkz5sHIQHm6ytI0uzte30+/ekQSZahCwyR
   9fo2FeJ0HIN5QnQhkxSMEm3viXsrdnxFW4DvYD0IvDi/7wRMfKKAOzu5j
   LEShc+4zsxbzDrG+hjITbPQoc5LTrRQdIjReyGn3Y5WU/l1CRs82LmbgE
   rth3pH1meKecM+k6FreAAwk3XLqDAcs790flLqbOU+rFkqmGV0WZ/Yj/3
   bTXZL8jci147ZnUuVHeD0tby4AviCjVDXztGJ4FIvORVvxsWV35e20e5/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381476220"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="381476220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="672873323"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2022 06:59:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 70D76AD; Tue, 30 Aug 2022 16:59:21 +0300 (EEST)
Date:   Tue, 30 Aug 2022 16:59:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v7 0/3] thunderbolt: add vendor's NVM formats
Message-ID: <Yw4XuXdFQggNO+5c@black.fi.intel.com>
References: <20220829111059.665305-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829111059.665305-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 29, 2022 at 07:10:56PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch series for vendors to extend their NVM format.

Starts looking better now :) I sent a couple of comments in separate
emails please address those and also the comments you got from Greg and
Mario.

You can put the changelog here in the next iteration of the series.

> Szuying Chen (3):
>   thunderbolt: Add vendor's specific operations of NVM
>   thunderbolt: Modify tb_nvm major and minor size.
>   thunderbolt: To extend ASMedia NVM formats.
> 
>  drivers/thunderbolt/nvm.c    | 274 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c | 105 +++-----------
>  drivers/thunderbolt/tb.h     |  11 +-
>  3 files changed, 303 insertions(+), 87 deletions(-)
> 
> --
> 2.34.1
