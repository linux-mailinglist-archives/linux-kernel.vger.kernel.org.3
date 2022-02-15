Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4D4B75ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiBORJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:09:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiBORJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:09:44 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA553107091;
        Tue, 15 Feb 2022 09:09:34 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id e17so16405430pfv.5;
        Tue, 15 Feb 2022 09:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=waumpi9D3AhawuraVenaOvCaaY6ji2zNehq7XYS0irM=;
        b=s1xylUsUk8tCQqFkuvOCI9ePt9XavjfE1IAQuXCelx30qOn2T6PN6DCL2L687TQuGG
         jkWG+BTSM4L7AFFxqUTC6xlUuran0Z+fDdEF4M8b+lmg/F15xOmArwEPsws0htJK2EOL
         lNawDPeg4R+BWa6iErMtmHVRFopKGjM2LoVYRDtYm95qRfuv4Ivc+okBwPix+qtd1dLm
         AtgQOK4IY4WmKR/CyuZtd640H4xvKAuZ2W50jCMsO2A0BRlpRHU7YJC0KUDSGn9O78Ag
         PCsN22aOhVLn8QXsiXvppPszyeEWSWMr1cOKSgjBqviMMLRnuCLgvUaHDPysp85lPXz7
         MCSA==
X-Gm-Message-State: AOAM531uungCeSTXAyjznZPFhIJSJO0orkIWvZ43zCVw+Nkq6fCjcEoy
        q0QhwMHX0CMydP7esLImiVRF55SwAgbWqw==
X-Google-Smtp-Source: ABdhPJwms27th60Cg/9NKcaxQfDpo9oEZNZEBqw6D6VcQXGCD43HEc4AoAXw/TpKwYbLid+AmKbiLg==
X-Received: by 2002:a63:d815:: with SMTP id b21mr4254601pgh.237.1644944974164;
        Tue, 15 Feb 2022 09:09:34 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id kb17sm9540899pjb.1.2022.02.15.09.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:09:33 -0800 (PST)
Message-ID: <da58f5c9-74a7-f44c-a8b8-78e694b41ed9@acm.org>
Date:   Tue, 15 Feb 2022 09:09:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>, Kiwoong Kim <kwmad.kim@samsung.com>,
        'Adrian Hunter' <adrian.hunter@intel.com>,
        'Avri Altman' <Avri.Altman@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com,
        vkumar.1997@samsung.com
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
 <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
 <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <007101d81eed$4d120a60$e7361f20$@samsung.com>
 <3f2938f7-2a9e-60e8-5237-fe7ebc3b4296@intel.com>
 <000001d81fcb$3b962f30$b2c28d90$@samsung.com>
 <1cb4db5f707692afedb005e2577f667f5e48e66e.camel@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1cb4db5f707692afedb005e2577f667f5e48e66e.camel@gmail.com>
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

On 2/15/22 03:00, Bean Huo wrote:
> The name of clk_scaling_lock has explained everything, for the platform
> which doesn't support load-based clk scaling, doesn't need to hold this
> lock.

Hi Bean,

Have you noticed Adrian's reply? I agree with Adrian that this patch 
breaks the UFS error handler.

Bart.



