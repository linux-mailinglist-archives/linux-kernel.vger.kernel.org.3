Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD75A43D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiH2Hfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiH2Hfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33311826
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661758529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcP+F2e+OAUzwbCnQmw8P2T4Qvhjr6zsaFRIn6mVHYE=;
        b=LI6eH5rvEBEA7szzyPQaUxFJQ4yKE6W4cWPbv4DwaO19eBFjb0MxlpZqgNlfQ89ic7tx2T
        G0ziHx4LLob+oYD9cfhzDKUbAsTrPhwo8fGiyKp7oQznHsvpmdjVPrIi6D0AxPDVScU45X
        OamQCOOmIhrYA1x/kZ0CKY3v/jP0tSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-30_UKTKtN5iQ10MxOKCOhw-1; Mon, 29 Aug 2022 03:35:27 -0400
X-MC-Unique: 30_UKTKtN5iQ10MxOKCOhw-1
Received: by mail-ej1-f71.google.com with SMTP id qk37-20020a1709077fa500b00730c2d975a0so1901399ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tcP+F2e+OAUzwbCnQmw8P2T4Qvhjr6zsaFRIn6mVHYE=;
        b=Y07vGoWkXXwsSI/rniozlbDMf6ggrldA6C9HZbBBYdbVfX1tpdXXIB8o79DkBKrkJs
         pxg8/tZpLd+AWOw6kclFNkImnsVlfsXlKInI3WtpwCvkimdDSiU9B4NMPG/RbL4PJpQI
         M0QJy/VW5RvAPYF5vd1hE95PQOAASh3JNsT6SaX1fiIyZBwfHVST7BCxAZUFz+rAZ40D
         XnVuHdAkFslzBK01wD45VrZJ5EQBhpwuoFzGmZqxquIGcdSnKk2gMoHU9VqMOtZZ+A7M
         lWMk7XeYS8eqW9Xa5tqyH2h8qW/fz9Fcoa32TAMGBTNAaVr5bAC9YraH1JU3znXY1Rew
         KHIA==
X-Gm-Message-State: ACgBeo0LbXEZiv1tfWRQIP6uAW09CfSiDk0gUrGj7XoVnu6JIsvDprt4
        I1LTpeW+Yc9NlxI4D5fR9+u5f/BRSghoT/pcCMElBshu1ONc0NyvvJb2K+U4iq/4XyFxbBkjCB2
        A/sM02r70IO9ypAIuRud+1hBg
X-Received: by 2002:a05:6402:530d:b0:446:e22:cca2 with SMTP id eo13-20020a056402530d00b004460e22cca2mr15430928edb.237.1661758526476;
        Mon, 29 Aug 2022 00:35:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4MiSP9BECDttArqN6kT+7CWuzNZjw8M6tgtyObcNb/XVwXqqpJ4eATlc+XOF46eJ/Ayo4K2Q==
X-Received: by 2002:a05:6402:530d:b0:446:e22:cca2 with SMTP id eo13-20020a056402530d00b004460e22cca2mr15430910edb.237.1661758526216;
        Mon, 29 Aug 2022 00:35:26 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id em5-20020a056402364500b00447e5983478sm5235257edb.76.2022.08.29.00.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:35:25 -0700 (PDT)
Message-ID: <aad5705d-2a7e-4564-6762-fdb3323f8f76@redhat.com>
Date:   Mon, 29 Aug 2022 09:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next v2] sched/deadline: Add dl_task_is_earliest_deadline
 helper
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>
References: <20220826083453.698-1-shangxiaojing@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220826083453.698-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 10:34, Shang XiaoJing wrote:
> Wrap repeated code in helper function dl_task_is_earliest_deadline, which
> return true if there is no deadline task on the rq at all, or task's
> deadline earlier than the whole rq.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

