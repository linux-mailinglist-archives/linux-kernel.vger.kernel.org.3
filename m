Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84134871C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbiAGEdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:33:15 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:58111 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346060AbiAGEdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1641529992; x=1642134792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IYoOmwmahsAdDDS4YAqbQvnaINLBblw4/8W0q8Ield4=;
  b=WaPT8JUj1S3h8pt8kltJkgnn2ro3rik/Ios+xRiKNCelJf5DDk49IY6c
   mKhAInGJggYJrfTUcNfoXts7N2SPmQFwE7kLKGuA19zBUBEKdFmI0O0pn
   1bmc5Fs5Ss2gUkInd1Xgla8ZUK+u9D2jjj9veyHrmeT8zZSSnB+G8K2Ga
   0=;
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:33:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx957Xy86CaiSF+HoUE1WzOdukQj3jakJhAmc8YBB3gvpuEIvr8yo10cwh/s7HfggFuoxbVBoDyZoQLiyY8R/bALWEOnzLN7x/zBETU4j186P1oFrObXP/o8PG+vg0vkpNfEUHpBZJ7CUGYoazw1JfnE5JqAKQKbPcXztAzog8aL5H4TbobyHC9IEiF9nujgTlytilxt91RJR4II5+2bGfgjfsGwmX2a1RefLCpKSAaOs4Un+H4b+Qt+x1ZA5L1CvBTcwSEL+DpABulOcIdqvh1+gd3BKfxuO3oiEoz1FqRUUvNf0OWHxKzW4wgh0oRTXMYPpKh0JEH/Urx6u9zjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYoOmwmahsAdDDS4YAqbQvnaINLBblw4/8W0q8Ield4=;
 b=FBzu7t10dFu77Vbk7LxE0RtTEYpQ99rVmyofu8dGhm9n+XAkTVA39sDU0rrDawMoBqQi5AYDU/0Os0T18YBlUaA2h3PQam8McjnjWw5aY3fQRUvnvvepQ4zq2PnnQOzLAJzRiVLTLk1wO7tdCN4vzFXvkNRSnfVWkioF8Yx2NFgbuokMvgskq7qH4qIRE9EFhNkOHQHL2kxEjhFRN8I6DKjqWMTbOTVSXNXyWmOB7aWhgMeOF1v/eDYR91Im/sQ8s77YmuNNXFxbUWUDOhtaZ7wOflrbDyjSnPQxfAnF7w2YgMsy2lXi7feSVUGGW6a1QDLV5xwZmU7mYA/kCCrqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by SN6PR02MB5200.namprd02.prod.outlook.com
 (2603:10b6:805:72::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 04:33:06 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009%4]) with mapi id 15.20.4844.016; Fri, 7 Jan 2022
 04:33:06 +0000
From:   "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        "rjliao@codeaurora.org" <rjliao@codeaurora.org>,
        "hbandi@codeaurora.org" <hbandi@codeaurora.org>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>,
        "quic_pharish@quicinc.com" <quic_pharish@quicinc.com>
Subject: RE: [PATCH v4] Bluetooth: btqca: sequential validation
Thread-Topic: [PATCH v4] Bluetooth: btqca: sequential validation
Thread-Index: AQHX9yuhatjIWZX420+xh1RGVFoWMKxWiFoAgACIoEA=
Date:   Fri, 7 Jan 2022 04:33:06 +0000
Message-ID: <SN4PR0201MB8725C4C34BE71388826DDD47E34D9@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1640174444-28561-1-git-send-email-quic_saluvala@quicinc.com>
 <3E84ACC3-BF17-4E7B-AA57-CDCA86549813@holtmann.org>
