Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1F4CF36F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiCGITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiCGISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:18:54 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57EB2A25F;
        Mon,  7 Mar 2022 00:18:00 -0800 (PST)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22773w8w007379;
        Mon, 7 Mar 2022 08:17:48 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3emxcs9df0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 08:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0Mm1L536zJqOUd/S8AyfJYFi8sck/ZP6BOaLHCYrTuCKWMITC/sybJdVVThhmxQ0bM3vzpnsgQZAVZJGuo9hjf0IPdu7To2L4kOK9H5oBhcF779cYgBD6CwH25yd/osVET/ewD7W7mXrUk5WDEZgTMWSnoEQsD148wL2sLhq7xrSfrnJVdmhSkUX50Ziw25YZL5lLjjT4hlL5Ls71ueD4Tm3/D5j+gGfQMLMq45BIxb9nR3O6kJq9j/WGvMO88OflRlZ625qccoCjboeOfWucEufRy1gpVdtfj9xn+a3WkJk57bSTPXyd9hTgcWYaNdwnffGgWLnb4wIyiBZCDaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJryBJkSd0XwWXrbX8NkJKVr97c9UAaBonZqLA9ZJps=;
 b=FXCdH6ewWqAMEZFjYASdgPV88IXxgWIjHQCxYkFg2VXCzCmREfIcdUxtTd/lNmuja1kmRo7ityGi4Bz1kSNysyyiT1T7PFxTMfeTthUFn4CjW6XHWkHz7Q3lUECrosen8t6v5MbbhkHMaey55GaCQGGk7JumA2PI+t/sAgoqHmG2TYP5k15CQmOTlBmB9VprbIEmlYKa+PI/wbiHCfCywOcDHuRnQUurBXPXHcgCRVMeU0hH3gNSPkdAI5AYrmkHVLZKJH/9su3m9s5jP+yQlpKb4iSICjAWjB27SFjVp1FD2czhWQ6I/okCDrraGpm2VYR2pGfHI3sqiJ1vlsYMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJryBJkSd0XwWXrbX8NkJKVr97c9UAaBonZqLA9ZJps=;
 b=Fdm4nQba/jwjRuhCLeci6rZG2XBXFSw4GAhlmJSOvbGfIG/CwAmCOwOr2TQDidc8/NtSaiUluPTuHL3t1GaX1ZgAQkRlDcvFQOVRKCaK3of7oGSaDuN6PI/9D7Z9G1R1uO+6y2dGB+Lj6vN0thhGz1nUBi6tqtTJxuYqa1yg8gzzguTGvw8hMCHArktMEkHV+5JiogWBw1J1ZNhkWAjZ+WnXlVix+HT+cpbQMI+1/rEEUNfVgGhQj6T1hok/HJeIzVxGcpWyJtAOeo/ffEc09T7vcgWVrD6PxOtK0OP9fMA1c9+39o5aSVFrvw5evQxJIyaPGaQIxEUOcG066hI3QQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PR3PR03MB6635.eurprd03.prod.outlook.com (2603:10a6:102:5c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 08:17:44 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:17:44 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Topic: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Index: AQHYMfvS+PrMFPR+OUmb9ZzOrE/y5w==
Date:   Mon, 7 Mar 2022 08:17:44 +0000
Message-ID: <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1646639462.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9159dae-0cf4-4f12-05e5-08da0012f51f
x-ms-traffictypediagnostic: PR3PR03MB6635:EE_
x-microsoft-antispam-prvs: <PR3PR03MB6635D4B92EE74A59365C79F0E3089@PR3PR03MB6635.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hn/vmVKFs1PwuV/hYz9Mx9F4sMC9FAqmo1NXcvz9glNfn2tXfSHFJCOjR5Eu2AkG7EwFfZjpgvO84/nS4AnfHrj/8QAHSUeeVJwldxxCWO8aUikTr1iaptSwcb4nhRulNjHsiXyK42Qhs1Iaq2OMob35guD81LJD42y24oyxlUOOMI0uQYh8sCri6C1A9j9OFAu5vcJUNlhaXm42xWhmXstD6WYEOoeCy9GV5rKmKvE5WVHR7Mpb3qnJ2KZFWMCS9XPdOS85dF4KMw7gh1GrdE5oGGgKCooB9cxznxnK5gAYHGwJiIK6J0xWsuz98H7xyyqRmjhx6nHtjztXL7XU1yfgl+uXzNPxQxQ9KVHknaIshlyvOTMS56OflPDruhHoosPhhuUevmPq53jnL1vttCruKpIi1twJ5SlKSvtZp7yLvAKXxlH7xg/t/18usp8s+08s/ORJuRaRqHlxsYeb4PX23TvrFaccP6oMftF2H0tMxSJuC3zdZ5QF0wI8b40MryQemrRmxFOZtR0miujiFmIzMPYNd3JE42RtuqXXIbvdV+SVBAIQh5NFPbJb126jgRsitFTNikfIlbQHXKd8XJqxAnFgXHFjiJpY9Fpoxl2XPjDD5Jbxe543DCBQ9lrTJurTeaniOllkvAnQe4GVMm2AEqGAyjUkBtyoZJ8fbUQqrJVPvjvqL2rkD23QM9D4GlOJXMiP7Ew10p1FzDVI4giDY3lmN2W5N9z07MRR5pQQIBTBUmUyUGMA+ATtIwGllLFmFzwblPgd7izcVKf0z0JKvvuTuFXkTzDqE33IjOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(26005)(6512007)(6506007)(54906003)(5660300002)(38100700002)(36756003)(6486002)(966005)(55236004)(508600001)(76116006)(186003)(316002)(122000001)(2906002)(38070700005)(86362001)(91956017)(83380400001)(64756008)(8676002)(66476007)(66556008)(2616005)(8936002)(4326008)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uFPWQdSTcj8IHmSeD27lHKSCqrIbfeLHl8ZP0GJ0O4GdtCvAObNhOj4vHR?=
 =?iso-8859-1?Q?R/QeYDplAPT/86Tbzj4j33ffdI5xmy2vmoC1wN9OQdNWYARFwhBt8FTaiY?=
 =?iso-8859-1?Q?E85QAehUpvhjVkaJvXfeKpAJAncWRVeLVcPK+3fDrvFukdQTLaGhI6jR/2?=
 =?iso-8859-1?Q?/NhlhSrN+aolCJhTh7onIzPv9v5RDoDUpnlJ3tbcJ7PaGzAN/y8R3pHe5i?=
 =?iso-8859-1?Q?qFeOKwzHlHX8HO6J0EWCvJ62PEreEqW6ne+6pzwePxyH2NfNfvER7MkZZE?=
 =?iso-8859-1?Q?IY9kybo2h1xBRjdhAIMxQMER67vxBPSaCv9jk+4toylxKJJqELUeg3sW9b?=
 =?iso-8859-1?Q?m6gpKLViIIs63kxxLGws16sUEmRSTCO+9Vm+1F/ZHgv1nuDB+hFhNahxtv?=
 =?iso-8859-1?Q?2RpNKb4uS8EBvfcRF8iHS8/esZn2pNWWkILEyx+F9m0ZFG6WJD97jHtmOQ?=
 =?iso-8859-1?Q?XL5VgQHjZTOOxSz0vo5PO4Qu8juBX3BFr2jm9tYWNUb8ApU1ktonVvWduc?=
 =?iso-8859-1?Q?25HBeSWAcwOqEiseJ9o9w4cy+JrLQnvQRpw7f0Ypu9Y0aCGCdGtzyjoKG5?=
 =?iso-8859-1?Q?BE2z38J45Ux1XgaH30k6i+3tGXztZz/LItFQQILgo/zAhvg8vzCBznfsSS?=
 =?iso-8859-1?Q?IkcTspW3v18f2JXAsaDYjGHIEpi2NeSMFiglRS8vAM40G5dFUtvTscijPI?=
 =?iso-8859-1?Q?yWiAeW/+DusujHdKlzqCTdLs5tCn+nF8hLl2zX5EoiFJWqAHRvOsG3LG2P?=
 =?iso-8859-1?Q?xEiiCzu/y+8iAoOoPt8TfbIKuIUBdJirypTUAhBSknFuBV3sy40cmmmsXQ?=
 =?iso-8859-1?Q?qYuN1f4BgjFsv6HoJIScyQ+oyIqrIXrqfbiUw96E6YTVoyzdRi8G6KNZ9h?=
 =?iso-8859-1?Q?jkke1CrFqBDeDC7JFiMBP+er+GpLHS8ZjR29m85ldyAn4vD+dsE+XF1MiQ?=
 =?iso-8859-1?Q?Z4q+L5I29SufSkRDEGXM+k1V4LKYLRXHwCBK+k5GD2UjYauBbHYAr8hx9v?=
 =?iso-8859-1?Q?HqhB/MIw9sWWj+oCPNl1QtVuQmNVHL2UIG2vy0dXxQ2wP+/QbCHSEckcQO?=
 =?iso-8859-1?Q?nSKmwVjG86QK3lXQ7ntD+ncJULWLuVVGGO/z6pHfcFvnhYV+oiiipPFHiS?=
 =?iso-8859-1?Q?b/2Njz85iOe5HCpP7xv+b0YSQQjJHryHkZ+6rdy9CwX5M/H9oudPP+t4K0?=
 =?iso-8859-1?Q?SpHB8ZCY083J7GRpOmtEONqSILoNQlZcJLawEGbfI8809HyOE92W/8+5eT?=
 =?iso-8859-1?Q?cKmGBgD/s5UYHBolkVSddF4N99yY38xLN7ccYsBZMS0KX8BJMIgqS+Ghfm?=
 =?iso-8859-1?Q?7xafCFBptuvt/YI2NRVmprbj+cgWbVYx0KboabQ/uo+jnjj+6P1wOGeh/R?=
 =?iso-8859-1?Q?j0kvvkrihru6XOnBTGTydIN3BbiGWd9QlhAJB6mw2P23k7h/bS4DIUNotS?=
 =?iso-8859-1?Q?Dn+62cDkTIw1scXqeZC1cbZl7dKjnUd7c6Sz5PdAfbACrqezucd+WfGonr?=
 =?iso-8859-1?Q?9IAgcwb8QE/tV2om1h8Ni6HgO+KoGpk6NQtE4yfBxrB9cMXQw98IVwLPtJ?=
 =?iso-8859-1?Q?2QISbAp+i6ulurCaHQCC6Al3Iyba+CP84Xf7CBEXh0lawRWGPQuIMBGikk?=
 =?iso-8859-1?Q?3oRDTJ68V09RQaNvahDR1/qCHfxWxuwOXXQx/VIE7avcXv8T54ZZ9JqDyh?=
 =?iso-8859-1?Q?uN+Yn8Df2uSVsvbMDp3Q3rNIueFEnDnuN5VPohJ6BmuTtYNAyI02R7XcRn?=
 =?iso-8859-1?Q?q2dzWYAPNxHweuu1u7wteIfBY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9159dae-0cf4-4f12-05e5-08da0012f51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 08:17:44.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cVsofUhdvzOfkfTxiGCs/V0QsdZOwCZWKjk4yL3Ym5TFepTtuxsYm4Tk1Z3N/RGZNp+GwGmKoaKn839Cx86xxO5KrL0blkdJUX2zmjn5AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6635
X-Proofpoint-GUID: XYhFzzzszA5bSuyKllF51VTwZSmvX1uI
X-Proofpoint-ORIG-GUID: XYhFzzzszA5bSuyKllF51VTwZSmvX1uI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 mlxlogscore=644 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document xen,scmi-devid property for the devices, using SCMI protocol
to work with clocks/resets/power-domains etc. This property is intended
to set the device_id, which should be used to manage device permissions
in the Firmware. Device permissions management described in DEN 0056,
Section 4.2.2.10 [0].

This property is used by Xen hypervisor, which works as trusted Agent, to
set permissions for the devices, passed-through to the Guest Domains,
which are non-trusted Agents. Trusted and non-trusted Agent terms described
in Section 4.1.1 [0].

[0] https://developer.arm.com/documentation/den0056/latest

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../bindings/firmware/xen,scmi-devid.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xen,scmi-dev=
id.yaml

diff --git a/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml=
 b/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml
new file mode 100644
index 000000000000..49dc9951b54d
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 EPAM Systems.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/xen,scmi-devid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xen SCMI (System Control and Management Interface) Device ID bindin=
g
+
+maintainers:
+  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+
+select: true
+
+description: |
+  SCMI device_id property is intended to set the device id, needed to mana=
ge
+  the device permissions via SCMI protocol in the firmware. The device_id
+  should match device ids, defined in the firmware so the device permissio=
ns
+  can be requested by sending BASE_SET_DEVICE_PERMISSIONS (see 4.2.2.10 of=
 [0]).
+
+  This property is used by Xen hypervisor to set the device permissions fo=
r
+  the Guest Domains. Where Xen is trusted Agent and Guest Domains are
+  non-trusted Agents.
+
+  [0] https://developer.arm.com/documentation/den0056/latest
+
+properties:
+  xen,scmi-devid:
+    description: Identifier of the device, matching device id, defined in
+      the firmware.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+additionalProperties: true
+
+examples:
+  - |
+    ohci1: usb@ee0a0000 {
+        /* ... */
+        reg =3D <0xee0a0000 0x100>;
+        xen,scmi-devid =3D <11>;
+        clocks =3D <&scmi_clock 4>;
+    };
--=20
2.27.0
