Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359E146639F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhLBM3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:29:02 -0500
Received: from cpanel.siel.si ([46.19.9.99]:57652 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233967AbhLBM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WAT7kNShq1OO482Bpx+8nDJEsH6UkPgjYk0R6HiKn9M=; b=fC+fITspqqdhPsiJbx9wExgsk0
        BAyD3FrnZc0uOD0pKh4Fr8Y8HGCLCAHkhk6BBWDQrVtX1/43ppF3dfgwmiFU34D2mwL37uPCgxY/R
        rlHJSUXTCUM4clxMc8jgHCt2p1AgUd/iyPTfncqNEgKxUw3jYimifXCHzODmsjmH/QvjgbhPNfqCr
        XbV65FDVrEPr46TUKIX27t4qDRwW9AlPhF/c8YqTHOUMuiv8bIfApyHPRGlBrx2zZtuUFp6xP7NN7
        hXttioUCQaokFfyuLdRAs2+UNTTSRaoi5AgoM5taXSoN1JDS975bUrhP+qwPY+3Nsuq4dUq/sdZdP
        9RSOoeFQ==;
Received: from [89.212.21.243] (port=54630 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1msl9U-00DskO-UP; Thu, 02 Dec 2021 13:25:28 +0100
Subject: Re: [PATCH v4 2/4] watchdog: da9062: reset board on watchdog timeout
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
 <20211202093230.3951996-2-andrej.picej@norik.com>
 <DB9PR10MB4652A6A2F9A2CB48920F3F5F80699@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <c6dec107-4866-50df-cdcf-db86542d8635@norik.com>
Date:   Thu, 2 Dec 2021 13:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DB9PR10MB4652A6A2F9A2CB48920F3F5F80699@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2. 12. 21 13:18, Adam Thomson wrote:
> On 02 December 2021 09:32, Andrej Picej wrote:
> 
>> Implement a method to change watchdog timeout configuration based on DT
>> binding ("dlg,wdt-sd"). There is a possibility to change the bahaviour
> 
> behaviour?

Of course.

> 
>> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
>> clearing it enables POWERDOWN mode on watchdog timeout.
>>
>> If no DT binding is specified the WATCHDOG_SD bit stays in default
>> configuration, not breaking behaviour of devices which might depend on
>> default fuse configuration.
>>
>> Note: This patch requires that the config register CONFIG_I is
>> configured as writable in the da9062 multi function device.
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
> 
> Spelling aside:
> 
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> 
