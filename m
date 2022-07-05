Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870E2566C88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiGEMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiGEMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:08:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642D23C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657022917; x=1688558917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t4bnxIAlzIQEOHmXOwgyLjmHsBOSElXHODbbcY2VNkY=;
  b=lLtQ//xWjgLBO1lr8GsI7pVE/sClqvI50avt8ugDP+FJtdFWp9fbMuY+
   tDNWMrq+BFAl4c2JaOygSL8AuVZFtdGyegzM44yLA+4fnDvOSWbvr8JNk
   T9CwmZ4+f3DkSKG8RC0H8QG/+rgclUY/RVsAPFYGx8ep803uP2qDNIqBX
   r3Khic1jcQEBH84IuzgURc/EeTmuCDkwLDApUN1WAj/Tjt8l5IclAh97j
   DtaDMS9oXuJ4bKBBNNXkTxk26CMJ0iJiKOan80Qs8Sc/btAbRKdDXFGWT
   BGsN5JM5HwFDlfp0LcHyqqBiuI3Zvy+kAApD8jFXdl5g2qrPAbstuwRSE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369658927"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="369658927"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:08:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="590379430"
Received: from kszenk-mobl.ger.corp.intel.com (HELO [10.249.254.134]) ([10.249.254.134])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:08:33 -0700
Message-ID: <21522ae3-96a3-ce07-6466-89cbf6c67a9f@linux.intel.com>
Date:   Tue, 5 Jul 2022 15:09:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/1] ASoC: SOF: Intel: bdw: remove duplicating driver
 data retrieval
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20220703143533.62173-1-andriy.shevchenko@linux.intel.com>
 <91f156ba-5d93-63d6-5fa0-86614bc370d3@linux.intel.com>
 <YsMTHTcOWX4Q3W7f@smile.fi.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <YsMTHTcOWX4Q3W7f@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/07/2022 19:19, Andy Shevchenko wrote:
> On Mon, Jul 04, 2022 at 10:31:48AM +0300, Péter Ujfalusi wrote:
>> On 03/07/2022 17:35, Andy Shevchenko wrote:
> 
> ...
> 
>> +	return sof_acpi_probe(pdev, (const struct sof_dev_desc *)id->driver_data);
>>  }
> 
>> We don't use the desc in sof_broadwell_probe(), so we can just pass the id->driver_data
> 
> I prefer not to cast inside the function parameters when it's not about POD.

Fair enough.

How about assigning desc before it is used?

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 26df780c702e..a446154f2803 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -681,11 +681,8 @@ static int sof_broadwell_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	desc = device_get_match_data(dev);
-	if (!desc)
-		return -ENODEV;
-
-	return sof_acpi_probe(pdev, device_get_match_data(dev));
+	desc = (const struct sof_dev_desc *)id->driver_data;
+	return sof_acpi_probe(pdev, desc);
 }
 
 /* acpi_driver definition */



-- 
Péter
