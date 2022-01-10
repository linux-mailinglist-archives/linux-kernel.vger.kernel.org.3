Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738FB489DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiAJQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:49:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:50943 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237732AbiAJQtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641833364; x=1673369364;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RD9okIjLSTH7xkAaitQ8zmG3R2QSjQPLZHJurvli5Ng=;
  b=TGRQGLeQO9nWr4vrwHBz+78BtY7l7pKdABjcRL2GCwpyjHgQr1QHW+uf
   fF15I9n9l2HL8SR6LZw6df19B8+YqVqDQPMqOWd8Kx2hYZs0rXA7zZJoz
   otzCYNg65i16TXpdpSKlWzEsZtY/Tybvvog3XsHCYECo/QEK9Uh/S9C1g
   161SStBN12eNGQBBdmXsFjKswFl6KqKnv2YdoPqno+dcRr2z+/Z1c5l+n
   +ffXlkPP4kubd3cnQqFHpaulm1ZG+FtKLaTmFcZOFoKU8IkTlTnejMVHU
   1MVh2Av7byisK8dfO0H2bNV7zPB9yTotAz4PNw4EgvQ2tXUfh6HkKkpSK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="243219152"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243219152"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 08:49:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="472123479"
Received: from boviedox-mobl.amr.corp.intel.com (HELO [10.212.36.191]) ([10.212.36.191])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 08:49:11 -0800
Subject: Re: [PATCH 7/7] soundwire: intel: remove PDM support
To:     "Liao, Bard" <bard.liao@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-8-yung-chuan.liao@linux.intel.com>
 <YcQeRJ060/u4n6fR@matsya>
 <DM6PR11MB4074FEE19010B83F0CDDE8A9FF7E9@DM6PR11MB4074.namprd11.prod.outlook.com>
 <YcRX4ehgXZIWx3jf@matsya>
 <DM6PR11MB407458F1824D52BFD0D9ED96FF7E9@DM6PR11MB4074.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0cb18de1-dcff-e3c8-414e-b5b96b30b387@linux.intel.com>
Date:   Mon, 10 Jan 2022 10:32:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB407458F1824D52BFD0D9ED96FF7E9@DM6PR11MB4074.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> While the hardware supports PDM streams, this capability has never
>>>>> been tested or enabled on any product, so this is dead-code. Let's
>>>>> remove all this.
>>>>
>>>> So no plans to test and enable this? Do the DMICs not use PDM?
>>>
>>> The point is that this code is unused/untested. We can re-add it after
>>> it was tested.
>>
>> That does not answer my question. Do the DMICs not use PDM?
> 
> I will leave the question to Pierre. 😊

traditional digital microphones using the Nokia spec with two
microphones using opposite clock edges do use PDM.

PDM over SoundWire is possible as well, it's e.g. used by Qualcomm for
amplifiers. This patch does not make a statement on whether PDM support
makes sense or not in general.

As mentioned above on Intel platforms the hardware is in theory capable
of supporting PDM, but that capability has never been deployed, all
existing devices we connect to are PCM based and all the PDM references
are essentially untested - and likely broken.

