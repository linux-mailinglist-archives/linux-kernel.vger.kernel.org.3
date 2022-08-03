Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92697589197
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiHCRie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiHCRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:38:31 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E411819;
        Wed,  3 Aug 2022 10:38:30 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id f11so15737803pgj.7;
        Wed, 03 Aug 2022 10:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xeyAvaWQs5dfgAhmS4gZ7gMOAtV55SeWCgiHLiTRaxE=;
        b=bcuNWb8B0rF5cxulLQ5LfToiFxLJHLxYNg0bvDqKXw3DM8/hT9MSeEV/j/6Q8mva4L
         N/lRvbTyrwn/1rwbsm7P5sezR6GKv13A9wl0cMEcR4wi6tPFs5HrLkGfxPRfIfoDTllm
         82EYIREcBPr7zQc3vLTx1mZ3aU/Fjv7Lo7lMvyI2AbDylwowoyp345HxqKK3Nx6h1Zqd
         WDXZ0U7S3lar9ff88e1R2D3Ef34QNWDeDQGILDWtUbn/KWn1J2srT7ApYEApgCgOzizT
         x1RDGPXTFqtnPrTWtyUYQg5hIxggvTP4R3yozxtCpv9HPs/L8taqA0ry1B+ZSYjK2oxi
         kOtg==
X-Gm-Message-State: ACgBeo3OtRycEbjWw7QQPSybCIK/9vwMI4CldI15emD2wkb3jRow0UPs
        4w9h4nGJDIl9RrDIBUaMFaQ=
X-Google-Smtp-Source: AA6agR55lAhIayHSvK572pxRLgZ0mTJXUgBk+a3seswhk0Zod29m6prJ06hcnejXdD2n4/czbP3N9Q==
X-Received: by 2002:a63:6b81:0:b0:41c:3a8c:b4fe with SMTP id g123-20020a636b81000000b0041c3a8cb4femr10079727pgc.84.1659548309755;
        Wed, 03 Aug 2022 10:38:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id u188-20020a6379c5000000b00419b128cf98sm11145939pgc.54.2022.08.03.10.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:38:29 -0700 (PDT)
Message-ID: <28b41877-2697-6bbb-066d-ee0f6e330565@acm.org>
Date:   Wed, 3 Aug 2022 10:38:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 3/6] scsi: ufs: wb: Add explicit flush sysfs attribute
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
 <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p3>
 <20220802080740epcms2p3893fd9cfb765d4addbbfe58c68cf5af3@epcms2p3>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220802080740epcms2p3893fd9cfb765d4addbbfe58c68cf5af3@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 01:07, Jinyoung CHOI wrote:
> +What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_flush_en
> +What:		/sys/bus/platform/devices/*.ufs/wb_buf_flush_en
> +Date:		July 2022
> +Contact:	Jinyoung Choi <j-young.choi@samsung.com>
> +Description:	This entry shows the status of WriteBooster buffer flushing

Can we rename this attribute into something that has a word order that 
is grammatically correct, e.g. enable_wb_buf_flush?

> +		and it can be used to allow or disallow the flushing.
> +		If the flushing is allowed, the device executes the flush
> +		operation when the command queue is empty.

The attribute has "enabled" in its name while the above text uses the 
verb "allowed". Consider changing "allowed" into "enabled". Please also 
change "If the flushing" into "If flushing".

Thanks,

Bart.
