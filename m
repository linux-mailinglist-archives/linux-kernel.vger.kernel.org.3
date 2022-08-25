Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED265A1B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiHYVsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbiHYVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:48:10 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF72CC6942;
        Thu, 25 Aug 2022 14:46:15 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id x15so20174617pfp.4;
        Thu, 25 Aug 2022 14:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=b/kOGC4F2xUm59JRxyr6870MdL+nGgrRYhM7/o4VT0c=;
        b=hXrZjNA6PR0UKh/BWgVQVsAxQUTKCG4E3AvR2luOo9pRRSiZeA5MsablzSPZgcJ8u/
         InV+4gvfEA9Dtv/rufSA7pKYtEM1xUBf+3KzdE1Ukx8+AnlOpnsOusfF+9yfXp5L5V/U
         znt/HcPUr0rDLHF5T0tNTAdEEg+Qh4j/DIchosaP3uQMlRb9IsX7C5LAXCqoPlFiaClT
         6OFCe/wLEK1Ly+agcQGbg5KHTPFs3raRxJm16Mlp6ozFl0G5FRiF4FUAB6R5m/OJR69a
         ibEUQcvL/y64Fl2qVInkb4BkDNKaH2qu+dNknAqbVekr3qtnHW5R0ThXYLbpLlu2ztFO
         kYig==
X-Gm-Message-State: ACgBeo2nSE1tdu5u+hzSkkT7TAqd1YKArKM2T2WrfMdJ55BEw9DkLo65
        p6S+abTwqby7+2Tv0cm6CVY=
X-Google-Smtp-Source: AA6agR75klAqItVGOT27TBqBxype2jtUq57AMSY37jZpLRunDrmU0pjJoNsnSIYBhfJ1+Z5ssbsM1g==
X-Received: by 2002:a05:6a00:1a91:b0:52f:29e7:c32c with SMTP id e17-20020a056a001a9100b0052f29e7c32cmr1064285pfv.10.1661463966264;
        Thu, 25 Aug 2022 14:46:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0016b90620910sm49487plh.71.2022.08.25.14.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:46:05 -0700 (PDT)
Message-ID: <ee3be9d8-b473-8e59-4d3c-84e0ef9dd6f8@acm.org>
Date:   Thu, 25 Aug 2022 14:46:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121907eucas1p295c375935b556729864dce39534c2579@eucas1p2.samsung.com>
 <20220823121859.163903-6-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-6-p.raghav@samsung.com>
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

On 8/23/22 05:18, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> As rounddown macro from math.h does not work for 32 bit architectures,
> round down operation is open coded.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
