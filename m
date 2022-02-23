Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44B4C1B31
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbiBWS4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbiBWS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:56:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532323F313;
        Wed, 23 Feb 2022 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645642547; x=1677178547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RimaKXFhr9mzukP4fNaT0hhnC3zqMaGlaLRl4CVVfDA=;
  b=EkILOzoyt++6gRKq/aNdDrAjgnIXqSd6c4EkEqSOX9OjIfO1NvoSEAlL
   y4p2Ripu5Oxq5Q2L5aZoUiqIXWiSehkwayf2cpo9gQqsmV/Pjs2+KKQH0
   46vZU7PQapUVC8GtbkXbg6Z+QWPDHiTHd5FO5FC+NJiXwt+xppwADW5Py
   p7G29tdBPkBnU/ZzetbJkTjPbyrS+eyrX0jPHPj9OKXiZ1Pi90CfwwKpS
   UTletKk7Fy08ZL86yeVoDPl1bbsfv/eGEEPmNaW1oPkYTOglr9yDud/vx
   dV/fTyzvlAARVIh8AVLrCYOV8K076IrzYmuM2lb7yXXqxsOucJ6s6acCD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251792693"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="251792693"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:55:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491319477"
Received: from aacunaco-mobl1.amr.corp.intel.com (HELO [10.209.144.93]) ([10.209.144.93])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:55:39 -0800
Message-ID: <d0b57e7b-3591-ee7c-c77b-02e328dba752@linux.intel.com>
Date:   Wed, 23 Feb 2022 12:21:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] soundwire: qcom: add runtime pm support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
 <20220221104127.15670-2-srinivas.kandagatla@linaro.org>
 <70db9c01-104e-e081-198e-0b6d8a1c17da@linux.intel.com>
 <1e532280-5388-157b-8e2d-2ca8b2619f37@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1e532280-5388-157b-8e2d-2ca8b2619f37@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> There are two cases here.
> 
> 1> Controller Instance support ClockStop Mode0, we mostly use the
> generic core to do that except in resume path we make sure that we start
> the clock.
> 
> 2> Controller Instances which that do not support ClockStop, we do soft
> reset of controller along with hard resetting slaves.

both are fine. we have similar cases defined in sdw_intel.h



>>> +static int swrm_runtime_resume(struct device *dev)
>>> +{
>>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
>>> +    int ret;
>>> +
>>> +    clk_prepare_enable(ctrl->hclk);
>>> +
>>> +    if (ctrl->clk_stop_bus_reset) {
>>> +        reinit_completion(&ctrl->enumeration);
>>> +        ctrl->reg_write(ctrl, SWRM_COMP_SW_RESET, 0x01);
>>> +        qcom_swrm_get_device_status(ctrl);
>>
>> don't you need some sort of delay before checking the controller and
>> device status? The bus reset sequence takes 4096 bits, that's a non-zero
>> time.
> 
> This is soft reset not full Bus Reset as WSA slaves have hard reset pins
> that will be toggled as part of suspend-resume.

Above you mentioned the peripherals go through a reset as well, in which
case they can only re-attach on the bus after 16 frames best case - they
need to observe a full cycle of the dynamic sync before changing status.

That's still a non-zero delay (0.3ms for a 48kHz frame rate)

>>
>>> +        sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>>> +        qcom_swrm_init(ctrl);
