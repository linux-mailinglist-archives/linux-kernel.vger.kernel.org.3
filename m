Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDB53BAEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiFBOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiFBOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:39:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAABE26D356;
        Thu,  2 Jun 2022 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654180737; x=1685716737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6FLATGDBi3yu7IKVmGaVFcjGWShYzk2UB4TqoSCIdfA=;
  b=jH4uWiY1yQANMAAM4GEdzqVipfNpKyKcTglPAoaWDb8TyCmFlLEXpgjE
   gb0mg5bGVLII5mBibJZR9Ie5MkH0if0wOILC9L8nSDq1FQK4FjdzkHOg/
   4crpLC1AVvaSywD3eZdgjt65jNGR2REQtc+nyWzVIKB8MGRIHu2P/8zIH
   E8zkxc3ufVrEI2Hg/6uAWXwwiVA8rWm9ZohvBr6RaXIFFUXu0onwpo38o
   335bEC2IUk0Y1Q8otY6tT2Mgci1NR0E5IIkEafqNMYP77WvtT32GEwg02
   A65TzQIDAP7PwN4QJL3Ll9WMn5OGOqUYHy+ausCJ4NDnaa06vcfVwxgga
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="256445683"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="256445683"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 07:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="552868014"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga006.jf.intel.com with ESMTP; 02 Jun 2022 07:38:38 -0700
From:   wen.ping.teh@intel.com
To:     robin.murphy@arm.com
Cc:     catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dinguyen@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, wen.ping.teh@intel.com, will@kernel.org
Subject: Re: [PATCH] arm64: dts: Add support for Stratix 10 Software Virtual Platform
Date:   Thu,  2 Jun 2022 22:38:16 +0800
Message-Id: <20220602143816.3432427-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7439ce39-a2c2-7310-27d3-08ba2ed75ac9@arm.com>
References: <7439ce39-a2c2-7310-27d3-08ba2ed75ac9@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wen.ping.teh@intel.com=0D

Hello Robin,=0D
=0D
>> +/ {=0D
>> +	model =3D "SOCFPGA Stratix 10 SWVP";=0D
>> +	compatible =3D "arm,foundation-aarch64", "arm,vexpress";=0D
>=0D
>This is definitely not compatible with any Arm Versatile Express =0D
>platform. It doesn't even have RAM in the same place, for starters.=0D
=0D
Will change to the correct platform i.e. "altr,socfpga-stratix10"=0D
=0D
>> +		l2-cache@fffff000 {=0D
>> +			compatible =3D "arm,pl310-cache";=0D
>=0D
>Yikes, I hope not!=0D
>=0D
>I didn't think AArch64 even allows outer caches that don't honour CPU =0D
>cache maintenance by VA? Either way I can't imagine we'd ever accept =0D
>PL310 support in mainline, so even if your model does actually have this =
=0D
>for some inexplicable reason, I don't think there's any point exposing =0D
>it in the DT.=0D
=0D
Will remove outer cache.=0D
All fixes have been done in v2 patch.=0D
https://lore.kernel.org/linux-arm-kernel/20220602141151.3431212-1-wen.ping.=
teh@intel.com/T/#u=0D
=0D
Thanks,=0D
Wen Ping=
