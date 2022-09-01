Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F955A8E23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiIAGPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiIAGPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35046AB409
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662012934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AHSAQIfsvBERzOAtGZgWItZ9BraQujnqLwAcYfSRgQ=;
        b=Ffp4Im38Mw937une5xz/glF8k7pGP6Mezkxeem5LvMprOkMoGOSlD/X1PxHsgfKviKYamC
        hZwq7mSUcqOQM2wKr8EMpTMHFtz11CQsabP7DU5j/kTwf8IfTLqRJTfDyhe6sMgS45UNz0
        DOHrMgn7PieCt1Z03Df9BOU2EA/qMUQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-GkAmRSIUMQiseLFiYFMpUA-1; Thu, 01 Sep 2022 02:15:32 -0400
X-MC-Unique: GkAmRSIUMQiseLFiYFMpUA-1
Received: by mail-ed1-f70.google.com with SMTP id v1-20020a056402348100b00448acc79177so5897076edc.23
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9AHSAQIfsvBERzOAtGZgWItZ9BraQujnqLwAcYfSRgQ=;
        b=haPDUxpubRvveTYHEF1hBzaV1ppXsm/L0Ho7u7CkR/YFdwjMuirl0gN8JkfoHWaqhe
         4WKtpYg/1GX53GVi7xrKRpzXaYfEqHHG5OY1WOIEGTRsFZgAlHwgAcjm/BXKJj7J9Hb4
         1r8nJ+Pu56fQcyWY51f4DZwWqG3+noINXMIct4heC21ZXsARM98DB8W6pZZ/0DaIgJv2
         1d7oeqBTVLAtjbnH1pbJlSJ5CZQzZMEeMCOaGyn/MYz3OSKSdd2E179sb9jz5tBw8AHl
         7EXnWS7W3AHM3khQPabTl4U7UvK39Um4hOCM/0MK1amoFlYDFeLRDK9WsYlixdNMQqNO
         EJZA==
X-Gm-Message-State: ACgBeo2r8Hw7uhlnHg/ABcmhExg1ZCrdrTowSZgvNF8YhCz/1f3EBbvC
        WGPv8ZTB12+IRr/ovlc09ohzSmAiyoqPANtspJAjHW5KulQbmvZ5r/d0/Y3pY7zmvQJ4dLxkCjM
        ictBcfE6ArTMZKMIYJCRK47uP
X-Received: by 2002:a05:6402:4303:b0:448:7014:ed8f with SMTP id m3-20020a056402430300b004487014ed8fmr15462470edc.335.1662012931802;
        Wed, 31 Aug 2022 23:15:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ZxG9abLlCPNUlYBtiai7/mUX9HA6hwTyBhuniMdh4Hjfkn+Em7HoSkQpeL82UF56LB0NwTw==
X-Received: by 2002:a05:6402:4303:b0:448:7014:ed8f with SMTP id m3-20020a056402430300b004487014ed8fmr15462446edc.335.1662012931604;
        Wed, 31 Aug 2022 23:15:31 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id i14-20020aa7c9ce000000b00446473adeacsm733744edt.82.2022.08.31.23.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 23:15:31 -0700 (PDT)
Message-ID: <0e2af6c4-2854-c2e0-9705-e4a57bed31e0@redhat.com>
Date:   Thu, 1 Sep 2022 08:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] sched/deadline: Add should_push_task_dl helper
To:     Shang XiaoJing <shangxiaojing@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220901020855.29951-1-shangxiaojing@huawei.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220901020855.29951-1-shangxiaojing@huawei.com>
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

On 9/1/22 04:08, Shang XiaoJing wrote:
> Wrap complex and repeated code in helper function should_push_task_dl,
> which will return true when task p should be pushed to other cores
> because of current task.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

