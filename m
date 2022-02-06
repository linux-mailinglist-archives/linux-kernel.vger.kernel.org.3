Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECA4AB051
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbiBFPnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBFPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B82B8C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644162210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ExlSUsP6fIrRLknDC2nQTzRHSOOXRnoF0vynoyNz4PA=;
        b=bzO2b4ZMA9/Jmx5Vdw4EEU+aVYfNV5PIeg7uWuq0iK4+rcDWs8MxK3j7D6afdRudGG70ty
        WBvFBy+izV9VIdv1cIh7rwGtytA/2U6cugEj9j8bkm9CraBBvqnyUKRxcsOZ1Ggwcd/UAU
        zC2rua+ea/GYf/LjBcyTrXvsDk/PJ+0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-5Cvslm_KOQWhbaNsyj0a9Q-1; Sun, 06 Feb 2022 10:43:29 -0500
X-MC-Unique: 5Cvslm_KOQWhbaNsyj0a9Q-1
Received: by mail-qt1-f200.google.com with SMTP id c15-20020ac87dcf000000b002d0a849c0beso9157940qte.16
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 07:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ExlSUsP6fIrRLknDC2nQTzRHSOOXRnoF0vynoyNz4PA=;
        b=OmmsDQJF3e0O48pGkpPT743aLspDFSY9vJK0KnV+lmHHa3G6sE3XCpeSlxfuCx5ROL
         LZiLxlgcHSs3T0sChCHuH+LYS3QGeCc4s5zZDu5cs2RrFitSHMLbSZ2Zac7KzFfCJaKH
         CHdLWFLwpcF6y1YtUtoxakIbYAYRhuRVUovISY+b6KWHfzkizF7rqXBvU0gX8ioaHiqd
         lCYq9auZVES20zRCyv6nNCFf0mSSNM5xR4qyocyR27m3kltFb+zEwiFa9BeO5tVzpuHk
         ngKTuJ0plOu4jybypGh3v1OQxl2opqS9EP92AibYw90F9BnvqTZMtC6dZly8W7utEIdR
         8tGQ==
X-Gm-Message-State: AOAM533HIsFwM4fl54mlregifC7LqR7G0ybDJBqgJTAghbpFD6kOGDNq
        m3JRwpuGM87LqdFrLUsbP9RDnyoRf0zrGNLu5jtuRsyCdlVAVaCYGtzxq5OZA9NpY5Q9d1cjD4q
        5G1Rpfc7H9cQ/2hUJWOsxOCIS
X-Received: by 2002:a05:620a:2592:: with SMTP id x18mr4325677qko.578.1644162209252;
        Sun, 06 Feb 2022 07:43:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqWLADdqijhyerKNhUtVZWu2qMA0+Uqm58RfBgXo/CmR1A9L3X8bLbkl+oLtymrGyNCX+xPA==
X-Received: by 2002:a05:620a:2592:: with SMTP id x18mr4325665qko.578.1644162209011;
        Sun, 06 Feb 2022 07:43:29 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m130sm3961412qke.55.2022.02.06.07.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 07:43:28 -0800 (PST)
Subject: Re: [RFC PATCH 3/5] firmware_loader: Split fw_sysfs support from
 fallback
To:     Russ Weight <russell.h.weight@intel.com>, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, basheer.ahmed.muddebihal@intel.com,
        tianfei.zhang@intel.com
References: <20220203213053.360190-1-russell.h.weight@intel.com>
 <20220203213053.360190-4-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <487b45dc-edd3-4406-7f06-9dc68e330623@redhat.com>
Date:   Sun, 6 Feb 2022 07:43:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220203213053.360190-4-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/22 1:30 PM, Russ Weight wrote:
> In preparation for sharing the "loading" and "data" sysfs nodes with the
> new firmware upload support, split out sysfs functionality from fallback.c
> and fallback.h into fw_sysfs.c and fw_sysfs.h. This includes the firmware
> class driver code that is associated with the sysfs files and the
> fw_fallback_config support for the timeout sysfs node.
>
> CONFIG_FW_LOADER_SYSFS is created and is selected by
> CONFIG_FW_LOADER_USER_HELPER in order to include fw_sysfs.o in
> firmware_class-objs.
>
> This is mostly just a code reorganization. There are a few symbols that
> change in scope, and these can be identified by looking at the header
> file changes. A few white-space warnings from checkpatch are also
> addressed in this patch.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>

Consider how bisectable and reviewable this patch is.

I think this patch should be first since reorganizing should not depend 
on anything new.

Other users of fallback will want to know if this change is going to 
break them, so the reorganization should be as mechanical as possible to 
make the review as easy as possible and easy to revert if something goes 
wrong.  Ex/ the whitespace changes made as a separate patch to the old 
file, not embedded in the new file.  The new Kconfig added later if needed.

Also consider if this move is needed at all, generalizing in the 
existing file is ok.

Tom

