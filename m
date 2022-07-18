Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98B6578A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiGRTNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiGRTNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:13:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4182F037
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:13:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z132so10113454iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=ZJEuLsMRKUxpd8gJCMilrz767jCkM6zmrnjpbeCFU9M=;
        b=kKR9I4FVfr4npYm/FwMPeGKnE1tPcWbWEboAMzIbnqmGPBfE0HhcHLODZX9wCjssBr
         pIUHKVSchsGIf/CRmXV3AjI6hb232hHVwMabwFCJwXNIzJhMe/b9sVmdtA2r7mtLtfFs
         4twaLIAXt43x48uQ5vN9z2s1Z8E0PIpg4DoZaTTW6AhYaKY+mAfb2Nhd5DQjizgXwESg
         T8haaDru1vuB3FX/EN/76vlFksF1xER108KfwUr4xtLQVmchCdtRad8ClkBLQ68m5n2e
         zOHsoZG6c7eLCsvZXa1YWo7tTEuhqAOgjhUsI6N7yKddSlOuvbqqmJHFYFtZfMG7vadu
         hIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ZJEuLsMRKUxpd8gJCMilrz767jCkM6zmrnjpbeCFU9M=;
        b=BBSkt1LjiTvYWyAWj/HO+nizME61FeGQOSOVrNr1UivK0LDcev7xSff962OBWVdqlk
         eOarVNR73flWDK8wHsZO4MMPs3bYsupAPYJg3PsIOIQ0mIPqH7DokFyX9HevdfQweLLo
         eWGV1j8k58dtVDnQNZypMhmWaapDZ8ViuWukzR1K1kCcjQ5zTMqnOHnmUNhysS7F2QZ5
         0Auwi9W2TaLd2vNzP26B+lrku5xUz6nhUbn9ObcYYqzzd9JyilR8msY3N5zt4jGSyvtI
         K91QarYTb4vKOYxK8PiAOt1eRE1CzZ1T1bO5Z4RrPQaG8xnS4y7/g4meZ10AbzESgt3H
         d5JA==
X-Gm-Message-State: AJIora9uIS5geJpQxA0rXUQSeKYJYYmWdoRA4QDNsMcYfyYgZw0JJKXO
        xkM3r0oc+wogwITxmd3CigjJG/bpv7qFGw==
X-Google-Smtp-Source: AGRyM1vYRfQKwwNpLfaIlTDzujVOxSzsfBauBFQCXTJMDcVRaclA7QalraSqvoqixrhuat0nLczyCQ==
X-Received: by 2002:a05:6638:1a1a:b0:33f:405d:b1ed with SMTP id cd26-20020a0566381a1a00b0033f405db1edmr15085179jab.164.1658171582231;
        Mon, 18 Jul 2022 12:13:02 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j195-20020a0263cc000000b003417ba4f66asm725116jac.41.2022.07.18.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:13:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220718042408.3132835-1-yangyingliang@huawei.com>
References: <20220718042408.3132835-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ublk_drv: fix missing error return code in ublk_add_dev()
Message-Id: <165817158152.143885.14328206381467598787.b4-ty@kernel.dk>
Date:   Mon, 18 Jul 2022 13:13:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 12:24:08 +0800, Yang Yingliang wrote:
> If blk_mq_init_queue() fails, it should return error code in ublk_add_dev()
> 
> 

Applied, thanks!

[1/1] ublk_drv: fix missing error return code in ublk_add_dev()
      commit: f50e5d670c622349277a46996a70386cc3661b10

Best regards,
-- 
Jens Axboe


