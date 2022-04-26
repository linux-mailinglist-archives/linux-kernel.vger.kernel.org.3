Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0AF50F332
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbiDZH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbiDZH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:58:58 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467291A055;
        Tue, 26 Apr 2022 00:55:49 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4KnZ1w3RCzzDqPk;
        Tue, 26 Apr 2022 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1650959748; bh=3aL3yiuRGJLKNdufRrOQc8sWMnykHDqjpt4U7wvTSQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=laK8x/GpCC/J+8D6qM3woE40/WsrYwHV/7SESR+cQDbDAMCP6akt8VOQFQH8r4GmZ
         o187u2sGKqD16ja3C60i7UwC9aBf9A0aVzYPRpSEjFZE09wIHNZACeMqLpKs1BwiUI
         uIxh+maPc2U0QQZx/WHDAgfqfDNXWEccR2eI5ZLU=
X-Riseup-User-ID: B739F329B21ADAD34223616135E79A0AD14E909BB87821BDF443FC0F821EC23A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4KnZ1q1mhzz202J;
        Tue, 26 Apr 2022 00:55:42 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:55:38 +0700
From:   Danct12 <danct12@riseup.net>
To:     kholk11@gmail.com
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, rydberg@bitmath.org,
        priv.luk@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijns95@gmail.com,
        konradybcio@gmail.com, martin.botka1@gmail.com,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v9 0/3] Add Novatek NT36xxx touchscreen driver
Message-Id: <20220426145538.e2af01d6d648b011a910f3a0@riseup.net>
In-Reply-To: <20201028221302.66583-1-kholk11@gmail.com>
References: <20201028221302.66583-1-kholk11@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series tested, works fine on the Xiaomi Redmi Note 7 (SDM660, NT36672A IC)

To the whole patch series:
Tested-by: Dang Huynh <danct12@riseup.net>

On Wed, 28 Oct 2020 23:12:59 +0100
kholk11@gmail.com wrote:

> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> This patch series adds support for the Novatek NT36xxx Series' In-Cell
> touchscreen (integrated into the DriverIC).
> 
> This patch series has been tested against the following devices:
>  - Sony Xperia 10        (SDM630 Ganges Kirin)
>  - Sony Xperia 10 Plus   (SDM636 Ganges Mermaid)
> 
> Changes in v2:
> - Fixed sparse warnings from lkp kernel test robot
> 
> Changes in v3 (as requested by Dmitry Torokhov):
> - Using shorthand u16/u32 (sorry for the overlook!)
> - Now using more input and touchscreen APIs
> - Fixed useless workqueue involvements
> - Removed useless locking
> - Switched reads and writes to use regmap
> - Moved header contents to nt36xxx.c
> - Fixed reset gpio handling
> - Other cleanups
> - P.S.: Thanks, Dmitry!
> 
> Changes in v4:
> - Fixed regmap read length for CRC_ERR_FLAG final check
> - Fixed YAML binding, as requested by Krzysztof Kozlowski
> 
> Changes in v5:
> - Replaced subsystem maintainer's name with .. mine,
>   usage of additionalProperties to unevaluatedProperties
>   and a typo fix for reset-gpios as per Rob Herring's review
> - Changed compatible string as per Krzysztof K. request
> - Renamed the novatek,nt36xxx.yaml file to just nt36xxx.yaml
>   in order to now reflect the driver name instead of the DT
>   compatible
> - Fixed blank line at EOF
> 
> Changes in v6:
> - Removed include of_gpio.h, added mod_devicetable.h and
>   gpio/consumer.h
> - Added kerneldoc to relevant functions/enum
> - Used traditional patterns for error checking where possible
> - Documented calls to usleep/msleep
> - Using be16_to_cpu / get_unaligned_be16 where possible
> - Added helper for CRC error check on retrieved buffer
> - Decreased indentation in the CRC reboot recovery function
> - Removed instances of error code sum
> - Dropped all likely/unlikely optimization as per request
> - Removed redundant reset_gpio checks
> - Dropped of_match_ptr and ifdefs for CONFIG_OF
> 
> Changes in v7:
> - Fixed typo in nt36xxx.c
> 
> Changes in v8:
> - Fixed typo reset-gpio -> reset-gpios in dt-bindings
> 
> Changes in v9:
> - Includes are now sorted
> - Used proposed sizeof variable instead of sizeof type
> - Fixed a return value check for common pattern
> - Added NULL check to devm_kasprintf call
> - Returning ret on probe function to be consistent
> 
> AngeloGioacchino Del Regno (3):
>   dt-bindings: Add vendor prefix for Novatek Microelectronics Corp.
>   Input: Add Novatek NT36xxx touchscreen driver
>   dt-bindings: touchscreen: Add binding for Novatek NT36xxx series
>     driver
> 
>  .../bindings/input/touchscreen/nt36xxx.yaml   |  59 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/input/touchscreen/Kconfig             |  12 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/nt36xxx.c           | 894 ++++++++++++++++++
>  drivers/input/touchscreen/nt36xxx.h           | 122 +++
>  6 files changed, 1090 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nt36xxx.yaml
>  create mode 100644 drivers/input/touchscreen/nt36xxx.c
>  create mode 100644 drivers/input/touchscreen/nt36xxx.h
> 
> -- 
> 2.28.0
> 
