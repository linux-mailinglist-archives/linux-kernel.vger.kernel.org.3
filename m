Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E55252FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356692AbiELQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348145AbiELQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:49:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ECD268649;
        Thu, 12 May 2022 09:49:06 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kzd2T6nn5z684JT;
        Fri, 13 May 2022 00:46:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 12 May 2022 18:49:03 +0200
Received: from localhost (10.81.210.133) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 17:49:03 +0100
Date:   Thu, 12 May 2022 17:48:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Eddie James <eajames@linux.ibm.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <lars@metafoo.de>, <jic23@kernel.org>, <miltonm@us.ibm.com>
Subject: Re: [PATCH v2 0/2] iio: humidity: si7020: Check device property for
 skipping reset in probe
Message-ID: <20220512174859.000042b6@Huawei.com>
In-Reply-To: <20220512162020.33450-1-eajames@linux.ibm.com>
References: <20220512162020.33450-1-eajames@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.133]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 11:20:18 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> I2C commands issued after the SI7020 is starting up or after reset
> can potentially upset the startup sequence. Therefore, the host
> needs to wait for the startup sequence to finish before issuing
> further i2c commands. This is impractical in cases where the SI7020
> is on a shared bus or behind a mux, which may switch channels at
> any time (generating I2C traffic). Therefore, check for a device
> property that indicates that the driver should skip resetting the
> device when probing.

Why not lock the bus?  It's not ideal, but then not resetting and hence
potentially ending up in an unknown state isn't great either.

Jonathan

> 
> Changes since v1:
>  - Fix dt binding document
> 
> Eddie James (2):
>   dt-bindings: iio: humidity: Add si7020 bindings
>   iio: humidity: si7020: Check device property for skipping reset in probe
> 
>  .../bindings/iio/humidity/silabs,si7020.yaml  | 47 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  drivers/iio/humidity/si7020.c                 | 14 +++---
>  3 files changed, 55 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> 

