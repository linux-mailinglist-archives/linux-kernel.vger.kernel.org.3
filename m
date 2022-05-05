Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF151C47D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381605AbiEEQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381600AbiEEQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:06:55 -0400
X-Greylist: delayed 16749 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 09:03:15 PDT
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82F2CE19;
        Thu,  5 May 2022 09:03:15 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245Asdjk005537;
        Thu, 5 May 2022 11:23:54 GMT
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3fuqdg3tu4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 11:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnyHNRXynOLA7/o88Kxj3fSS5OdGZMeyBnp8M0AJLgBD5N8zRyxZ13sixWP/AcKkiMOLsw9is+bkc3IkP9oZQ+k9Eh8jeiG+ggj7IMze2AII86WHlmr4l1GwMf9uPsh83sw2Y57+qeot8TOSqoFlKC7R2oM0ZgxvFfV2+bEPwDKCFr0Tf/3+wCwfxpSv8Z4vn5tW7WZpMMAmDo6/7Gv1gpmNfmjSnshBV5cRUo2rFHr0CboA7dbvHUamXQhYXUOw9IHnSqK1YFJZaC530X+UiWF6HjvgS/k4nE6XxIz3hrr6UqbMYF01ZRz4hqLYur216Vh5Aif8YKR3TViuIiybVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lguzpScIMjNZsimsLmB7CwOgxB3iL5Tf/QnRI7JeLsM=;
 b=Q9359q56cGk99oJFaFSvP5g+MbxND2yibB9jC+KdZT4WHiNCMeA/AdU2YC5mMPwCi7OoRxqzeOFwnzBZyRh4139A5Bf6smqicL/li1JSrbdV7NLoUmucYZgCp2FZ8LSZdV4LllllDpfBox7FL/DJny/afrcdWnG5GocMb5eOjZmuaObhQNmNlJyR7Qx3J0h2qowbRdFKX4VERJi0pDpWp+Nz7uFUrx2BUvuhn7qaYXJu7bJOSIaV9ozZEdqkN6CjryQQdLpmZFND4RYgM1nETyFiQUBpCmu+62+ivcGgF6goTz9isQ5Yfylh/KTs70pddlozqAKhQlsgLJ2wtkmWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lguzpScIMjNZsimsLmB7CwOgxB3iL5Tf/QnRI7JeLsM=;
 b=CK2snl7L2H1V1bs9pjC2dYEIz/B6p6nhQDyJ/U6ZgOtcDsHdMuT3fsEmlc6ONvgnoanc9x9w7aCaav0uK+dB1a9PNy9uKhKAZH8hn7hVou3KMbwI52xPSrQPVu+qrHYQzK/oa3fWQCXKh2jCPjXrWnpaU+zBWmDYR1Wn4QPmNm+8NjrfigRMnRNNUbf8oTxPRvcj9Bwa/+aSJFJKMp8sgyyQ4PP+bLZMw4M1rLUIavOXRG97YOmcV/YGLuwoq9tJ9XUTRKzknlIQSaxCFlwzYxBf4oQSG4+8oRA/Xm0XobrfZF+qc1ROkHi9Mms+/g0jmyv4sZhQSyHvYg7L1FnKaw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB8PR03MB6010.eurprd03.prod.outlook.com (2603:10a6:10:ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 11:23:51 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d9f2:1306:69a6:e191]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d9f2:1306:69a6:e191%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 11:23:51 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/1] dt-bindings: Add device-perms property description
Thread-Topic: [PATCH v3 1/1] dt-bindings: Add device-perms property
 description
