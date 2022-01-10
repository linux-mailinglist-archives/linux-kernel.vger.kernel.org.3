Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BD489F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiAJSoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:44:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60530 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiAJSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:44:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20AIhwRD024096;
        Mon, 10 Jan 2022 12:43:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641840238;
        bh=GXFv+aD2Z2QpT9wkKsMxpEH3rvlER44XWUwe0K4BQGo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q19vHUXdIct9YXddCk9aYe0mYdaZr5u/dtOqG0+gTBRxSAJ7v2eLzAxZTwe1nncKv
         HRudZ1ATy/XaLUflANitx63S+X/Eez2b8yLr8CjaesjjmT0aRoHEhgEHaE58Bwafgs
         g/1Sw72x/HJIyNP2il0WJp4gUdPDcqFBZwzBCq3I=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20AIhwuF017932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jan 2022 12:43:58 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 10
 Jan 2022 12:43:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 10 Jan 2022 12:43:58 -0600
Received: from [10.249.36.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20AIhvjn023819;
        Mon, 10 Jan 2022 12:43:57 -0600
Subject: Re: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
To:     Miaoqian Lin <linmq006@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        "Nagalla, Hari" <hnagalla@ti.com>
References: <20220107080428.10873-1-linmq006@gmail.com>
 <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
 <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <fd659736-2106-1be3-084b-7caddf2dc18e@ti.com>
Date:   Mon, 10 Jan 2022 12:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

On 1/9/22 8:43 PM, Miaoqian Lin wrote:
> Hi Suman Anna,
> On Fri, Jan 07, 2022 at 08:42:16AM -0600, Suman Anna wrote:
>> Hi Miaoqian,
>>
>>
>>> Add the corresponding 'put_device()' in the error handling paths.
>>
>> Also, need it in the regular path, not just in error handling path.
> I think after calling platform_get_drvdata() normally, the
> reference will be released in other functions, so don't need it in the
> regular path.
> 

No, it's a local reference and is acquired within omap_iommu_probe_device() and
needs to be released within this function. What other function are you referring
to here?

regards
Suman

