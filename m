Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA952CBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiESGGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiESGGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964E31DE6;
        Wed, 18 May 2022 23:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49B9F619EF;
        Thu, 19 May 2022 06:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4834C34113;
        Thu, 19 May 2022 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652940358;
        bh=p7UYdPQOAJbTrfr64KnvmmJZKtwxq6TbR8dxfI/yYw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abu/f+/O+tJWcX0UWxMHehNMU9osb13v0x76UFxc6NMAWPJcUPe2dI+rNbQEo1bLM
         w9chAMz3g7w53v6t5Pe9yE0vzrpXqUpekgmQVx2OYm4N2oaLmzyB6rn4n6LzO6BF28
         1v2Rwe15rd1SntGjE7KC7+37UvO+gsRcuPY4HwvjGP7vbpKIUqxHOQlE2eCSzF+r1r
         TMh2RfgXnaClBDdyPdGpmAtg1KW52Hh10ir82JWAjYffhQM5lD5+Qauscp1tVWPL/s
         JGBFHED6+hIo9QcvKotQctcGQmN1+KKt2TZXoI+Upyrrxz+x1/12hC9PUoKQVz3Evd
         UcYJg+TpyBQiA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrZIO-0007vw-CA; Thu, 19 May 2022 08:06:00 +0200
Date:   Thu, 19 May 2022 08:06:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Carl =?utf-8?B?WWluKOaut+W8oOaIkCk=?= <carl.yin@quectel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rspmn@arcor.de" <rspmn@arcor.de>,
        Torres Liu <torres.liu@quectel.com>
Subject: Re: [PATCH v3] USB: serial: option: add Quectel BG95 modem
Message-ID: <YoXeSO1Hd75tT1/y@hovoldconsulting.com>
References: <TYZPR06MB4270D3394B8E3E0301738F6B86D09@TYZPR06MB4270.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB4270D3394B8E3E0301738F6B86D09@TYZPR06MB4270.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 02:34:43AM +0000, Carl Yin(殷张成) wrote:
> The BG95 modem has 3 USB configurations that are configurable via the AT
> command AT+QCFGEXT="usbnet",["ecm"|"modem"|"rmnet"] which make the modem
> enumerate with the following interfaces, respectively:
> 
> "modem": Diag + GNSS + Modem + Modem
> "ecm"  : Diag + GNSS + Modem + ECM
> "rmnet": Diag + GNSS + Modem + QMI
>          Don't support Full QMI messages (e.g WDS_START_NETWORK_INTERFACE)
> 
> A detailed description of the USB configuration for each mode follows:

> Signed-off-by: Carl Yin <carl.yin@quectel.com>
> ---
> 
> v3:
> 1. use USB_DEVICE_INTERFACE_CLASS instead of USB_DEVICE_AND_INTERFACE_INFO
> 2. introduce limitations of QMI in commit message
> 
> v2:
> add at+qcfgext="usbnet","rmnet" and RSVD(3)

Thanks for the update. Now applied.

Johan
