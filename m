Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BF4CEA7C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 11:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiCFKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 05:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiCFKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 05:18:58 -0500
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA5027CFE;
        Sun,  6 Mar 2022 02:18:06 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-2dbd8777564so134833787b3.0;
        Sun, 06 Mar 2022 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=FMOobh8nHhcrPpWV4O/wajuKnYqT9MqpD2rk4aIOeew=;
        b=Goedn+VBvsRSba5EGffAp1+WLrLJfspwNpMpUqoW/ooYaehP3heX/hRuDnsyJxzS3/
         gHugUemS2aSDn80bCTFowNaF5KWVcmLRIyAZdNTWKrJe4asm9hSNsnEuDoi9kP1/yv5N
         oZCdqn7jvhMNgpRZzSkbU2vvBivUeCoBrmqwtLtZfaOlTqjikwvLrMpmCnVuufu+OF2c
         7i/IXSJlywGHxK6yeHTOgVUAh+a+E4OVl+0ecIWxxNsz4soz8nGHlkx3c+18UEGiAYZe
         YMM/BxKDzlPbbM1nvjGeaWLpKXHEIew25bWlQsGNmScLjTn8HMDVLGqG+2KSA7Pmr/Zx
         PaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FMOobh8nHhcrPpWV4O/wajuKnYqT9MqpD2rk4aIOeew=;
        b=UZ4jVLLlJiNEU7pJGJ8/nGg4hdFtHBCw8jrTh8Mn4q6pFzm9MX/yV3DpWigXGUVwgv
         FbF17hXHkCQ3jva/O0/ip6aGbmbkhQ3zlaGOL6rgo9EFyGarGCdRyMAMyaJzTy56ZdIz
         ZmzX+LJ28CxsiuUreH21HcMTzjzEqTN3Qyd6FIb0Z47v6V94ldSVIRFFsHnsMaYqTZwy
         WWgbNcQe9rttodR8CHgC8qapntGA57ESKugzioyPIQyqx7W0I8sOMsid4fnJpHh1xqUi
         JfEyiS/NKlpIGAqeIuPbYdpI7n8qsGDcxaWq8Wsqns+hWn6ov1/Y/QmHPKGf2G9Bx4x7
         AkqQ==
X-Gm-Message-State: AOAM5327g9SGRzC9MXXhP5NAm98/lXAdSJvPgsnvvT8t1MaioM3/evia
        6UGC+FRLqsIiWhrQY2y/hAmYIgcP9bZIg9kT7u5XaNXAQeGgM9VR
X-Google-Smtp-Source: ABdhPJxiOhUnhtEwbnu50sJjXz6gV1Z3Rk2jM1FVLyO/ASgHE9+5+Jubw//NwDs2sQTh3QYGJPjxSUbMq6kEGP/RrMg=
X-Received: by 2002:a81:8781:0:b0:2db:da7f:c068 with SMTP id
 x123-20020a818781000000b002dbda7fc068mr4772814ywf.75.1646561885254; Sun, 06
 Mar 2022 02:18:05 -0800 (PST)
MIME-Version: 1.0
From:   Yunhao Tian <t123yh.xyz@gmail.com>
Date:   Sun, 6 Mar 2022 18:17:54 +0800
Message-ID: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
Subject: PREEMPT_RT causes scheduling errors with f_rndis USB gadget
To:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm using Linux 5.15.24-rt31 kernel with PREEMPT_RT enabled, on my
RK3308 board. I set up f_rndis gadget with the following script, and
plugged my board to a x86 Linux computer running 5.15.25 kernel:

#!/bin/sh
cd /sys/kernel/config/usb_gadget
mkdir g_smartcross; cd g_smartcross
echo 0xF055 > idVendor
echo 0xCAFE > idProduct
mkdir strings/0x409
echo "SmartCross" > strings/0x409/manufacturer
echo "SC-1 USB Device" > strings/0x409/product
mkdir configs/c.1
mkdir functions/rndis.usb0
echo EF > functions/rndis.usb0/class
echo 4 > functions/rndis.usb0/subclass
echo 1 > functions/rndis.usb0/protocol
ln -s functions/rndis.usb0 configs/c.1
echo ff400000.usb > UDC

 I started a HTTP server using python3 -m http.server on the x86
computer, and executed curl on my board to download a 100MB file from
the computer. I got the following kernel logs from serial console of
the board:

% Total % Received % Xferd Average Speed Time Time Time Current
Dload Upload Total Spent Left Speed
7 100M 7 7500k 0 0 7217k 0 0:00:14 0:00:01 0:00:13 7218k[ 23.002846]
sched: RT throttling activated
23 100M 23 23.4M 0 0 5948k 0 0:00:17 0:00:04 0:00:13 5948k[ 25.992869]
NOHZ tick-stop error: Non-RCU local softi!
[ 25.993834] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #80!!!
[ 25.994833] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #80!!!
[ 25.995832] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #80!!!
[ 25.995885] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #180!!!
[ 25.996831] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #180!!!
[ 25.997830] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #180!!!

If I turn off PREEMPT_RT, there won't be any errors while downloading.

I believe this problem is not tied to any specific board, and anyone
can reproduce this problem using a Raspberry Pi (Although I didn't try
because I don't have one). I would like to ask for assistance
regarding this problem.
