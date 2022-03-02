Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085E4CA0FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiCBJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiCBJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:41:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FC2DD7B;
        Wed,  2 Mar 2022 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646214026;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GTsceg3gfFUthwIWgrTbIqaWua2HCpNnflzslx3rLe8=;
    b=pvDlFLUIpqTdygq6nCGrDGFC3juSdMQ6qxOA3O7AIOABZI+lxe2PDA8BisQ/EY6Ysg
    cgPop4WhPzDnVgadfFug9aLU+nEVuC14eSiNV/PvshO9KONf970n5eI2ZXWjGx/TOicn
    136TTz83xopZNCXJ0sByIcxGCIEfERROZihlgaQKYjg6hZSBzwb9mcXRSB1pYk1blPii
    6ZtKUGR39rhZ/rXWkdf9XP/uzMxLQi32/GYtpGphSgemA90H3PVpJLlYMaNnWLr8qtM0
    lw3WopBxbjDAKIfH+rBgPkptT+TbiVeqp5xWGPe58B3rugo8+/Q2wxwvdf26nK66ZoPD
    dleg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43oQ+E="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id V41e6fy229eQTCH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 2 Mar 2022 10:40:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [BUG] mmc: core: adjust polling interval for CMD1
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20220302082034.GA5723@math.uni-bielefeld.de>
Date:   Wed, 2 Mar 2022 10:40:25 +0100
Cc:     Huijin Park <huijin.park@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6715A5BE-CA64-4A3D-8EE5-5BEEB63F268A@goldelico.com>
References: <27DDB061-1235-4F4C-B6A8-F035D77AC9CF@goldelico.com>
 <CAPDyKFrz_2Vp64SUzB8CiHJLTjO8Hx8m3QEhY1VU2ksZhVEx7A@mail.gmail.com>
 <20220302082034.GA5723@math.uni-bielefeld.de>
To:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 02.03.2022 um 09:20 schrieb Jean Rene Dawin =
<jdawin@math.uni-bielefeld.de>:
>=20
> Ulf Hansson wrote on Tue  1/03/22 14:38:
>> On Thu, 17 Feb 2022 at 21:12, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>=20
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Date: Tue, 1 Mar 2022 14:24:21 +0100
>> Subject: [PATCH] mmc: core: Extend timeout to 2s for MMC_SEND_OP_COND
>>=20
>> It looks like the timeout for the MMC_SEND_OP_COND (CMD1) might have =
become
>> a bit too small due to recent changes. Therefore, let's extend it to =
2s,
>> which is probably more inline with its previous value, to fix the =
reported
>> timeout problems.
>>=20
>> While at it, let's add a define for the timeout value, rather than =
using
>> a hard-coded value for it.
>>=20
>> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
>> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Cc: Huijin Park <huijin.park@samsung.com>
>> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>> drivers/mmc/core/mmc_ops.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index d63d1c735335..1f57174b3cf3 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -21,6 +21,7 @@
>>=20
>> #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>> #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s =
*/
>> +#define MMC_OP_COND_TIMEOUT_MS         2000 /* 2s */
>>=20
>> static const u8 tuning_blk_pattern_4bit[] =3D {
>>        0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
>> @@ -232,7 +233,8 @@ int mmc_send_op_cond(struct mmc_host *host, u32
>> ocr, u32 *rocr)
>>        cmd.arg =3D mmc_host_is_spi(host) ? 0 : ocr;
>>        cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>>=20
>> -       err =3D __mmc_poll_for_busy(host, 1000, =
&__mmc_send_op_cond_cb, &cb_data);
>> +       err =3D __mmc_poll_for_busy(host, MMC_OP_COND_TIMEOUT_MS,
>> +                                 &__mmc_send_op_cond_cb, &cb_data);
>>        if (err)
>>                return err;
>>=20
>> --=20
>> 2.25.1
>=20
> Hi,
>=20
> thanks. But testing with this patch still gives the same errors:
>=20
> [   52.259940] mmc1: Card stuck being busy! __mmc_poll_for_busy
> [   52.273380] mmc1: error -110 doing runtime resume
>=20
> and the system gets stuck eventually.

Same result from my tests.

BR and thanks,
Nikolaus

