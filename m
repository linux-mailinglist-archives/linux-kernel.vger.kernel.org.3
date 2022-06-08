Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA47E542248
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiFHDGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376557AbiFHDCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:02:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD29C1F5C40
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654648250; x=1686184250;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CAEs+eNkcEk5PucMiRuUH9VvF5OOvLGOLrW/nucQ0t0=;
  b=hlqoD294Eet11KRqzeOH3CsXk5uBGMkIHyKxuuv3Fie31r6/Co04ZZST
   AzJQYuqyVFXsmi5nPepu+wWvUO15d/eND0gtEhgRWCQeAv842LOfgrAZ3
   tNNKEMD0M7lRDsTg+GSVguPCXPEgPIm6YNfeyrN3BPeSXZRmQi1u90W9a
   zFbivoYMFqaKa+dNSNsQDGrJv+ia7N/ZkJd6ZTDvhRV6q0e6cLRhQ/GED
   +rkZ2orxY/gX9qEabWjU8++mzfFYey+EQEt1c18burp6l9tGeSYOz4wsf
   v8v8NXYhkno7yqs6Tyo1v0JaLXMa4QvrEOb86d1Tz7z8Nt3YNqRgFPmut
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257206797"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="257206797"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 17:27:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="532864405"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 17:27:46 -0700
Date:   Tue, 7 Jun 2022 17:27:38 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Mark Brown <broonie@kernel.org>
cc:     Tianfei Zhang <tianfei.zhang@intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, hao.wu@intel.com, trix@redhat.com,
        yilun.xu@intel.com, russell.h.weight@intel.com
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
In-Reply-To: <Yp9PdZn2Xu/oqiA8@sirena.org.uk>
Message-ID: <alpine.DEB.2.22.394.2206071714420.3001206@rhweight-WRK1>
References: <20220607013755.594554-1-tianfei.zhang@intel.com> <Yp9PdZn2Xu/oqiA8@sirena.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Jun 2022, Mark Brown wrote:

> On Mon, Jun 06, 2022 at 09:37:55PM -0400, Tianfei Zhang wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> This patch adds support for regmap APIs that are intended to be used by
>> the drivers of some devices which support generic indirect register access,
>> for example PMCI (Platform Management Control Interface) device, HSSI
>> (High Speed Serial Interface) device in FPGA.
>
> What is "generic indirect register access"?  I'm not clear what this is
> intended to support...

"indirect register access" is a RTL design pattern we use in FPGAs 
frequently.  The design pattern involves a small number of registers plus 
a little handshake code to access various register spaces inside the FPGA 
fabric.  The design pattern is "generic" in the sense that the same small 
number of registers and handshake can be used with many different IP 
components in the FPGA.  Historically, the bit definitions and handshaking 
was slightly different for each IP component.  This is an attempt at a 
consistent usage across IP components.

Would a different name help?


>
>> +static int indirect_bus_clr_cmd(struct indirect_ctx *ctx)
>> +{
>> +	unsigned int cmd;
>> +	int ret;
>> +
>> +	writel(0, ctx->base + INDIRECT_CMD_OFF);
>> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
>> +				 (!cmd), INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
>> +	if (ret)
>> +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn", __func__, cmd);
>
> ...and this doesn't look particularly generic, it looks like it's for
> some particular controller/bridge?
>
