Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFF054D21D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350230AbiFOTzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbiFOTzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:55:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8232229345;
        Wed, 15 Jun 2022 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8/XljWZrmcL2YdcuWDBrkYF7wQr7RHmdlPcVPREXheY=; b=Smg02axWWFOzSLkQ1MAheC7JEP
        SJ/CKjft9dSD4tgHQ/prrWKSi+UjVmSJukWNZvgcLeZ/4NRVD8QwO2fI5+rqTGoVNHHl7MMcIFhTk
        dz/zDpWCjZ0e1FaJLuJqP1ulojg090QLnCsRWhfPkBlUFFzQXA+8eb0P8fIbDIIXo+G6zIsXoGemo
        WKfbIpKoBvMosBfiHcZxiVbHhLd6ObgW6JD27G+xQCaZ3LFBCollqX4w7j7tBIy0gVmCLEyaW1DZr
        bW8e7xcWBrjUAPUnlP/bI3E2i3CGj3pak2Bvy1I3Q1YsOwF9mQEMr4Cf+rWPDsmiw86SrXTzsf+Lo
        ENCq9NQw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Z6S-008D8F-P3; Wed, 15 Jun 2022 19:55:03 +0000
Message-ID: <0480d917-94e5-20ab-514c-bb1374a8d9c4@infradead.org>
Date:   Wed, 15 Jun 2022 12:54:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220615101920.329421-14-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/15/22 03:19, Pankaj Raghav wrote:

> ---
>  drivers/md/Kconfig                |   9 +
>  drivers/md/Makefile               |   2 +
>  drivers/md/dm-zone.c              |   9 +
>  drivers/md/dm-zoned-npo2-target.c | 268 ++++++++++++++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 drivers/md/dm-zoned-npo2-target.c
> 
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 998a5cfdb..773314536 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -518,6 +518,15 @@ config DM_FLAKEY
>  	help
>  	 A target that intermittently fails I/O for debugging purposes.
>  
> +config DM_ZONED_NPO2
> +	tristate "Zoned non power of 2 target"

	         "Zoned non-power-of-2 target"

> +	depends on BLK_DEV_DM
> +	depends on BLK_DEV_ZONED
> +	help
> +	A target that converts a zoned device with non power of 2 zone size to

	                                           non-power-of-2 zone size to

> +	be power of 2. This is done by introducing gaps in between the zone
> +	capacity and the power of 2 zone size.

All help text should be indented with one tab and 2 spaces
according to Documentation/process/coding-style.rst.

> +
>  config DM_VERITY
>  	tristate "Verity target support"
>  	depends on BLK_DEV_DM

[snip]

> +
> +MODULE_DESCRIPTION(DM_NAME " non power 2 zoned target");

                                non-power-of-2

> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
> +MODULE_LICENSE("GPL");
> +

-- 
~Randy
