Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7350B47A9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhLTMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:49:30 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:32135 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231130AbhLTMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640004568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBHH8WJbdq4BQrFDov+29v6Ttxk66pZRJkY+OpKFi/8=;
        b=ar5Ox3cqhB4z59bzHnckn2SGW0n/5g+HCH+ykmLEvtwXn+0oein/qF1DXGYgEhs4QMYSqo
        gtnL94/9j5epMpu9bmzCP292IWP7pwNUBQKyObK4Deut0L+/ptqB2XeYkvE69elVzlvYzT
        YnDmcz9PgVaq25dKvdHZDlL33dm7LH8=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-DP8MgJ6uMbK7bnce5nPuCg-1; Mon, 20 Dec 2021 13:49:26 +0100
X-MC-Unique: DP8MgJ6uMbK7bnce5nPuCg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiZSwonp0YyoCtLDlPU7zttdobde1ezwirA0ppko+VgCpyy3e5Qdsg68hkAe8y6ds2NpMPirPSxITZURlyxvO86wBAusFh9o3g/SA1kaB4+ta9SCleFCjRZlHFOOJ0YrfS39YZn6MHe0uk+FApBSwR/sDrji/3vkTuk+SJ/EhWDa91fHty2K5T68cAtaue6oq4Dq0QucbM4mhPivoxkuYCfSCbOrIOfZHrb+csCZTUtk62ldZ+EiY1G1NStDqUphEy3XS1fQ8XwyNyV0l5qgUHSdkFmiYMcihIALEDd8ySjn5Z3ekVd6/aCgxV3Bs2KZuJNorlgwaxGPpIWxPjGIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZt9HHz6TxmgdY6uK6AM40cBC7j2oee7FwFB/0+eO9U=;
 b=VtWLtBBZmxAEsh55cEfqI7g5s7PQuGddc2cnUU3AJM2nLtTMi0H2YzjI8IS/HbYKhUobTF1DI3yNzRyBtDgr3Zl+0lsVnGtYmhIq2M9VYKPtiqk49MTL8v5kvBr+t+870/r8k5o1k2kbOttcvae+aB8merrrmJvyebdzKix4Nl8QQAQs0MZo/fQ1QyGHB2ozqa9p652qEQIOMLj8bVhkApYYuYY4DLFptxMS2+U8FoE3Dad0u9reiWCuKoS46urRsYQPwujgqK9Z0jeG4LrvhmWRvYMZXe7aSp/+mIPoXJDVuWqDk/nWkxty1f4zEKNBi1hXFwgUA9c2qvLWb704dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB7PR04MB5179.eurprd04.prod.outlook.com (2603:10a6:10:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Mon, 20 Dec
 2021 12:49:25 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1%7]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 12:49:25 +0000
Subject: Re: [PATCH 1/2] gnss: add USB support
To:     Johan Hovold <johan@kernel.org>
CC:     Marc Ferland <ferlandm@amotus.ca>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211220111901.23206-1-johan@kernel.org>
 <20211220111901.23206-2-johan@kernel.org>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <091d25b4-cfa5-c702-144a-8cfdb70b7f42@suse.com>
