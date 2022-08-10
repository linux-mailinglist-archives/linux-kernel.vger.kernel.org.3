Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60B58E94A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiHJJIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiHJJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:08:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE5676479
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+n9TwbkWgWDUa/IUKOAjtZoGr4C2XJskHqKj0VU61dEok/XS+J5I+LJ51dxkC6HBaCkeGi71cZoepOPI6X5cPv5YPjvdgIMgcgrj/L3b991KbuBFgPxSO3zbajZeM28Rp8JNlLbW5Jc9/mTz20TMZcG/KyTymxkJ2AgFt6xoV7+GMDnBvhhp1swggyLoBfzuxlVvBS4qNNSicw0/Y5xtOt/uqt/2IGe92J1r0SrL17Msuo2v7E6L1D27BHPbWL1GevuBmibt2Euj6BnunGQBhiewd5YtwwIUjSpUUNsfzDXmlvJdaF8QmW1ftwGmOCSxDPmPCA4IEIMsucj69Vf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY5JLcGcl+kO+JgzLql4Q060eECNQrGe1zeI9eSNtCk=;
 b=AJrSDT8OxdwwCmz5HOOIs4phRaWgozHeCduOwADNPmXklq65aojJ73Qh/2mI/rUGW1IOcjETnprBX0aakD+ze8uZXBHHFPdINpoOJ6ItyP3oAbF2pRaveeqUcrxqw3x+TlTvLcFnBNgN6HGj/3YjLQTJqnGboCHpLtqKFeMloCTZf8Kmm5hqfn0UVN63uwNuXRGcv5ES74dCKAV+BfIIoeojQVkvBOW5qK1gopsRtHb8s2vJe8hUUKURei0xU4LhJg0KoYAU28OI0jW9ewP2C4KSeySn1V8//u50OyJ30CN3Gd8jGVP4D1/QMRvTf/Ix+h/dMeScEjEfpi4vCO4hcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY5JLcGcl+kO+JgzLql4Q060eECNQrGe1zeI9eSNtCk=;
 b=ROpV6S68MwH5mpVAhzwV2gzLpmwVLI8MPl0vyWRUK0Qkpa2oZLC9K+t9ouHTUWrEFvvmi9lRWeeArKHbqF7Fiw3CEwNS0e5VrPNF9BQkbeiBtuMVpEAF51/39M1W2A0sGmORxTPRshQFFfN5cJSJJbzgvjT+myNfmGuHPRfhothajLBFBceDfZIgcLFSpTo9mAgSwTmtDqHh7qnYsietI9VHRwZ9OP8LvddF2Fx3rSVhAJQVtbWlwMROqvCR1tEc7JE26gajZztLi98XowMY+rFOQTE8c0a3Ah9auEPcqZrl4EFW2E1/RM2fYYvcSLGP++k2Xau0I8gkBWUx1Z9akA==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AM8PR10MB4644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 09:08:13 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::951b:8d8:2989:be31]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::951b:8d8:2989:be31%7]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 09:08:13 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Mazin Al Haddad <mazinalhaddad05@gmail.com>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "paskripkin@gmail.com" <paskripkin@gmail.com>,
        "syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com" 
        <syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] tty: n_gsm: fix missing assignment of gsm->receive() in
 gsmld_attach_gsm()
Thread-Topic: [PATCH] tty: n_gsm: fix missing assignment of gsm->receive() in
 gsmld_attach_gsm()
