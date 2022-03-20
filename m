Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B434E1CDC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiCTQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCTQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:32:53 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7C39817;
        Sun, 20 Mar 2022 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1647793705;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=xAqIIk59P2ITsK5sfRVvGAwbAfO5UIo5jxPV7DrGofg=;
    b=qZr9CEalXGEGY6CluVtbvvaTPte9Hv0yQWLfialiAI2PEL28kzRJiwvCcAzYcvCRwO
    WVIDBTAnt3vUzs04KXYXk/ukG0oDWWMhpmsc9VVM1NX0HL90OlZyuWOkuASqWsXXi4M1
    GNvuwKYFAZM9q/hEBFx6AaCgLLA3sryWNnOCRrJhsCVfNeCFLLgYQLYRELhXGRXRVhaR
    c2U7/nVO0y7dUedxUOSlHUPE30mX+Z/nnIbcnFHqfAQvcUyCy1RhC/VLrRA+11hf3lYG
    vRwfa8bIxChuEepxQXahQ53RMm/eqAlm03kU1asqLQp1oCpDJznauxdZPKlsjCTglQqC
    w4zg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iM4RaQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.41.1 DYNA|AUTH)
    with ESMTPSA id L6b887y2KGSMH7x
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sun, 20 Mar 2022 17:28:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] iio: palmas: shut up warning about calibration mismatch
 (due to noise)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20220320155259.0fc79dd3@jic23-huawei>
Date:   Sun, 20 Mar 2022 17:28:21 +0100
Cc:     Colin Ian King <colin.king@intel.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-omap@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <18533164-C17A-4CA1-A882-5A160D370498@goldelico.com>
References: <1cee45bfc3fa2ab59dcc17242fb52468035360a1.1646743982.git.hns@goldelico.com>
 <20220320155259.0fc79dd3@jic23-huawei>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

> Am 20.03.2022 um 16:52 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Tue,  8 Mar 2022 13:53:03 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Although technically checking for ADC values below 0 is correct,
>> because they are outside of the calibration values, there is usually
>> noise which spuriously fills the console log with error messages if
>> calculated input voltage gets close to 0V.
>>=20
>> Ignore small negative calculated values, but clamp them to 0.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Hi.
>=20
> Should we treat this as a fix or a cleanup?
>=20
> I don't mind either way.

I don't mind either since we have it for long time in our distribution =
kernel.

BR and thanks,
Nikolaus

>=20
> Jonathan
>=20
>=20
>> ---
>> drivers/iio/adc/palmas_gpadc.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/iio/adc/palmas_gpadc.c =
b/drivers/iio/adc/palmas_gpadc.c
>> index f9c8385c72d3..bcfa6a7f6cb2 100644
>> --- a/drivers/iio/adc/palmas_gpadc.c
>> +++ b/drivers/iio/adc/palmas_gpadc.c
>> @@ -376,7 +376,8 @@ static int =
palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
>> 					=
adc->adc_info[adc_chan].gain_error;
>>=20
>> 	if (val < 0) {
>> -		dev_err(adc->dev, "Mismatch with calibration\n");
>> +		if (val < -10)
>> +			dev_err(adc->dev, "Mismatch with calibration var =
=3D %d\n", val);
>> 		return 0;
>> 	}
>>=20
>=20

