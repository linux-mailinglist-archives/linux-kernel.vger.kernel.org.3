Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF22B4F21B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiDECgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiDECgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:36:03 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5837EA8A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:32:55 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id t4so1369393ilo.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6PtMEKVO1ZTFuSFcYXJpT4vLhMltZRK/gjze2byJKtk=;
        b=pFv7ELs8zrkZDSymxJdDv/zST5AddOFXmbFr8D0+MbU3cDEVc3VIRB+T9GWWCL1Ile
         WChZyFauA4Iftw4l1+TJIWIYd3oOBbJpNKf0MRs+USl+xkORVlUcHo2YzOR2pDGE/yhl
         MtlemEC8QOOtiPBKqGcHCAvuR70cLdeycojY8vi6jF0tCbS2cCYFXblUL3tl3Txj5JiD
         1jIR8LsJsXU4O2IpoESxiUBRyn25/EJMYU+MBtgpaHFfrPeiVHFdUL4Rx2QF4rt/Cjpo
         hEjE7ovBrCAnwxpsGkL0Jwt8obWNNwP2/n+7R+3BCNAY8IjG5JP6twWQSKkoIz8UB5Vx
         bGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6PtMEKVO1ZTFuSFcYXJpT4vLhMltZRK/gjze2byJKtk=;
        b=H6oRt1HKDDoDu9mmue3xyMlIzaV5lyWnYJpaWjF9iRsbzWFrJKuMUIkIVNl/0pSea4
         A/WD9l5O6ANR92SWM5E8vrdWEeYFsvVuJLl97TVId59v2BxSLAiUDvwBKyxAPQdP7WxK
         29ht993sBK1aPEHvXLiiHz1Otl4CVD0DQZmC6VW0PhGs7SoYAIa0/PtPwkc2XyxhmYyL
         wKYawmpgZCRr25IYgnduNr0J3IvNe5/r4qa3MywPvdD4r5TVGTXGNCiNGG4KvhgerKMn
         XHD8HisO1DdKuPlOWFgqkhGpETMlQ3lBBdV98SmvYHANpEGkiqmpyX5I4F40KZtdnRDS
         OPzw==
X-Gm-Message-State: AOAM531FpCyQBN98/RfMH4L2ywwNHy35I4MdwPZ3Pkd56cFSl30KEtPm
        f5ZehKUE/9CNwngTtH7SV3BWQs4lKe4=
X-Google-Smtp-Source: ABdhPJw2u8NRgw7YHmXpVoHIbjVp1kih9R/FZ/ein9KsFEfzjKx2z+Y9vra62lRJ2s+WHuPXesfZKA==
X-Received: by 2002:a63:ae03:0:b0:386:2b5d:dd7d with SMTP id q3-20020a63ae03000000b003862b5ddd7dmr618573pgf.332.1649118122702;
        Mon, 04 Apr 2022 17:22:02 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id w79-20020a627b52000000b004fd8d1e5489sm12935541pfc.87.2022.04.04.17.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 17:22:02 -0700 (PDT)
Message-ID: <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
Date:   Mon, 4 Apr 2022 17:22:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220404182236.1caa174e@rorschach.local.home>
From:   Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20220404182236.1caa174e@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/22 15:22, Steven Rostedt wrote:
> [ Resending due to cut and paste failure of email address ]
>
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> While looking at a crash report on a timer list being corrupted, which
> usually happens when a timer is freed while still active. This is
> commonly triggered by code calling del_timer() instead of
> del_timer_sync() just before freeing.
>
> One possible culprit is the hci_qca driver, which does exactly that.
>
> Cc: stable@vger.kernel.org
> Fixes: 0ff252c1976da ("Bluetooth: hciuart: Add support QCA chipset for
> UART") Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f6e91fb432a3..73a8c72b5aae 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -696,8 +696,8 @@ static int qca_close(struct hci_uart *hu)
>   	skb_queue_purge(&qca->tx_wait_q);
>   	skb_queue_purge(&qca->txq);
>   	skb_queue_purge(&qca->rx_memdump_q);
> -	del_timer(&qca->tx_idle_timer);
> -	del_timer(&qca->wake_retrans_timer);
> +	del_timer_sync(&qca->tx_idle_timer);
> +	del_timer_sync(&qca->wake_retrans_timer);


It seems the wake_retrans_timer could be re-armed from a work queue.

So perhaps we need to make sure qca->workqueue is destroyed

before these del_timer_sync() calls ?

>   	destroy_workqueue(qca->workqueue);


ie move this destroy_workqueue() up ?


>   	qca->hu = NULL;
>   
