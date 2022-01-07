Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACD4878C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiAGOR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:17:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58350 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239091AbiAGORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:17:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 207EHqCO042918;
        Fri, 7 Jan 2022 08:17:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641565072;
        bh=HSVQzyMdA0QJV/hriLNqRvdOYdA9p7o5eaHwOePeRAA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=FpOg1jXPq9MDFvAToVmX/Puv8BxVFCKKB0tPrtj0MjCvdKgSZbhMXY4ptl8VQdL/F
         eKa+PLNH+tGFxrvH8LZQVvcqTLn14WiySgQzyTEMvCOPA+UDHPxt91S4s2gbrxLliK
         f25pXOO0Kk+0XYkIRWfmQ8X6omb2xUP47+O7PPlY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 207EHqSf058117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jan 2022 08:17:52 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 7
 Jan 2022 08:17:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 7 Jan 2022 08:17:51 -0600
Received: from [10.249.36.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 207EHpmU081495;
        Fri, 7 Jan 2022 08:17:51 -0600
Subject: Re: [PATCH] dt-bindings: remoteproc: ti: Fix the number of mailboxes
From:   Suman Anna <s-anna@ti.com>
To:     Rob Herring <robh@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>
References: <20220107030457.2383750-1-robh@kernel.org>
 <642312db-4af8-7087-45bf-e86923396038@ti.com>
Message-ID: <762335b1-d6a2-64d2-75a1-f865cd557098@ti.com>
Date:   Fri, 7 Jan 2022 08:17:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <642312db-4af8-7087-45bf-e86923396038@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 8:13 AM, Suman Anna wrote:
> Hi Rob,
> 
> On 1/6/22 9:04 PM, Rob Herring wrote:
>> Based on the example, the TI K3 DSP and R5 have 2 mailboxes, but the schema
>> says 1. Fix the schema.
> 
> No, 1 is correct. The OMAP Mailbox binding uses #mbox-cells as 1 and not 0, and
> uses a phandle as the cell-value.

The following is what you get with your current patch,

Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dt.yaml:
dsp@4d80800000: mboxes: [[4294967295, 4294967295]] is too short
Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dt.yaml:
dsp@64800000: mboxes: [[4294967295, 4294967295]] is too short

regards
Suman

> 
> regards
> Suman
> 
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml         | 2 +-
>>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml         | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>> index 5ec6505ac408..648144fa1582 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>> @@ -53,7 +53,7 @@ properties:
>>        OMAP Mailbox specifier denoting the sub-mailbox, to be used for
>>        communication with the remote processor. This property should match
>>        with the sub-mailbox node used in the firmware image.
>> -    maxItems: 1
>> +    maxItems: 2
>>  
>>    memory-region:
>>      minItems: 2
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> index eeef255c4045..2c5f91ea5296 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>> @@ -135,7 +135,7 @@ patternProperties:
>>            OMAP Mailbox specifier denoting the sub-mailbox, to be used for
>>            communication with the remote processor. This property should match
>>            with the sub-mailbox node used in the firmware image.
>> -        maxItems: 1
>> +        maxItems: 2
>>  
>>        memory-region:
>>          description: |
>>
> 

