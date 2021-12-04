Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC946873B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349813AbhLDTtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 14:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349441AbhLDTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 14:49:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365CC061751;
        Sat,  4 Dec 2021 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1Wx0sNFc4nRwhtP15w8D3y+GxIPogNNpQRDFakzYmm0=; b=hFNtobnXBDHvelC3AlP2yV1DEC
        8lNkI+0+AhlngJ9q0LW3UGxj2Yns4Q6tC6ljiHqprE6kbnHOuIKoSsCFk2Q2qGM4fAmny9t8oHDo1
        LAm4HAiOANCU1pjkYnpKZLz4jDNj8M6v6RGM2Y6UNLv2cCd4Cb+QKLCGNq8g3U8pOLpo=;
Received: from p200300ccff382c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff38:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mtayx-0006rL-SI; Sat, 04 Dec 2021 20:46:04 +0100
Date:   Sat, 4 Dec 2021 20:46:02 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, linus.walleij@linaro.org,
        rydberg@bitmath.org,
        =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <20211204204602.58b6cc12@aktux>
In-Reply-To: <20211202122021.43124-2-alistair@alistair23.me>
References: <20211202122021.43124-1-alistair@alistair23.me>
        <20211202122021.43124-2-alistair@alistair23.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu,  2 Dec 2021 22:20:18 +1000
Alistair Francis <alistair@alistair23.me> wrote:

> +static int cyttsp5_setup_input_device(struct device *dev)
> +{
> +	struct cyttsp5 *ts = dev_get_drvdata(dev);
> +	struct cyttsp5_sysinfo *si = &ts->sysinfo;
> +	int max_x, max_y, max_p;
> +	int max_x_tmp, max_y_tmp;
> +	int error;
> +
> +	__set_bit(EV_REL, ts->input->evbit);
> +
> +	max_x_tmp = si->sensing_conf_data.res_x;
> +	max_y_tmp = si->sensing_conf_data.res_y;
> +	max_x = max_x_tmp - 1;
> +	max_y = max_y_tmp - 1;
> +	max_p = si->sensing_conf_data.max_z;
> +
> +	error = input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].max,
> +		INPUT_MT_DROP_UNUSED | INPUT_MT_POINTER);
> +	if (error < 0)
> +		return error;
still some issues with X, sometimes it is even a mouse, depending on
config.
hmm, why is it INPUT_MT_POINTER and not INPUT_MT_DIRECT?

#define INPUT_MT_POINTER        0x0001  /* pointer device, e.g. trackpad */
#define INPUT_MT_DIRECT         0x0002  /* direct device, e.g. touchscreen */

Regards,
Andreas
