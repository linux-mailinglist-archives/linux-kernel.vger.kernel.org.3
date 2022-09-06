Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E94F5AE529
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiIFKTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiIFKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:19:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1B13F68;
        Tue,  6 Sep 2022 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662459589; x=1693995589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6UdNMQf5P67R/SO0iHPymVmNTSuQksayz5cRGz3hf98=;
  b=HWiXpcygIoHGIFr5o4X2yshP1qbPHT+DQxduzXt2iI4iDv8KM0XlOXRt
   CHFGcum5WGZtsNAQBRscH/Afqah000Gn22P4YzlxiWE2qjyQg7MmF7e4D
   K+u20z7IweYP9MWqHBCMiovRUZqLWx7+dV+oMwmPJajQD2yFFzJt3qsak
   LHxZqdyvDwoTe0D034pzn+f0LJm5SlXvjnIy2/niedA+nClss1w0/DliV
   p4d8fgZK+LuaHdO4UQQlpztJXksHEZkTRifaVjCYZ7i+6yf8NYWRLccae
   WXXkrMbE4IprW170Yo0AAXXY+RsPZzADtrA/T9tPn6HL9eLaNUpI6SAra
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276296550"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="276296550"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 03:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="616663274"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Sep 2022 03:19:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1B3A314F; Tue,  6 Sep 2022 13:20:02 +0300 (EEST)
Date:   Tue, 6 Sep 2022 13:20:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     YehezkelShB@gmail.com, gregkh@linuxfoundation.org,
        mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v9 6/6] thunderbolt: Add support for ASMedia image format
Message-ID: <Yxce0WshoIgS7zBz@black.fi.intel.com>
References: <20220906101128.6504-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906101128.6504-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 06:11:28PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> Hi,
> 
> >  
> > +static int asmedia_switch_nvm_version(struct tb_nvm *nvm) {
> > +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = tb_switch_nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
> > +	if (ret)
> > +		return ret;
> > +
> > +	nvm->major = (val << 16) & 0xff0000;
> > +	nvm->minor |= val & 0x00ff00;
> 
> 	nvm->major

Heh, that one was clearly a copy paste error ;-)

I will fix it up when applying. Thanks for checking.
