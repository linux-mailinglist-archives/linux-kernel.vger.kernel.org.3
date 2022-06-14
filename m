Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353154B6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbiFNQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbiFNQqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:46:13 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E792873A;
        Tue, 14 Jun 2022 09:46:12 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id u18so8228051plb.3;
        Tue, 14 Jun 2022 09:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XeHP7id8WmZTGKkjEha5O21Oln+yx3+YyNSzubTbX7o=;
        b=3aqFb97IjnJxuvyFyiPiS5aRc8qcv/KzzWCbhLOzPwWsffZydPvEK5q+OlNbLyfTUC
         XRBcdeF0AnbTLPH2CTrymAOxUxfHrnnw6LnBKeAxv3+Gv4xjwIdUuQNL3Qw96HhNm/ME
         wwitfPCA22JwEN08ednrwn+e879mCxW9Q2h2FLKUz52mpXDDsUbQsNtcq0xSy3cwbd+9
         Sk0Q0XrnoEdrWW5LJD6uyDPa716SKpWUmxLXMQ3ELL0mem1y5X1Xgq4rL0R/YC4c8v2n
         7b+Nk44MM9Iq+zzJpvbIhTCc56+laL4SjmJjw1EDRuRyySYMiYwsjqgyd+WtTpMG6SSk
         0KHA==
X-Gm-Message-State: AJIora8nnSmmkn8caytKXab7VtKrexWV1wVCagJoxtDgPLDev6nuL8LU
        grDpdLaJo5F+FfSHebcieec=
X-Google-Smtp-Source: ABdhPJxK86lxsFlUeMlIFjj8CFOGjeAe6jXAqNHUGBu5TTD8B3LU8ZdKHpc2a0KclMEGNg2bh72GGw==
X-Received: by 2002:a17:903:22cb:b0:167:992f:60c3 with SMTP id y11-20020a17090322cb00b00167992f60c3mr5277282plg.59.1655225172032;
        Tue, 14 Jun 2022 09:46:12 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id q1-20020a639801000000b003fdfb59bd85sm8064797pgd.12.2022.06.14.09.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:46:11 -0700 (PDT)
Message-ID: <386bfd16-e7be-7f80-cbaa-f55e01d3b070@acm.org>
Date:   Tue, 14 Jun 2022 09:46:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 03/10] scsi: ufs-mediatek: Introduce workaround for
 power mode change
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        Peter Wang <peter.want@medaitek.com>
References: <20220614141655.14409-1-stanley.chu@mediatek.com>
 <20220614141655.14409-4-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614141655.14409-4-stanley.chu@mediatek.com>
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

On 6/14/22 07:16, Stanley Chu wrote:
> +	if ((dev_req_params->pwr_tx != FAST_MODE) &&
> +		(dev_req_params->gear_tx < UFS_HS_G4))
> +		return false;
> +
> +	if ((dev_req_params->pwr_rx != FAST_MODE) &&
> +		(dev_req_params->gear_rx < UFS_HS_G4))
> +		return false;

Please do not use more parentheses than needed. I think 8 parentheses 
can be left out from the above code.

Thanks,

Bart.
