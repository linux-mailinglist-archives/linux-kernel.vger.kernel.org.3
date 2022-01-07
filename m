Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6D4878B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347553AbiAGOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:14:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57626 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiAGOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:14:08 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 207EDt2j041934;
        Fri, 7 Jan 2022 08:13:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641564835;
        bh=IdKClSqCi2IgnKjhnsNkLkR4E+KGUg7FXkzRHnBjT/M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UYDBWmsZ6lJPxMF2Ql5ralBK+E2LgwS+hH74GM79Fci2k1Fu9S9W5R19eG2tD2kbX
         sXzUtcQgWVnVi/prr8190Rl53q3x468t2ZdFG3l3tkJ3HiQZnycV23s2noxsbn8vsm
         QJV3XrbDtQELDvhMmYD+NgFxIpKy14bdWwYHgftU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 207EDtUM002141
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jan 2022 08:13:55 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 7
 Jan 2022 08:13:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 7 Jan 2022 08:13:54 -0600
Received: from [10.249.36.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 207EDs1W015704;
        Fri, 7 Jan 2022 08:13:54 -0600
Subject: Re: [PATCH] dt-bindings: remoteproc: ti: Fix the number of mailboxes
To:     Rob Herring <robh@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>
References: <20220107030457.2383750-1-robh@kernel.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <642312db-4af8-7087-45bf-e86923396038@ti.com>
Date:   Fri, 7 Jan 2022 08:13:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220107030457.2383750-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/6/22 9:04 PM, Rob Herring wrote:
> Based on the example, the TI K3 DSP and R5 have 2 mailboxes, but the schema
> says 1. Fix the schema.

No, 1 is correct. The OMAP Mailbox binding uses #mbox-cells as 1 and not 0, and
uses a phandle as the cell-value.

regards
Suman

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml         | 2 +-
>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index 5ec6505ac408..648144fa1582 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -53,7 +53,7 @@ properties:
>        OMAP Mailbox specifier denoting the sub-mailbox, to be used for
>        communication with the remote processor. This property should match
>        with the sub-mailbox node used in the firmware image.
> -    maxItems: 1
> +    maxItems: 2
>  
>    memory-region:
>      minItems: 2
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> index eeef255c4045..2c5f91ea5296 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -135,7 +135,7 @@ patternProperties:
>            OMAP Mailbox specifier denoting the sub-mailbox, to be used for
>            communication with the remote processor. This property should match
>            with the sub-mailbox node used in the firmware image.
> -        maxItems: 1
> +        maxItems: 2
>  
>        memory-region:
>          description: |
> 

