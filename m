Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1882A582D97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiG0RAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiG0Q7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:59:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD4E67CAB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658939837; x=1690475837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Xu6IgGf7EmqEfszrQvOKIjQaHODWfI38AJXg11+tcA=;
  b=LdcmHtpdDxppgPmOvqfnDo1TKA+q+7C9clzYiQcZURl4uiD2ZmTq1jZS
   QPU4r3tVPvYmvTX5zyZgJwhtdqp+gfAz571lB6EP/DfVF9Kbw8KEoEgFt
   cNl2LpvwIEVKofPrz/HzWT3fDojCzWpHFR8pyHL1/y3wsNPntzU+cCaZH
   A+SYsGco5TxJ/FRjC99zt1WkOw8HnIGoDYXNDoJMu7kYzw/iot5w8GRkR
   hSdGDi0Lrn0sNKmNeoEpaSYY8rUgIpVU3TFTXF3aKya3UgL2DnFLVNx+g
   7fBPAC6I1Hr7SbLaclyVFD/iaOvDSVVby4Aic6H2J8NRcWaL/W+NnST6Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="352279806"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="352279806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 09:36:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="628450023"
Received: from lgumar-mobl.amr.corp.intel.com (HELO [10.209.151.195]) ([10.209.151.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 09:36:44 -0700
Message-ID: <69713155-39b0-5492-4966-73dfdacd1fc1@linux.intel.com>
Date:   Wed, 27 Jul 2022 11:36:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: Intel: cirrus-common: Use UID to map correct amp
 to prefix
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Brent Lu <brent.lu@intel.com>, xliu <xiang.liu@cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
References: <20220727160051.3373125-1-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220727160051.3373125-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +/*
> + * Expected UIDs are integers (stored as strings).
> + * UID Mapping is fixed:
> + * UID 0x0 -> WL
> + * UID 0x1 -> WR
> + * UID 0x2 -> TL
> + * UID 0x3 -> TR
> + * Note: If there are less than 4 Amps, UIDs still map to WL/WR/TL/TR. Dynamic code will only create
> + * dai links for UIDs which exist, and ignore non-existant ones.

is this intentional to support all variations of 1,2,3 and 4 amplifiers
being present?

Or is the intent to really support 2 or 4?

> + * Return number of codecs found.
> + */
> +static int cs35l41_compute_codec_conf(void)
> +{
> +	const char * const uid_strings[] = { "0", "1", "2", "3" };
> +	unsigned int uid, sz = 0;
> +	struct acpi_device *adev;
> +	struct device *physdev;
> +
> +	for (uid = 0; uid < CS35L41_MAX_AMPS; uid++) {
> +		adev = acpi_dev_get_first_match_dev(CS35L41_HID, uid_strings[uid], -1);
> +		if (!adev) {
> +			pr_warn("Cannot find match for HID %s UID %u (%s)\n", CS35L41_HID, uid,
> +				cs35l41_name_prefixes[uid]);

A warning is a bit strong if some valid configurations don't expose all
4 codecs.

> +			continue;
> +		}
> +		physdev = get_device(acpi_get_first_physical_node(adev));
> +		cs35l41_components[sz].name = dev_name(physdev);
> +		cs35l41_components[sz].dai_name = CS35L41_CODEC_DAI;
> +		cs35l41_codec_conf[sz].dlc.name = dev_name(physdev);
> +		cs35l41_codec_conf[sz].name_prefix = cs35l41_name_prefixes[uid];
> +		acpi_dev_put(adev);
> +		sz++;
> +	}
> +	return sz;
