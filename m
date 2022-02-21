Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7A4BEAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiBUTYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:24:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiBUTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:24:44 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E565BA;
        Mon, 21 Feb 2022 11:24:21 -0800 (PST)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LGn6V5025634;
        Mon, 21 Feb 2022 17:26:52 GMT
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ecek8r4rq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 17:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUiNL5QRFQt2PfQwvkaoAP3+CKi6TVsL4+8fUBbShQTjC4FjwBdk/asrtFxqw72VdhBAp59MqhDqwaCQcJPH6gC/xF0C9J4H3V5zzM7CZW7BwygOXiXVhNfV08e6LPYpgSe5xWrig94CJZRVkH35THATkgP/lBRQ0fNGzjI6mrrW7pq+qsLa/TZsJ+J/HeI03EfcOKgmyJ1cR6Zf63dloV5S2Iyu9Z9Fl1QdrhbiKNdonazXR2FzD6tCM3gwfHW6Pk5YBMmMWnhSfClMXNDgneSKyRFkb/DYh9rOaSGBgR2ZvbKDk64YypJ0kHvQ7XEr70S407CPEN63jGRAaLELtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wO6ZWHmNVBF0TVHIwv1PLHXWG2b/EtcfyboVRa4GfWE=;
 b=aGNS2XaD5L8lKTPhz5N92zFgnOB2JcBAx6D+Q2UCpy9VXAUvcpln47NSRkh1hphsrq0QfjnWWMWCExl92J3oZDk0yFFQR7UCy30hzHPtS6oE5Z3gdr05gdLKDhmj2eltAABIvRyyt4CE9l8wSduoioVJtzwm55uLRabNfvsV+HoLO70KD4B+eRH1UmcwSim9FLDPZHnqZutyyDM0FmGSUSdovJzVtDAIP083WXlSf8c8BHFVPkFSn46zTURjjnJlNEAGjGsGUUFbwaPmphz8IpHyFwwXGYgXckU08Qj6xOdJU5cgsysl3VZidf+9ErjCdhlQAeC73on9hWUj16SY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wO6ZWHmNVBF0TVHIwv1PLHXWG2b/EtcfyboVRa4GfWE=;
 b=WqHaKijYqtHDZmwz9n9I0fZfyvb7ga7SnNIlxX49LYUt2cKbVcow7Eg6ZJklIpW+4xgiE5rjOD6h1+any/Mk2oqtTr8uZGSYxv/6cOifxsU60I2axDGpPI3oGnDDGZ3+uJgLS3oT4YpZ1SSCfkmSFxHNka7d/n24SJH66po6QygOwCFK4hxhexqLXo6A+++VKABiCdqc0DT29xD1fEqGjzqQwtVdygorzGfjVjJqkWcKJDKLBq3VjZPFWS+AHKd+FXP0OmN8MAbG0yFhbvywTw88yBhIfbTDCA6PU5ArhfdeVp3Fe955MrTBM+/laXuVz6oqPon8hRBHcqBDher4CQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM7PR03MB6466.eurprd03.prod.outlook.com (2603:10a6:20b:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 17:26:48 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 17:26:48 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/1] dt-bindings: arm: Add scmi_devid property description
 for SCMI
Thread-Topic: [RFC PATCH 1/1] dt-bindings: arm: Add scmi_devid property
 description for SCMI
