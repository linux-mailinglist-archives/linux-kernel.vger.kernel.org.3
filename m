Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231F14BEB22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiBUSvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:51:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiBUSt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:49:27 -0500
X-Greylist: delayed 4920 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 10:49:04 PST
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F69195;
        Mon, 21 Feb 2022 10:49:04 -0800 (PST)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LGn6V4025634;
        Mon, 21 Feb 2022 17:26:51 GMT
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ecek8r4rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 17:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcpXn7+x0J1M0PNLh46Ku917oZMJ5M8C+pitxawGVUeNaIPcYDuDKlYHAhm3e7iayxeCzZOehXzIAfpB+Uo7y8DjCQev0j51HZONNQE2nMS53b5RYlgVaDc44n1AqarBMQxiw+OjfmEx+kXyELeQFdcqxLpcDrlsBY4ArOxt1u/xjO3pQ2q9hxE5XsaTvNZap+gNi1X5A9Aihl7BZSu89GAFp83Oc3B/SpP8C/3QBthnCuQLNP8wFC65mEIVaCFwMJCkuXO5VytV6m0VapqN2YdxoxqCxMDKqbwAgqWNY36Me5QtdACpUyimfoUGIUDOFdYSNPjeSoBIV5blChJeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p05ZuRWkFo07UP+J2YSwu1tPd1ifLwCTHtdXJEHcpdM=;
 b=jMO1MkOVIQKahfBn0iizTcYXAwBOeziPzM3bgqWNhYUq3fzxSu5nQmUH7Htv/XU7u3xll1BMPMppQWlj0OKVWrZqpmgOTlwfthykat3ER4NYOqNB5HOhOIVjHkrL+0i0B9m6y6EnNdiqoNOUsWxNBLRS3Jr2qb4l6ell9zXs3bI0nJnJR0rhv2PZQOm8QOTUaCq2fBmLnakfWjcky32oNNouB0HzjWrYxiPwlS3/ErvCsqrsXEPmg3JA0qAk1OjW5jqDq/QY+8eXnO0OF+gqyp+dYi9UlYQStRi2frjxOtjRgCd/lZiY8EYBZ4rKnQjOmX4GW5o+UVyNiWZ2pKYEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p05ZuRWkFo07UP+J2YSwu1tPd1ifLwCTHtdXJEHcpdM=;
 b=mLjIL7hsIT68e1O3G7eMBRIZe62He/hw+QY1eWpG96OhJb2ui5nb+GwcxUwS2lot9Tk04Jy46ixzDIODuBVf9G6IKshJIf47+z4i9PXPvRn0JEORtWMNVgL6y9HdZeInW558qGa8hj5R8Mg7t6fxNPtVaNyt6wDCB+eGKZDfbJ7WGOf6+ePDYhE7zHFaNaKob+ruDgkrN+q7LrO/3ONLxlqSZZtbCcxLxgQfK9E1DXH32WWKjqXHf1zC0+nBhZAgsIqTw+7P/UpirH+M2+gipr0NMaXeAFhHC/GYfHKdLmRyPOJmXNSVpK/iq3KXWEvs338vgTezWwD7DUhGHRgDzw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM7PR03MB6466.eurprd03.prod.outlook.com (2603:10a6:20b:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 17:26:47 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 17:26:47 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERQ==
Date:   Mon, 21 Feb 2022 17:26:46 +0000
Message-ID: <cover.1645460043.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 758b47bf-c0c8-4c2c-4708-08d9f55f5688
x-ms-traffictypediagnostic: AM7PR03MB6466:EE_
x-microsoft-antispam-prvs: <AM7PR03MB64660C6CC88A12943A7F32E5E33A9@AM7PR03MB6466.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U/NzX4wSpqKiVnvTEoi0lbEC0kINbJmjQ8rtfz2neB3+P53ZJd9kz/taeCH7s3bAfgtLyGHY7DC1ugCLyh5ovQoI4HAYjEsx3muiX+5a8AN063Nswq4voJpN5IULCoe8Sbsl2cs7s2e4y8XtJ+skycTYGC3ebD5lFOgl8c/1EdgxTWbyOh70HGlr4hWcELkPXXaQXHqt/5OGCSHSWxfJntqafUQvRcFl1LSzYfG7oFmMf6v4KKAptCVQY2RmHD532zYCUY0eK5gOCeaLGGlbVRkiZKYI415NkdAXsKThqDN0gbdCQoObbv7MUCW+jdemArjE/pmMeTKFRCAggdCEE9XT1zLJkbCmbrpstkXJpYZA8xNHSy1/yqkC9poXk0P27DB5pYHOPZFbI0VR88jJCeH1Ss6P1T00DdXAIN2QiaFZYwiN6lFC1Ito6dBri43EgroaH4/5AndX2CAn3s/oD7XZ5FK4MhG2QuwdmHtoZcN3NEbFfWeqpu2gDaGXxKAo9KnYrrqqPAVyBAGwPzfwQRhriqMvXxK0fPIHFEajy2YZlbSszAQ8/zAEuwACdAjcMWsTqmihJd6Gx9YSbaT9GXtHFGtzK67ZE6tAUgHZ/H/Yvgk3cQTaMW1c2kjrAHXrCzbAaA7TWMPIwc7ODm0qKKPljsyWV8Gr38ETUj9GAg6hQbOPd9EQVIPU1nxBmsFUePC9OziCCME4GVzTz5KzHzwleGjVzc04r1AtQlC6+vNOztPHFWaqVuS3ttDOfvM7bKQUNw2uOj4Fqiw3eSyQSRneUgMeligUfL3vzU2s1hk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(508600001)(8936002)(966005)(6486002)(54906003)(86362001)(83380400001)(2906002)(316002)(5660300002)(2616005)(8676002)(186003)(66556008)(66946007)(4326008)(36756003)(76116006)(6506007)(26005)(64756008)(38070700005)(66476007)(66446008)(91956017)(122000001)(71200400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FeiR0h8MqA73d7wlKx68pFbsH8dMVteZ/GUcHyDsQOwXHfaFeWZb7aqWX9?=
 =?iso-8859-1?Q?P9oSHNEGDcXMmXFA4grgpNsPPLUZkIk6wyFAN3GzJQ3zwI32iiBb2xR7/K?=
 =?iso-8859-1?Q?RfLEDkJHEqKiWqzREJU5fMpHKoU6NoU5RjfAcb9xjv2MWbhMELoAb7wSSt?=
 =?iso-8859-1?Q?7vDzi2KkVNe9adGQlzm6Vp0E77nwjPZTjO+kkPw02tERhPohcxTQ4QM+f9?=
 =?iso-8859-1?Q?XUvgCYtfqOlwniekb/rbCEUd93eURpq6QkfqSuhooIdQbwv5GMVE7x9DW+?=
 =?iso-8859-1?Q?C4vKqOlntH07gh8kC17nTy//STOv7BYh1qfJQixkYBhECTJto/z2wRVqjw?=
 =?iso-8859-1?Q?OQK1e7TZrvGfFTyd5U3ztndrAVyPgy7EpQhGmvk/QVhbdsQv/etqUFQDYS?=
 =?iso-8859-1?Q?UuX3LwAvJRPKmQlyR9Kygx2CiRGhilu9Bm7M/wKRGehvvrAtf49ktTubOv?=
 =?iso-8859-1?Q?TO+Ccrkk2ksaBMLJXDSDN3GMtav48/pi91OeKNwwJbzDKba2HKpRejeeWo?=
 =?iso-8859-1?Q?HvJrGyUzCsaV1QrvcOIzq6942T+I7B28r77j8GGNmqpOLSBRXXaVL75WAx?=
 =?iso-8859-1?Q?AMSXvarYmC5WwH4M/trz7Tpw8pXtnvs9PkGvo4q+zaQVyGr8O1DvdEndDV?=
 =?iso-8859-1?Q?CkCtch/6mVB2cmrbc/oUfs6OezHfVcpvx7hYlIN5Gni/L/a2ww97XaEm/l?=
 =?iso-8859-1?Q?/QvADVDcIfDv/TFcY66hLc2EluMMy365fKKEbpvpiZ2sCoXa7R6MfSNQpJ?=
 =?iso-8859-1?Q?YBjz3JkbzPnGbKP+iQw3/0eiyeYKfqUkWDFyCnCILpvuY3PKPtvgMNt0M4?=
 =?iso-8859-1?Q?Ev/0HY7ulC0IdW0CpjB877+qEpZGS2V/uvr8WR+7BQADJPbPYDTWBhTlP/?=
 =?iso-8859-1?Q?bhaLNXo/e7c5tu5u4HfDkQDjCYiOdWgU1PXf6xXzXmDwgbCeNlpCjybbR7?=
 =?iso-8859-1?Q?2mj7YlJ9PbhjCCugf9Q223OehG3237k4Ug69voltdKWWil+SNjw30RdJR9?=
 =?iso-8859-1?Q?wOMqiz8XF/Wmvsa6zC1gwyTn+e1uEaHNhjqe8ZeupanRZqvPZo7v/H1AlV?=
 =?iso-8859-1?Q?AQFXnzCOHfAXuNm+Tlur143ZLiwK6Dne23C5OJC2/l5lGbnC4jeALV1qI3?=
 =?iso-8859-1?Q?a4TEOMZ1fnfhRjK9iTe7x4FmDBKMBOrGmXuv4zlC834Q9UU6AHFBuZy0Gx?=
 =?iso-8859-1?Q?ew0C0cs1lnOEiwM2ZgsYm+w3MlkWJ70r8M6cy0Gvzy/fhjeRJHgx+b3Ynn?=
 =?iso-8859-1?Q?agDSpFDr+2Dpc13mtAG6fHNwEBFnj+Zw3kkeUnoMHch4N/unnLoLcopblY?=
 =?iso-8859-1?Q?3bHcxTc9aLmdnnh0139+4Wies7PTLpyOEa/T73nVEv6faAg2/6p+u9wCVD?=
 =?iso-8859-1?Q?JODF8Ht5GYyzvBvBJyn2nyCWBDj+eZ/M6K29mA/b4PFtp8Y4MG6bUXpw06?=
 =?iso-8859-1?Q?UpISaqpdFoouQj10SseGekwcAD3oTyKA4wVeUmuzwYif66x8ASw2FOEqjQ?=
 =?iso-8859-1?Q?7P0QHGeYMAbh0BaZ7XZKWOPRbDSBmwuc4ou1WjZdu3oJ49iMCl6doDW9R3?=
 =?iso-8859-1?Q?6vUjsApf2bPdiKaLK5Y4tzYX+LSByX1ySxB849MGLpKLaG+tF18SSxnizh?=
 =?iso-8859-1?Q?0HdzCyC8LgF+jMsECdJAvHujqDJnEDjYadaAjPv4TCB4g8ia8BPRBFDhKi?=
 =?iso-8859-1?Q?lKKK/VPmclEyMbjFGnptLMTwr9RnfFnxSQ9cQwsoWPYBYoENDfILg5mHdz?=
 =?iso-8859-1?Q?7Ap/2Be0C+JY/amFSKfUPTFd4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758b47bf-c0c8-4c2c-4708-08d9f55f5688
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 17:26:47.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W23u9Ztle4eTtX15Y8hsFRG3YAMn1x1rj3SR8V1/GMhPcE2ctCsUkrtzuu77KjPqH6s0njRuW9fFwFiuLxLDwP6vI2YSHekokbo7USnkL+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6466
X-Proofpoint-GUID: XPMz66BUP8AURLUM0XKuijYvtB6vqgBZ
X-Proofpoint-ORIG-GUID: XPMz66BUP8AURLUM0XKuijYvtB6vqgBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_08,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxlogscore=509 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202210102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing new parameter called scmi_devid to the device-tree bindings.
This parameter should be set for the device nodes, which has
clocks/power-domains/resets working through SCMI.
Given parameter should set the device_id, needed to set device
permissions in the Firmware. This feature will be extremely useful for
the virtualized systems, which has more that one Guests running on the
system at the same time or for the syestems, which require several
agents with different permissions. Trusted agent will use scmi_devid to
set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
for details).
Agents concept is described in Section 4.2.1 [0].

scmi_devid in Device-tree node example:
usb@e6590000
{
    scmi_devid =3D <19>;
    clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
    resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
    power-domains =3D <&scmi_power 0>;
};

Given example shows the configuration of the hsusb node, which is using
scmi to contol clocks, resets and power-domains. scmi_devid is set
equals to 19, which should match defined id for usb in the Firmware.

Trusted agent will use scmi_devid to set the device permissions for
the Agents. Guest OS should not have an access to the permissions
settings, so no code to process scmi_devid was presented in Linux
kernel.

We are currently contributing changes to Xen, which are intended to
mediate SCMI access from Guests to the Firmware. Xen uses scmi_devid to set
the permissions for the devices. See [1] thread for details.

[0] https://developer.arm.com/documentation/den0056/latest
[1] https://xen.markmail.org/message/mmi4fpb4qr6e3kad

---
Posting this patch as RFC because I'm not sure if I set maintainers
correctly. Hope community will help me so I could set the maintainers in
v2.

Oleksii Moisieiev (1):
  dt-bindings: arm: Add scmi_devid property description for SCMI

 .../bindings/firmware/arm,scmi-devid.yaml     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/arm,scmi-dev=
id.yaml

--=20
2.27.0
