Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B453A47B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351668AbiFAL72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbiFAL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:59:25 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03511DC;
        Wed,  1 Jun 2022 04:59:25 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so2837104pjm.2;
        Wed, 01 Jun 2022 04:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=91WLR4x8N/d2cket7T0sGmDgmfSOOo4AlCpi1uelSJQ=;
        b=2vsfxYncFGzy3UrerWDSSGzAPtD/KbV//vSD78g27SvlfIetTW1uTxTCcaFfmtiH+P
         I7uYCUU5ta99J6wq1oLe3maxdjpqqqm2IYhNbqEV0czeJNIZDYyxR3XkXzVgeJQmXG8e
         oXBmdK/YF6t73yC/v/C9dkI5pTW14+SG3ea2yja+Y4Qhgdjy5ZX5lK4DMbFq2gnX8g4t
         iq5L94BfBRShtA2zbnhqPtiBqBxNQfTQxX9x6OqO7spDnouKFmu+rQ3r6g1zlxhW2S4o
         3maEOI/hpBSHsHPdHpqTxf9UZa1Y6z/vMwccQqoCmP2YlwqLFGvEuc+xT/+6zyWWtL+m
         Tz2Q==
X-Gm-Message-State: AOAM532lJ8vYVH2oZAkzctKetfU9fDjHVx0Cs3cqa+p86OJfJRQ0pBKD
        5SHPgWecTsfuuvcHGMsPsXk=
X-Google-Smtp-Source: ABdhPJweKR88zivyopAagwRyJq5cAohZJGhAoFHTGP98fE/n2Sm4S9u+0euiL7ATQulF17osCuVMbQ==
X-Received: by 2002:a17:902:f54c:b0:163:f64a:612c with SMTP id h12-20020a170902f54c00b00163f64a612cmr11180686plf.22.1654084764256;
        Wed, 01 Jun 2022 04:59:24 -0700 (PDT)
Received: from [192.168.51.14] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id bb7-20020a170902bc8700b001624dab05edsm1398513plb.8.2022.06.01.04.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:59:23 -0700 (PDT)
Message-ID: <3e13bf8f-060c-fc81-4405-e7d5820518cc@acm.org>
Date:   Wed, 1 Jun 2022 04:59:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scsi: ufs: add a quirk to disable FUA support
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
References: <20220531201053.3300018-1-jaegeuk@kernel.org>
 <d3038c9e-c9ec-16e9-bad4-8b1de5e23ba6@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d3038c9e-c9ec-16e9-bad4-8b1de5e23ba6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 22:24, Adrian Hunter wrote:
> On 31/05/22 23:10, Jaegeuk Kim wrote:
>> +	/*
>> +	 * This quirk disables FUA support.
>> +	 */
>> +	UFSHCD_QUIRK_BROKEN_FUA				= 1 << 17,
> 
> Wouldn't it be more appropriate to make it a UFS_DEVICE_QUIRK_
> since it presumably depends on the UFS device not the host controller?
> 
> Also, as already commented by others, there needs to be a user of
> the quirk

Another possibility is to use the generic SCSI blacklist mechanism. See 
also the scsi_static_device_list array. See also /proc/scsi/device_info. 
 From scsi_devinfo.c:

/*
  * proc_scsi_dev_info_write - allow additions to scsi_dev_info_list via
  * /proc.
  *
  * Description: Adds a black/white list entry for vendor and model with
  * an integer value of flag to the scsi device info list.
  * To use, echo "vendor:model:flag" > /proc/scsi/device_info
  */

Thanks,

Bart.
