Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6984EB464
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiC2UEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiC2UEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:04:41 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB11E5A6A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:02:53 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 24878 invoked from network); 29 Mar 2022 22:02:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1648584169; bh=/g4KKIPXUZrOJnlssSBP5HQLS4UfmGVodkLjCw9J1b0=;
          h=Subject:To:Cc:From;
          b=DEuCG1tIaXH9sZAbtuBdbVLD2LxRj6co6BgAgvcnusQU5ab1fK3tIaGSl+Y/u1KYU
           qmdG3RjaQ+Hx9gTyWYcvZlUG/298SP3O2JKK2oyD36jI4XHt+Dd94tCqdv8GoZkWaQ
           Ai3NPW4CNGAISH84TUShgAQgmXvngpw33oxyIIPo=
Received: from aaew62.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.126.62])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-rtc@vger.kernel.org>; 29 Mar 2022 22:02:49 +0200
Message-ID: <1595f3c3-ea44-0c1a-8375-211789c64590@o2.pl>
Date:   Tue, 29 Mar 2022 22:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 8/9] rtc-cmos: avoid UIP when reading alarm time
Content-Language: en-GB
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
 <20220107124934.159878-9-mat.jonczyk@o2.pl>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <20220107124934.159878-9-mat.jonczyk@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: a28fd5f8788c77f0b92c197d82dc2fff
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000B [cXNE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 07.01.2022 o 13:49, Mateusz Jończyk pisze:
> Some Intel chipsets disconnect the time and date RTC registers when the
> clock update is in progress: during this time reads may return bogus
> values and writes fail silently. This includes the RTC alarm registers.
> [1]
>
> cmos_read_alarm() did not take account for that, which caused alarm time
> reads to sometimes return bogus values. This can be shown with a test
> patch that I am attaching to this patch series.

Hello,

This patch and the following one went to mainline as:

commit cdedc45c579f ("rtc: cmos: avoid UIP when reading alarm time")
commit cd17420ebea5 ("rtc: cmos: avoid UIP when writing alarm time")

After some investigation and testing, it turned out that the problem
was hidden by the algorithm in __rtc_read_alarm() and __rtc_set_alarm()
and mostly did not affect existing code.

It happens that both __rtc_read_alarm() and __rtc_set_alarm() call __rtc_read_time()
before reading / setting the alarm time. In the CMOS RTC driver,
the function cmos_read_time() waits for the UIP (Update-in-progress)
bit to clear before proceeding. The UIP bit is set > 244us before actual
update begins, so there is usually plenty of time to read the current time and
then the alarm time. My synthetic tests did not catch this and I thought
that there was a problem.

Therefore, I will not be sending a matching fix to stable.

I have discovered this as I was working on exposing some form of
__rtc_read_alarm() in debugfs for driver testing purposes. I'm going to send
RFC patches for this shortly.

Greetings,

Mateusz

> Fix this, by using mc146818_avoid_UIP().
>
> [1] 7th Generation Intel ® Processor Family I/O for U/Y Platforms [...]
> Datasheet, Volume 1 of 2 (Intel's Document Number: 334658-006)
> Page 208
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/7th-and-8th-gen-core-family-mobile-u-y-processor-lines-i-o-datasheet-vol-1.pdf
>         "If a RAM read from the ten time and date bytes is attempted
>         during an update cycle, the value read do not necessarily
>         represent the true contents of those locations. Any RAM writes
>         under the same conditions are ignored."
>
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
