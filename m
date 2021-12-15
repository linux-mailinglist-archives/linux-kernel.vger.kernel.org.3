Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2695E4757BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhLOL2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:28:22 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:57024 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLOL2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1639567699; x=1640172499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMKXlv7H/K9eEgBAWGNuQ5v5BTjZPWeQ5ZBXGKAFZKI=;
  b=zVx2rMwsr+4Nw887S/76iXxbkwI4dBUdOPDi3Zb3x/iMAWupjKRElddB
   sNwAowA1G7eGQ0qsnxde648l4ikDoow3o8KQ6wkA4MYmIP5rlhjf4J3Lh
   z65Q/N8AdFFzRTVam4M0m54QiYLa3HvutQbuut+o8VV+n839RVpvD96ax
   g=;
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 11:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQgPxmbSlTMMo2vAizCKfG6YAsvRiP0C2fgpqfTXeh0s+EQI2E7slDun4jqquzQ5BKiOca1mJwpRk7eDGH0/ZoPsVJ7qj35Io9Nqp/embzemyXpWTaeXRKS3r0FDfzD30u7LFUt45t4aBfPDrIVSU5u5P8cixZfEmnyoem8MAlQcVO1a3Dlb/PUCPPhV+VIe+b68VtFxtWUICWi3ClTLj7q5maPbej43TpJ9wO9ffmnMa+gWh4oinN9+iaiZnx96yM7N2FyuQ/0S5CMBvu9qSAAhDAKxhbM1t/tFBHcv7kLGQJtimkqtyqKMPRIhWCzoy4ZZnAllaHsRaTgbb0P/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMKXlv7H/K9eEgBAWGNuQ5v5BTjZPWeQ5ZBXGKAFZKI=;
 b=ay8pnWYLM7wSrQmqgJC3MtmMWa8a7vcRESck0hO2GguR3QwYlOPq48FJiMAa5KjbPIqGZ7ZMeOPGoR51sdCqNw/L80H3DRDiocWYrvOU+S9QEoy6bE03g3vzq/lBk+z4edqu2wFCEQgZRQcyfHwIimxwF8S8LfLdiiTP9YKT4sblXq8qu8YxiK9cnEMNo+a15XmhY0qICJwYRp+xB/sLy9nUqpPiJvq3CYJkaox2LPjn87dKvuP4zLnsVxtupkXXNgYdrL09HBWbE+UZMDatu1XXAtLyCga4iofKey7Y6TGd/kRFcOdLSc0q984o1+8+jQ4o6x7oLlIC3UBH7eYFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by SA0PR02MB7291.namprd02.prod.outlook.com
 (2603:10b6:806:e8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 11:28:16 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::71b2:90f0:8f8e:c03e]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::71b2:90f0:8f8e:c03e%6]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 11:28:16 +0000
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
        Rocky Liao <rjliao@codeaurora.org>,
        "hbandi@codeaurora.org" <hbandi@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "PANICKER HARISH (Temp) (QUIC)" <quic_pharish@quicinc.com>
Subject: RE: [PATCH v2] Bluetooth: btqca: sequential validation
Thread-Topic: [PATCH v2] Bluetooth: btqca: sequential validation
Thread-Index: AQHX7MjINdT5VbQJeEaHM/dJwnhK5Kwp+ikAgAl59uA=
Date:   Wed, 15 Dec 2021 11:28:16 +0000
Message-ID: <SN4PR0201MB87254F7D357675346E138AF7E3769@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1639032466-8457-1-git-send-email-quic_saluvala@quicinc.com>
 <42E81D62-346C-4AC0-9B97-A54D67482331@holtmann.org>
