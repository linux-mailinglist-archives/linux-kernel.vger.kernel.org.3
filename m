Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79F51C67D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382523AbiEERtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382936AbiEERtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:49:03 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E103895;
        Thu,  5 May 2022 10:45:20 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245Asdjj005537;
        Thu, 5 May 2022 11:23:53 GMT
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3fuqdg3tu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 11:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWng4yKFJZVTZrExouY9P1XMV0mMcW9xBqhIwMtW7B/vju+IAJ53IKtco16NqlcTW2ScpFlaJfe36EvsqXr0wHZ3vjhYx8oWkjYAQBxdFzSa3dbU2xK7VaJpjXJC00IGd6chZBEWRl8c5f5g/jqz6+4uNUgoWKA6ogWTS8X/0YDOY4CSJpnb0YuT4TufNhkoGDRBrMWlB8ZOc7rxmgEZPH+hrlUatg9dr6Mry2lZSc7SyIog3KGUCH9y0cEDR/EukMa/6VTBeeGYLOoIi3jyBLaQOxGumjyi0YRzttxvbNEx3oP3JcnbUUJO/WXwo+Wr1U8q4MgkCnAKvceBW0gk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xGUwUuUoab1+R6pmneiVsp3l5RD8vxHmjbWXoNJXAI=;
 b=G9RxglP418jg8Dk+xH35HoWBghvYR7Wy5lKuEo6Uyb+UFcfbrhFu7DgXUxfGSLKF76KgUWrNUNddbrB4L+qGDwwXr1TbUeQSIFLQkiAl+Fub/EasMsYW5jWtlpzQaqJtIBOWK1TcNAC8bL0ObBMolAlBjgADxGasAMKtbwARivaNnbZF0ZEDxcuHtNX4NsJBC/sWJJzwv50jQIfKHj1kNqAsFGMrlph17hv5AKZOj4SO9bhgog+NC0xGB3OR0rq2Ok0MniQFRZHs/ZaVl7NBzBzSlQreo6dNTW1CgrEazBPvrvkwgyKW3BZC1YDFWjoJ8TjNsFZXyRB0GxDoYSv3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xGUwUuUoab1+R6pmneiVsp3l5RD8vxHmjbWXoNJXAI=;
 b=LGvHTKOFHC1laibTBGKQ5LHyRgnhYYSIa69jed3NkXNm3SyRrb4GbOpOQCAZiPn3lum7M1tG7TErBUQhWMVwJ7H0VmkxUHo0vUPnz9ucKI+jvZil4sNPUbUOjJM/xNUgPiobelgEfUlPP9yBeQe2kqhZqgRgN+7aIvI0QlFjrV1Bk0ESfOkMyP42+Ibrrf2T5zW1dDhicoxgPe8M0nzAUnvJJ1YJTJxs4GgQrMhK29Uzc+R7r1wwLtV6+lRvRZ8GzUAYen2md2ZPgmKrIkCWyUndZMScI3mQ7cFyYncNTEIkONCiDuQS/RxXedcA0rHtiAkN/Wbq7qkzhjooGO3BSQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB8PR03MB6010.eurprd03.prod.outlook.com (2603:10a6:10:ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 11:23:50 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d9f2:1306:69a6:e191]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d9f2:1306:69a6:e191%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 11:23:50 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/1] dt-bindings: Add device-perms property description
Thread-Topic: [PATCH v3 0/1] dt-bindings: Add device-perms property
 description