Thread-Index: AQHYJ0g0zA4b1xgTn0m4ZMeiASfcFw==
Date:   Mon, 21 Feb 2022 17:26:47 +0000
Message-ID: <c751add9b54e9661e463ae265d8d5f0314eac33e.1645460043.git.oleksii_moisieiev@epam.com>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1645460043.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 020de823-10d4-462c-ff49-08d9f55f5706
x-ms-traffictypediagnostic: AM7PR03MB6466:EE_
x-microsoft-antispam-prvs: <AM7PR03MB64661ABFCEF2665ED5972AADE33A9@AM7PR03MB6466.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xnhuljr9MD8sVNZgzOE5CLIdiQs3rY95IRWUBv5Liq5gKQ8LSUgXe7EBLmsOk1FHZ1tIac1kiNaq//hOK0p32LkRk1gWEJobQhdYIoQ0BewMoJJQDKYR6nmrGqG61KieVS0lr/sc4rJgOUEBPh1Vt1tFIObRG8ar/eXHPAJvCwnFvPvEdc1wCMRQMnKgwdFzbGwH2C+f/Sk3erwMgW9G7J3jRd1xk+IXL1E3oN7KbEK9HrPW/K2baBXoMg1AWORV2UYZiFKrixyIlV+qsk/qV5z4UlXzdS5zOoX3ov69nRYHu6prPIiJzs3584GZ+koQ6P4rFSVvq8zLTO3Pnle1kK5WAYF8HDatLZWaJgSj7oiMnvsrCGqml4TQCq5DVALfV3M29DU5LAYzvaCLP7tLLga/MJ2tgBBmN4JlhnBjpWghpsUBD+JxOebUtTDdx5qdr3G2r5q0bgyzUPj/ZqBTb3Y1WaaMZ+2mlqoShFoOwHi7/gEntp74tEJLV2LEiUTv+sNLTJgw9kF2WlecoVV/Kowfgz5FxFtU9QvgCFJ1c3Y9F7fimvzlMQLilvMvC5502Cd3+3gmCXLEpC5K4nZX3rJZAGqVpY/befFEHLLwtfWr77ILc54jtSIjn6EJrBoEXzxTSNgp7Oph8f0grtOe4hpH0Jw0jyjpHe2abEVjtr0tspTCORgQdV5MEwte4ZhNIf1GU6vCqKu0J9ftg8DpFXxrKdxBEDdOV6JxuhIIDEeYSNnZqtPRs6n0kSDUct9FKHM8OTBzsUhwVD84k2GwHsypoYHTRdghaZBA9B3UWZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(508600001)(8936002)(966005)(6486002)(54906003)(86362001)(83380400001)(2906002)(316002)(5660300002)(2616005)(8676002)(186003)(66556008)(66946007)(4326008)(36756003)(76116006)(6506007)(26005)(64756008)(38070700005)(66476007)(66446008)(91956017)(122000001)(71200400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?73SFgQrXIr0ujPZcUCPKYOJgw2rdBmoIAOziqI8zlAkw5GI0XWDN68q6gV?=
 =?iso-8859-1?Q?fyWAR4TyVy1x121jEY2ZjdQe8uCkZRrPMQvl6VQDMo364vix7zJzTiFejO?=
 =?iso-8859-1?Q?oSXey2uLz0Eq8Cl5EG2mrOI4sybi6RAVpZ6vPttIMdy4XzTiaeLHAL1kpH?=
 =?iso-8859-1?Q?v7WB/hyG0+3PvbHMrpV+gg9NNTH75jo+FxLzowXcbNqMnELD4ZPkH/T0W7?=
 =?iso-8859-1?Q?BoUBx/FCuphNQyOMx1tmMJPF9OBcFXCQydzIIFx1wWx3VFiA5yxId+dD2F?=
 =?iso-8859-1?Q?09Q6IN3b0MqvZ7/4eX9rBoOM5/q2knzX3j3tgxbFXREBQrzXJ8z8MsnXuq?=
 =?iso-8859-1?Q?juTIY9soPs5Tgz6cBj4eQf/n2kD3uLMzgYzRVxFVjA6WKwy6HhORn9zqOh?=
 =?iso-8859-1?Q?RzLHB1N20uPLW5F6TGx16zXj6k0SopEJrrKefgdQXVoGvsIuyiUZT+0sUo?=
 =?iso-8859-1?Q?IeG3HZASJCfPoRwn+a85B4e0EoL9RylqMII4rTenSG409ZxOsrAEUdwRVd?=
 =?iso-8859-1?Q?DZvkBW6ast0Dbz+ykFkej9TfAy272YjHUpNMQYLXnCFJGZE7ld0OsapUR8?=
 =?iso-8859-1?Q?KSYPHwUmEQEnyMfXNvlCM+7to7H95eIMZOCfPxDJWHwPqq+KJPqxoUZZLX?=
 =?iso-8859-1?Q?vAZSh891LXljCoQOQilBIall2j9YKuhdSLHKwMFAowshCBPsFupyB7CzLX?=
 =?iso-8859-1?Q?FTgFAbN0UCoAaq42/VUb0JeBi001HrNGYA7pQpvH8iQM4yoOCAyE4ZGp3s?=
 =?iso-8859-1?Q?o0V62vRzs+JAG9S5h1tfxwDyR3J2vJjLVnkRzNPbx9YRfZTOFrJ4HQJKPT?=
 =?iso-8859-1?Q?TxRVFeQVRfFKTtzqL5sQ8Uxe5bNJGXjfWmcYemPEZ4hfjPid57X8K23bB7?=
 =?iso-8859-1?Q?XDe/hy9iMsRIlB02cV/AsLOhicO3URQ4W7Z7Kk8QMgUqqOBrsaUec/nVq9?=
 =?iso-8859-1?Q?5TFnhJ32GNHTTa3zIODMN1mEEiGkjiS30+UjE1QnLLR/0CF9LPhyyV7aZe?=
 =?iso-8859-1?Q?aNBZPIsYMB8LDGSJb34hlajubVjG0a01aNn57JBG2zWIMqFzsR8yblBK57?=
 =?iso-8859-1?Q?l4+yeMcBhgZ0r/HStD6csoISbWWy5q75UbWHpz7taKUa+3hVw+2LvOVb1E?=
 =?iso-8859-1?Q?GmfXeX3LkjquL0gXiWH2YF8KPs6h+aH3vfWGl5Mzy2n5WQKwfjlQib14c7?=
 =?iso-8859-1?Q?4uGSIdgkl2jBuLP/Q0+7g0mOyewyG5BX6lpteE+p3GtnMkJTNcSHew1mTt?=
 =?iso-8859-1?Q?dx83gY4F+QUPuo2EVHXtHcIbAGFzUKOiZuBtYt5wX3DSccZZ4eMQaimDXB?=
 =?iso-8859-1?Q?ImUEmW0fXIS8H/+gKmbtUq3THvnHfgDf3kcQiIXXvVzq6ILGhld3BYHgx2?=
 =?iso-8859-1?Q?b1nCFMWbQuGnvQRwiD1DLsxHBTIkiv188sDMRWy8GpzlP0GXOG6XQYFkMt?=
 =?iso-8859-1?Q?7HbAqwVkKEHuszsxtFhrtdm1t6MZq/XMsWf7uxL3ffMcyg+26euL5HAnlC?=
 =?iso-8859-1?Q?81DEq/wQ3tI8rATEARGYNUpY4FnnG6ja4KAOr98ALsADLLWgGdp2zLsJh0?=
 =?iso-8859-1?Q?YPetbq1D6xigpE0jd/+BiU5zhuIKv0xZeI0GPBGxEyXWcllE14cJMfcT9X?=
 =?iso-8859-1?Q?1VCFiMXyXDhJz49F53nBZcSRukf5OMzfhxNKdOc4RbJNPofqICaeYtH99R?=
 =?iso-8859-1?Q?cDF6PP9AV3U4QrfHvI/GURvJI8neylDIRt6BUIdnPlKhcFRuSYr1AHAT7k?=
 =?iso-8859-1?Q?mTHXlT3gngrxW/J6Ko1QemzBM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020de823-10d4-462c-ff49-08d9f55f5706
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 17:26:47.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9TcGla/lHiN0qaYWO1XIpgxzLWiczh8v5u6qieXlgP1/9ZVVPn2D8T9ssxTQv3Ms3vVFnEmIdLpeZlvZEzucSxZ/HQsKYnmWtcZ7m/jQH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6466
X-Proofpoint-GUID: 77YRlup52W7yP-dh0DuQSWc-ThSu1Mxg
X-Proofpoint-ORIG-GUID: 77YRlup52W7yP-dh0DuQSWc-ThSu1Mxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_08,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxlogscore=574 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
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

