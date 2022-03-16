Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB24DB347
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356773AbiCPOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356540AbiCPOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:30:40 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6155B43ED0;
        Wed, 16 Mar 2022 07:29:26 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id z16so4114082pfh.3;
        Wed, 16 Mar 2022 07:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jR+mNzXzu8eZdMh4liARjUPmv7YRmMuKRYUGBTgeCrg=;
        b=SA05BNLCEaji8Hp7RO1NC5ePnLRftnibf90c7GOUuSg8fVabL24z3aB+u/wtRKtXiw
         lqEZ3UhOJaeuhxQ/Mkb6ifzqn11RT5AhYIMu0Sk/usUwjqSF54DrFWDN+S0iyNyeGkzO
         3VbR8XhDItXTSUg6LvFYDx5wFkF1n1rzeZ1CrAvhriB0w51MPwyYFZuOSQ7e43VkzspO
         SoOoj8Z65KiqOh5hnygb+Orh8Qhvlsr870JS4Qyv3paWuDGaiegPVU432tJkqnrd99Ra
         oceE0ohwAdH3pZyKATkIOyLwe57jKwT/foN/w17A54v56W2UqoT134nGNzxwj7k5CXGI
         1cAA==
X-Gm-Message-State: AOAM532dzz9zn3Nt0JfqqAM544FWgDsuwOYyyA9z5T9iJ4y8ty6WxwEV
        Djihn3KVBZc+gZrntYJ0QxY=
X-Google-Smtp-Source: ABdhPJzYIHcMhBFVJhlyt9XgiMw/rgbVkteWxd4f+A1hvuewnlFW5y5dN3prW5UdWujVRETAt9XYsQ==
X-Received: by 2002:a63:4e14:0:b0:374:4a37:4966 with SMTP id c20-20020a634e14000000b003744a374966mr28096671pgb.118.1647440965707;
        Wed, 16 Mar 2022 07:29:25 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id f30-20020a63755e000000b00381f6b7ef30sm1619222pgn.54.2022.03.16.07.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 07:29:25 -0700 (PDT)
Message-ID: <c3c7aefc-8d0b-b23a-8b9f-012f6ca8f8e4@acm.org>
Date:   Wed, 16 Mar 2022 07:29:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] scsi: core: Fix sbitmap depth in
 scsi_realloc_sdev_budget_map()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.wilck@suse.com,
        ming.lei@redhat.com, hch@lst.de, hare@suse.de
References: <1647423870-143867-1-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1647423870-143867-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 02:44, John Garry wrote:
> In commit edb854a3680b ("scsi: core: Reallocate device's budget map on
> queue depth change"), the sbitmap for the device budget map may be
> reallocated after the slave device depth is configured.
> 
> When the sbitmap is reallocated we use the result from
> scsi_device_max_queue_depth() for the sbitmap size, but don't resize to
> match the actual device queue depth.
> 
> Fix by resizing the sbitmap after reallocating the budget sbitmap. We do
> this instead of init'ing the sbitmap to the device queue depth as the user
> may want to change the queue depth later via sysfs or other.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
