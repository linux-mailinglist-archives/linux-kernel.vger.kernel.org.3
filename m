Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38C3519788
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345027AbiEDGrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiEDGq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:46:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E01A04D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:43:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so1017639ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vmfGvdzEe7Sq3XbMqL7KmA39B54APPzcmwPdJivs+Iw=;
        b=yUHggd5XkRGX7BVJ4f5wXLAMvX9qY4kDBGmX5mQ+cfxmRE/aFUntAgddgmt0hj+6ZY
         aDH/UyHEGP4FFDNJ4HjId6UVjym7p8vIejq+c28syw0lcSafOBNduiTzH3cAcn9OXCpY
         tDJpHzCtfMXinvogMOhlwsjAKW+o5l5tmv4g6GAoPKZt6ee7vJ+wRK+INu7gUjIsPXy4
         sgXx28LeVmUJS22bHNbAdA/WmtCn55/uro8ypXAJu5n8Gc9MvsNT5XlYunSnrZF4m3dD
         uW4QdavtPhGGLgwT/G98i+aZsGo2Edv+CRx9E6YzbGuywWlxUxCkHZffHMH+OTm8s/Fu
         TuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vmfGvdzEe7Sq3XbMqL7KmA39B54APPzcmwPdJivs+Iw=;
        b=6w8Lo7qGTS5LNgIDPfM6VkhvYjyp/K5w0SGTfCpk9dKlt6BGvO2DeyppeDRa4aiPuj
         pWjKTY0CC8MniyNCQg5tiiXGRY4J9ZJIRA2778qrQC+XpffWtgO15Fk6H65WDPANYA4k
         u2ONJhr9l3T7GERkZmjnplOetWZ6rg5Mx2LdfPAc4apd1Wh35B3/Bz+7OKKlOwkP2YB9
         oW70sKfyTjuC71r1K1nAXbHbuoPBfRzn6TWqGkzRWd7fjipTFD/0JG+ZsvTmVnkivY/z
         Gv5zSePPNRiUWGm8JJKzpqBuLSnu/57bjpZZb8Cfy0wwT1CTrWDDF5zYWkCGft2AxVXu
         zWQg==
X-Gm-Message-State: AOAM530QPCQzWq9W8TymnhaFlPqDv3zWrSUaf6nxrXCFaGucmQuWP/Hl
        3zKhFVlLr/Nda4di/RHoDYeW7g==
X-Google-Smtp-Source: ABdhPJxRFMk5S9I6bl1IFF4cZ1hDJJ33NG9TVpbihrfMxZsC0Wy/1hStbekFcMTYa86v+ErMcU4qMA==
X-Received: by 2002:a17:906:dc8b:b0:6ef:86e8:777 with SMTP id cs11-20020a170906dc8b00b006ef86e80777mr19342462ejc.326.1651646600068;
        Tue, 03 May 2022 23:43:20 -0700 (PDT)
Received: from [192.168.0.208] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hw7-20020a170907a0c700b006f3ef214e16sm5385364ejc.124.2022.05.03.23.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 23:43:19 -0700 (PDT)
Message-ID: <5eebd441-ded0-3668-f592-05bdeef920b1@linaro.org>
Date:   Wed, 4 May 2022 08:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH net] NFC: netlink: fix sleep in atomic bug when firmware
 download timeout
Content-Language: en-US
To:     Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
References: <20220504055847.38026-1-duoming@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220504055847.38026-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 07:58, Duoming Zhou wrote:
> There are sleep in atomic bug that could cause kernel panic during
> firmware download process. The root cause is that nlmsg_new with
> GFP_KERNEL parameter is called in fw_dnld_timeout which is a timer
> handler. The call trace is shown below:
> 
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:265
> Call Trace:
> kmem_cache_alloc_node
> __alloc_skb
> nfc_genl_fw_download_done
> call_timer_fn
> __run_timers.part.0
> run_timer_softirq
> __do_softirq
> ...
> 
> The nlmsg_new with GFP_KERNEL parameter may sleep during memory
> allocation process, and the timer handler is run as the result of
> a "software interrupt" that should not call any other function
> that could sleep.
> 
> This patch changes allocation mode of netlink message from GFP_KERNEL
> to GFP_ATOMIC in order to prevent sleep in atomic bug. The GFP_ATOMIC
> flag makes memory allocation operation could be used in atomic context.
> 
> Fixes: 9674da8759df ("NFC: Add firmware upload netlink command")
> Fixes: 9ea7187c53f6 ("NFC: netlink: Rename CMD_FW_UPLOAD to CMD_FW_DOWNLOAD")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
