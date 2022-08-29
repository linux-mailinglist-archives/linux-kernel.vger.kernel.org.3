Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF89C5A4403
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiH2HmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiH2HmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B94F1B6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661758930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqnlFO+78/vgxZVb4wxxYkdpdCrDcq7ztOpTYe2hVnY=;
        b=BLX+uIqZEGbkJ2UU2jQJTUkftb/VmE/9m07nj9YfIzLkQ1C8NVpiuiZLx+9F1SpfQACXfc
        W1UGPEzFj4mOrY9E+cwdgelcSuI21UGUFx9m0scmTaLbr8voWq1AO1kWNBRNyBS1fKzLFs
        C4fGTQD1LgfdcVzeY8KEqAGLel6x6pA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-136-H2gGlcNKNPKdTt4WAGfuQA-1; Mon, 29 Aug 2022 03:42:08 -0400
X-MC-Unique: H2gGlcNKNPKdTt4WAGfuQA-1
Received: by mail-ej1-f71.google.com with SMTP id sb14-20020a1709076d8e00b0073d48a10e10so1931076ejc.16
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iqnlFO+78/vgxZVb4wxxYkdpdCrDcq7ztOpTYe2hVnY=;
        b=Lc9XSOcIibAmYyLRX6PmKspHBmS+dVoK8M24nIC2fQ3jrb7jD8AiAKuTHWJDPusZgD
         XOj7ygk9jBFgVFtipxLNvBavmOsdtd160Z4dUsDM3RgjEDpabwdNCtDKol0kZUJckXE+
         87by8NHazeWMPE4hDJn0ygYyqRqWBo/Gu37cA81R8qqI0j39zfLF/1XTvnmUQPwRkH/c
         cVPP9paCfM/JHfC2LgzhYWIwjSWTTEQuwMipWy5HDdlFO9OZVYx/RIYt2sQwwuiqowxN
         A9ydel8UDCObr7oNO1P01Z5CCXqVP9W/UuS6vl6/E0f2sUNGc2fqf81pttUya4/gbSde
         Zp9g==
X-Gm-Message-State: ACgBeo1xPA0uZdDCNC5ron7xCWdXSYVMIi7ZyJJhsOVAFmYmG1FGN4mI
        Mt2EOJkmfF6Wtp1CatMicbclPa+82LnMTOvBLREjIZ7KHy/BIy7eTGvMSdQiGaA45HSbcbT7zZ4
        IQYmApPykpRkioUG6IV3ydQnq
X-Received: by 2002:a05:6402:34c6:b0:43d:8cea:76c0 with SMTP id w6-20020a05640234c600b0043d8cea76c0mr15959398edc.268.1661758927689;
        Mon, 29 Aug 2022 00:42:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ekwDPfgZKmb7fmWItdGyXBBlFTqii3LiOdilaa1BcYBiSDfub8XZ4UrO6NrFrkz8SDWqcgA==
X-Received: by 2002:a05:6402:34c6:b0:43d:8cea:76c0 with SMTP id w6-20020a05640234c600b0043d8cea76c0mr15959379edc.268.1661758927464;
        Mon, 29 Aug 2022 00:42:07 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906300400b00721d8e5bf0bsm4134102ejz.6.2022.08.29.00.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:42:07 -0700 (PDT)
Message-ID: <d35c5522-5e51-929c-61d5-cba02e3320ef@redhat.com>
Date:   Mon, 29 Aug 2022 09:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next v2] sched/deadline: Add replenish_dl_new_period
 helper
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220826100037.12146-1-shangxiaojing@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220826100037.12146-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 12:00, Shang XiaoJing wrote:
> Wrap repeated code in helper function replenish_dl_new_period, which set
> the deadline and runtime of input dl_se based on pi_of(dl_se). Note that
> setup_new_dl_entity originally set the deadline and runtime base on
> dl_se, which should equals to pi_of(dl_se) for non-boosted task.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

