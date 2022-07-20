Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0777257BB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiGTQVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiGTQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:20:47 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3031845050;
        Wed, 20 Jul 2022 09:20:46 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso2561314pjp.2;
        Wed, 20 Jul 2022 09:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EtY/SeORzLrSCr1jdA4Qjx8UUc6ri7seQlaa4SBenzg=;
        b=SJ9ADJYohcx8f3T1z2IBbwrkkE3K5hXg6tsSiA+RweNl7q3wA67GwE4/0pqbCxT1O0
         sSUlA3SAzH8MpU5F+v7xGQrAhx1svURrx1phy9vG9DyhQVHiSbvxxkBARIZCu5iAL/T8
         idLeFk2FgXKOpuW8oySrA4nq7jfmCRaxcsTv+ir3ntV4sOZ0lEqwDRYgIQzgCHd185FR
         lz9Kj3dODd5NHuy86cDN2WDjgs/w73S+CsQarugd4C8cjFYSOLBBRFyB6xsE912ZNdMN
         7k3DRYQkL9XG+6fgqbKuuQjRHPRUWH0TpLPSuqQC248cO2szAlKb8AYNwjwEWyaHp6Xx
         31Sg==
X-Gm-Message-State: AJIora/ZdWKaUaFtYZSZlYXYoZXeZbwLN9TN5C95YFwOB/cSNZM0dZN1
        22X8q05+FiaoMcJeEyGbuEw=
X-Google-Smtp-Source: AGRyM1tO6LqwlGx+Ff4fF8RhH1idbq59pDQaFMUGQaaFg4pls5nHFvUtysp2E3y/dodMidWO7zTV+Q==
X-Received: by 2002:a17:903:244d:b0:16c:52f1:d12 with SMTP id l13-20020a170903244d00b0016c52f10d12mr40268309pls.44.1658334045300;
        Wed, 20 Jul 2022 09:20:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a7e0:78fc:9269:215b? ([2620:15c:211:201:a7e0:78fc:9269:215b])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b001690d398401sm14465600plh.88.2022.07.20.09.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 09:20:44 -0700 (PDT)
Message-ID: <21e7c959-6365-8029-d26d-985ff888333e@acm.org>
Date:   Wed, 20 Jul 2022 09:20:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] block: Introduce nr_sched_batch sys interface
Content-Language: en-US
To:     Wang You <wangyoua@uniontech.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangxiaohua@uniontech.com
References: <20220720093048.225944-1-wangyoua@uniontech.com>
 <20220720093048.225944-2-wangyoua@uniontech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220720093048.225944-2-wangyoua@uniontech.com>
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

On 7/20/22 02:30, Wang You wrote:
> The function of this patch is to add an nr_sched_batch interface under
> /sys/block/sdx/queue/, which can be used to set the number of batching
> requests. Of course, the default value is nr_requests and will follow
> nr_request when it has not been changed.

How can reducing the number of batched requests increase performance?

Please provide performance numbers.

Thanks,

Bart.
