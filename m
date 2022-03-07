Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793F34CF36E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiCGIS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiCGISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:18:53 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0937D2A716;
        Mon,  7 Mar 2022 00:17:58 -0800 (PST)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22773rPG010793;
        Mon, 7 Mar 2022 08:17:47 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3en3gvrycj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 08:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hisp02Bie6d+0Av4FB9tsCQpjgONkr8o1GfLwLHu+wFi6veMqckjLgUU24WKtvtC+6IZy/HpC21VDzGsnwTnC6aq/+yquSauttwp2eaNFFaeHqob5XuieiRSPD7VW2Z2QKRyYSmQ34ivTesRdQaTcPUISEL87lx63qVhme6XxxKqUjOaSHcI2pvwRE/wbM5aXyCaaC8KRbjxeRWhMXSD4iQoF8epzAWP02vPZ7IY3gGnJGVfp6vSn+CtAq29mwwiskLJATuiWgaojsJXBa8HTpF89+9BXEEOWDNTt+2NuFVBHP3kO2huJsIBhRQqeI77CQ0uAglcl4Mm/Zb3nQA4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Pb9zE+3Ovi/tEgUi1EDsBnR9Nn6ss05gwsKNPY5uIU=;
 b=FJX0lgXKHD7omz2d23m9CTAx2fU/Y/CNh1Ux7l1tuUzBkBdtpVjkShn2kdac7zEpWrOKc0ttxP8RqUgBrsyk+x2e6Qok7fmEP7P2ktbawDlmdFbhOOFguBoWIUiHveuIbLM3A5xkHpa3v0N/5d/NphQmRt/qquGF4K2EnF11+07DLD47td5mYbcmdJIfUNqFHtNY0jeVHGMqMS+iKv6F9ED1PnAz0ZT2ZJ/5TU79dWlLZZbnfW1m00NQIrGVwOxF+9Kfs9kgqail3gAcse9VOksU7JM2rHwvZi/KWVbF5c7DwlmPFHeHdKQwwHNHgTUqySv1dnyJNBQoO7QOd5WbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pb9zE+3Ovi/tEgUi1EDsBnR9Nn6ss05gwsKNPY5uIU=;
 b=RCMHDf+EiPBblFwtd492O/8DADJVk1QBsTSN2Hj3nBFVjSQq4QyLU1Ans/oCWUKXhftHQAwDzzGno7/Hq+oGW1KDNb1UbVADmpR3J1tR87HtqBjq9KUHq2JEbkPAOlFAbI8mykv/UUVCDcYa5tL4X9G0mnOZKOaP6nqFJxDZ4P+jx9a/M+Lh481x5tFsjcuVQz2BObDREs20y7B9KfKuBQfXNj7lFlvQ4DNKlT5qMyYFxy+OuDbzNIn0CPI8aYw2MsZ3oNx+HS5sD7Uak55QRT/XlQSmjoja+WmhD5oCrOr6W8xLbDCmMin+ej/prCyUaTCkeXsuOICUevnERvBxKw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB6PR03MB2887.eurprd03.prod.outlook.com (2603:10a6:6:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 08:17:43 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:17:43 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] dt-bindings: xen: Add xen,scmi-devid parameter for
Thread-Topic: [PATCH v2 0/2] dt-bindings: xen: Add xen,scmi-devid parameter
 for
