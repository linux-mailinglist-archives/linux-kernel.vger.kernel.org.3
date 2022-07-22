Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA957E5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiGVRfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiGVRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:35:41 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780D5140DB;
        Fri, 22 Jul 2022 10:35:40 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so8748208pjq.4;
        Fri, 22 Jul 2022 10:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UoXi1nudRHl+6dVP3UV/0Pn5DwnhU1+hJ70HZ4cZSbk=;
        b=NOol5CJcU5mgDelr7GNlH2f9fa5lLJLKzbnGhfPFiWBxYlgq78HQTVpK4Gmqxgaglf
         +fAI+oSlQ2hOVSkHFPPYUMwZutVLAxKLuQ6/dAUuPUdImoe5QsIno8I3wkwc4k/MoWx+
         tHLeKBVmt1M/ayRmJb1jm137JidjSNxqaW+tkM4pSmiOi46mUCKvxqA/zV7vJ14Dh4Hp
         KgfkPa5XpCc/E2UILZ53X5x4vGq7liVpTrtI+vNZK7DlPWKWoi2V6ejfL0zmmbqJFuOC
         OKn5gZm7nMZ0/K6J60ZiPRTz9w7narR8Rz+ycdJ430nFEYKjYI+JKym3Whh5Dcu/ai8j
         l9JQ==
X-Gm-Message-State: AJIora+5h/FUKH/KIrARbchSms8tVrxUMKGHp9jU9r59ESJ9JMbnn5uj
        LbMZKqxEcOplsGwH8cRA0xU=
X-Google-Smtp-Source: AGRyM1ug8+OjA7LmfwWCaRJ98IxRXR0KGkO8l6q+/OcfxHEcFV54X9sIv5D8dzSBKHPI2xw6FHUnMw==
X-Received: by 2002:a17:903:1207:b0:16a:7e87:dad3 with SMTP id l7-20020a170903120700b0016a7e87dad3mr902343plh.99.1658511339806;
        Fri, 22 Jul 2022 10:35:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cf6:7e29:d977:6fc7? ([2620:15c:211:201:9cf6:7e29:d977:6fc7])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0016bea26bb2asm2195573plh.245.2022.07.22.10.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:35:39 -0700 (PDT)
Message-ID: <da0fe451-c036-cd18-7eb2-55c51c104ab5@acm.org>
Date:   Fri, 22 Jul 2022 10:35:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] block: Introduce nr_sched_batch sys interface
Content-Language: en-US
To:     Wang You <wangyoua@uniontech.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangxiaohua@uniontech.com
References: <20220722095120.371212-1-wangyoua@uniontech.com>
 <20220722095120.371212-2-wangyoua@uniontech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220722095120.371212-2-wangyoua@uniontech.com>
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

On 7/22/22 02:51, Wang You wrote:
> The function of this patch is to add an nr_sched_batch interface under
> /sys/block/sdx/queue/, which can be used to set the number of batching
> requests. Of course, the default value is nr_requests and will follow
> nr_request when it has not been changed.

Do we need this new parameter? How does the performance of reducing 
nr_requests compare to configuring nr_sched_batch?

Thanks,

Bart.