Thread-Index: AQHYYHKYgJFkAcUSN0uqJ7iSPlGuXA==
Date:   Thu, 5 May 2022 11:23:50 +0000
Message-ID: <cover.1651749565.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30aea31b-268c-431d-d711-08da2e89bac3
x-ms-traffictypediagnostic: DB8PR03MB6010:EE_
x-microsoft-antispam-prvs: <DB8PR03MB601064DC5E9D79772BAE1B64E3C29@DB8PR03MB6010.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mgMFSQ9zO+f/dplp3/TqJbFIGJNnz+gecePohMBkVh9iNDKySFEG4rjU51zb07cz6YfTftQYh/AJ3w9bnneuhg8vDIZpPiBqkiK0vKgRmJOLrhjFTHNkSfdC82Ymhx5tuFXPqQqZY4VpkH1sq6ctPJQfhusqqjlLlXJjgnJxV6gLRgNLCJsA6a7DVlyyd/0bnvjQm+vHtpUbQZK5y1bFnnYLD7+fdImxJtMjn4FKOocnaC3m6WPkPFi2GrHDGuSzU+wl8pJa+aFMj5m0wVUoBQ6xWLXGgVYT6XGi+E9CEvb4LZ5aFhqnDpY9v8Q/uN8cmFd6iPM3IKE9DjmVp4J5bCeeopfEn9YAauk5VMLFCkItawvQdv+TV0DVVt3G0/o3PVNvixDNz/D6cKVEXjR/u672sdo5FbE2kLYI/bL9ogRKiyqVNqVzzVTPyYxbv5CPIFS+9emWX4HDHZ/dzHuhrca2dXf3ZrLMz1qHZw7v/lNFhjT69W4OL3ISN2VMqhhNZDLBjSe+pCeMka/XP2kNTxwE5eO1NyzDQzNx2meZerjmUrN14v0LFZW9GByI8+O2092ozuLWDk2D9ML5l9VtqeJaYeO8RHzygU49u0SFoFueMeQTQXSlXKC3HmHQjh3r69IKbjZiSh+LERjIecMwA6PXoHB+DsvSh2LlUCy94J6pOFG2hzozBtziJRC7OsXJCw3wuBdhbgX5zE0+2uJxdeUs69AA9UANxI5xRMRcRf/eopiq78WzoShLnv7sh/P68WHgrICAjMp7D7lI48rMlQswr2G4+3n6Mffj33Se+QU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(2616005)(55236004)(36756003)(186003)(86362001)(83380400001)(122000001)(966005)(54906003)(66446008)(66946007)(66476007)(66556008)(8936002)(5660300002)(316002)(91956017)(64756008)(76116006)(4326008)(8676002)(6506007)(26005)(71200400001)(6512007)(508600001)(2906002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tL+NeVuDpqQVt9FhFTbXflFUBb7IRazp7Y0w3RY6dfdw2CNoEtnG4vuykZ?=
 =?iso-8859-1?Q?NT5FKJPfYpBkry/Xqz7ymK95xuPEA3jnTX0Zd0QfFzgnFowlMujq4d7+ct?=
 =?iso-8859-1?Q?bRh0s7Hh8WdhRl6h/3gl9ceSXkoo8lrnivNOmHF5D4Zqa5thcRU48Ygwk+?=
 =?iso-8859-1?Q?V86L3lk9N5MV+97EOb6PkFLTWddprNbzhPZ8oGoRCeVHM1JiZJU7HlEuKA?=
 =?iso-8859-1?Q?1oaxnlj1HmpngQg0wnbPLZrVrX9rKaebHkAa++PTPqu0sYNKXy4Hw08O/G?=
 =?iso-8859-1?Q?XGVnMnW41gp+ZUpr4KXjB0Zj2TfohFtHqJLkFWBJ0cp1R12Erkpmv+7XG/?=
 =?iso-8859-1?Q?WF4kmlEXXwaajP6BOT+s03U2hmLj1N7udlk04pspIeH1ghpZSQXq2j0ajP?=
 =?iso-8859-1?Q?O+W/ROE7wvwejpy71W4zIt0/fIkrGyxDAOcEN/nsKNwsBcPwkB0SBXtlKQ?=
 =?iso-8859-1?Q?hCQQRMgfcvtY9GQT2Ya9qgqZBQzXhmBq2kfK7PIFXPQy9B2auMd/wWHYoY?=
 =?iso-8859-1?Q?e4so+1R3PW2wI7SJDqJlDqjrUT4+vwGK7t7R2W/YgiF4woA6IEOkJwXiLf?=
 =?iso-8859-1?Q?KcMDMFXGrMRvoNSgyiwzL4hykRN+ZwhGkvaY/pc4030QOx102+1EFfYKJR?=
 =?iso-8859-1?Q?0x+2wMetYoYxqP66fs5S5FVfOLATA2+2hUoOyH0jwCIxx5KPXv5LMV+8rc?=
 =?iso-8859-1?Q?uErRTI5DgbVEppjw/N3qoQC/ORLd/6BRcYQF5QN9tE6gFGU3hnPLEqdBhx?=
 =?iso-8859-1?Q?ZxMXAtseXE5YrgyKcTuL8ROO/KR9kP7msnwRmzfnYwHh84qvf7ritmQYI0?=
 =?iso-8859-1?Q?ZMSrmraa5wfO2kbeJMwt8NKxRunG0Hk6Kb9LwRxwi64OSmS1kRt0YUm+f+?=
 =?iso-8859-1?Q?KWi+ND1fzIWlipLbBxX25x6+LX5gT09IVYAFLhPWfnlPXtKP3ejh/iuNf/?=
 =?iso-8859-1?Q?DrCQu8+PCyTLALvyN3NWG95zKUZj6Ast73dJq8zFv/Qc8dkoHaHHEea+J/?=
 =?iso-8859-1?Q?dYmQQ11UrYZMn5EEU92IuU/GPIEF2zp5N8cvFY0wNSDjmqmIg7LqD0ZMHN?=
 =?iso-8859-1?Q?SVSZEWqHC6cVULz/KCsi1Umd/qmiLQhjqWgLr3lPoosQ5NJsYYAdqZZ5Oz?=
 =?iso-8859-1?Q?dWqpz3n0dyLU4ImtGAkPryFrM7NcmYP3m/eV4PTxbJHL2IcFhXxLXmI+UK?=
 =?iso-8859-1?Q?hrvithesIb3yt3VUUiXU6PAp5HyKhYR5BvJU46WmQEJTUu53sGowr4UKGa?=
 =?iso-8859-1?Q?TcHgI89WaoxlBmhy7IuLHBFz4INktDPLzYFlIn9/EUbXoe6XuXttPt5Hj8?=
 =?iso-8859-1?Q?MjGU6xeDpCeTzmDJon916jpa/GOQM0lcUdr4trlWlXvnvByhFC+vb65j1c?=
 =?iso-8859-1?Q?0CK+TGBta0I9+6aMsBQp/BvrtteQYoiDv7LLZ17bn16uDZt287VQFAabzm?=
 =?iso-8859-1?Q?++7+PCU7iInPL4uyvR/8N4nIqLEVncCncjwa3lcHcw2mM4czjJ4WweavON?=
 =?iso-8859-1?Q?huWUwMfaQQ4bU8o0/Re8ewLPafDGwLgN9beS54c911+MKPBDK+pf1fMoCu?=
 =?iso-8859-1?Q?ddzxauhYBMZkEu2/8GGFYlc4DSaUakVE1jX66sYGnODuoWU9yyHLOFI+7h?=
 =?iso-8859-1?Q?tDljEObQ0U/8pWAGk6AXNnvfl34zZttXfa5kUW3nhg373lS9NwLrj07qcK?=
 =?iso-8859-1?Q?OiJEqqNPjh7c7qjIcGEIsd5H/S80beLP4owFixo6GBzq+WuWl3vkhNqjIH?=
 =?iso-8859-1?Q?oybB26b04XRNDLjRkJNEDWdgkGavH6GJNmYsDxWeSKpkxp1OjypJtPXxf2?=
 =?iso-8859-1?Q?rDpD8MVwcpiVFqE+s80i979rhNlmbXA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aea31b-268c-431d-d711-08da2e89bac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 11:23:50.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2gSS1M3W0i+6+VPxgxUEZsfkG9jsYV6bCbnddjqPIbvP5jb9uDQuF4vpcf2dYYKybq+FlR4Hu8vl2aTR0L/UlWQpYfeQIZuWFml5gl7w6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6010
X-Proofpoint-ORIG-GUID: 83o3QyupwgDF7axEO6UCuP-gnyih5BwE
X-Proofpoint-GUID: 83o3QyupwgDF7axEO6UCuP-gnyih5BwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_04,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 mlxscore=1 bulkscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=1
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=209
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205050082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce device-perms property which is intended to set the device
permissions for the System Management interfaces.
An example of this interface is SCMI (System Control and Management
Interface) which controls clocks/power-domains/resets etc from the
Firmware. This property sets the device_id to set the device permissions
for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of =
[0]).
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
Given parameter should set the device_id, needed to set device
permissions in the Firmware.
This property is used by trusted Agent to set permissions for the devices,
passed-through to the non-trusted Agents. Trusted Agent will use device-per=
ms to
set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
for details).
Agents concept is described in Section 4.2.1 [0].