In-Reply-To: <3E84ACC3-BF17-4E7B-AA57-CDCA86549813@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d10e22de-da22-4147-72a5-08d9d196cd39
x-ms-traffictypediagnostic: SN6PR02MB5200:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB52009F8C0B93EBC9309BE09E9F4D9@SN6PR02MB5200.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5S2kaZR5Gcrt0ysx/Wkd0OvgXehc9AJ8MJzcn8NgrRSmvenSoS3sjQCv/e2swL2P9l/S80/Bh9DXL3TrUO4W9LnEfILKKf85mQjGRqz/iItG/VoRY3NTh/ClFqurR3t+LqSeDR+6k1gGrktSSvcbpoo+ROMUfmvzbZgDtz9SM27dCcPWT1r7G1PktlHeqm+Oqn6LClsKBbfV2i5nX2FwUy34TEqOIv+BHHGl8eeO/ELVfnekq2RIMETAC7L8qC24eySUDfT4ut34A+LyPa+H2pxSpUfEmPNVew4P1aig0wZUQkcYZZ563lOu1g/mDxivwSBswTZ0j1uY2dHqwIXClFqBXqr8nT41V1u4dgUIvC3xuqxB6FHT3TnbDqQyhIssZfOQ1AY+kl53vWtcOECtAxfmXswlxri0g6t2KkTu7k67wZ22L8Qi5tk2CKGEqp+dWGE1Wp8JawuCHX17yQFpgrWUjXIYWa4MMW73xQcwqf6SYv4qrHtPWdKvX4rQQDqG8pCrBzYgbqR420X7giRUPy2PxLZrhYRhtanU2dw0PLBnlKCxmHBImaGqgStXcBD1QSGh022FE0uwb8qSwDPfR4sISZtoI47g1dOO7KE5/s2O93XB5zqgfkUygrJHULVYQpnMqyO5qepj40QL3TyZ7ytkPH7lFxK+92+IBLByEm7yEOVIoQwj30IAk3HnGTBIxRBMqQ1/eQDzRznWuqUbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6506007)(71200400001)(66476007)(7696005)(76116006)(83380400001)(9686003)(66946007)(64756008)(2906002)(7416002)(4326008)(66556008)(5660300002)(38100700002)(316002)(122000001)(107886003)(8676002)(38070700005)(54906003)(110136005)(55016003)(52536014)(26005)(186003)(53546011)(33656002)(8936002)(508600001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VYKNLz6fLyNGwVMk4gCHDgG25w/H0QJhtuqD2g4MiPkO8Kbi/aDav5AUwK6J?=
 =?us-ascii?Q?8W9iPetNhM+FJPT0o9vSg+APJNSNbXcP/ZNMnxp4iAuBGmE/ei92KngDdpSE?=
 =?us-ascii?Q?5CDkdltnO5SlrUV0PXmop5Rs6fWAtFZasnvuljcKg3g+A+R0w3db05/bqVal?=
 =?us-ascii?Q?NaUeBkHWcQnH69XCZ28ud7avhez04e/k0txZfUcNeVnwHUcrZeHPMiyU5jBS?=
 =?us-ascii?Q?5kBUC5xnefO26/77wFzzZ5+9oDZ6QjuU0eWw46jnEoIrJUkfdt+aMkY2Zvb+?=
 =?us-ascii?Q?Mi/MqjGFsuNnDjI4YzvN8bUiTLmf3zRsK5zwoDHkK0x5av3/Ew19gfIB2QKJ?=
 =?us-ascii?Q?7gY7q2fa9MZxGHxzORxzw1rCbYJp/2rpwgwPZ3D4GZh19Oeg3Y8CyZTml1Po?=
 =?us-ascii?Q?mADH75R+WvgO6FjkLahZCyi8LFEHsBkj9hWWCBKpyw8t/80ySkByrnOn2E2p?=
 =?us-ascii?Q?WqeZdmmlWlyWIul7bshrobyP8kWPJAFoe7F1kglDZJxr/+PHNYqhYZHEQFbA?=
 =?us-ascii?Q?UkoS86iNUUCl7NeR/IGhpEcDxBRJ6vv/EizGdimUH3KhkKBqT7QsRu7Q7e3P?=
 =?us-ascii?Q?h+HqOFYgf+aiIg6xckN9pQh9WAGwi6n2YDvUbV8765gzyhy+dWC63b+B5TjR?=
 =?us-ascii?Q?N231Kx+/RcAyNuPkF8O0UmFMXrloPoakEBROOT9rcrTaBJu6UaNyV4ot8gCa?=
 =?us-ascii?Q?xlKGGjm6zsHPeBGMsJMXkjpEyRjZzUSYgB3wDYK+GS5FJNvwTFM6LXa9q9cX?=
 =?us-ascii?Q?WwfjzhfM1/SMY3i+fwKKjjLcLTmUumzVOyJglbTUSEJXudvYx/FilSvDzZ5J?=
 =?us-ascii?Q?x6n3r8y53tvhzWgUhJF3jAbTDLdf+af8xL5OXUYTdHNb/j1UsY6Z6GBVXrpd?=
 =?us-ascii?Q?kpuLJhBnLdHyKZ1GsCfaYeyUAv4BNFEfQctfWU3llqgLx0GqBn8DmHYnGGhT?=
 =?us-ascii?Q?ZcJX8QQFNbsRbwjXAX/UQMbzcVyK3hdXnpiZTlgc2V3N6Dwem5KHBBxDqqOp?=
 =?us-ascii?Q?fl99dlTKvLY0dUGrzKRSeLCF53utsYoCC9eSm1Jfk/xi6PKhGcIO14fOARS2?=
 =?us-ascii?Q?j51j3dGVj83Dm21w5/vb+fPKlcUm0hIwlq1SkD8LcoJGZpLhvrCAy3FM/8Ca?=
 =?us-ascii?Q?y1P+zG1h2LnyCm37ujnf7sqchnJDn5F7B+56DXtFsogKdNs5Ufuc/Okg4K9K?=
 =?us-ascii?Q?crqF/sPgHro7HoNeKr3Sdt8yWmNWAPnP8EPSAkvxEYWZ4pSbQywqnAYkSBA6?=
 =?us-ascii?Q?ptf2aTWRsv27Dc17hAMIdFEANibnzN0XsD4smQG80wVCnCz5NRh0+esXktg+?=
 =?us-ascii?Q?3qvfZ3ACv/YbGW0+lJQH+OgDBk464AoJ/saK1hGHcvzQnI/eQJJQ2HfsVlRJ?=
 =?us-ascii?Q?CyiY89f/3wRAjpBNji93fPlSSuUF5hWb7E7plpt1iw/E/EIrqRnS/GcL1dXh?=
 =?us-ascii?Q?k2AZtQK0Kw5bQSLvqxDOuCLANOqg6VyJmZMC+xhv18Pr31EfX/Ot0vOblE57?=
 =?us-ascii?Q?kH3rDILS5Bo/LBdSScZDTIoI9TTnuV9odXRj4j17j29g2S5kdtbFsa1nsvWE?=
 =?us-ascii?Q?9x7ViwuzuUChq7dE7L9LesEbuHD4w+Mx91lUfPS7pEV7Ft57ha9qoUTfAAQC?=
 =?us-ascii?Q?FCcEeojQTNKoPnJXINXnFH68jQOuFc0sErbFRx+t8ninhJAMw7Kn+ICr3m8p?=
 =?us-ascii?Q?bPZf9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10e22de-da22-4147-72a5-08d9d196cd39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 04:33:06.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktel0f/A8FTyvWS1qzQMcyM0NnEz+wsh8dvrZjKitgzzsJaXOYKS6m4dtc1YQpf09n/rJOFAUtFfbxAqZ8ifQAlk62ucwvoafWFpO976DaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org>=20
Sent: Friday, January 7, 2022 1:54 AM
To: Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>; Matthias Kaehlcke <mka@chromiu=
m.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-blu=
etooth <linux-bluetooth@vger.kernel.org>; Hemant Gupta (QUIC) <quic_hemantg=
@quicinc.com>; MSM <linux-arm-msm@vger.kernel.org>; quic_bgodavar <quic_bgo=
davar@quicinc.com>; rjliao@codeaurora.org; hbandi@codeaurora.org; abhishekp=
andit@chromium.org; mcchou@chromium.org; quic_pharish@quicinc.com
Subject: Re: [PATCH v4] Bluetooth: btqca: sequential validation

Hi Sai,

> This change will have sequential validation support & patch config=20
> command is added
>=20
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
>=20
> v4:
> * addressed the change from u8 cmd to const u8 cmd
>=20
> v3:
> * removed rlen,rtype
> * Replaced kfree with kfree_skb
>=20
> v2:
> * Added static declaration
> * Addressed wrong indentation
> * Removed EDL_PATCH_CONFIG_CMD_LEN
>=20
> v1:
> *Initial patch
> ---
> drivers/bluetooth/btqca.c | 48=20
> +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  2 ++
> 2 files changed, 50 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c=20
> index be04d74..9091a88 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -141,6 +141,51 @@ static int qca_read_fw_build_info(struct hci_dev *hd=
ev)
> 	return err;
> }
>=20
> +static int qca_send_patch_config_cmd(struct hci_dev *hdev) {
> +	struct sk_buff *skb;
> +	int err =3D 0;
> +	const u8 cmd[] =3D {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};
> +	struct edl_event_hdr *edl;

I said this many times before. =3D {[SPACE], a, b, c[SPACE]};
[Sai]: i will include spaces & update in next patch

And I prefer the const pieces first, and int err last.
[Sai]: I will update in next patch

> +
> +	bt_dev_dbg(hdev, "QCA Patch config");
> +
> +	skb =3D __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, sizeof(cmd),
> +				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err =3D PTR_ERR(skb);
> +		bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
> +		return err;
> +	}
> +
> +	if (skb->len !=3D 2) {
> +		bt_dev_err(hdev, "QCA Patch config cmd size mismatch len %d", skb->len=
);
> +		err =3D -EILSEQ;
> +		goto out;
> +	}
> +
> +	edl =3D (struct edl_event_hdr *)(skb->data);
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA Patch config with no header");
> +		err =3D -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp !=3D EDL_PATCH_CONFIG_RES_EVT || edl->rtype !=3D EDL_PAT=
CH_CONFIG_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +			   edl->rtype);
> +		err =3D -EIO;
> +		goto out;
> +	}
> +
> +out:
> +	kfree_skb(skb);
> +	if (err)
> +		bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);

