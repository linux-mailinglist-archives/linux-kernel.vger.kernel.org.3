Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7BE586FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiHARsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiHARsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:48:50 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E0A2F01F;
        Mon,  1 Aug 2022 10:48:49 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 206so6819275pgb.0;
        Mon, 01 Aug 2022 10:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EN6VLRMLyX8Pe8pUfOBoTSaSGWWPYWCDNxOmZN2qUZE=;
        b=S057YlMtKhdK+oTVpluP7EEfNOjUEHHvz2V2yxfoLxtaEc6Fs+XJjvtjDCGKlbWxIA
         zeDMAGPdy4SgbS6aWKWVFJV5f6BiDcypuoL+pqYy5wPvFwAcFWC18LmxpVqgIxCTU0PD
         uB0ad5cLEqLjYEMwgqCsvkmaBzqelcHzatUxTpj8F+VSCCREO+K6alAVFMzPYgRWsMcD
         Oqu+9SC1Ap+Xbc07X1X9NblbR3rJyndIsGhv2AgN3k+YVwTYHSzcvKF61xKAnmxqGVUT
         G9wqFHd4pGxeOvo0+9raynPZhvXvT8BiwtDZSHzsCHI7N5OoDXw8o0XPu/Kg3Iio18fK
         R+0g==
X-Gm-Message-State: AJIora/2DKaVPNlIAZ/0jBCpUzurOMUXCArwvxJpYpbuGMgHlUerFirJ
        pa4SGZ+SoLgcaBSrq49WOi4=
X-Google-Smtp-Source: AGRyM1s3sQEiFccWVLANXwiDQ2eLWBsm42X5+Q5P4fg5LoKgu+s9ID24Gf8TXPj2PzKAUWypLGgOLw==
X-Received: by 2002:a65:6c05:0:b0:41a:d13f:f0fb with SMTP id y5-20020a656c05000000b0041ad13ff0fbmr14358372pgu.393.1659376128957;
        Mon, 01 Aug 2022 10:48:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6496:b2a7:616f:954d? ([2620:15c:211:201:6496:b2a7:616f:954d])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0016d1e2a240dsm9832596plk.202.2022.08.01.10.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:48:47 -0700 (PDT)
Message-ID: <1ca16b27-21e5-3537-400a-25cdae52396e@acm.org>
Date:   Mon, 1 Aug 2022 10:48:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220729151301.v4.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729151301.v4.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
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

On 7/28/22 22:13, Daniil Lunev wrote:
> Allows userspace to check if Clock Scaling, Write Booster functionality
> status.

The above sentence is not complete. Did you perhaps want to write "are 
supported by the host controller" instead of "status"?

> +What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/clock_scaling
> +What:		/sys/bus/platform/devices/*.ufs/capabilities/clock_scaling
> +Date:		July 2022
> +Contact:	Daniil Lunev <dlunev@chromium.org>
> +Description:	Indicates status of clock scaling.
> +
> +		== ============================
> +		0  Clock scaling is not enabled.
> +		1  Clock scaling is enabled.
> +		== ============================
> +
> +		The file is read only.

I don't think the above documentation is correct. My understanding is 
that the UFSHCD_CAP_CLK_SCALING flag indicates whether or not the host 
controller supports clock scaling. It does not indicate whether or not 
clock scaling is enabled.

> +What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/write_booster
> +What:		/sys/bus/platform/devices/*.ufs/capabilities/write_booster
> +Date:		July 2022
> +Contact:	Daniil Lunev <dlunev@chromium.org>
> +Description:	Indicates status of Write Booster.
> +
> +		== ============================
> +		0  Write Booster can not be enabled.
> +		1  Write Booster can be enabled.
> +		== ============================
> +
> +		The file is read only.

Please change "can not / can be enabled" into "is not supported by the 
host controller / is supported by the host controller".

Thanks,

Bart.
