Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF74614D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbhK2MRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:17:37 -0500
Received: from cpanel.siel.si ([46.19.9.99]:53930 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234457AbhK2MPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ViBlr2ET0ChVWPO5jDyMBAX+WCiIakHViFVfkY+8k1Q=; b=COWMoJDH7mCbKKjsBARm0O5BYp
        c+HPp2TUxJs5fWG44WHk08UxzthLjM6ba2Da8c2wIaRVZMv5cys5TL1Oy3ttLfYAG1ywxcxd/5dLM
        65ZcZNor0vhNBLiEs4MfoRUgp8froUOEi0frnu1M1n7pipQ6+K3eAf0/nauw+rtHQIdleO7Epko4q
        K2ihjsdoPTGUj9PZyXzOyM+oUH4SOpjEJt7nVJxYApmBW3YwmSEpvEUcC2WejsROXMzREinusx6lm
        MwTZAfrYixd/rWgNPciZWokMCDBslihPUhKIJ/GhuBVgXw5VH6hKhrqgy67rJmuBpxARgqtx9Mn2B
        l1W0qO5A==;
Received: from [89.212.21.243] (port=59668 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mrfW0-00F5oN-K6; Mon, 29 Nov 2021 13:12:12 +0100
Subject: Re: [PATCH 2/2] watchdog: da9062: reset board on watchdog timeout
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     "y.bas@phytec.de" <y.bas@phytec.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211124083258.2606511-1-andrej.picej@norik.com>
 <20211124083258.2606511-2-andrej.picej@norik.com>
 <DB9PR10MB4652529FAC6253C266B172EF80639@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <b65c9c58-485d-1735-bda2-e750ee8d8a8a@norik.com>
Date:   Mon, 29 Nov 2021 13:12:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DB9PR10MB4652529FAC6253C266B172EF80639@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
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

Hi Adam,

On 26. 11. 21 14:28, Adam Thomson wrote:
> 
> I'm a little concerned about forcing this change in the driver. There may be
> platforms which don't want the PMIC to perform a full reset through OTP re-read
> and if we hard code this change then that's impacting those platforms. If we
> want/need this then I think it should probably be a DT binding for da9061/2
> which then indicates the behaviour we want.

Ok, I see the impact this might have on the platforms that are relying 
on the current default setting. I will start on the DT binding 
implementation and submit a new patch.

> 
> NRES_MODE bit also plays a part here as it controls whether or not the nRESET
> line state is changed as part of the power-down/up process. I'm assuming for
> your setup this bit is 0?
> 
We leave NRES_MODE as it is, 0 by default I guess? So do you want a 
separate dt binding for NRES_MODE?

BR,
Andrej
