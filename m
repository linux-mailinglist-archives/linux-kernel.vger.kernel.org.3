Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD14AC429
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384279AbiBGPnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiBGPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:42:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B8C0401C1;
        Mon,  7 Feb 2022 07:42:05 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u12so4303318plq.10;
        Mon, 07 Feb 2022 07:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=7ig8by8e56o4EYLYkc6fPLQYZasp8vJLPsQ0K6bAyGQ=;
        b=dwar9GQFDfzTw7a7hJjbwZ13AurkkntTpTzLErO1MMQf0Knh5xkPjBG9ESOaqZd/1f
         ILXS2mBNHSJw+csRz6rxrq49Ts0FCwor+bewDf6rFT5FqzCiT+jXvHV+OxGNVWxTJYOQ
         TsAQEzujBbeKQXN7xvF3y5Wty1O8mDqYcFX30aCwIuL4/aOcVvC2GXH63FREG2LPgF+i
         LbCpeDQnuccpGUHRDOGWksr+6M7ftkvtN/Z9Tyq69ZV6uFR6mrngcXNUVl4sTT56pN7R
         zQ87waDSxWJfYQDo6zYrSDCPtEONsl6/BTrJf8sNMCSPIUZbcU7Sh+uxgTtOeKSt/V+D
         vV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=7ig8by8e56o4EYLYkc6fPLQYZasp8vJLPsQ0K6bAyGQ=;
        b=d6+ooYttikNGFh+gmJiA9isgJzuG4kxjjrmboecrzuLN/X6qrtI1vQ8leug6hShCHX
         AUFT+OqEg8KmubC/8VdXf96dNH1DRhGE4wZHom2czPXSgmHFOjlkIkSHfxQGc3IakFY+
         1GkNdTmwIzRRVlV5nNPakuVbZgoXk3wCplVpy/3u7u3qPyx2r+28ydFedQwwhQD883XC
         wus4TM/kuMs+FGJgjmvZWxDH0ONmqhRcUK9oCpQWbkHQEZAKc1ZRidLCzrSMq/R3+GAk
         TWdFtRvljZotrlFWXbTRkUe59+0JjMYXoG0i/q/vNMhcHxY/dvOhesvffahA/PUS41i2
         cWkQ==
X-Gm-Message-State: AOAM533Rq4JndCaQGtqfcJ+fA8ilnhCN0NpDrpAy/gU4ORp23TRRBxHY
        1acfLpY0wpWtf0q5WbvdNfE=
X-Google-Smtp-Source: ABdhPJx337OIo+YSoTn/w0nURrlCWi4puuCf3DsAZ40orZvwh4CqnAzGSj1Fbw1jU4VlcSjvBzE9Ew==
X-Received: by 2002:a17:90a:5407:: with SMTP id z7mr165714pjh.7.1644248524937;
        Mon, 07 Feb 2022 07:42:04 -0800 (PST)
Received: from [10.59.0.6] ([85.203.23.80])
        by smtp.gmail.com with ESMTPSA id a37sm8711111pga.3.2022.02.07.07.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 07:42:04 -0800 (PST)
Message-ID: <f04b6000-f128-f928-0e3e-e3acc206d2d1@gmail.com>
Date:   Mon, 7 Feb 2022 23:41:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     jic23@kernel.org, lars@metafoo.de, valek@2n.cz,
        gwendal@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] iio: light: opt3001: possible deadlock in opt3001_read_raw()
 and opt3001_irq()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible deadlock in the opt3001 
driver in Linux 5.16:

opt3001_read_raw()
   mutex_lock(&opt->lock); --> Line 399 (Lock A)
   opt3001_get_lux()
     wait_event_timeout(opt->result_ready_queue, ...) --> Line 276 (Wait X)
   mutex_lock(&opt->lock); --> Line 412 (Unlock A)

opt3001_irq()
   mutex_lock(&opt->lock); --> Line 693 (Lock A)
   mutex_unlock(&opt->lock); --> Line 730 (Unlock A)
   wake_up(&opt->result_ready_queue); --> Line 733 (Wake X)

When opt3001_read_raw() is executed, "Wait X" is performed by holding 
"Lock A". If opt3001_irq() is executed at this time, "Wake X" cannot be 
performed to wake up "Wait X" in opt3001_read_raw(), because "Lock A" 
has been already hold by opt3001_read_raw(), causing a possible deadlock.
I find that "Wait X" is performed with a timeout, to relieve the 
possible deadlock; but I think this timeout can cause inefficient execution.

I am not quite sure whether this possible problem is real and how to fix 
it if it is real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai
