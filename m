Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F650EC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiDYWtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiDYWtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C846D113CA0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618E261501
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56360C385A4;
        Mon, 25 Apr 2022 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650926777;
        bh=cd0i7Ed7NfQR2dxq3htXK+1jeF/yThtG7IB0nBQjI8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C/VDS2X89Mr7VvHFrRiRf9PhnLM2U7ovAFnVaGqKENuVhFG58o6cXrPXGdQBSKGfh
         xLdv7BNytJ+yhc0kShrKAzuYLKWkJBDi9Q7qswvFVtU0zQUmRzwQ7L+27eB5qB6U/E
         LLsrdu9FuuNaHBPbqPwirFWwECyBg/r8gsQE7ZVY=
Date:   Mon, 25 Apr 2022 15:46:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH] topology/sysfs: Hide PPIN on systems that do not
 support it.
Message-Id: <20220425154616.a0e38aea35649d13d5afb5d4@linux-foundation.org>
In-Reply-To: <20220406220150.63855-1-tony.luck@intel.com>
References: <Yfhbj7Q99dqRIYaL@zn.tnic>
        <20220406220150.63855-1-tony.luck@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Apr 2022 15:01:50 -0700 Tony Luck <tony.luck@intel.com> wrote:

> Systems that do not support a Protected Processor Identification Number
> currently report:
> 
> 	# cat /sys/devices/system/cpu/cpu0/topology/ppin
> 	0x0
> 
> which is confusing/wrong.
> 
> Add a ".is_visible" function to suppress inclusion of the ppin file.
> 
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -152,9 +152,21 @@ static struct attribute *default_attrs[] = {
>  	NULL
>  };
>  
> +static umode_t topology_is_visible(struct kobject *kobj,
> +				   struct attribute *attr, int unused)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +
> +	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>  static const struct attribute_group topology_attr_group = {
>  	.attrs = default_attrs,
>  	.bin_attrs = bin_attrs,
> +	.is_visible = topology_is_visible,
>  	.name = "topology"
>  };

x86_64 allnoconfig:

drivers/base/topology.c: In function 'topology_is_visible':
drivers/base/topology.c:158:24: warning: unused variable 'dev' [-Wunused-variable]
  158 |         struct device *dev = kobj_to_dev(kobj);
      |                        ^~~

I suggest this be fixed in the topology_ppin() stub implementation.  Do
it as a nice inlined C function which avoids such problems.  Rather
than as a crappy macro which causes them...

