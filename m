Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F121757BB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiGTQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGTQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:23:04 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E82558F1;
        Wed, 20 Jul 2022 09:23:03 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso2737349pja.4;
        Wed, 20 Jul 2022 09:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j/7Nq86xQuLWi18Sbz5otnLeWqHxkZyGTPSeuAnlhKs=;
        b=tHGTDDtwPk4MKkQXQKOeE7YnQNmvp1lzmsR73XIs0SPh/+eBY+eGa09w7rZWYzmbT0
         mXTWOz1XUpTSISBnhFPtbr+I2BvL9gcBJCH+zrjiSbC0XhcAPYTVzHJQicNp3JgRrdEv
         Ycn/h1a2Ty0XC0783XrX696KscNIuWHH9V5mif0ugr5Xp4L32YCQatJYAa7dongNm71T
         6srgHkVnbyOkQwqlclWQLMrp1mcUggvW/AG2WLbJ9nZTW8Ll0OHMgG2QLn6pD4Su9uRq
         HxitYUd16Lj5hEozwxWej9h6qfrPEiztMYqFjS9e/0xJugrDXLgVCobogC1V7cJ1r2mb
         J6bg==
X-Gm-Message-State: AJIora+v5S58jDPWFQpoSFba6oqlQSjoEoDFyzeqS4HXOJyVGgsT2WPJ
        v8Xj/IJO/ukJYn33wRRfNf4=
X-Google-Smtp-Source: AGRyM1tqGfJtimyYcs1bWLVlLQ6mD2g4Qr/uCJsVxrhEue2fwXlDDOikx06kNgQUciR02J9JPzCa9Q==
X-Received: by 2002:a17:90b:164d:b0:1f0:31c1:9e88 with SMTP id il13-20020a17090b164d00b001f031c19e88mr6513725pjb.206.1658334182537;
        Wed, 20 Jul 2022 09:23:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a7e0:78fc:9269:215b? ([2620:15c:211:201:a7e0:78fc:9269:215b])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ab8500b0016bfcf8a463sm14058884plr.289.2022.07.20.09.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 09:23:01 -0700 (PDT)
Message-ID: <c4da04a9-3f3d-3e22-a59a-1ab2867a5649@acm.org>
Date:   Wed, 20 Jul 2022 09:22:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] block/mq-deadline: Prioritize first request
Content-Language: en-US
To:     Wang You <wangyoua@uniontech.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangxiaohua@uniontech.com
References: <20220720093048.225944-1-wangyoua@uniontech.com>
 <20220720093048.225944-3-wangyoua@uniontech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220720093048.225944-3-wangyoua@uniontech.com>
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
> The test hardware is:
> Kunpeng-920, HW-SAS3508+(MG04ACA400N * 2), RAID0.
Please also provide performance numbers for a single hard disk and with 
no RAID controller between the host and the hard disk.

Thanks,

Bart.
