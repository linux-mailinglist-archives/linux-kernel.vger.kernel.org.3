Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2D57E8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiGVVJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGVVJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:09:09 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB859B56C;
        Fri, 22 Jul 2022 14:09:07 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id go3so5375946pjb.0;
        Fri, 22 Jul 2022 14:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C4VMOw5ZurYpzdTyZc4RfmhO3hKlQCRXTQ2X4qGf7UU=;
        b=i55kXEvOUhO98/sJJyg4Zl6V+vVyjQVHdE5eMDyJ4I9RcsqLeV2JRYaHzkuxQLO0Yj
         yOojq7w2LtKE/7Fh69fl3LnRrKPoLpcOKXnnnOYRqr3N4yQ89KHv8C7AtOtYa011QI/X
         06OrFvrDZCTS9fILanCqcT96BshNOa1FLhizY0q1bSpWvRaF1WilnLBr2USYuodhhwmX
         e9ABPWcfj0VPzkzc0TxLpPZQHlM4Xp5hSCKVD3kpIcDqm9BgChFhNIzqJvx1haQaqspS
         S/hHEjo0O4W0gPKqYYVG70xlK3RSvNHsJUz0AL5eU8Zk5YTaslGNXxke7Hf98dgv6SWr
         JvIQ==
X-Gm-Message-State: AJIora8FoArq3eGOR/cnNW9CzjqBhYOTocTWsfFz8mqheW27GQrp76rD
        BXIfomoqwZ1NJFF0GUtOe6Q=
X-Google-Smtp-Source: AGRyM1u/M1jriI4jtBt6NKM2zel0NZ1S2FSZvZVoH/49fSgiaRmP9+LkC705mYhjeXaX7LqAMcI+bA==
X-Received: by 2002:a17:90b:3890:b0:1f0:2abb:e7d1 with SMTP id mu16-20020a17090b389000b001f02abbe7d1mr19493333pjb.158.1658524146701;
        Fri, 22 Jul 2022 14:09:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:805b:3c64:6a1f:424c? ([2620:15c:211:201:805b:3c64:6a1f:424c])
        by smtp.gmail.com with ESMTPSA id y65-20020a62ce44000000b00525b61fc3f8sm4415198pfg.40.2022.07.22.14.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 14:09:06 -0700 (PDT)
Message-ID: <f628bd28-612c-9be7-e0e5-457113fe65d6@acm.org>
Date:   Fri, 22 Jul 2022 14:09:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] scsi: fix WARNING in scsi_alloc_sgtables
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de,
        syzbot+d44b35ecfb807e5af0b5@syzkaller.appspotmail.com
References: <20220720025120.3226770-1-yanaijie@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220720025120.3226770-1-yanaijie@huawei.com>
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

On 7/19/22 19:51, Jason Yan wrote:
> When iovec_count is non-zero and dxfer_len is zero, the sg_io() just
> genarated a null bio, and finally caused a warning below. To fix it,
> skip generating a bio for this request if dxfer_len is zero.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
