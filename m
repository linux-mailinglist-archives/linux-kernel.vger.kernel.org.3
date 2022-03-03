Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6B4CBA30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiCCJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCCJaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:30:17 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1C16BFAD;
        Thu,  3 Mar 2022 01:29:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw70yf6g8k+XKYLU/X3y8XdH+AmuNLLOvU/L5hR18E43SB5MoQX5IP55JVXZUbHSWXloxj2mN2sTsVUKDjEkoWy4tP02ExNpfORqbBnUVTgTVWcR6VQ1A5WgCvPsLfurRsXNBvf0b1ouMuB9bZzAh7uAsejmiV/35pwTcB2LHXaEXCSRQU1R+a8xLY+JcUyY9XyUWnUpoHCEhzDocKGhLUU+rPWqmRTc0AF/+Ov7DrpisxqidaQaZt1xyM8k7HsfbeU613JNIZqZ1g8I6zbe9kUudHu8Hx9loXPihYO997fdeuwxdSd6auqqu2ljuNr4awJW/Yo1YuLYC2bHbka4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIAnwwQNJEwUnw9SJ1zHU0OHiNI2fL+IHdAzV+T4usY=;
 b=apVmPFKp+Emf/lgO6rCpPd80BKUl6YNu/vFGvg6TnjPRrCwEuHl5Vsa2hsP8FlZDVDEOd3d4gM/ueZLjwLIA1kXJIFJ4NU6/2iV3HXC0uBTdo2dhxTCRbQNHvpOQ7cbgvKOjM1Dn2Rzd+foZhi8bQkvEJYU4A1vdV6CTT9L90YH2JUk8fk2ezWZIA5jJqguqeqRAIrhMWKvau9e9xMuwRqNshXvTNq0c65X525yzhd8IHSCIaCNLFhFmP0OkS3jiHkeakNwDT2CfxwLszDQ92kv7W+SO1YiC7TSlP3vmFqFISHnK/g80p241+v5hYDRGrqIM4aDrhQc27f6tep1B4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIAnwwQNJEwUnw9SJ1zHU0OHiNI2fL+IHdAzV+T4usY=;
 b=Fl8nPLBDz9ER4ZSBpvQhyHgC1SA2qhc3HIR/oVS0GvJg5pZakLMWocXcsqyQ24wFmC1s2q6qPb4Vvwm2eb/zMd5qIsfV3qRBzf17TbE2Hnn+6Xh90c1f1rO5YvWnFZVRNEgDVFmWZ2FbPFwNMXrzehXGDdzz0fkFPTBgLz47HZE=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by AM5PR1001MB1203.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:203:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:29:27 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 09:29:27 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Yang Li <yang.lee@linux.alibaba.com>,
        "sre@kernel.org" <sre@kernel.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH -next] power: supply: da9150-fg: Remove unnecessary print
 function dev_err()
Thread-Topic: [PATCH -next] power: supply: da9150-fg: Remove unnecessary print
 function dev_err()
