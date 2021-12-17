Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C453747859C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhLQHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:35:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35874 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhLQHf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:35:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47EECB82751;
        Fri, 17 Dec 2021 07:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC14C36AE1;
        Fri, 17 Dec 2021 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639726525;
        bh=2sBl03XWxpTILlbw8A9cL2Lsv4CZVmG6QVoqler8sdo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fdaDhFRxqfInz6qe7YyGlE0a42TjE6MYqn9F7Nb7q0m11+zFK5Dy4sdfkCpgzN6AG
         6wAD5ZfhTSS3ERVw25D1S8RhXCBoPpZtYqQNUYQ52ofoXe25Qfwbvc3ILHZZdzT7kN
         aPTKA43brMVV0SMCp/vZRMFhRkKtmPk4KSTqS27NiCtMulDlYSGpMxkb42zza0GWtu
         3ynsgeECatOLuKLYaM++6izoZbQ4KlkOWPRNdX/0LC2t7dLpnYx821hPZiFiQgy7nK
         2I6gFZXBCIes3XZBWvkRqYlTPKyV63OqHRAagCa2s0WtEBJ2O/SxLNPLPu6l8qgkR6
         hsm+WmcHiZaZw==
Subject: Re: [PATCH v2 3/4] memory: omap-gpmc: check for nand node name
 instead of just compatibility
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski@canonical.com, tony@atomide.com, kishon@ti.com,
        nm@ti.com, vigneshr@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211208124611.16843-1-rogerq@kernel.org>
 <20211208124611.16843-3-rogerq@kernel.org>
 <YboRyR+SqBV03cY0@robh.at.kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <e54729b3-0a72-a217-b320-b81c1f90d3f9@kernel.org>
Date:   Fri, 17 Dec 2021 09:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YboRyR+SqBV03cY0@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 15/12/2021 18:03, Rob Herring wrote:
> On Wed, Dec 08, 2021 at 02:46:10PM +0200, Roger Quadros wrote:
>> We have added new compatibles for controller so just checking for
>> "ti,omap2-nand" compatible is not enough. Check for "nand" node name
>> as well.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/memory/omap-gpmc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>> index 624153048182..9f0062a262db 100644
>> --- a/drivers/memory/omap-gpmc.c
>> +++ b/drivers/memory/omap-gpmc.c
>> @@ -2183,7 +2183,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>  		}
>>  	}
>>  
>> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
>> +	if (of_device_is_compatible(child, "ti,omap2-nand") ||
>> +	    of_node_name_eq(child, "nand")) {
> 
> It would be better to stick with compatible strings. You can match 
> against a match table. This should be 'nand-controller' really if this 
> binding had a proper split between the controller and nand chips.

OK. I will change this to use compatible strings using a match table.

The 'nand-controller' + 'nand' chip change will be done in a separate series
sometime later.

cheers,
-roger
