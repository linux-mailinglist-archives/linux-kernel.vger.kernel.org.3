Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279B758562A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiG2Ub2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbiG2Ub0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:31:26 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EF67162;
        Fri, 29 Jul 2022 13:31:24 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so6305619pjf.2;
        Fri, 29 Jul 2022 13:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gBwpIuZlDADZCkkRAEQb1zu82KO6R+3bEvgvkEzehbY=;
        b=we7EJL8Cr0Q+yOv4l1GFVZBpBmmTQg0sHEMa9rWeN09hzkZ0HsI3N7CBrVwJoRhj/4
         XD3nEoKMxKkvOuhPgutZbFww1JRPIo1w5rNXCLk8QZGqiIH5FT633NnGNY1xy2vE6yZg
         +ahlzG+ij5NGVL9gVcuKJtUNvzMiyfpzKfzqXZ8NPokklA6YU9j99vd9TcXTwldThuQE
         9kqp32X3c/H16KWfFFfA7fwKh4a/U7xURjbYPO/vpWsYVChjShF1nU8CKQmNdqHPG4GT
         dzPpg7gFtDWsWKPE+XQDJLda3t5nr6UK5aImh3wZnw7F99yY8xZTHTyjCYpDXVgJyZqp
         jAcQ==
X-Gm-Message-State: ACgBeo2bOPWabCOShk3Fr4Rr+Rx0UxQQPj8ZJ/lkpSq/GHorgAYES74H
        YKjT1mRw4cZdLJU9YfcYUTo=
X-Google-Smtp-Source: AA6agR67krWy1eHe+gxf9sz+hMkG94//uE0j/opEe3cqMlle4wMaVkqfcPlawrNEopofPY0vanRMsQ==
X-Received: by 2002:a17:903:249:b0:16b:9cf3:596e with SMTP id j9-20020a170903024900b0016b9cf3596emr5450016plh.60.1659126683894;
        Fri, 29 Jul 2022 13:31:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id e64-20020a621e43000000b005286124df03sm3292945pfe.87.2022.07.29.13.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 13:31:23 -0700 (PDT)
Message-ID: <82d1e6da-df4b-31bb-ec46-76099d7c3288@acm.org>
Date:   Fri, 29 Jul 2022 13:31:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 3/6] scsi: ufs: wb: Add explicit flush sysfs attribute
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
 <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
 <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
 <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p4>
 <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
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

On 7/28/22 21:56, Jinyoung CHOI wrote:
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 6b248abb1bd7..7e9e1db55d60 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1417,6 +1417,16 @@ Description:	This node is used to set or display whether UFS WriteBooster is
>   		platform that doesn't support UFSHCD_CAP_CLK_SCALING, we can
>   		disable/enable WriteBooster through this sysfs node.
>   
> +What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_flush_en
> +What:		/sys/bus/platform/devices/*.ufs/wb_buf_flush_en
> +Date:		July 2022
> +Contact:	Jinyoung Choi <j-young.choi@samsung.com>
> +Description:	This node is used to set or display whether WriteBooster
                      ^^^^

Please change "node" into "attribute" (here and below). Sysfs files are 
called attributes.

> +		buffer flusing is enabled. The data written in the WriteBooster
                        ^^^^^^^
                        flushing?
> +		Buffer can be flushed by an explicit host command or
> +		implicitly while in hibernate (HIBERN8) state.

The above sentence is misleading because it suggests that setting this 
attribute causes the WB buffer to be flushed in its entirety. That is 
not correct - what this attribute controls is whether or not the UFS 
device is allowed to start with flushing the WB buffer.

> +	if (!ufshcd_is_wb_allowed(hba) ||
> +	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
> +		dev_warn(dev, "It is not allowed to configure WB buf flush!\n");

flush -> flushing

> +	ufshcd_rpm_get_sync(hba);
> +	res = ufshcd_wb_toggle_buf_flush(hba, wb_buf_flush_en);
> +	ufshcd_rpm_put_sync(hba);
> +out:
> +	up(&hba->host_sem);
> +	return res < 0 ? res : count;
> +}

Please leave a blank line above goto labels as requested by the kernel 
coding style guide.

Thanks,

Bart.