Thread-Index: AQHYLUSlaCnVtxRsW0Kxt4++yULyEKytZpXg
Date:   Thu, 3 Mar 2022 09:29:27 +0000
Message-ID: <DB9PR10MB465258DD39BFBFE52D2FC38780049@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20220301081619.121904-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220301081619.121904-1-yang.lee@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c22cb8b-134d-4e18-95b9-08d9fcf85022
x-ms-traffictypediagnostic: AM5PR1001MB1203:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1203D25D46842558EEEDDB4EA7049@AM5PR1001MB1203.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztvn6CBeSnrqWddAXfyQCIO9gFaQhhLYUljJ69QyEZRyEXwb3zVpOOmvJCBviryRGj2mOzRNEtZkHPbagREXe7Hc9CLZ+jPj8Ydgq8bI2LDgVxBU+KXjEGRv+lhimeXLiX1oqzW648joZp9/W5Yj1GlwEax/PS7aWxmkmlXl27w/Lg3+43C1FJhcFLZtJD5l4J/GgGl0A73zFvrC7Lfdu/c9/+f5MhysIghBjlz1Ai0/VmSK0EkMnza84Cc9ZP4+KylvocI0L+n0zAW79u7X+zDbj3jIJg7AXoeGb7fnlVO4rBuH8opJS8VR/p2UYsu6f30YmJIoVJDic7X6cVCjhlCo8nEk+OeGAC8NPPYaa2Rrz1Hj4+lI3iNU7xPWBMoI45/rCF6e+ErsICboCo1ev3Dh8bALE7jm3fIGowFXJDjcjq0r4GMzi4pEUxPdUrhyMHkX3nHtEUWgiIB1wqErJ8B1rrOindfc0Rv85AQFn/RACFjrwUBlQ+xCNx1wewst0cDd/Y0TICxqvHavhX/Syv5ShNnq21Hqws764lfnHTPABKF2H+1BqwoJ4Osc+dIQ8wN1ivCeK7R6QjDWIfhWkFZ8eU/+hSNCrD4/69QuCakmBn/qQfAe/FpPOqE1P163LGgJ+AcQ8zvjXxyeBp/cdrSmNJcdhLPDiWk5d8g+GiakeGv5R3pOgEvOviEgygGCYui+qFjfpaKSPDrl22ip5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(2906002)(9686003)(6506007)(122000001)(508600001)(8676002)(33656002)(4326008)(110136005)(4744005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(5660300002)(53546011)(55236004)(7696005)(8936002)(86362001)(52536014)(55016003)(186003)(71200400001)(83380400001)(26005)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k5qyZF5ZGb6qXhc2CZdJw5tDri0y4IwKJEy9MT0QfGdi21zI3uJmT5Pu9C9s?=
 =?us-ascii?Q?W6sUjcnoIDfhOABFctJY5dppExqr6402qUq3+Nywls8wG9In9JNyRSx0Wrg7?=
 =?us-ascii?Q?pPsqkoNe8erCdRkaVFyfl5zh98GvsolK9Ryv9gdfMN3wl75ZGA+rON6lfjNQ?=
 =?us-ascii?Q?RcYAiL3zTc4Ma2O3IIqj1cumAplAwzGwPReBPMGFON2pRsGLBJx8psuQk97F?=
 =?us-ascii?Q?3PDX8E6m6bnW8cNUrNRuij4o+7Y+IEgVaxpY08L2F0el7s0GDPWPkCAAc4HZ?=
 =?us-ascii?Q?drPnusYB3TP/fQ91Rg7URu/AtprMitXcGQAE+PIiMB22HTJa+XYJJTk5CERJ?=
 =?us-ascii?Q?qFl6F9lA2K6yCclMzAgvh2W/TQQDRzrggnNyArONJSPlT9j88YgDhTAE6N6+?=
 =?us-ascii?Q?X9+qaC61Td15FO/QUrb/3tZ5sr18CYteZG3ibZ6UnveDagKHqrD/nBcIdF0g?=
 =?us-ascii?Q?dgQLoEzhg+NVxcL4s68Ce1rlJzdp/mOFky456iEXajAQuYZnyJ918Qfr4g+f?=
 =?us-ascii?Q?pMBbIjQZFQddcU2ai8yXKtC6DL/b5KvhZvgI5F8tb0QfyVJ7HLBAby/FJWzw?=
 =?us-ascii?Q?RAaJ4ffSELyyYwXlCCcGS+XKgGMZgisr5FJ+ntf1FZ6Hfu/UNA3wQaJL+bVk?=
 =?us-ascii?Q?zzZcNWd0rgFocS5kYVNEyJoVcwJP+oxAje+xaQgUSkQcQ8mULX/ubrPgul4A?=
 =?us-ascii?Q?Xl5HyHmSCGHm5WvNSzgu0u1HYZI86XvzBXRblZ6FuecbE5xjtDsEma2GD+OX?=
 =?us-ascii?Q?cRgYVoGiuEua0M1oI7RaWz37N5ThkSk1xML9ELz9/QG345duEsBLbNINAjGK?=
 =?us-ascii?Q?2emD5aIweCdP/VhN39nTih60pgyKIZelRIQRc4qEuottvMrdp6jTygkhOj33?=
 =?us-ascii?Q?cFcZW57mo5raDjgXO9HHwBg0oU46zToB9E6ZRknTvvW7b+LGNlpHtG+prV2Y?=
 =?us-ascii?Q?aAryrk4VX3dFRgUsqYYhLwbzUqRroZpOacEHktcS6ejoLLSsAVJznA379+45?=
 =?us-ascii?Q?Y/TfnTJDZ9qNDpFEEQxh9C+wKk10yP3ajH7G1wg+WhNltRHG57fNOyqFy39j?=
 =?us-ascii?Q?9DdfC7L4y2fL+uSw2FkgkuZshSAYG3iMcSiefdO7y/MYcNOaEXIQjfZ5sWA2?=
 =?us-ascii?Q?EEauCh1dLgpFDz9e32WquRn5HfA2xDH2OTY9LU1mBBPiiRZZ8DxtnpiBr8sJ?=
 =?us-ascii?Q?g2BvbW5kl3Ak1GSvS7x9S1gQ/DTE9RhcdsGgEE5/RKto2HZmccBxn5VPpX10?=
 =?us-ascii?Q?x6CmAve4zbZHuWbc3PaNYH/Hq0p8mto0Fd+CG7p9ubEW9xb5NOIO2N3BosAf?=
 =?us-ascii?Q?kFnNzoE6U48Y2vr6EqcBi7io1lAj4Bbquzdlo6k55o+Jy1JIk8qeJcxWy4iO?=
 =?us-ascii?Q?CJcCbzuRku322OU9d6P0wIxfugh6L5dIdPEw4GFCjloD6dFdAEE8ocEpLTPK?=
 =?us-ascii?Q?yCq5kikadQEvKqcqep8HGGh77a6mq9+QpizmOkHMja3fPgSrK4rhuY8BXQVx?=
 =?us-ascii?Q?Va15syfAs+iVaRazk8PHw+DEPjDkBFPWYOKV69CrJBB/rTI8tye5/1Qx0Om4?=
 =?us-ascii?Q?wUb65aia5s0q0+f1dLpInSQBmHH2ZUntQJEWN87l5TPafDKpyhAOagnmwFgL?=
 =?us-ascii?Q?PKOU/1jV9Fpn9HU2uQQg2HUOfcyjUfm0tX5l+ov4ykC5hs1TsPlz/WQjJMcP?=
 =?us-ascii?Q?WQRUqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c22cb8b-134d-4e18-95b9-08d9fcf85022
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 09:29:27.5231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4t9aBFjVvvRMTZHIowDyWojUHReu4hFny2M2h2tbjrJeOA4K0jXjGlHXJOGcaE9R3NSELMNCpQA3ws4/1Eqs9FJWumtaryGIfUei0z/8M1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1203
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 March 2022 08:16, Yang Li wrote:

> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
>=20
> Eliminate the follow coccicheck warning:
> ./drivers/power/supply/da9150-fg.c:524:2-9: line 524 is redundant
> because platform_get_irq() already prints an error
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