It is rather pointless to print two error. So just scrap this one.
[Sai]:  will delete in next patch.


> +
> +	return err;
> +}
> +
> static int qca_send_reset(struct hci_dev *hdev) {
> 	struct sk_buff *skb;
> @@ -551,6 +596,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baud=
rate,
> 	 */
> 	rom_ver =3D ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
>=20
> +	if (soc_type =3D=3D QCA_WCN6750)
> +		qca_send_patch_config_cmd(hdev);
> +
> 	/* Download rampatch file */
> 	config.type =3D TLV_TYPE_PATCH;
> 	if (qca_is_wcn399x(soc_type)) {
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h=20
> index 30afa77..61e9a50 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -13,6 +13,7 @@
> #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
> #define EDL_GET_BUILD_INFO_CMD		(0x20)
> #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
> +#define EDL_PATCH_CONFIG_CMD		(0x28)
> #define MAX_SIZE_PER_TLV_SEGMENT	(243)
> #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
> #define QCA_DISABLE_LOGGING		(0xFC17)
> @@ -24,6 +25,7 @@
> #define EDL_CMD_EXE_STATUS_EVT		(0x00)
> #define EDL_SET_BAUDRATE_RSP_EVT	(0x92)
> #define EDL_NVM_ACCESS_CODE_EVT		(0x0B)
> +#define EDL_PATCH_CONFIG_RES_EVT	(0x00)
> #define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
>=20
> #define EDL_TAG_ID_HCI			(17)

Regards

Marcel

