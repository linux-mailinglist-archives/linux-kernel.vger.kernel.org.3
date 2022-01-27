Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E006B49DC09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbiA0H5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:57:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:59718 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbiA0H5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643270250; x=1674806250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ki0ykdkhJOf88ha9tOTvyUSb4E9LXGSO+yXsB3UEYNs=;
  b=aRBJqxOH/JOtimh6Ja5fL6KwkZCkEnEySk8A41cJ8EvN1AB1Pmtv+ova
   iAmdgdDzybcNdVgD5SwjoJ8HtnEiiaJgzSfJXiM84xZntEEOEfVQ2qrEb
   dzTAffTpDIKCNTM0/N9gkIDe3MmM0SKvoSWoEctlBE55pWN6xeVIw2C3t
   hQTQAvE2eqwBMGpB7ILrHJeYaDX5Lo5+boB97oRCEMOg1CGSd5KOZJjoO
   SgL7GmIWKvXproU0qdoSDqBNrEmN34p0Adu5pwZTc3eCXcfS+JA7CuSj/
   Trg6yPEo8HUHs2eM0UXJ4WZ86gqdcjZWpUjbpy2YULO7qqv+0TzYjAlpH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307494700"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="307494700"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:57:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="625131808"
Received: from anithaha-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.224.126])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:57:28 -0800
Date:   Wed, 26 Jan 2022 23:57:28 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 02/19] dma-buf-map: Add helper to initialize second map
Message-ID: <20220127075728.ygwgorhnrwaocdqv@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
 <20220126203702.1784589-3-lucas.demarchi@intel.com>
 <f0dbdcc0-13b5-c484-0bf3-a1f8c3e48954@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0dbdcc0-13b5-c484-0bf3-a1f8c3e48954@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:27:11AM +0100, Christian König wrote:
>Am 26.01.22 um 21:36 schrieb Lucas De Marchi:
>>When dma_buf_map struct is passed around, it's useful to be able to
>>initialize a second map that takes care of reading/writing to an offset
>>of the original map.
>>
>>Add a helper that copies the struct and add the offset to the proper
>>address.
>
>Well what you propose here can lead to all kind of problems and is 
>rather bad design as far as I can see.
>
>The struct dma_buf_map is only to be filled in by the exporter and 
>should not be modified in this way by the importer.

humn... not sure if I was  clear. There is no importer and exporter here.
There is a role delegation on filling out and reading a buffer when
that buffer represents a struct layout.

struct bla {
	int a;
	int b;
	int c;
	struct foo foo;
	struct bar bar;
	int d;
}


This implementation allows you to have:

	fill_foo(struct dma_buf_map *bla_map) { ... }
	fill_bar(struct dma_buf_map *bla_map) { ... }

and the first thing these do is to make sure the map it's pointing to
is relative to the struct it's supposed to write/read. Otherwise you're
suggesting everything to be relative to struct bla, or to do the same
I'm doing it, but IMO more prone to error:

	struct dma_buf_map map = *bla_map;
	dma_buf_map_incr(map, offsetof(...));

IMO this construct is worse because at a point in time in the function
the map was pointing to the wrong thing the function was supposed to
read/write.

It's also useful when the function has double duty, updating a global
part of the struct and a table inside it (see example in patch 6)

thanks
Lucas De Marchi
