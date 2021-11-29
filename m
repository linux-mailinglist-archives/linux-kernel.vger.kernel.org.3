Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65440461B98
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbhK2QOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:14:09 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:42795 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345026AbhK2QMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:12:07 -0500
Received: from [79.2.93.196] (port=58666 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mrjCy-0005C4-EE; Mon, 29 Nov 2021 17:08:48 +0100
Subject: Re: [PATCH v4 8/9] watchdog: max77620: add comment to clarify
 set_timeout procedure
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211120155707.4019487-1-luca@lucaceresoli.net>
 <20211120155707.4019487-9-luca@lucaceresoli.net>
 <20211129160414.GA3014810@roeck-us.net>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <0e08d0e0-489c-342b-4fa4-d4457af20a65@lucaceresoli.net>
Date:   Mon, 29 Nov 2021 17:08:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129160414.GA3014810@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 29/11/21 17:04, Guenter Roeck wrote:
> On Sat, Nov 20, 2021 at 04:57:06PM +0100, Luca Ceresoli wrote:
>> Clarify why we need to ping the watchdog before changing the timeout by
>> quoting the MAX77714 datasheet.
>>
> 
> Unless I am missing something, this adds confusion instead of clarifying
> anything, and it is misleading. The added comment in the code makes it
> sound like clearing the watchdog timer is only needed for MAX77614.
> However, the code was in place for MAX77620, suggesting that it was needed
> for that chip as well and is not MAX77614 specific.

You're right, the comment comes from the max77714-only driver, but now
that it is in a multi-chip  driver the confusion started to exist.

> Please either drop this patch or rephrase it to clarify that it applies
> to both chips.

What if I rephrase to:

	/*
	 * "If the value of TWD needs to be changed, clear the system
	 * watchdog timer first [...], then change the value of TWD."
-	 * (MAX77714 datasheet)
+	 * (MAX77714 datasheet but applies to MAX77620 too)
	 */

?

-- 
Luca