Thread-Index: AdismLWTN62NoSI9RGqOqYqh03p0jA==
Date:   Wed, 10 Aug 2022 09:08:13 +0000
Message-ID: <DB9PR10MB58813E33D3516BAB526156B1E0659@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-08-10T09:08:12Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=dd49cace-9954-4e8c-a4ec-6ed1aa9320f0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 659118d2-5c1e-4b8d-c5cb-08da7aafdaf3
x-ms-traffictypediagnostic: AM8PR10MB4644:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +o7z58Rl48n1xQPyay8KBSNEk28ERgtL3hZ39WvSh89ivDVVR2ZxvfrykAF3AJO3MF09/hVeYjXd1xs76EBLMTuCb8Ns0E7YmRDLQGmLkHw2ZouTuff77WTP3QSQPuNW7+NKxE2KxsZJ/22AhAOu+u+h4G0Id+58eBdCMb/7aWP6IO7gpfcMNUT7HBweKzcdX0ZAclJ6PDkMgTTu9AdWd8U8F+nCU6DPW13tZi4E/UjalS7tu4p6qWXKHm2A6rspxZVaHKQdLsIxTu/XMwl6IZG9XJUYRznbDGYMqiaTq0eJj2Ijw2y/+6pdIeSFKQW0GrILANmBsFvGg/wVlSpYJyc07r0hPse+j+44NihqYL1o9ZmxjFk6PptKEpyz9s8c3Da5SuJbTT30ntrZyJazI0BjX+scvKLYCpUdpEHgXwqNAzvbmOQoau4JFYeDbfhfzUhBXwosVr+8x4gjIxmxiinFY+mJVEKJIWBF1a/wTuLnItlRZyocAW396NLRLFa2lo1NaqTG4CuQ6gBfNzAfJCWLIuVrCk/5AsXfF1yko+QfuuE/pahErRyG/mfv3+novRrbuBFyB9WK0jzkou+NuNcSKhvkelwEzNG76cZo6ZO0OScuRxw9gDjHFGkC6koyb+yBnYQeE5HiZvZAGhfQJ9LGJyX1aVPjj3OO2wbdMPEeoFdmKt9ZkMfVjcZk5LrWwjfK156dZR4r2tsSR3BJ1HMjeIAMEzhW1OjwRY7yVvGPH+KlUHDucZ4eZbVusbPViz2TuNkjTT1+aAH0xUAKKIKyk1Ewre2Kq+nE77/wdX2oJhD6ODwGPVIxaQrsFYFPyZyoZK7glp6DQWT67rLBnTsxSBFUKa7MuonVhCKFI/k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(76116006)(38100700002)(7696005)(33656002)(6506007)(54906003)(6916009)(316002)(52536014)(8936002)(8676002)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(122000001)(38070700005)(71200400001)(82960400001)(5660300002)(478600001)(83380400001)(4744005)(2906002)(55016003)(41300700001)(26005)(9686003)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K512hC21PTmVNgEbDKz4TTshM7s9T1Z79f0GM/WaNPk8/zDj0EKo3cxuMOQj?=
 =?us-ascii?Q?8sASMqBKMlCleL+W6irjgUZPXF7ikjrwnsvkEIQO/hvppClgd2iS1GIGV5EZ?=
 =?us-ascii?Q?QjcHhyTS69sf2jZZJLv/Q07jfnp2pB3KIUjFc7wOV7LnSP9yiqDe+E8pWd0l?=
 =?us-ascii?Q?MX86mR57LLnrz24kc6hxLOhoHJSH1+jLaICuYkrL4oBcmt+wPkO5NZo2FZI7?=
 =?us-ascii?Q?ZVxMU+AtuVOxwtNBngnk2IEsvzS9721YrJ7JL1emJs5Jb1YWbvhbo7m0Dp/i?=
 =?us-ascii?Q?9LRz/f0tRGsI0CWZbVd6sRSwQWMv1szrWRNTpyenoLDGiLIknN/y7lFItE4/?=
 =?us-ascii?Q?ZElZydoDLnKrWiPpxL26MznntRSTEkDYI1McrY1e7JycjcBRLEQuhKJcmeCQ?=
 =?us-ascii?Q?fg8dnxn4NED37ERY2m/+kr6O6FaJPtzOjJzk7aHRpyR5M8P8VFMLLBfgFwDu?=
 =?us-ascii?Q?fQDU5ZZyxXlPcQZRF/g+RTJ3hGnpTUP/GVYlfzHxjKAyQPgiTlrd3BOnIGDJ?=
 =?us-ascii?Q?0aLmtnAHq/Xx5BNqh8ZYlWOshPq1YNyWqZMp0LmJ1hAJQT1rbuYrWdgo0fNj?=
 =?us-ascii?Q?xZ160zLgeSiFDwL08q7VeuAbsrZvM3l9OEHxiOWP7u9s3novDa3UFcSkFuKA?=
 =?us-ascii?Q?MSSBhEWsMJ25RfHnke3Z2CXQqNwNq40S/IOIRx/X434UuHwc21RNcITN3wmn?=
 =?us-ascii?Q?Wx35XhbAnD5WhLdBPKffRwES06z+6mlsN/MC/tRHtNPr5I4q/sT1DCWCB2il?=
 =?us-ascii?Q?AeX5DAubkAO6Vl0eYUcMAkRJENIhPhzki7T2nQcDv12SYld+6i4kezbkPGB4?=
 =?us-ascii?Q?B5xdXopFp2tqhXtewXeKCdWQFzayYBhWzeqokLUQcaym4CcK/HFDYnDrDJYM?=
 =?us-ascii?Q?YnpuhgzLTllT8968m6siCsfIJbRsJZxl0eTw8JqLTrCPkyJFswwWXKhftW0R?=
 =?us-ascii?Q?dH11uLDFZFtUiJB7DX5bujZNIvPVUe95Sul1AZK6bBnWClMyYuXNsO43TZ61?=
 =?us-ascii?Q?zmloqGBzKfl/+efKjGGVwVg6lbdGrmdzjP12HqZUn990qbuBRN4p/PRJiiW6?=
 =?us-ascii?Q?DhEGdWxWX/V/IrrOka+mik2KWVb2SNDdE9pIbJtfCVlIAaTJbeEKYj/CR05j?=
 =?us-ascii?Q?Dzz0862JlNJ0G+eoi0v2SeUWmoCwZXsGp9wAx5XQECa/NbG8II+IFHgxruv0?=
 =?us-ascii?Q?4rM3FliQr7SrhsgWzZm0CJXn7SpEdFvMQEQfaJH89gLFMNmpUs4SMO5ZgD2q?=
 =?us-ascii?Q?e9oSOnPPoB9/JDsQct2ZrI83ZAaYf/z54+A4Ec5Br7S1/6qclA93F1uhd53J?=
 =?us-ascii?Q?NvdUtYz75QZ/0//ykFCkn6jmMpE4GMWilMEudRKqFjVHMZcrUnu0/bi3XNJi?=
 =?us-ascii?Q?sZv7FTo+RyQwQM72KRNtld6k6knkbzPKF3qp/Xa6hojAhrTcOyxdI/WVY02k?=
 =?us-ascii?Q?BxboriVNK8+U8SoxeEtz8Qbn+gHlr6g8PY9dq/Y7bDbrySYX6HH+4Tq4BYvj?=
 =?us-ascii?Q?lM6ibvP/1jwOE3XVxC1oVLrVexmcFq6ETOrSqwajtb7zGcIiY7IMoqhjYXBx?=
 =?us-ascii?Q?m8d6841UlmQQwGWaaSgu0AP3mlJhPAfykv+/+eh7G+xDybJh+PNccTfziRDb?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 659118d2-5c1e-4b8d-c5cb-08da7aafdaf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 09:08:13.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6C2SzKl1/6THBdLKpcnSTcGTTc7YQ6iCFe8RJZRoYz6sACb7xg/E0i0b9wZ/Wb02njUem58OSO+87yaWHRiMRgq4kEDfMUbQzRKQwD/WZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix this by setting the gsm->receive() function when the line=20
> discipline is being attached to the terminal device, inside=20
> gsmld_attach_gsm(). This will guarantee that the function is assigned=20
> and a call to TIOCSTI, which calls gsmld_receive_buf(), will not
> reference a null pointer.

In my opinion there are only two possible ways to fix this:
a) Move the gsm->receive initialization from gsm_activate_mux() to
gsmld_attach_gsm().
b) Avoid calling gsm->receive in gsmld_receive_buf() if not initialized.

The current code might assume that gsm->receive is only called after MUX
activation. Therefore, variant a) may break the code in other places.
I see no need to initialize gsm->receive in gsm_activate_mux() and
gsmld_attach_gsm().

Best regards,
Daniel Starke
