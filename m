Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB834C303D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiBXPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiBXPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:45:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4607EA05;
        Thu, 24 Feb 2022 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645717524; x=1677253524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PzX96kduRIYE/gKPsTNuQPtzkDDYW6yJR2z6E96mZSY=;
  b=d0WERB3RAp/CicoT5flDd6VKqrW1FPZtctG3QR64XPg/X1id0vn9jQpY
   QyLRVXrvzPXr1Kyl96oN8JhNmD58urRoVPzxsiA5BseBEo766IvQhOQ7o
   LujrL3l4l9JBq0nrj59vNLENpbyLR71G0Iz+IXQDdPWr7qNmiZwakRJkM
   DCaLYFuLtvh3OtIhDXOhLpdFOW1Iw0kb9CnMElLmsqTs2tIQaLuaEsdOf
   Tf0/J65+e0/cU6jPofrqz4x12KItUSLSn6g7d9KfZmrPJLsWv17K9I8/V
   EoskBWfQZ5I3v69wHDTtcoDlpHyEHfH9/uAf0idEb8Oz49fvZrz+YeLd2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239663602"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239663602"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:45:08 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533178518"
Received: from ronakmeh-mobl1.amr.corp.intel.com (HELO [10.212.97.131]) ([10.212.97.131])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:45:07 -0800
Message-ID: <87f434b5-0e99-d1d1-e4d1-248cf35cd05c@linux.intel.com>
Date:   Thu, 24 Feb 2022 09:44:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] soundwire: qcom: add in-band wake up interrupt
 support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220224133125.6674-1-srinivas.kandagatla@linaro.org>
 <20220224133125.6674-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220224133125.6674-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/22 07:31, Srinivas Kandagatla wrote:
> Some of the Qualcomm SoundWire Controller instances like the ones that are
> connected to RX path along with Headset connections support Waking up
> Controller from Low power clock stop state using SoundWire In-band interrupt.
> SoundWire Slave on the bus would intiate this by pulling the data line high,

typo: initiate

> during clock stop condition.

while the clock is stopped.

A peripheral cannot generate an interrupt after a successful completion
of a write to the ClockStopNow bitfield.


