Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19C75007B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiDNICJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiDNICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:02:06 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89E3630C;
        Thu, 14 Apr 2022 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649923182;
  x=1681459182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uaWL/LQdg91ACApW6dRxuLJ2OqDnSMYWm8FoCaD5BMU=;
  b=cNgbSXWX9MQIOQLfTpkUVgKP3eV9T4rVs7lBxnX04rNoZfI432+mmueo
   gUPqyROjePQXbMlOIIXaQiOb0BM6O6iCdAIIvp0vy/1M2cwqNVmKPphnL
   7oioqj/e7bK+bpN7lkcFajrRbY1hVOEh+b3A4sc5HmHRQfXhNXsHmTqxk
   zuqFBui2LxIq9c4gcMfUAcCeXIOXCYd2XAoc3MRCjU/9/loT7UoOG1he4
   tNbMI02Ejo75tmKSqnU61SFP5WSS2WAd2FC5yVN6wasDLXWmuQEkKkQD6
   B7HfzQk4Oq+/gmlKvEqG8VwMF/We4KUFkxtf6S7R2MiE3grad0Ky+1D3f
   Q==;
Message-ID: <d8db3fe0-9847-9045-2cc8-3bfe824f6a1d@axis.com>
Date:   Thu, 14 Apr 2022 09:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 0/2] hwmon/tmp401: add support of three advanced
 features
Content-Language: en-US
To:     Camel Guo <Camel.Guo@axis.com>, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
References: <20220413114014.2204623-1-camel.guo@axis.com>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <20220413114014.2204623-1-camel.guo@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 13:40, Camel Guo wrote:
> According the their datasheets:
> - TMP401, TMP411 and TMP43x support extended temperature range;
> - TMP411 and TMP43x support n-factor correction;
> - TMP43x support beta compensation.
> 
> In order to make it possible for users to enable these features and set 
> up them
> based on their needs, this patch series adds the following devicetree 
> bindings:
> - ti,extended-range-enable;
> - ti,n-factor;
> - ti,beta-compensation.
> In the meanwhile, tmp401 driver reads them and configures the coressponding
> registers accordingly.
> 
> v3:
> - dt-bindings: remove unused [address|size]_cells and 
> ti,beta-compensation.items
>    from ti,tmp401.yaml;
> - dt-bindings: change ti,n-factor range to [-128, 127];
> - tmp401.c: instead of u32, use s32 for ti,n-factor.
> 
> v2:
> - dt-bindings: fix format and describe hardware properties instead of
>    programming models in ti,tmp401.yaml.
> 
> Cc: linux-hwmon@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Camel Guo (2):
>    dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
>    hwmon: (tmp401) Add support of three advanced features
> 
>   .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 105 ++++++++++++++++++
>   MAINTAINERS                                   |   1 +
>   drivers/hwmon/tmp401.c                        |  44 +++++++-
>   3 files changed, 149 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> 
> 
> base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
> -- 
> 2.30.2
> 

V4 is out. Please review that series instead.