In-Reply-To: <42E81D62-346C-4AC0-9B97-A54D67482331@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e2f9f89-0a4a-4abb-dc6c-08d9bfbdfce1
x-ms-traffictypediagnostic: SA0PR02MB7291:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SA0PR02MB7291BE32821B3A3720EC38109F769@SA0PR02MB7291.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKwxjbBF0sD+mcPkim5IxaqmFJr8SljneA0KiLyK0w2Pz/CqjxZ4ecwtKRtYNMder3842s+UCi3pcl3mIVaqVjYmqj3kPVLQWncLo4yXGxfdPpIpIQfUwhiQXaRT+f0zXEQHybGRpT1tM/hnD+l7GySUeCb2Zfy++mOxC81wb8j3JA90uon54NMBo/ZT8wHpVdU/cnfiPtIv7EbmDWxBggwSL8oMhFqkRsBvdSoyfnnxc8fGwpk+Zf4ROKOBFS772d5/3/yv8ez9No2xtD22FbCsSJ6sjUN100WtUrJrnxZrLVzRzca9JxZI9jz8H7N6xDm3wdBlJR4Bc/l8bwjDYu/+RpgsIsK1qG9QpzQc0XZBVWTvsVAmSpZMcS1oY9JRKFGlUUnbNi6qy00qYFFCOJpZcIBLTHMy/41hzPFxhHSrhM3IU2nOsHF6/xiGGC1A1WQgpnHOGYVfBpPCotxuSOHQKH+5CBjVAbMcqWiGU0Ln6+qv1sgGryAE8uO+B/pt2E3i1X/iDhUGQ0ff5yFaeyGfOwi0k3RivI5xwRV1cwDCkir+f/wKzOXnaYxA8Nkz7sP65UL3GSEeDt1LsNl4DbnfO8EncWUwsYYjCevzmZfOApW5qdCnjy7ZCWLpmObst4A3RKQtp8FGl1gk25yZfeFbDDf/U5muRcVl3WBX7KVJAvAJK1EWUQax6oa9rtA2AIB9nCJB8BffkaKBJEbtYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2906002)(33656002)(55016003)(316002)(7696005)(38070700005)(107886003)(38100700002)(5660300002)(186003)(6506007)(122000001)(86362001)(52536014)(53546011)(110136005)(7416002)(64756008)(54906003)(4326008)(83380400001)(508600001)(71200400001)(66446008)(26005)(9686003)(66946007)(66556008)(66476007)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BjJMgW91EYRpCj3O1kaOWqqTAtMJKZ8AkNErtNVlye/K+VE2wBeyGUAoIqXM?=
 =?us-ascii?Q?MSngxPRWaBOV7nCrlUh4pnOv1wgd38s9tlZOibj4gR9zPPXjGgAHjvRMe7nE?=
 =?us-ascii?Q?5tiKJ/3QfjoRmvgRQ62/jYEPqMyA3Ka4BxXMCxpOZS/yU6fmCTsho3qC2qT1?=
 =?us-ascii?Q?GME193zZA/2PXwyNFv+jZ1v0HZ85HId64tVcdxdSgw5s2SR3HjZNSPFdHBiW?=
 =?us-ascii?Q?PKioY6MN2sBvyeRYjcOAenSDvGB0xoqKDHt0PSdr3Z38r4lXYN/45c8lZIPX?=
 =?us-ascii?Q?ODg7EXaBhajKcw6xUkecot4g9BRGwKTrT3m71gz6u5ArFuptLMOtE2EY3B7t?=
 =?us-ascii?Q?kk4SJnTEp9Sfu66Z5fVADVX9iKR9ibshFdoWlAdqv02zqD91y7Y21su18LSX?=
 =?us-ascii?Q?sRsZuZHdKGrgsM15n7qqYeagploZalqqjGMd3aex0JONWsAcE9ivUUUWS4nQ?=
 =?us-ascii?Q?E85hA6atmZ2hNFIedfHMdChKBLaOaw1uTbVnfOudK/X8YDfaqgNwstEHrHmq?=
 =?us-ascii?Q?TGzJqLDdQE+BJ4uzcqY7LwMM0/uUHeMR16/Ka+jfzs9h8sjN932bRGxDKCPp?=
 =?us-ascii?Q?ZNN4eiNqabj9B0IOJ3wfrM3ciYV1boTs93VmQaYf4FTgvVBaO/yjBpkVKKQi?=
 =?us-ascii?Q?K8I7mQC2BTRGLzCaERRn1IyxHnYL12HtYHjtxPCpo1NcjU6AAI1jH/pC7hzK?=
 =?us-ascii?Q?9kRMq3UJRSolIzCb4muVhruyzkNeOFbzrgxCM6TvEkGpsbYLpIL7KnhwULA8?=
 =?us-ascii?Q?/a89hFlSa0xifqF2SfuvI38Y70AXEyUGZcg0cK/gFMidtSaHVzWtHhmfDori?=
 =?us-ascii?Q?LJbJVuuFKzaQF4kCTMrK4GBF8td45h8zUXdriG9cQF5SGGlahcWuxQgV4ybV?=
 =?us-ascii?Q?8kvY2IRCN8gDlXSDZmwRf5xs6ztUJZ7AhI6IogaVhGV+MHc/h/teIs7G+lSq?=
 =?us-ascii?Q?J1XRxr4AOo9anYF+fUOZA7myraCbk4aSXyISZkPfoMYBk/OidG0hy62Pm85+?=
 =?us-ascii?Q?7vyM3Wnkgu3A2sEBmski1rB+NlZ3OoYWz7tOiI61zd6mstiIvq+lGkNamNpl?=
 =?us-ascii?Q?i8uegOiaEpQXKcaaXtcH13kh5xdTFH+Vu9iWceJqKmhOwwaychXAlEMftaUl?=
 =?us-ascii?Q?QVRTUfkUQ6vua/wUcNPKTXE4qH/3NpbrjDu0czynnF7vBW1GSSU+g031cxra?=
 =?us-ascii?Q?w7PbMZvVUS1rKWmicu//n1jkrFx/USw7ZG/GQqU3N54X5Owdg3A7E+Q+PQGR?=
 =?us-ascii?Q?waytcV5rXkRX9Lv8hbFl8PrPmdI6b2pwovT2DVsYDxuNB2KfiSZCyEotKxoh?=
 =?us-ascii?Q?ngAGpz3Q6vTOViE9G2HVGDi56SogZjcAPI7KNFhFAXkodpLyZK8gS0cmxWkX?=
 =?us-ascii?Q?i8wMpWhhIOqDpq/QnZIayPemGroiJV+su59e3n1c/Ss7xE8l9BQJyr89ooeS?=
 =?us-ascii?Q?TOljwg1U9C/Hmup1+lEIIWjEXPp4JrpSZngwwfCc//VP+OPX4OXY8ZY04vIv?=
 =?us-ascii?Q?AzVZJ5//bA5Ap/DIj81NMgKICODohjWtzTNRvMu3RautYK6l/oJN8RGE7rH4?=
 =?us-ascii?Q?VIk3Of98jD/NpJbCAhQhywfJcIKVcItGgYmD7BHCP1nvSb0kMhV20Uj9o9rI?=
 =?us-ascii?Q?05Lrn3erY7b0vH3/jiX/92ixQM3plaXWXD9p5ItHolhJT7n5uPVr8LqMi72K?=
 =?us-ascii?Q?GDbk2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2f9f89-0a4a-4abb-dc6c-08d9bfbdfce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 11:28:16.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vg4mZjFnXFOrWFUUAu4dKnnDD+adv8yCue7QqC+CyomHC9hCMCeJq8L0Q31vsywBKqp2N6jWusBKQUE0PWIeLvP5FCUdY/+NKh0deX6mLq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7291
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org>=20
Sent: Thursday, December 9, 2021 4:15 PM
To: Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>; Matthias Kaehlcke <mka@chromiu=
m.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-blu=
etooth <linux-bluetooth@vger.kernel.org>; Hemant Gupta (QUIC) <quic_hemantg=
@quicinc.com>; MSM <linux-arm-msm@vger.kernel.org>; quic_bgodavar <quic_bgo=
davar@quicinc.com>; Rocky Liao <rjliao@codeaurora.org>; hbandi@codeaurora.o=
rg; Abhishek Pandit-Subedi <abhishekpandit@chromium.org>; Miao-chen Chou <m=
cchou@chromium.org>; PANICKER HARISH (Temp) (QUIC) <quic_pharish@quicinc.co=
m>
Subject: Re: [PATCH v2] Bluetooth: btqca: sequential validation

