Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF32546B866
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhLGKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:07:48 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39562 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234664AbhLGKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:07:47 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B75kTRX027933;
        Tue, 7 Dec 2021 04:04:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=TTVGHmaU4VbZvXb+ZG07SZEbgxSMk6weMk819DmSDXk=;
 b=cgtcfxlNz05uHx0gN7gFFvjNXKr6R2qi2Cui3aIln8AfcNJSS3Rd5FITjN9CpNeJiODG
 atvHZiWneHMmuQGO6G+DIaDHcp0E6HGrRnrPAa8cEC0fKCIvOppyP+Z8edaz/PGeqRqc
 pNFf1pCAcfsSvu4KtK16UHh59etuwTt3ViHOoZQF5obWV6FSaZ24cSf0ywD1NajmhkMj
 omvLJEPKDH8ZHZdCG/DT2u46d5/20sDx9TZvQXrxnvQobiU1roS8iEoirKzq38AJpC51
 VzzNkfTp5BWFXl6pn7SagPtRbjHvXeHi9ei9Pn7tQXsowwOB7UFuGRMznt3pmNEULP9W QQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3csdc9hhn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Dec 2021 04:04:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 10:04:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 10:04:00 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9A76445A;
        Tue,  7 Dec 2021 10:03:59 +0000 (UTC)
Date:   Tue, 7 Dec 2021 10:03:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: mfd: cirrus,lochnagar: fix pin controller
 nodename
Message-ID: <20211207100359.GO18506@ediswmail.ad.cirrus.com>
References: <20211207083618.12940-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207083618.12940-1-zajec5@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 0B6qZZoyPd0ak7gmpoOx9zhpZjmMIlc-
X-Proofpoint-GUID: 0B6qZZoyPd0ak7gmpoOx9zhpZjmMIlc-
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:36:18AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Replace custom nodename with a generic "pinctrl" to match new pinctrl
> binding requirement. This will fix:
> Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>         From schema: Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com> 

Thanks,
Charles
