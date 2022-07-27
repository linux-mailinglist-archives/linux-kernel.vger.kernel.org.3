Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3220583595
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiG0XTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiG0XTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:19:46 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5152DC9;
        Wed, 27 Jul 2022 16:19:42 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so471154pjf.2;
        Wed, 27 Jul 2022 16:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kOepgtwcdLQRP/qRZeoxPArZsGP7iFtltMUiXWZxlTA=;
        b=tY2wqxBhbn9ED5ntQXGfZBBks9gGvurFn6sqilqP77TsBC0B2P7jo/G7+I81iNbgqo
         607caZN/vWRb6YkI75+6j31y3qOf6VGviIGOidumkzN+W1uaVeuOjSPigEdUPOCXAd+A
         86kLkq7w0YEaefrFarspw1P+TvukOXAsc+O41P/vHE9p4niqbumydjUIGgDe3/Zdr1Kc
         p3h0+3K2OMZ/XgnTu25z2dKyU+TUdp6Ols2hpmSThYvWjcA9qzsOj6uQhU7R/4hRubJe
         zSh24iE8BI8HloJujvtAmeIoGG0wMbO0NiL5G5dRhhSv2hGQquAHvEPx03FO0re0ed1K
         eKpg==
X-Gm-Message-State: AJIora+0t3bEJXENua95U/PotGj6i9hSQ6ELB1dvyQdcORZueNV0L5nI
        La8s5X6Kt6z9LLqYP71EX+I=
X-Google-Smtp-Source: AGRyM1v4arIrU8OrBsKV8oknRZWNQ7p4sPrLDkPKFw6Y11E+aVKagxx/UxaZflYaD5XeZX1L1eA7ig==
X-Received: by 2002:a17:903:2282:b0:16c:500f:b78e with SMTP id b2-20020a170903228200b0016c500fb78emr23736794plh.49.1658963981476;
        Wed, 27 Jul 2022 16:19:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id q13-20020a65684d000000b00419cde333eesm12516908pgt.64.2022.07.27.16.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 16:19:40 -0700 (PDT)
Message-ID: <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
Date:   Wed, 27 Jul 2022 16:19:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 09:22, Pankaj Raghav wrote:
> This series adds support to npo2 zoned devices in the block and nvme
> layer and a new **dm target** is added: dm-po2z-target. This new
> target will be initially used for filesystems such as btrfs and
> f2fs that does not have native npo2 zone support.

Should any SCSI changes be included in this patch series? From sd_zbc.c:

	if (!is_power_of_2(zone_blocks)) {
		sd_printk(KERN_ERR, sdkp,
			  "Zone size %llu is not a power of two.\n",
			  zone_blocks);
		return -EINVAL;
	}

Thanks,

Bart.
