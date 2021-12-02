Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EEE465F86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356126AbhLBIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:35:01 -0500
Received: from cpanel.siel.si ([46.19.9.99]:34430 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356327AbhLBIel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UMsTag79/OOGq0Mj96sAl6FAOppAH0vJDBU8cO2cGIQ=; b=dxJ4LMSFZmmPtSR9Wv6wW33xQd
        9KG5tk0TX7jADmZt+HYmnTlcJ4SCaZogHsKM5Nc1DnKLfr57Al1gBZaTeCALkXAo6OkjSOKi4463j
        zjB3Z8PRwmbyn8WZRqXTpVWiStwunNPfKUPRS+NPNetE4U2quAYacSTLFD0b3VE7DdrU99JsT3PTe
        CEo/f/u67pjXom/5z/Aax61+X8sZGDfj/E0DrogMiz6O/OGneqhMSjgi3gRBBykGrmdU3ZLji3Sb0
        /IDoMHjbYzka87mjF4bV/Z81NVHjH+vUuWJYsf0wFEpa3MmIItU9SJ9fSzLYcV0b5yPtkihLhx+JY
        zDQBRIew==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:50452 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mshUh-00DFG1-0v; Thu, 02 Dec 2021 09:31:14 +0100
Subject: Re: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
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
References: <20211201081512.3580837-1-andrej.picej@norik.com>
 <20211201081512.3580837-2-andrej.picej@norik.com>
 <DB9PR10MB4652EF562CD20FB72FDBD71880689@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <8de702cf-3454-44be-d522-6af3515079a3@norik.com>
Date:   Thu, 2 Dec 2021 09:31:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DB9PR10MB4652EF562CD20FB72FDBD71880689@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
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


> 
> Personally I'd stick this code in the probe(). The value won't change once it's
> set, and that seems the more logical place for it in my opinion.
> 
I think that's a good idea and I don't have a reason why we shouldn't do 
that.

Will send the next version of the patch series with this change.

Thanks for review.

BR,
Andrej
