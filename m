Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB81C5455BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbiFIUer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiFIUej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:34:39 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3120F6F;
        Thu,  9 Jun 2022 13:34:35 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so367809pjq.2;
        Thu, 09 Jun 2022 13:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6wtdNtGFdpESF6glfweoRrpOjBH9aO2zp0t1kc4rzd4=;
        b=XM41EtxdgqDwSnXs9BxHiYNEE9xSlvjsSvGS6YC1mYa51sY4dbnJPUmP33vLBALWEl
         YF8HjcT9tTOZ9yKl9lTEJpFNTs4cj75iNSJolVpAWTqd+6drodK2hc/XpgrULVfTfhkM
         SiuICvel3BY1u5JqongrT2ea2PF98hWm3CPFC0rupvbFyql1UUg3V0eBU0HrRf2heRA1
         YqdKtj2Dcn5soxcLM3uEVpc8jUR4s7NJgWhxNNgtWlTyxdl33Kb6ehuUi3y0kvBgMxSX
         v41eHk0ggApdXMgDT3p9hUrU6qdErcrfAgplQGeXt+oMXl0qrSWJwwqhYDVDfBKP6scD
         qVug==
X-Gm-Message-State: AOAM532q7xox2hHyyYrC3bYVMrIAUP1Ozs9DT8j0jhF8WAg97yN4S0i3
        WeLm0cbhRtuj33O0zQZh5lA=
X-Google-Smtp-Source: ABdhPJzP68mcRSDMkhmkAefbn0A7+sB9Xcl1QQgOF53xsaTu2y4djDDrLLteVYsPMpjj5mZsq2HCYQ==
X-Received: by 2002:a17:903:22d1:b0:166:4bc1:a1da with SMTP id y17-20020a17090322d100b001664bc1a1damr37186025plg.13.1654806874934;
        Thu, 09 Jun 2022 13:34:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8a44:a3e:c994:3f4b? ([2620:15c:211:201:8a44:a3e:c994:3f4b])
        by smtp.gmail.com with ESMTPSA id k16-20020aa79d10000000b0050dc7628162sm17863699pfp.60.2022.06.09.13.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:34:33 -0700 (PDT)
Message-ID: <23bf4427-41c3-bf1d-903a-75928bb47627@acm.org>
Date:   Thu, 9 Jun 2022 13:34:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
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
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
 <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
 <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
 <a2585983-75d7-c627-13ba-38a464cf716e@acm.org>
 <9b1d155e-28cc-08dc-5a5a-8580132575e7@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9b1d155e-28cc-08dc-5a5a-8580132575e7@huawei.com>
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

On 6/9/22 10:54, John Garry wrote:
> ok, but do you have a system where the UFS host controller is behind an 
> IOMMU? I had the impression that UFS controllers would be mostly found 
> in embedded systems and IOMMUs are not as common on there.

Modern phones have an IOMMU. Below one can find an example from a Pixel 
6 phone. The UFS storage controller is not controller by the IOMMU as 
far as I can see but I wouldn't be surprised if the security team would 
ask us one day to enable the IOMMU for the UFS controller.

# (cd /sys/class/iommu && ls */devices)
1a090000.sysmmu/devices:
19000000.aoc

1a510000.sysmmu/devices:
1a440000.lwis_csi

1a540000.sysmmu/devices:
1aa40000.lwis_pdp

1a880000.sysmmu/devices:
1a840000.lwis_g3aa

1ad00000.sysmmu/devices:
1ac40000.lwis_ipp  1ac80000.lwis_gtnr_align

1b080000.sysmmu/devices:
1b450000.lwis_itp

1b780000.sysmmu/devices:

1b7b0000.sysmmu/devices:
1b760000.lwis_mcsc

1b7e0000.sysmmu/devices:

1baa0000.sysmmu/devices:
1a4e0000.lwis_votf  1ba40000.lwis_gdc

1bad0000.sysmmu/devices:
1ba60000.lwis_gdc

1bb00000.sysmmu/devices:
1ba80000.lwis_scsc

1bc70000.sysmmu/devices:
1bc40000.lwis_gtnr_merge

1bca0000.sysmmu/devices:

1bcd0000.sysmmu/devices:

1bd00000.sysmmu/devices:

1bd30000.sysmmu/devices:

1c100000.sysmmu/devices:
1c300000.drmdecon  1c302000.drmdecon

1c110000.sysmmu/devices:

1c120000.sysmmu/devices:

1c660000.sysmmu/devices:
1c640000.g2d

1c690000.sysmmu/devices:

1c710000.sysmmu/devices:
1c700000.smfc

1c870000.sysmmu/devices:
1c8d0000.MFC-0  mfc

1c8a0000.sysmmu/devices:

1ca40000.sysmmu/devices:
1cb00000.bigocean

1cc40000.sysmmu/devices:
1ce00000.abrolhos

Bart.