device-perms in Device-tree node example:
usb@e6590000
{
    device-perms =3D <&scmi 19>;
    clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
    resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
    power-domains =3D <&scmi_power 0>;
};

Given example shows the configuration of the hsusb node, which is using
scmi to contol clocks, resets and power-domains. device-perms links to
&scmi phandle and set the permission parameter 19, which should match
defined id for usb in the Firmware.

Current implementation defines Xen hypervisor as trusted Agent and OS
(Linux or other) as non-trusted Agent.
Trusted Agent will use device-perms to set the device permissions for
the Agents. Non-trusted Agent (OS) should not have an access to the permiss=
ions
settings, so no code to process device-perms was presented in Linux
kernel.

We are currently contributing changes to Xen, which are intended to
mediate SCMI access from Guests to the Firmware. Xen uses device-perms to s=
et
the permissions for the devices. See [1] thread for details.

[0] https://developer.arm.com/documentation/den0056/latest
[1] https://xen.markmail.org/message/mmi4fpb4qr6e3kad

---
Changes V1 -> V2:
   - update parameter name, made it xen-specific
   - add xen vendor bindings

Changes V2 -> V3:
   - update parameter name, make it generic
   - update parameter format, add link to controller
   - do not include xen vendor bindings as already upstreamed

Oleksii Moisieiev (1):
  dt-bindings: Add device-perms property description

 .../bindings/firmware/device-perms.yaml       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/device-perms=
.yaml

--=20
2.27.0
