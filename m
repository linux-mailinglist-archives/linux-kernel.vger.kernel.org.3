Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB185033D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiDPEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiDPEwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:52:25 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F95641F;
        Fri, 15 Apr 2022 21:49:54 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id q3so8517980plg.3;
        Fri, 15 Apr 2022 21:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n64Ceh0+mncTh8c+PN3WAxiVq0wOhX+10SaNJK7xeCg=;
        b=Jqnmzopz5ELeysnhdiaOIaA8G07f/4jdOqvoLHb6YcDLZs4tqvKQzagzV+wK86eQAL
         wtpzUZiHX7wnBd7mmAQ3l9jDVgBArNapaJGjtVWLCiousTou+ZM7HAX4luB1GxNDW9FI
         WKk6lcZctQhpWjAQJoBhcddHQHunG9yAQ4IeEmRAdUf19AJVF0NUF3/YHNmNgA9vo5vo
         xHzWWaIrJQeidPzeuSKLiggShjE5yoMh885s61e3/1ZnuHrSnxes6dE1L9RyT6CFWAfe
         fKouCfNGBfjtVNYJdgzwY4HJVX70mzWQEi2iYjiToDJuFjYGe4sTbovEQql3/gr58CKC
         T2PA==
X-Gm-Message-State: AOAM531f0cmG9kg7wIGkZMEKfuxT+HlTcBT2JFcys3QIxQbFaCWvHQh2
        KedyMGmSf07amDvT8+KztKc=
X-Google-Smtp-Source: ABdhPJwT6to3858USQjNTK1oP4TKo79v1y7v98iKirBSDZhQhO7QnuXHQM8Wa7Lvk5eiXgmaG9AuCA==
X-Received: by 2002:a17:90b:4c44:b0:1c7:1326:ec90 with SMTP id np4-20020a17090b4c4400b001c71326ec90mr7502827pjb.87.1650084593598;
        Fri, 15 Apr 2022 21:49:53 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a3e8400b001cd37f6c0b7sm6129296pjc.46.2022.04.15.21.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 21:49:52 -0700 (PDT)
Message-ID: <3164cd23-28b5-e971-c7a9-1b565b344ed5@acm.org>
Date:   Fri, 15 Apr 2022 21:49:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/1] scsi: Fix racing between dev init and dev reset
Content-Language: en-US
To:     Alice Chao <alice.chao@mediatek.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, matthias.bgg@gmail.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, powen.kao@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, yanxu.wei@mediatek.com,
        wsd_upstream@mediatek.com
References: <20220415061243.30229-2-alice.chao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220415061243.30229-2-alice.chao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 23:12, Alice Chao wrote:
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 0a70aa763a96..abf9a71ed77c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2461,6 +2461,7 @@ static void scsi_evt_emit(struct scsi_device *sdev, struct scsi_event *evt)
>   		break;
>   	case SDEV_EVT_POWER_ON_RESET_OCCURRED:
>   		envp[idx++] = "SDEV_UA=POWER_ON_RESET_OCCURRED";
> +		wait_event(sdev->host->host_wait, sdev->sdev_gendev.kobj.parent != NULL);
>   		break;
>   	default:
>   		/* do nothing */
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index f4e6c68ac99e..431f229ac435 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1904,6 +1904,7 @@ static void do_scsi_scan_host(struct Scsi_Host *shost)
>   	} else {
>   		scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
>   				SCAN_WILD_CARD, 0);
> +		wake_up(&shost->host_wait);
>   	}
>   }

The above patch can only work if scanning a host is followed by a POWER 
ON unit attention. I don't think that is guaranteed. Additionally, what 
will happen with the wait loop if the device generates a POWER on unit 
attention after the device has been removed from its parent? 
kobject_del() clears the parent pointer. device_del() calls 
kobject_del(). scsi_remove_device() calls device_del() before the 
request queue is destroyed.

Thanks,

Bart.


