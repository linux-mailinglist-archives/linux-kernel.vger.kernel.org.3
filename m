Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0304354BA93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiFNTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiFNTdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:33:13 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B9819F8D;
        Tue, 14 Jun 2022 12:33:11 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso12745973pjl.3;
        Tue, 14 Jun 2022 12:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0yuY33WdxMB76iynhvTSZPcdcuymbepOOB6v4k/PQOY=;
        b=jbB+qjSucecXj/HEgCIw1t9EsXmppQ+DavJNYSpUNrariNuH3b/MN6vnNGUdupzrv7
         Ts0oisAV493ABkX7o5r7XccRpuoTotG9aYWaLeuZGI5NEEZXg5xfH8Etn/oGwBlELKIw
         TwFDZQIkZR1UsNS3pH4oJd13pgkrt18JLVnTkjk4bOcTyHifJQa2WUIi1z0Kl8sYWRpJ
         MgV5Npe92Yhbs0SFQkMYx1XllUWHvxta87xXoEo8DX4zVvAgCFprz/61JCFbRLimYkZm
         0TJQNlQbQOd+0rkt+/RR5M9wFXZg/BRG7CbluA+SR9ofD3E8XaLaWoUvQr6afvSgr/zb
         jlJw==
X-Gm-Message-State: AJIora8eDAXkXliL2whctKXAYlQ8Lf1nlHvLBa3mSBrA2fNN3yX/Z7Wy
        N/cfMLZaKfOSc3sJ38NCO019JbLPqIk=
X-Google-Smtp-Source: AGRyM1s5w76ZfqYj/+26pMyhfynVA754uE8tmVNVmVHD3j64emOukGeeDvplcoiOLZ4wwUSbu4tMLA==
X-Received: by 2002:a17:90a:e50c:b0:1ea:14c1:2236 with SMTP id t12-20020a17090ae50c00b001ea14c12236mr6274836pjy.2.1655235190627;
        Tue, 14 Jun 2022 12:33:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090b169200b001ea629a431bsm7969640pjb.8.2022.06.14.12.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:33:09 -0700 (PDT)
Message-ID: <b61d3687-70ea-1ab7-63e1-44e381d36012@acm.org>
Date:   Tue, 14 Jun 2022 12:33:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v2 02/18] scsi: core: Resurrect
 scsi_{get,free}_host_dev()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, brking@us.ibm.com, hare@suse.de,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-3-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654770559-101375-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 03:29, John Garry wrote:
> +/**
> + * scsi_get_host_dev - Create a scsi_device that points to the host adapter itself
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
What does this mean? That part of the function description is not
clear to me.

> + * @shost: Host that needs a scsi_device
                               ^^^^^^^^^^^^^
This is not detailed enough. Consider changing "a scsi_device" into
"a scsi device for allocating reserved commands from".

> + *
> + * Lock status: None assumed.
> + *
> + * Returns:     The scsi_device or NULL
> + *
> + * Notes:
> + *	Attach a single scsi_device to the Scsi_Host - this should
> + *	be made to look like a "pseudo-device" that points to the
> + *	HA itself.
> + *
> + *	Note - this device is not accessible from any high-level
> + *	drivers (including generics), which is probably not
> + *	optimal.  We can add hooks later to attach.

The "which is probably not optimal. We can add hooks later to attach."
part probably should be moved to the patch description.

> + */
> +struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
> +{
> +	struct scsi_device *sdev = NULL;
> +	struct scsi_target *starget;
> +
> +	mutex_lock(&shost->scan_mutex);
> +	if (!scsi_host_scan_allowed(shost))
> +		goto out;
> +	starget = scsi_alloc_target(&shost->shost_gendev, 0, shost->this_id);
                                                           ^^^^^^^^^^^^^^^^^^
Is it guaranteed that this channel / id combination will not be used for
any other SCSI device?

What if shost->this_id == -1?

> +	if (!starget)
> +		goto out;
> +
> +	sdev = scsi_alloc_sdev(starget, 0, NULL);
> +	if (sdev)
> +		sdev->borken = 0;
> +	else
> +		scsi_target_reap(starget);
> +	put_device(&starget->dev);
> + out:
> +	mutex_unlock(&shost->scan_mutex);
> +	return sdev;
> +}
> +EXPORT_SYMBOL(scsi_get_host_dev);

Elsewhere in the SCSI core "get..dev" means increment the reference count of
a SCSI device. Maybe scsi_alloc_host_dev() is a better name?

> +/*
> + * These two functions are used to allocate and free a pseudo device
> + * which will connect to the host adapter itself rather than any
> + * physical device.  You must deallocate when you are done with the
> + * thing.  This physical pseudo-device isn't real and won't be available
> + * from any high-level drivers.
> + */

Please keep function comments in .c files because that makes it more likely
that the comment and the implementation will remain in sync.

Thanks,

Bart.