Thread-Index: AQHYMfvRRPpzAb5FskGmucio2Cv3Lg==
Date:   Mon, 7 Mar 2022 08:17:43 +0000
Message-ID: <cover.1646639462.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7df7a097-7984-48c5-0534-08da0012f452
x-ms-traffictypediagnostic: DB6PR03MB2887:EE_
x-microsoft-antispam-prvs: <DB6PR03MB288722BB73AB0AF36EFF319CE3089@DB6PR03MB2887.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7vH4R0cldFB6t4yRvVnCInyUrKXdUq+WtGfIF+2HuiJh9G7K0njRPAhfQPhvF5YxX7YE3S72uCYfoRewb4Z2ASCKDetnO/4wqKRsJgZINT25gUVg6/+Q8CDB2xOwDOo+kIohzOVSykr7V1YozYf0t/9PzpI8SFjoYEOvUNquViJT69+Ovohm1ivtrDlL54+V0n3H0vgOYYhg9wRqfuy2lINqb/0MeMa6DjSd+T6t/J6YzGoPgP2FYpsk80VkCDMaRjImdLE6a94Lk5UMGCRJovbBBjw/nRV/6mvAZdJ4m79RLTT5rMpvqxx+9rdb5CdHQ1O6yuWvEZBLc+JEYSoEZTQ+S0Yxrk2BAQsiVr6hON/4o9yKE76DregCGnMKTovlm1Meqgv9FYw8EOE9qk7XQn0gh3IF+OeppJOBw4EUm04eQzPv+V2ByfcaLlzfCmdPOo+3zxxlZqc5KOPtqoUBEBRrP0XkWEPxMeOxzNooacEohOe+i78h+Av3dEsQ3G9kvX9RcgSbgZJuYRf0oS+uCvIJ7iSJzpF/mC4GgRfIBVFmRDdfPZ0ksDh6h813LtDQYSlK3CY1YTSVsJva9NdOXRW4ULIvCj9OzLK5JAOOt7BdcfGD37j1OipBoWhmAE/fbEUxLamNYI/W8mQpv6Cyv1AvE5XRAR+2gTbswkaHDISCc+s5qy7QFcps8AwZa5H8mJHW0Op6RzWgCfHeEIwrFpVPyDjwG2Fj/xgi1o3C6Y9gYJRfPvhmKXemY1xQgATPbsWQhvKDrEb2P1NLYPZbjI18GJCfzbapfvL7xAGK8s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(91956017)(316002)(64756008)(86362001)(66556008)(66476007)(66946007)(66446008)(122000001)(8676002)(4326008)(2616005)(966005)(71200400001)(6486002)(38070700005)(508600001)(6506007)(54906003)(38100700002)(186003)(55236004)(26005)(36756003)(6512007)(83380400001)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cLVRqKFGuD/JtTo0GQTqjoIzwzOJ0poOuTCXDR+KzrlCWSJefbZh0AAQcV?=
 =?iso-8859-1?Q?fWilVssZxV7f5vFIkenFbHPy8d32A8Rf5QqZfGkutFM63c0hyqHe5/u/b6?=
 =?iso-8859-1?Q?IDm59/d7X/vNfW/4Z0Eb9vaOWDW50mTFXHrjtIUVwwf3IUR84kLngKXLoj?=
 =?iso-8859-1?Q?RlNKsOXPmuf1/VS2kgXUwDcMNTC8+I+/ydK1MopeCbeghcWGW3z6nno4fI?=
 =?iso-8859-1?Q?9vZvU0Du55T06OJdPr+YiJMsBxsB/MEZdXpdpKdNrytuNm1dvHI+bVVOWg?=
 =?iso-8859-1?Q?RlecE//xwmxjALc5yD9zylI97tMISS6kFkUM8uTRg87CJS3qPJ7GuSCxPj?=
 =?iso-8859-1?Q?BABA81CjNk6KP7w3COCDw5UtAdh6HyCdVvQvZ2YOUckAXeKxGYxcirkwlM?=
 =?iso-8859-1?Q?sIRDZyp+R7h7hSm22GwhQIl3Ccr4fXIQT+jwq/5xbKcF7eiaHcCGoriVkB?=
 =?iso-8859-1?Q?run0hTjZo4zy7gxAB1k5yaLocQcC0B5pAmLD3Jc9NpLXHdx6kr+DzDf/+f?=
 =?iso-8859-1?Q?CHxxVYmf2SZOQcpaOZXGsztGqH2Iopn6ayFQKehcCYJkB1kwdYef3F+Irs?=
 =?iso-8859-1?Q?9nEIhIh9Cmi11fLxd4ALow00Ua6qyujF7TkZPnTM21U7BpG7QdNRbrvUmq?=
 =?iso-8859-1?Q?AcXx5wv9sld866h7ubQsatIelTDkeIUxuRThVD8Br7j3ELQMJDgCc5bYAk?=
 =?iso-8859-1?Q?oRNZSk36ypXSUzlEMQvdMIPTETRow4REYfJly+ZZVGOnrnoIkOs/B42iWB?=
 =?iso-8859-1?Q?l67hKhr5guqM4r6JWeABMl0OLxwX1YFeOcmnHs3QWofce8xdporxEbY9d7?=
 =?iso-8859-1?Q?bneO97vBLr9OxMKhHwf97+tukFE+2GSr9oqqH/MNR+ia1ojl9hyty29gzo?=
 =?iso-8859-1?Q?nt/i+aW6HKRclVPeTRElUuQU7XluB/Cn6Fgd5nXmMkz85M7q2RLenTKPIS?=
 =?iso-8859-1?Q?lfGEodi8AyMclpuTFI/pU3eV6rTopdyD320oycNfx/wYJkLiX4B1QHCY86?=
 =?iso-8859-1?Q?jRmrCQLMxliRgWJ3mgFOjVrL0upA4khpx8oDv5SJM4DaJXBoWPbJDoqvo2?=
 =?iso-8859-1?Q?1aAu3O9N20aZCb1EoOkf98x2a2WdhsTH4Ovo9Z63596WWUNuz/BtZ96bli?=
 =?iso-8859-1?Q?f1cCBaA9O7tsgC/ahoVM0UdarJSxHB7GYHHIiwYxrQABqP2JJlHV/tjAJC?=
 =?iso-8859-1?Q?bTNtE5FHTRMLJma/58IxTrVNqzs4f3qwM/COgjouvZ7LsNfzx20c5a07G+?=
 =?iso-8859-1?Q?v/BpLHI2DfyiaFWmbcuOC3BXfOGv88QOtzaLi8DSiRNFt+ERCACXM5pzA1?=
 =?iso-8859-1?Q?1SqEB9pVN4UnHD/8m6KgVL96WfZsYln/2X3CMmMBLIjeGcowTk4kJ7CJiR?=
 =?iso-8859-1?Q?6ZB0rkkBUHzmPie50GKnPEZSpQSPHcLKuCaiENvT+o9+5E16SuaAPne/nC?=
 =?iso-8859-1?Q?t9kLFjvKY4EVsuuAUeN9EuLmv7+9Hc0r/fEPp8/hg0LAyNJaZK2YjJq1dn?=
 =?iso-8859-1?Q?u8YXjQGJ26QdJSgvvkX0F5lQxGXgtmuYdP0yyS6fcGfwUJbD3635rM0QTt?=
 =?iso-8859-1?Q?C8JciAMQuQJg3a0JX5x1sXK3LraiXsvhtFXgH+DU2t0BNO1OaSYjjqvmY3?=
 =?iso-8859-1?Q?9vXIelGUZ8JHVDBF77qYJHk6iyIOTshYB06VrmS7uFl8TjNcSRRtj6QcEt?=
 =?iso-8859-1?Q?KnTwKrqAZuY2Sd/K2IYm+7ojoO7F3OvBG47GDp6n/qMNQA3f6RRlhnOGnX?=
 =?iso-8859-1?Q?ACdqRdnH3SVo0qvmhthskI0nM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df7a097-7984-48c5-0534-08da0012f452
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 08:17:43.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tf8/PFo2qK536IiyCDSwcsOGmtrOvOi57XOFQdhJDW32LMNrKrI0Ly2W6WMJJ5gao8AqfP79bDi8S2NMOPFcVXEEnVDXh0FIBXoIMSoPjKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2887
X-Proofpoint-ORIG-GUID: 724YuSLz2xCYHa333PXhRuiidPBTkFr-
X-Proofpoint-GUID: 724YuSLz2xCYHa333PXhRuiidPBTkFr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=580
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing new parameter called xen,scmi-devid to the device-tree bindings=
.
This parameter should be set for the device nodes, which has
clocks/power-domains/resets working through SCMI.
Given parameter should set the device_id, needed to set device
permissions in the Firmware.
This property is used by Xen hypervisor, which works as trusted Agent,
to set permissions for the devices, passed-through to the Guest Domains,
which are non-trusted Agents. Trusted Agent will use xen,scmi-devid to
set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
for details).
Agents concept is described in Section 4.2.1 [0].

xen,scmi-devid in Device-tree node example:
usb@e6590000
{
    xen,scmi-devid =3D <19>;
    clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
    resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
    power-domains =3D <&scmi_power 0>;
};

Given example shows the configuration of the hsusb node, which is using
scmi to contol clocks, resets and power-domains. scmi_devid is set
equals to 19, which should match defined id for usb in the Firmware.

Trusted Agent will use xen,scmi-devid to set the device permissions for
the Agents. Guest OS should not have an access to the permissions
settings, so no code to process xen,scmi-devid was presented in Linux
kernel.

We are currently contributing changes to Xen, which are intended to
mediate SCMI access from Guests to the Firmware. Xen uses xen,scmi-devid to=
 set
the permissions for the devices. See [1] thread for details.

[0] https://developer.arm.com/documentation/den0056/latest
[1] https://xen.markmail.org/message/mmi4fpb4qr6e3kad


Oleksii Moisieiev (2):
  dt-bindings: Add vendor prefix for Xen hypervisor
  dt-bindings: xen: Add xen,scmi-devid property description for SCMI

 .../bindings/firmware/xen,scmi-devid.yaml     | 42 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xen,scmi-dev=
id.yaml

--=20
2.27.0