Document scmi_devid property for the devices, using SCMI protocol
to work with clocks/resets/power-domains etc. This property is intended
to set the device id, which should be used to manage device permissions
in the firmware. Device permissions management is descibed in DEN 0056,
Section 4.2.2.10 [0].

This property is useful for the virtualized systems, when several agents
are running on the same platform. Agent term is descibed in Section
4.1.1 [0].

[0] https://developer.arm.com/documentation/den0056/latest

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../bindings/firmware/arm,scmi-devid.yaml     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/arm,scmi-dev=
id.yaml

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi-devid.yaml=
 b/Documentation/devicetree/bindings/firmware/arm,scmi-devid.yaml
new file mode 100644
index 000000000000..b0949319e00b
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi-devid.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 EPAM Systems.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/arm,scmi-devid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System Control and Management Interface (SCMI) Device ID for permis=
sions
+    handling
+
+maintainers:
+  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+
+description: |
+  SCMI device id property is intended to set the device id, needed to mana=
ge
+  the device permissions via SCMI protocol in the firmware. The device Id
+  should match device ids, defined in the firmware so the device permissio=
ns
+  can be requested by sending BASE_SET_DEVICE_PERMISSIONS (see 4.2.2.10 of=
 [0]).
+
+  This property is useful on the virtualized systems, when several agents =
are
+  running on the same time and permissions should be set for the devices,
+  related to different agents.
+
+  [0] https://developer.arm.com/documentation/den0056/latest
+
+properties:
+  scmi_devid:
+    description: Identifier of the device, matching device id, defined in
+      the firmware.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+additionalProperties: false
+
+examples:
+  - |
+    ohci1: usb@ee0a0000 {
+        /* ... */
+        reg =3D <0 0xee0a0000 0 0x100>;
+        scmi_devid =3D <11>;
+        clocks =3D <&scmi_clock 4>;
+    };
--=20
2.27.0