Thread-Index: AQHYYHKYED1XNg8RU02ShVh4atz7mg==
Date:   Thu, 5 May 2022 11:23:50 +0000
Message-ID: <0adca4afdd5cffb978fb67ca13a6aa80f16aaffd.1651749565.git.oleksii_moisieiev@epam.com>
References: <cover.1651749565.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1651749565.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b058e7-bc55-4551-80f5-08da2e89bb12
x-ms-traffictypediagnostic: DB8PR03MB6010:EE_
x-microsoft-antispam-prvs: <DB8PR03MB6010B7B7B5C8D92DE8DB2349E3C29@DB8PR03MB6010.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2iQF2x1jYA3Srol3WYpy77jm3kk5Q3j7paDj2kVT60UNaDT6O2KsAojnH7aQRz/a/xCbUJh3r8KSfb1UIOysm3YRJOo1vvTjP1PZXqCftza4zKz0fJ+eoc5rdpdK+c/aDOFd8tP0DcJlQhcyPkB8d0oQ4pgBGMP/g7FG949j0ADGnhR9PiTIG8oSzaYvO+SqdB5MYOh8xa9QhY+BNLxKLorGMnuQEVmQX8wIJOO+YHb+mMQ7ygWiPXRbdwbbVFcyeRz+26bKt53HLEvjYTtBO2fzhaqhtodF0NnSibE5SPF5Q/kn1JgtiLjlLNQjpqTwNY46jSB3YDjC/fXWu0sfi0kh+j8Muc70li7Bl8jafO3Y9Aob582MwZpUkLhZhnznWXWPRY5epdq3wWZfhLiW+IYNNEZM7pF+6ZyKxqSfQVNboMJ7OD9hj+GF5DMLw7hZhAyEjeqUQwxDZ2fTIY44E/2eUZTHunQXy7yqBgHZMbO+VENQld/7flCgOUVDnnusrrTlFAl1BOt0zqsSKhkZJjIsBZq7rJqyYnlZxbHc8sJ8SL3RFLmFc+/nLMLbwHP8e8oyre6MmL9qHmYohLGdiTHglVPtmzWBxfZEGF8qSUV7i0lwCvqbQmf/jD0ty1ni23jlOAVYJ1uewdAqdWaX1DJ/QglGzg1i6DCbPGppCq4FVHuc6njAuZKJQ3gwN5tqrk5lLhTG4zGHANt/mOGMWXZDLPlWze+MzERdj7CxYlVyY8od1HG06Y9pyEhZintgS5LrkrHK3RJZJ8eMT0JbeoxI2CNxCrSV3KaDrPf2RUY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(2616005)(55236004)(36756003)(186003)(86362001)(83380400001)(122000001)(966005)(54906003)(66446008)(66946007)(66476007)(66556008)(8936002)(5660300002)(316002)(91956017)(64756008)(76116006)(4326008)(8676002)(6506007)(26005)(71200400001)(6512007)(508600001)(2906002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jg+kNlXgYctqYMDXzubLX1RHGTLBnSOJAV213qky0gJlTkb20+puFvNsJF?=
 =?iso-8859-1?Q?s7tdo6lo4UfVDVa7FA/AqH+AGJUfBqieqC6EsOa5J0i1ZtrmeJT2gltlBP?=
 =?iso-8859-1?Q?LQDOAIjRAGnVV3+vbScRi2iZj1fOJnDiCFDeUmekNAaly0yweuGFoW1WDf?=
 =?iso-8859-1?Q?ge8OIrK7mRfDJ/ZGNKN0BngNMImLP/BKiil7ihsW78Xn87RmJ7G8LJn8MU?=
 =?iso-8859-1?Q?HcB9p+BNOYg6/6CZksIQTEucL8mXqw8wXWXfawS5w9dtGCP3XSPkjgP4Vt?=
 =?iso-8859-1?Q?JSSU52NdF5NKaopQhFwxUiRhd68nCy9FsaEJSNVO8JnQ7SlWMRZjjc50bH?=
 =?iso-8859-1?Q?GLx2YeJOQJplhbe1E4zFQPoANFqB/YjP0ybSTqfwHMTJ9w/nVu2poJMUD9?=
 =?iso-8859-1?Q?G63WN6798xkWU94x7wHVdMSPILdGXozsXc7vaMems88Ywu23+uOrbx12wB?=
 =?iso-8859-1?Q?eD4Etmo98wNePS+C0rOcjO234/XuzX2GgU1AAD8HxWB5aDkA8eGIIxHqpp?=
 =?iso-8859-1?Q?5fqr7xKBjQElb4vG7JVAMhRQeuo4TNzalP/oH+mYYYEDkgpJ0WwdpnLfSL?=
 =?iso-8859-1?Q?X99F05u+/W11mVn+SIWo3PHZlmRkQKNONbFr5fTJUuz3Gh/IqGogeGF3nn?=
 =?iso-8859-1?Q?BRohzsSM0jv1Ak4o7CJW7e5bHhjHFqiBH4lYxv/UP0kvP7wsmqQgBO3R8X?=
 =?iso-8859-1?Q?arNmUVmniPWKQLOBKoJscJxF034ElZatMmelkUdQamaC4RtzdxLc5AVHGS?=
 =?iso-8859-1?Q?pv7AnlufP40J1RSO2xFL7Xfg6gbGS3mocTBzl7biFFXLEtHPLA+JzquEVw?=
 =?iso-8859-1?Q?2XpCyCz7TYS4+//Y5e0W+NY1pR4k9SbkXEqSO64r5mCiDIg+YUg/5Qn3af?=
 =?iso-8859-1?Q?7BWd/A8azzG03wdIvKPB8Nz7gXJZgTO1Jbn94qGLYWsDnLdhgKuRHso6ac?=
 =?iso-8859-1?Q?7JZYSPycSUWvrxpgQpMLUJLNK3hs+P4P7Xkd398PCwP2QcNsGpzvh1/gpq?=
 =?iso-8859-1?Q?usN9wrY9QTCif2KmB99CUIGwoQfMaEWGhhjfkkDxOLKCUZhYjmyw4EGoTS?=
 =?iso-8859-1?Q?rvTAafsW/Jefa6UkL6GIelxOvICBi3/11SuYzcH2cPM1a+CDA3mE9rGCTb?=
 =?iso-8859-1?Q?HkAbjTO9D2CvcXM8aewliBdrb3ltX2269zY6qwTmiCihI5fiLUus5FxbDM?=
 =?iso-8859-1?Q?qKSBLf9bdOSw24uIDI0q8DmljvxQDLOnOqyVjJU46klw0Sk5rGn3MoT/oW?=
 =?iso-8859-1?Q?VNegguAeLusIRh+swyNyuVmyDXRbsDz8ku+BPynP8BRP3R/pbpF9lMZ2GA?=
 =?iso-8859-1?Q?diDzsnR03blK3TLkxWYRgxlJfp51mpeIJae6AJfmIfxqZkzYwotsGgGMGY?=
 =?iso-8859-1?Q?vJDA889KU5DbPgpEJxPsrPDZW4bOQwp4oDCXJbZs7zcNliAYXhyXtZ9Asa?=
 =?iso-8859-1?Q?PwCfbxRyCHwWl/hKH6lHFU4i394pu1gjo9CddmAp9peWyEWWX/y2bv9yg6?=
 =?iso-8859-1?Q?s1cKSDbfxtz0sJb5IhjITbh9eATF+NVN+pwy2915GLrFZmzZwOw/jwaq1V?=
 =?iso-8859-1?Q?v2LCsoc9poDff/3uz2rs5U0XFo1RssyxxHZVGFh4tnfU4UccT6dF29fcbl?=
 =?iso-8859-1?Q?nfq3DkLKOwRaJzcK1G+RinezNhwvIlLu++p68olqhDRqSU3psXICnwapj4?=
 =?iso-8859-1?Q?hhwjOCae9ynCowPmNVg67+74ZeHo0by78NuMic+4HxNtS1oOMhr6ogVlaD?=
 =?iso-8859-1?Q?IWLgUm3h+/J+51EGS2+C/r03H6+wqk3JiniTX7NUTEPJ4onkSqUPyMGDJb?=
 =?iso-8859-1?Q?xzU3NJeaUSRV7BJdCgnHGUa3Xmn6SlI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b058e7-bc55-4551-80f5-08da2e89bb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 11:23:50.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuRC3mUw+0cysRpcZmMnhRoE9LffcLDUQvH7HfpmTnu+mMmDnnuXRDOO4VvZzD0eUFsawTPz4uqpkTWiVyi/9K7kxaJnMg1kh2PWTRhmV18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6010
X-Proofpoint-ORIG-GUID: fjkF5xI-4IDOXsXUojmrpF1R9IgoGKvJ
X-Proofpoint-GUID: fjkF5xI-4IDOXsXUojmrpF1R9IgoGKvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_04,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=519
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

Document device-perms property which is intended to set the device
permissions for the System Management interfaces.
An example of this interface is SCMI (System Control and Management
Interface) which controls clocks/power-domains/resets etc from the
Firmware. This property sets the device_id to set the device permissions
for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of =
[0]).
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].

