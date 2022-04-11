Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425734FB904
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbiDKKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbiDKKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:08:15 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F71A3B8;
        Mon, 11 Apr 2022 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649671553;
  x=1681207553;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lbYVKGbW07aYEwRdt01aTABZYLAnzpfCoaitAjLM7yg=;
  b=OZMNn/tP/AXSr47gLZd3naYD00/hkhn66NqNYaQ5afLTrAO+NGatgj7E
   FTwNR6mRv4qoHZC2X56G2g/Ly1EKo1pIZJ79DoKFhDdcPXFQWbo0204di
   FTasEHCzH5G2RxZ1ifrGzibyuNhYInJgTi6wSmVt01H/tNUm9kdChLoxp
   Kp3bvnQQtP5MQCf8b7yDajGeS0hmVCOe7ACZgSf+8r7ISvRlQSWc/Jp0C
   yswf88xBnIm8fLr+ZOyi3q86NTPLZ3q8F43+ptoD1LzLOSHIiHSYVrnum
   HCyDL73142PmIFAwhJIHyRH4i6JZCluRgFzpt0ojNki/ryyiXwoZ1ipxg
   w==;
Message-ID: <82a95ac7-7859-d57c-de1b-c47fdea1e93c@axis.com>
Date:   Mon, 11 Apr 2022 12:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/2] hwmon/tmp401: add support of three advanced features
Content-Language: en-US
To:     Camel Guo <Camel.Guo@axis.com>,
        "inux@roeck-us.net" <inux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC:     kernel <kernel@axis.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220411095634.1782732-1-camel.guo@axis.com>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <20220411095634.1782732-1-camel.guo@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail08w.axis.com (10.20.40.14) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 11:56, Camel Guo wrote:
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
> Cc: linux-hwmon@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Camel Guo (2):
>    dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
>    hwmon: (tmp401) Add support of three advanced features
> 
>   .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 111 ++++++++++++++++++
>   MAINTAINERS                                   |   1 +
>   drivers/hwmon/tmp401.c                        |  43 ++++++-
>   3 files changed, 154 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> 
> 
> base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
> -- 
> 2.30.2
> 


Incorrect email address in --to. Please ignore this one.