Hi Sai,

> This change will have sequential validation support & patch config=20
> command is added
>=20
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> ---
> drivers/bluetooth/btqca.c | 50=20
> +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  2 ++
> 2 files changed, 52 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c=20
> index be04d74..633a24c 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -141,6 +141,53 @@ static int qca_read_fw_build_info(struct hci_dev *hd=
ev)
> 	return err;
> }
>=20
> +static int qca_send_patch_config_cmd(struct hci_dev *hdev) {
> +	struct sk_buff *skb;
> +	int err =3D 0;
> +	u8 cmd[] =3D {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};

is there are reason not to address review comments?
[Sai] : I will address in next patch

	const u8 cmd[] =3D { EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0 };

> +	u8 rlen =3D 0x02;
> +	struct edl_event_hdr *edl;
> +	u8 rtype =3D EDL_PATCH_CONFIG_CMD;

I missed these two and must have assumed there are used somewhere, rlen and=
 rtype are a waste to be declared.
[Sai] : I will delete rlen in next patch.

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
> +	if (skb->len !=3D rlen) {

	if (skb->len !=3D 2) {

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
> +	if (edl->cresp !=3D EDL_PATCH_CONFIG_RES_EVT || edl->rtype !=3D rtype) =
{

	     edl->rtype !=3D EDL_PATCH_CONFIG_CMD) {

[Sai] : I will update in next patch.


> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +			   edl->rtype);
> +		err =3D -EIO;
> +		goto out;
> +	}
> +
> +out:
> +	kfree(skb);
> +	if (err)
> +		bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);
> +
> +	return err;
> +}
> +

Regards

Marcel

