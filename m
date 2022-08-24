Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2859FFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiHXQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiHXQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:40:17 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA323B4AE;
        Wed, 24 Aug 2022 09:40:14 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id c2so16151688plo.3;
        Wed, 24 Aug 2022 09:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kCL4BW6wndWM8jV/We7eMfUU516GeaRGxdOb22z1qxA=;
        b=29wWt4rfV4BfD8PqMI+VDB+eVzmrzNr2x1o947HHK9kEKQYEMmR7VOxe0aNxqS9hcm
         YAOw5Lwko+iu0Z7yopNqxXHNLUNS/q2GUQ9Y6tbHMpFJ7nQauVJMbH2cSFl/nQe4580u
         aKVzK2cdxIQySnqL8EIet7ZhfjCu2rHqG1Dm1TLuu4V1LHAo+0vwEKv7tdOhCFR6b7qK
         jvsKhWPddWiHAHWb0Gx+ZE3sk5D7NlFnN8llgneqkM+6i0NxLx1e8eUBhcSTSl1/nOAn
         l6iLdIXlPAN4RAjQ608xMvPS/RIahOIxaY1BydTmxm9ZmXptXYENpA0VNwez/7H9Wpzf
         FCxg==
X-Gm-Message-State: ACgBeo1mOZoYm5P/iR/xZGKoUqF2Fc/pSYNcKO1aIUJiH8+DooqeIjnd
        f5+RSreDazLQytRmu/q6sO4=
X-Google-Smtp-Source: AA6agR6uPDXioeTI1NTOxX6jKOOFXqiJrzzdPMLFlc9WedHU9zymkMUveLdDcV9EyfGywdAMjRHegg==
X-Received: by 2002:a17:90b:3ec9:b0:1f5:7e38:1fd1 with SMTP id rm9-20020a17090b3ec900b001f57e381fd1mr9075919pjb.101.1661359214307;
        Wed, 24 Aug 2022 09:40:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:222f:dc9c:99a3:dfb8? ([2620:15c:211:201:222f:dc9c:99a3:dfb8])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b00172a4b6bb15sm6544241plx.13.2022.08.24.09.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 09:40:12 -0700 (PDT)
Message-ID: <9bd8c0f6-f7d2-e5ae-fbe9-d9a9a569adaa@acm.org>
Date:   Wed, 24 Aug 2022 09:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: ufs: ufsfbo: Introduce File Based Optimization
 feature
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>,
        Jiaming Li <lijiamingsofine@gmail.com>, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
 <347dae29c07fe13e6974b0e59e127c399f63ef69.camel@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <347dae29c07fe13e6974b0e59e127c399f63ef69.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 07:16, Bean Huo wrote:
> Is this a UFS extended standard or vendor specific feature?

Hi Bean,

This feature has been standardized by JEDEC. My feedback to the sponsors 
of this feature a few months ago was that FBO will become obsolete once 
all UFS devices support Zoned storage for UFS. The FBO standard defines 
an interface for telling UFS devices about the relationship between LBAs 
and files. This allows UFS devices to defragment files. UFS devices 
won't need that information for zoned LUNs since for zoned LUNs the host 
software will be responsible for ensuring that files occupy a contiguous 
range of LBAs.

Thanks,

Bart.