Date:   Mon, 20 Dec 2021 13:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20211220111901.23206-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0317.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::27) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37717fee-cfc4-48fd-67a6-08d9c3b72701
X-MS-TrafficTypeDiagnostic: DB7PR04MB5179:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB517923D397F1D626F521EBCDC77B9@DB7PR04MB5179.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6xq7Co0olC53Zqss5DQ0fdUZdExVagjkot1NGaabNTVnjoj1mSOT7NFL969HeD677X+OuEz653u/PW4cTtX9hfFMuFh3h1Si9QqbVzwI3dUUcjXoIFLLHFjHvK3K6SbmuW757702g1oNjN4audAg/d0h2oUFpTnuWgANMMUazOg4czjfz+ia/s6uZJFMGHwDM3JdqIfCTyLEO9nPxe3ilMerQH1fIsWchBiqdEX2MrshDpMaAkyfK3Fcz6yu9As4GiOQPPL3ycdZSaTTVJHXZyuNREKyEgxwbw/3RxCjdgRbgGBAisz3kTOK1P2dxGBorlbebSP1RKtzqNtPO5qnY6xw4p03qJyY6HpVepknIsoP4YRVfwsFsjcUjV8npqYObvDYlc2SAJFkaqptfiEeSv1afxe+2EZGW2QA0HGBdOAR8wn2krmCxA4WE2TsxU5KMyyv9PWCvilsJXkz3LyquEe2LEPg9/0ctepmtlcybTcMQ6Lx3pNlPyhYCptaS1y4cFp1U+XUpr+spxsISY9bCfWryTIZXKyPwOJXxYL2G5aUMVXDxs4ED0CUYfrjexhz522oZsPao4qJZW0HNCDOhXGxtSC54Dj21r7s/QBtOtzpDLqeipFDcVDmLiDPbuSVoeMbr0q98SH2CU4lhegn+25xCxQ5hgQCgjF9TX/TKkwmF7/Uij1DwLoieJHVufICRlOH6kJXr+JsqzeBDE9AVTc9DPNxpxVFBpFEYjATtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(2906002)(4326008)(316002)(5660300002)(508600001)(31696002)(6512007)(53546011)(6506007)(8676002)(186003)(36756003)(86362001)(6916009)(6486002)(8936002)(66476007)(2616005)(31686004)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTcqaB0i4WEBOmAWDfmGL0tqu/fONkARLehxqCgd5fPJAOZp1Cfb74np3fuS?=
 =?us-ascii?Q?CKcmtTjw9mAeJPxKoB6wP6+3+a4LpEh+YqA0c0n1qSEoqk5OImTgFWu/exQx?=
 =?us-ascii?Q?+INkaLLZhv7YwhDpZ+aq7qIfHsWvWUp1/KoY4otz8yd9LQusmiuMOpgmv4PV?=
 =?us-ascii?Q?An0P7k0QvtZsajFzsgjYu8DkdAy+NHTLrxM7X6esE2tQLL+x+TqgyvFkhg3V?=
 =?us-ascii?Q?OyqsoG6DCVowq/9PlW3Mvx/tKL5mbfIeuO2tVKuydSS59qWcXgZEJQFWjBdS?=
 =?us-ascii?Q?zICmmKoqmDV9Kfv3UPS181pq4PJ/3JP1vLESn+A2YrKavQr09uaQTKVm5kXt?=
 =?us-ascii?Q?7DOAinHRZMg0J+j2sgLy4L+LLs2voX8VVsNgO9aMB+lUGkpuGlHEHBNkBYX0?=
 =?us-ascii?Q?fL8TrlJAujFT6retQpP9Ql1Cu1yNz82rNFrh1jpYVhayAItA78hYA3yT8iS8?=
 =?us-ascii?Q?y1g0+PdciXeJYrM8xVaLgpc33BLEMla6xYjFleAWvnhD60VgYYDF2mcCcVFu?=
 =?us-ascii?Q?Eea07OCwoXJfVltiiwmCH/5x7c6vXoXvp9fbgo7lCECE7hRvMrA3bD7MRWNz?=
 =?us-ascii?Q?nlQiWNoTzuaS+882vdJojD4JM606DNFzyETCDsEkTo71UbfKTg6y2zu50E8H?=
 =?us-ascii?Q?WXmjiNaHpOaS5FMxzaPUMRChe7cm7OYcZDVFbbqVwqaFoUdXdX5rOGMZQXY7?=
 =?us-ascii?Q?6Adty/TeCIVqQybTyz+IGWDafKmuuRbeeLyZV71QvVMq/PtrwhX6jxhUs/CJ?=
 =?us-ascii?Q?bjUW/NCTIqMRR3ZRbN79zSlc9y6J8M6rn7FX0XzlI24Z1RT6iX7IPYL0bz0o?=
 =?us-ascii?Q?m47Sf3WCLG7OQalDHzawI3WqtTc55eYM9ouGKLkeIZ+Tgr6iZTqRbvHknIRe?=
 =?us-ascii?Q?lqUhO5XT5mA0ZuIr1AWvT3PbPLpX14Ji3+ok9b9b5n7F51nUMkEeKICecTja?=
 =?us-ascii?Q?WRbybQajAhqLvfKhfTR3ho/r/Xfor7PF8Qy33Vqtu1N3unRPetupu+s2hf2C?=
 =?us-ascii?Q?soWpt8u3ibDzdbRg0mp9YL0zwu9R7od96OaElPE5upPIsEA/ymNFuBFxqqKO?=
 =?us-ascii?Q?++Jl+lLO1Gerf/eIJLOCF5z+2VaR0jjsTFdTIwZ1nkFO03gOaOv+5dg11NLo?=
 =?us-ascii?Q?f+fzBd4M8aaUOtJEN16rKsI5N6chB0NDJoc4TJyyUbeC3VtjWzOcgnKgM9cH?=
 =?us-ascii?Q?PbYQd1jvYZzLUfTkwPjPr0kIh8EYM8l4gZNuGRAHf0L3tMXKym1GSLILqRy0?=
 =?us-ascii?Q?IBXbguiUmWJ/LTgaY9l3+AU39eHwQHUL3al/cfM5CrWAgaWMXjqjoZZdeA6w?=
 =?us-ascii?Q?JqnIF8fT6D21pMjzY/eoMuHRobut1T3FGDylz7PpnpP77AbfOO4whXGNkN0A?=
 =?us-ascii?Q?GCvklPSGKQ+8bcYd+xgXauZQCy3Bm1WlWuivgTPRvlu3KAq5n/1zADd+kr99?=
 =?us-ascii?Q?l499BAyyE+l8HsM7ac6JiPHAVCLaV1a9rxdYnPy+LT+mLRzc2hwkqmtxNZbY?=
 =?us-ascii?Q?1Bx2DedAKSCE0jjBhT7DxUEmcMtqhb3HfNbhu7Pepg8/DxNmhpI4K87dWf8f?=
 =?us-ascii?Q?NNjaqOTQ2+RsrySmFazVwp60HlKayqcPxxYW2xJThbZE5zDmUFZXqcrfVWVZ?=
 =?us-ascii?Q?+Q7qoV9+cH2YEM/4QirHOVPz24/ObnhiNI4kZL63ju+bZhf4PD8JkeZpJAil?=
 =?us-ascii?Q?ecUQ//3Gc8CHp6EMp1Epash6jes=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37717fee-cfc4-48fd-67a6-08d9c3b72701
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 12:49:25.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dltaDbH/H/E0z7ZYjpvI1cIhGcKdx5wk/FgmvzGZ+klMOMj5cDdh4eQtMWiIquu5+CWac7f9wpcpW+r/F5JRaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.12.21 12:19, Johan Hovold wrote:
> +static int gnss_usb_probe(struct usb_interface *intf, const struct usb_d=
evice_id *id)
> +{
> +	struct usb_device *udev =3D interface_to_usbdev(intf);
> +	struct usb_endpoint_descriptor *in, *out;
> +	struct gnss_device *gdev;
> +	struct gnss_usb *gusb;
> +	struct urb *urb;
> +	size_t buf_len;
> +	void *buf;
> +	int ret;
> +
> +	ret =3D usb_find_common_endpoints(intf->cur_altsetting, &in, &out, NULL=
,
> +			NULL);
> +	if (ret)
> +		return ret;
> +
> +	gusb =3D kzalloc(sizeof(*gusb), GFP_KERNEL);
> +	if (!gusb)
> +		return -ENOMEM;
> +
> +	gdev =3D gnss_allocate_device(&intf->dev);
> +	if (!gdev) {
> +		ret =3D -ENOMEM;
> +		goto err_free_gusb;
> +	}
> +
> +	gdev->ops =3D &gnss_usb_gnss_ops;
> +	gdev->type =3D GNSS_TYPE_NMEA;
> +	gnss_set_drvdata(gdev, gusb);
> +
> +	urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +	if (!urb)
> +			goto err_put_gdev;

The value of 'ret' here is the result of
usb_find_common_endpoints(), hence 0 due to the prior test.

> +
> +	buf_len =3D max(usb_endpoint_maxp(in), GNSS_USB_READ_BUF_LEN);
> +
> +	buf =3D kzalloc(buf_len, GFP_KERNEL);
> +	if (!buf)
> +		goto err_free_urb;
> +
> +	usb_fill_bulk_urb(urb, udev,
> +			usb_rcvbulkpipe(udev, usb_endpoint_num(in)),
> +			buf, buf_len, gnss_usb_rx_complete, gusb);
> +
> +	gusb->intf =3D intf;
> +	gusb->udev =3D udev;
> +	gusb->gdev =3D gdev;
> +	gusb->read_urb =3D urb;
> +	gusb->write_pipe =3D usb_sndbulkpipe(udev, usb_endpoint_num(out));
> +
> +	ret =3D gnss_register_device(gdev);
> +	if (ret)
> +		goto err_free_buf;
> +
> +	usb_set_intfdata(intf, gusb);
> +
> +	return 0;
> +
> +err_free_buf:
> +	kfree(buf);
> +err_free_urb:
> +	usb_free_urb(urb);
> +err_put_gdev:
> +	gnss_put_device(gdev);
> +err_free_gusb:
> +	kfree(gusb);
> +
> +	return ret;
Yet you return it in the error case and subsequent error cases..

=C2=A0=C2=A0=C2=A0 HTH
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

