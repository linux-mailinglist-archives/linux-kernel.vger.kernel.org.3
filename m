Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9155A53E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH2SWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH2SW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:22:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990F56B666
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:22:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k17so4649756wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4YAAlethIIQrFR2vpBd24EfrwJUTcM+nANhEdJiEGZY=;
        b=bHYesJDpDAUyQBJGkb8LU+f8EsMHr8Cig+upMJ5BCiK1x34xoEscZ1dMeu12rnXEnL
         VYS4L2HsLD4k2agPI8oVyD9mUvYZHAtBliMaZSQMOGwE06LKF62aH9WQMtNVKDjeKFMQ
         9y0Rfwpk6K+RP4CU0J0gzG/qeck3ZSSR6ay31HuK4cFqE6UONwfWgoGu2VaEwwxWsfv4
         g9oseEN8BpAO8afKRTqOhdbFAStScyCRnh2jVoU2/eTCHaEFwamhadHyHMZcOfVumMRJ
         Budjw7wsSEbM0RcnVLaUN9BSZdfN+nH76R1/wiBSDrJ07jU7xFKfH4LNadBslNtjj15+
         5dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4YAAlethIIQrFR2vpBd24EfrwJUTcM+nANhEdJiEGZY=;
        b=aYOCb+W2kfQl0wtm5YG22T/TGyZcseYk+9lIm4EbiL4d6H6SNVcNULd3diUHwL1hJG
         oyhaPw4585LePEol70wI00FBS/uVb/fCwuiZeCVha6Bh378wkgjXszZnKJjUYYy4Yaw8
         T2HLGy6XCt4NJ1D5dHw9hCAbu5mMA/5V+qaL20F5g90Fj3wvqUJmnHIQc+yUzTJe7VLP
         3Sdv7mmPv4q2QRwsb6qAnVGZ7yPadMvdJX4FinkNGvJGmneMcIDd+de78y2TGrg5PLYw
         EAYlkgofFxsUfqJhpyvvRo8InkYVHc4m/xecWl5ta87BakFNO4Bt/7AUhPaBZpbqhPKc
         yh1Q==
X-Gm-Message-State: ACgBeo2GnuVn6PDbzlXkIOZ415LOkEGB19iGNyk51mRW6MuSkrevKd/s
        F2ZDIqwFIF75MWMk88aqFV6eTQ==
X-Google-Smtp-Source: AA6agR5vxwaT26xzVQIcy+er8KV9MSlztxuA03M76VkFtwqEgGVz+DeqcteBePjd3ZsWZZTm9zZKCg==
X-Received: by 2002:a05:600c:3555:b0:3a5:d319:35cd with SMTP id i21-20020a05600c355500b003a5d31935cdmr7310132wmq.161.1661797346101;
        Mon, 29 Aug 2022 11:22:26 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c2d9400b003a604a29a34sm9230925wmg.35.2022.08.29.11.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 11:22:25 -0700 (PDT)
Message-ID: <3efdb052-d95f-9093-e6db-02548dcc5126@arista.com>
Date:   Mon, 29 Aug 2022 19:22:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/31] net/tcp: Calculate TCP-AO traffic keys (fwd)
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
References: <alpine.DEB.2.22.394.2208271630440.6645@hadrien>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <alpine.DEB.2.22.394.2208271630440.6645@hadrien>
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

On 8/27/22 15:31, Julia Lawall wrote:
> Please check the kfree on lie 332.

Hmm, I don't see anything criminal here, but I can do for version 2:

:--- a/net/ipv4/tcp_ao.c
:+++ b/net/ipv4/tcp_ao.c
:@@ -939,8 +939,8 @@ void tcp_ao_connect_init(struct sock *sk)
:                ao_info->snd_sne_seq = tp->write_seq;
:        } else {
:                WARN_ON_ONCE(1);
:-               kfree(tp->ao_info);
:                rcu_assign_pointer(tp->ao_info, NULL);
:+               kfree(ao_info);
:        }
: }

just to make static analyzer happy. This part of the code is anyway
under WARN_ON_ONCE(), so it's not something that actually runs (as long
as the code is consistent, it's only error-path to free memory if some
code checks become broken in future, to avoid leaks even than).

Thanks,
          Dmitry
