Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1851748C8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349710AbiALQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:45:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:50789 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239986AbiALQpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642005949; x=1673541949;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fRrm1uZQrkX3U3iwIWdjmqt0HX6DyiPt9SbTXaP/1Wc=;
  b=HTKZ3aLCE9tiqRg8Y6pz0iA1f/hXRJLz5dClu/uOUCkb0bTPn67T2JAD
   XAEF+9Tq9BaChZxR9nGKQDi7MKHXY1Jobc2i24mrLnW3YrnhHe2/qTgqW
   ikPzTEv0sHoQjG2tzyCBeXN7L37okVLjettbwoRuIwAk0/w5Kz1z9/JIm
   afTWXcQvplcn7eMotbPzTZ1qUl6Wfb3giPqX1TnjmNJfB/U+f8ouAiQPx
   aTptiq5F8deAyV6Pf+upilLEtbUe+BgKSWI06LrEnvln+qXQ+EbLITrVr
   WHZi0Q5U9wpstSbtuAjMBfcdYThTFmHsnhpyGHKU2HwxvRNvvd6zgQ0XJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="231120289"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="231120289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 08:42:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="529248449"
Received: from rfriess-x1c10.amr.corp.intel.com (HELO [10.212.33.247]) ([10.212.33.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 08:42:05 -0800
Subject: Re: [PATCH v2 0/1] firmware: mtk: add adsp ipc protocol for sof
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        cujomalainey@google.com, Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20220112113247.29135-1-allen-kh.cheng@mediatek.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <61ba06c7-74e4-03f9-2fe7-f12f862c7942@linux.intel.com>
Date:   Wed, 12 Jan 2022 10:42:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112113247.29135-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/22 5:32 AM, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch provides mtk adsp ipc support for sof.
> 
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> changes since v1:
> - add comments for mtk_adsp_ipc_send and mtk_adsp_ipc_recv
> - remove unuseful MODULE_LICENSE
> - change label name to out_free

my comment was not on changing the label name, but making sure you only
free something that was allocated by using *two* labels.

> 
> Allen-KH Cheng (1):
>   firmware: mediatek: add adsp ipc protocol interface
> 
>  drivers/firmware/Kconfig                      |   1 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/mediatek/Kconfig             |   9 +
>  drivers/firmware/mediatek/Makefile            |   2 +
>  drivers/firmware/mediatek/mtk-adsp-ipc.c      | 159 ++++++++++++++++++
>  .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
>  6 files changed, 237 insertions(+)
>  create mode 100644 drivers/firmware/mediatek/Kconfig
>  create mode 100644 drivers/firmware/mediatek/Makefile
>  create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
>  create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h
> 
