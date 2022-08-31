Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851635A7A34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiHaJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiHaJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F0CE46B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661938135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33ERTiT1rWucI/K0hCNpwjOdUqVNd9TBey+In04O250=;
        b=Rv1GGuE0QTlhTjKFdFfmEHwDTfJjahcRYq0F+nva3WQDDqBdOy7xayRujiBJBOuisGm4X3
        0goRuCcBUxc9l1B7YyfLmIzS8+d/NoC1pz9lRxhNKp2MfdhyuA8jxAlnMlBwjlQmqSzfhV
        jrMmCR/GU2vbQ+3juCQuA29uExIjIDA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-282-5StsWnvaPqGV-8dj2snmnA-1; Wed, 31 Aug 2022 05:28:54 -0400
X-MC-Unique: 5StsWnvaPqGV-8dj2snmnA-1
Received: by mail-ed1-f69.google.com with SMTP id h6-20020aa7de06000000b004483647900fso7143577edv.21
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=33ERTiT1rWucI/K0hCNpwjOdUqVNd9TBey+In04O250=;
        b=Dk+3KcWKFvQZTAAJQ6wZQ6vnKcLj007NhPNGPrbxL/Als7Q8KP3VEf3WqDAuzyVNUE
         3f36BI/VGXY0dyWaYLUoEpS74lQnFclgAk6CjucojX0wjWgMLL9Roc24z/WXsx5JrTEA
         78LSSxKkphjQAk7Q2uHRTiqBaOECOOS7vCoh9Ow+OblgYfrcdn9d2wAIrKEc70c+3CUx
         /1pk2Eb96dcppAn52/UrZ11wKROMDMYS18cdthahUbQQB5xF/FWVfq5qMR0y+/Gxdt7o
         E17FYamtLK437Udlj5cdR+hZ4lqWs26MhRxeWmzEzBfubKR5A9egNCDgIyaQMowqp3BM
         //9g==
X-Gm-Message-State: ACgBeo2m9e5Leeu8kzij16BEaAAbzBWJDOvlLEWScrq27zQsciQdjaC+
        WOjyCJuF02QtWxqnOL8FchzTHPYAA2lH95hnzGn69I7+RxLSLtPOKvxx+jhynPJHnJKlgHcqPNe
        xzsVr2BXmOz/XA2nvH4A5U2PH
X-Received: by 2002:a17:907:9712:b0:731:67db:1b48 with SMTP id jg18-20020a170907971200b0073167db1b48mr19654195ejc.754.1661938133155;
        Wed, 31 Aug 2022 02:28:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73SJaK7/gl7hf6NQgj0GbJyOTFLBtk5YRiTbkFisPwkEDXpvDDslqCuMUZEqHeS5iINoIQlQ==
X-Received: by 2002:a17:907:9712:b0:731:67db:1b48 with SMTP id jg18-20020a170907971200b0073167db1b48mr19654176ejc.754.1661938132951;
        Wed, 31 Aug 2022 02:28:52 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906308b00b00740e88177desm6554267ejv.125.2022.08.31.02.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:28:52 -0700 (PDT)
Message-ID: <f3fe439e-15ce-a77c-de6e-76e2abd4bf61@redhat.com>
Date:   Wed, 31 Aug 2022 11:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] sched/deadline: Skip meaningless bw updates in
 dl_task_offline_migration
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220829115904.28560-1-shangxiaojing@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220829115904.28560-1-shangxiaojing@huawei.com>
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

On 8/29/22 13:59, Shang XiaoJing wrote:
> Skip meaningless bw updates on root domain if task still stay in same rd
> while calling dl_task_offline_migration.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

