Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64747476F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhLPKyY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Dec 2021 05:54:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8530 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231500AbhLPKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:54:22 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG487NN011583;
        Thu, 16 Dec 2021 05:54:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cyrbx9uxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:54:08 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1BGAs67r016336
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Dec 2021 05:54:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 16 Dec
 2021 05:54:05 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::ec36:89cb:a387:866]) by
 ASHBMBX9.ad.analog.com ([fe80::ec36:89cb:a387:866%20]) with mapi id
 15.02.0986.014; Thu, 16 Dec 2021 05:54:05 -0500
From:   "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
To:     Kees Cook <keescook@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] iio: addac: Do not reference negative array offsets
Thread-Topic: [PATCH] iio: addac: Do not reference negative array offsets
Thread-Index: AQHX8grEUPh7+C22Y0mYZUFxEOgun6w08ZMA
Date:   Thu, 16 Dec 2021 10:54:05 +0000
Message-ID: <43682e2c485a48deb8f40c9ee060d45c@analog.com>
References: <20211215232321.2069314-1-keescook@chromium.org>
In-Reply-To: <20211215232321.2069314-1-keescook@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3RhbmlzbGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy03YmZkOThkNS01ZTVlLTExZWMtYjZjZi00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcN2JmZDk4ZDctNWU1ZS0xMWVjLWI2Y2YtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzMDYzIiB0PSIxMzI4NDEyNTY0NTE5?=
 =?us-ascii?Q?NjY4MzEiIGg9Ik4xS040OXVFeUQvaXVVWTdJME11VjlvNTVibz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QnZCMVkrYS9MWEFhL2VFbytPcks5RHI5NFNqNDZzcjBNREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-originating-ip: [10.32.224.39]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: -vgUyfpi36K0G3BB9fepXcpi6R6iG3vw
X-Proofpoint-ORIG-GUID: -vgUyfpi36K0G3BB9fepXcpi6R6iG3vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_04,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
> Sent: Thursday, December 16, 2021 1:23 AM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Kees Cook <keescook@chromium.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Tanislav, Cosmin
> <Cosmin.Tanislav@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> Linus Walleij <linus.walleij@linaro.org>; linux-kernel@vger.kernel.org; linux-
> iio@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: [PATCH] iio: addac: Do not reference negative array offsets
> 
> [External]
> 
> Instead of aiming rx_buf at an invalid array-boundary-crossing location,
> just skip the first assignment. Seen when building with -Warray-bounds:
> 
> drivers/iio/addac/ad74413r.c: In function 'ad74413r_update_scan_mode':
> drivers/iio/addac/ad74413r.c:843:22: warning: array subscript -4 is below
> array bounds of 'u8[16]' { aka 'unsigned char[16]'} [-Warray-bounds]
>   843 |         u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 *
> AD74413R_FRAME_SIZE];
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/addac/ad74413r.c:84:20: note: while referencing 'rx_buf'
>    84 |                 u8 rx_buf[AD74413R_FRAME_SIZE *
> AD74413R_CHANNEL_MAX];
>       |                    ^~~~~~
> 
> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/iio/addac/ad74413r.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index cbd9aa9b399a..b0a6d8ee5133 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -840,7 +840,7 @@ static int ad74413r_update_scan_mode(struct iio_dev
> *indio_dev,
>  {
>  	struct ad74413r_state *st = iio_priv(indio_dev);
>  	struct spi_transfer *xfer = st->adc_samples_xfer;
> -	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 *
> AD74413R_FRAME_SIZE];
> +	u8 *rx_buf = st->adc_samples_buf.rx_buf;
>  	u8 *tx_buf = st->adc_samples_tx_buf;
>  	unsigned int channel;
>  	int ret;
> @@ -877,9 +877,8 @@ static int ad74413r_update_scan_mode(struct iio_dev
> *indio_dev,
>  		if (ret)
>  			goto out;
> 
> -		st->adc_active_channels++;
> 
> -		if (xfer == st->adc_samples_xfer)
> +		if (xfer == st->adc_samples_xfer || st->adc_active_channels
> == 0)

You can probably keep only one of the checks. Both xfer and adc_active_channels
will be incremented after your changes anyway.

>  			xfer->rx_buf = NULL;
>  		else
>  			xfer->rx_buf = rx_buf;
> @@ -896,7 +895,10 @@ static int ad74413r_update_scan_mode(struct
> iio_dev *indio_dev,
> 
>  		xfer++;
>  		tx_buf += AD74413R_FRAME_SIZE;
> -		rx_buf += AD74413R_FRAME_SIZE;
> +		if (st->adc_active_channels)
> +			rx_buf += AD74413R_FRAME_SIZE;
> +
> +		st->adc_active_channels++;
>  	}
> 
>  	xfer->rx_buf = rx_buf;
> --
> 2.30.2

