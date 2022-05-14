Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198C52713E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiENNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiENNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:32:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF10167ED;
        Sat, 14 May 2022 06:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 136D9B80759;
        Sat, 14 May 2022 13:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A530C340EE;
        Sat, 14 May 2022 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652535115;
        bh=TExNkCJIyi7sDz+kd0um9+TpmBxdCc8saAXZNsfA+Jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NTYaemDyM2EcpaBTJbdwga+I34SCsAkZ43SzvYi2A/h9HXiFUqi6fQWUc+afC8sKD
         aDeorUuiE2Wy4pfaEM9+KVfnH/dIglvw+dHdI0mexse6ssIC/jUkC1stFGoWvjhhrl
         fh8CwBLQTA2FTj59soeJcdLvtfcoWNSxBMbtrUlVNW+1M7Rjt0vIzrmADN7pkizh9+
         GvGssv6P5m/QIGjO9itQlWhUQ5pBos1CZsxtZWQq6BgjJ2I049t5YAS2ExJn5mUB0C
         5HBvTQZVHQQ3L0xLIh2HCtH9kE0UGz1/HwoiHCJszvi5tmsFRwsvaxjzMBUR/BEAO0
         OC0wsubNWhVWA==
Date:   Sat, 14 May 2022 14:40:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, miltonm@us.ibm.com
Subject: Re: [PATCH v2 0/2] iio: humidity: si7020: Check device property for
 skipping reset in probe
Message-ID: <20220514144030.7a57da70@jic23-huawei>
In-Reply-To: <c2f7b09d-e046-409e-b65e-153157f84b03@linux.ibm.com>
References: <20220512162020.33450-1-eajames@linux.ibm.com>
        <20220512174859.000042b6@Huawei.com>
        <c2f7b09d-e046-409e-b65e-153157f84b03@linux.ibm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 14:11:06 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> On 5/12/22 11:48, Jonathan Cameron wrote:
> > On Thu, 12 May 2022 11:20:18 -0500
> > Eddie James <eajames@linux.ibm.com> wrote:
> >  
> >> I2C commands issued after the SI7020 is starting up or after reset
> >> can potentially upset the startup sequence. Therefore, the host
> >> needs to wait for the startup sequence to finish before issuing
> >> further i2c commands. This is impractical in cases where the SI7020
> >> is on a shared bus or behind a mux, which may switch channels at
> >> any time (generating I2C traffic). Therefore, check for a device
> >> property that indicates that the driver should skip resetting the
> >> device when probing.  
> > Why not lock the bus?  It's not ideal, but then not resetting and hence
> > potentially ending up in an unknown state isn't great either.  
> 
> 
> Also, I should mention that in our case we can rely on the power on 
> reset, so the device should be in a known state.

Until someone unbinds and rebinds the driver...
It's very hard to have any guarantees once users are involved :)

Jonathan


> 
> Eddie
> 
> 
> >
> > Jonathan
> >  
> >> Changes since v1:
> >>   - Fix dt binding document
> >>
> >> Eddie James (2):
> >>    dt-bindings: iio: humidity: Add si7020 bindings
> >>    iio: humidity: si7020: Check device property for skipping reset in probe
> >>
> >>   .../bindings/iio/humidity/silabs,si7020.yaml  | 47 +++++++++++++++++++
> >>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >>   drivers/iio/humidity/si7020.c                 | 14 +++---
> >>   3 files changed, 55 insertions(+), 8 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> >>  