For SCMI this property is used by Trusted Agent to set the device permissio=
ns
for the Non-Trusted Agents.
Trusted and non-trusted Agent terms described in Section 4.1.1 [0].

[0] https://developer.arm.com/documentation/den0056/latest

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
Changes V1 -> V2:
   - update parameter name, made it xen-specific
   - add xen vendor bindings

Changes V2 -> V3:
   - update parameter name, make it generic
   - update parameter format, add link to controller
   - do not include xen vendor bindings as already upstreamed
---
 .../bindings/firmware/device-perms.yaml       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/device-perms=
.yaml

diff --git a/Documentation/devicetree/bindings/firmware/device-perms.yaml b=
/Documentation/devicetree/bindings/firmware/device-perms.yaml
new file mode 100644
index 000000000000..5cf45f7f26d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/device-perms.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 EPAM Systems.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/device-perms.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device Permission settings for the Firmware
+
+maintainers:
+  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+
+select: true
+
+description: |
+  The provided property is intendend to set the device permissions for the
+  System Management interfaces.
+  An expample of such interface is SCMI (System Control and Management
+  Interface) which manages the device permissions via SCMI protocol in the
+  Firmware. Binding provides ID for each related device which should match
+  device ids, defined in the Firmware so the device permissions
+  can be requested by sending BASE_SET_DEVICE_PERMISSIONS (see 4.2.2.10 of=
 [0]).
+
+  For SCMI this property is used by Trusted Agent to set the device permis=
sions
+  for the Non-Trusted Agents.
+
+  [0] https://developer.arm.com/documentation/den0056/latest
+
+properties:
+  device-perms:
+    description: Link to DT node, which should set the device permissions,
+        device unique identifier should be set as the parameter.
+
+additionalProperties: true
+
+examples:
+  - |
+    ohci1: usb@ee0a0000 {
+        /* ... */
+        reg =3D <0xee0a0000 0x100>;
+        device-perms =3D <&scmi 11>;
+        clocks =3D <&scmi_clock 4>;
+    };
--=20
2.27.0
