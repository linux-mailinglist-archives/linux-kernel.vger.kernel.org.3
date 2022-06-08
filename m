Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E82543A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiFHR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiFHR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:28:20 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA9D275CA;
        Wed,  8 Jun 2022 10:28:04 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d22so18200259plr.9;
        Wed, 08 Jun 2022 10:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dpHSA3kj0eHHqdYze/RCpBE0tw7cvZjVvQOy/DfoJ2s=;
        b=Guv1VNHFN+Ce4NfvlvvjCl8Vqnee7V9IlJyIuo0hpl03uOIJXLYGICZN7c9+/YD2gF
         u0QYLZTkqttAyGbzIsvUud3oyvRsMcse9DMqTqyjKnWRIZX13kjfXBxpMXy0o5NkG3GH
         FTCjkg8Y7LKwi6rooY2NGHPlp+OKx4Qy7ifa4BYexg35kC8r0PkCpURocSHW7rvMyop4
         jj0zSpThIEgKjBAd+TAAuPuJXvfRyLpvbP+B3qh7Iy+ifOoffGGcJz0dFnfRYBZglXfm
         70r9p0S1enNuWTgxrrOX8eZMaX6GnprqeDJ8Xe+YviMDIRXxVXESDh+HTME/Qes8ekW/
         hE4Q==
X-Gm-Message-State: AOAM530C+tw3h+YkaGdb+/hUAvtePOtzS+sgpgbR2SUNLvydA5aDnPD7
        DBHPkdoGlW9HNRYVuALHysg=
X-Google-Smtp-Source: ABdhPJzMDpvgYrNyCdrUrf5LIBVmTVoNnNeogBR/uNjDb79MyeVN9aegG63yruaNNjBQ7ETB9eku5Q==
X-Received: by 2002:a17:90b:3a87:b0:1e8:8079:b7e6 with SMTP id om7-20020a17090b3a8700b001e88079b7e6mr247147pjb.139.1654709283698;
        Wed, 08 Jun 2022 10:28:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39? ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902c45300b00162496617b9sm6030401plm.286.2022.06.08.10.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 10:28:02 -0700 (PDT)
Message-ID: <543345ac-fbfa-1020-b6c7-72f65412f444@acm.org>
Date:   Wed, 8 Jun 2022 10:27:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] dma-mapping: Add dma_opt_mapping_size()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-2-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-2-git-send-email-john.garry@huawei.com>
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

On 6/6/22 02:30, John Garry wrote:
> +::
> +
> +	size_t
> +	dma_opt_mapping_size(struct device *dev);
> +
> +Returns the maximum optimal size of a mapping for the device. Mapping large
> +buffers may take longer so device drivers are advised to limit total DMA
> +streaming mappings length to the returned value.

"Maximum optimal" sounds weird to me. Is there a single optimal value or 
are there multiple optimal values? In the former case I think that the 
word "maximum" should be left out.

Thanks,

Bart.
