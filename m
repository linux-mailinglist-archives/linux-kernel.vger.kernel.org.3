Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF03D588207
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiHBSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHBSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:47:22 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC33AB24;
        Tue,  2 Aug 2022 11:47:20 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso9228321pjf.5;
        Tue, 02 Aug 2022 11:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BL1+P3W0SDQas26l5EYNJ3j1pMnFbdd5k052VAxNr30=;
        b=tmJa9N6PH5ReE9p0P5MpbDdk6pJ43Cq7S1PZfFz6xyGhNasv15Dm4N3vIlPqC9rDlr
         Yseay4a8bOddo9A50IVzDxcL1zaBIUn+4xrJhEJ5b4tRthl5f+9hysLb4AHT169huVvx
         uy9FtlVE7bTZJNGK6oI01n00lywFmbM+w+8viPDfNWZJXAZlFhA7v2pJj20KcZZBa38f
         p4IYi8eHGMtEHAzAbiDZnVr7HbBquKwijwStRjhjkBdQBEmX7xoXe1zxpreKdNPs/4lU
         f6aJ2tu7lcOPLykTcKT+xU/G9N4aHyz62UbxRH8eO576acnTm+zDMrdcPwRFcwUCa7mk
         JUbw==
X-Gm-Message-State: ACgBeo0QyYp04cEanXZk8zL4TeExgLo+kH7CZIG1rGMY4B6f8Q1DpnwX
        F19MWhhwSl9y+cJ/27NJtN0=
X-Google-Smtp-Source: AA6agR7rUZCUXrO9uGz7+OdUOBEixPBGvnoUYQu7RMtVWuiQPYeBQxLCBYDaVRvHg4DbfmBQDrqefQ==
X-Received: by 2002:a17:902:f70d:b0:16c:50a2:78d1 with SMTP id h13-20020a170902f70d00b0016c50a278d1mr21882061plo.34.1659466039774;
        Tue, 02 Aug 2022 11:47:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5297:9162:3271:e5df? ([2620:15c:211:201:5297:9162:3271:e5df])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b0016bfbd99f64sm32306plh.118.2022.08.02.11.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 11:47:19 -0700 (PDT)
Message-ID: <39b2b9d6-8e17-5c9a-4e6e-a8d40f9ca4e0@acm.org>
Date:   Tue, 2 Aug 2022 11:47:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/5] scsi: ufs: ufs-medaitek: Support clk-scaling to
 optimize power consumption
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20220802135423.1007-1-stanley.chu@mediatek.com>
 <20220802135423.1007-6-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220802135423.1007-6-stanley.chu@mediatek.com>
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

On 8/2/22 06:54, Stanley Chu wrote:
> 

There is a typo in the subject of this patch: I think that ufs-medaitek 
should be changed into ufs-mediatek.

Thanks,

Bart.
