Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1B4A5B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiBAL4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:56:12 -0500
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:3681
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237302AbiBAL4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:56:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkAYw6iakbjxTe1H6zQTbGTWe8RZ4DRQnZREJMw+FnH5GVY/jBfq+ZSWZsfDaPWRiYeMUq97bHVV0X6EAKmvOWiU6Jh4epZaU7O+B68kX9cF1aQkNX7SvRKOn32i++sNX1EbyH8yDDkAaiX4/cHf6h0QHW1G3IsWebaSMewCT5P+UBWbd5x1J7FqSLldTuBgK75E6ioOJRNjf4W5UedaalTUGhUhLxrDAU4yW0d8z3jSzeOIGmYY5AWZAKC2I8Cw0hdH16cikMppkQd54cQ9fAS9VD+ILy1G2Op9DOAC7Vs8tPrbxaQPBARHYsvsZK1EZox+t1l9y+/UmPSO0nosRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsaqcyqoaYALpx8Yc7XCAPt30ZOW0WCcSBr3+0N7l7A=;
 b=jdPy5NpMbsvSwn4AaYVeuI2jvZ+GmdGV1OuZVBGsl1gBLOQA4+m0XstQUv8lAOVOkJRo3T2bi2rMIZe80pgyOgX7MgTozyU14NN1Zi5qC2MNAvV6UqvjfQ/QmS1x00r2WtojsHOBAhDQwFYvWYoXAbA1RMWZ/4jnmuoyjCCq2jsLO9qDYdMp2j0EtByd0dYDAGzttU/SKARRNXH6wGTkXfzzvdAA7SrVHnkSNk1ynOC4BDvs2ZYPYeQfP7R4VCABRott152mYhdGsqTRtrjafBV6adea3bM5qnNwYq1r4Dgt8C8ZNRVMYZl7cvubpQdDfwwRK/1HhmZJKzFFqNT1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsaqcyqoaYALpx8Yc7XCAPt30ZOW0WCcSBr3+0N7l7A=;
 b=IABTmcYPvroeQtEUZAzi4SUjV0/cmP3nI+5VzdAt3Q5HR9PEHXgEDSBxFOTl3p8e4tXXND13BpAbuqxCnZd+CYvU3BkzpZPzmraxPt3Hzh8QWc0M1SPOGy/Do1r+EckrDyiYzL4R/CZnap09zRU0nmDwkiW6bU6IB1lc01ioQSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by BN8PR11MB3810.namprd11.prod.outlook.com (2603:10b6:408:8f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 11:56:09 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::2025:8f0a:6ccc:2bfb]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::2025:8f0a:6ccc:2bfb%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 11:56:09 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] staging: wfx: possible deadlock in wfx_conf_tx() and wfx_add_interface()
Date:   Tue, 01 Feb 2022 12:56:01 +0100
Message-ID: <1710740.8zh8KgFqrM@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220201113303.3883-1-hdanton@sina.com>
References: <6f489bf2-bac0-8030-7ea5-6f5c12daa568@gmail.com> <20220201113303.3883-1-hdanton@sina.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P189CA0090.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::35) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce87822-fdd5-4790-c993-08d9e579d59a
X-MS-TrafficTypeDiagnostic: BN8PR11MB3810:EE_
X-Microsoft-Antispam-PRVS: <BN8PR11MB3810F62F78A40624CA897A9D93269@BN8PR11MB3810.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /uqjeSsqmzFYdHgVQa6N63RQKS38TWQZf+NyJFOiJ8ZUyN+yUx6IvvlLw2oDXy6uiMeufCqOkRbOgbHr3xv6b03EDqWhCm3g/AGWMgcfcTaCqQvqpIYUUMhK++Z+TeYZMpcQo7+pYzEKPwa3QSaVANv7P4oSRFzRAc6Ief1z6njOBPuqsXW2VyVIXHLB79ul76BjzHDkIJVNrRnS5NE3BfwgzD2a3cl7K7lexNRll/VKvC5YvliCVObMQkvqQEu2qBG6ylw1OkHgOXhCum1FjGhYzb6/x8LlJ++U9K58diRaGgDDjRw5LQLJrQ7+fNWvVP2buzEvrqEMm8aBrhEUkqh0NjsC4jmEkCEr9zkjhFZdJtOFPi0U0dubjbBBhQc5C7pMK0GuZZsN2MxDLzOM5u8TT08Opd6jX0+lmpcbc+gaYSMHNrLuoQ5oczFqzsBn7FZofkbLbhZqMMuwupRSBOL+zwKpIET3NZuaseSFR1hfvaK94JJ5j/S3LyXDi3KRLwUQT8+XyYzc2GRmYPWBGwyoolfvFqcLnIHs2viQA8InJ6V9t8PFzkaYatxbNKwRzFVAu9N69wNT2viL9A/2j8yUXVnKR8vcsnP72Z/A4RVTuHR42uuMCb1ab2T/ifLJoTklH1RxosRMi9NVLQ6bmerpruVm9Uy51dsI/AIPkA7N/RRkIGIxxuC0V//PbxDI9KWAikRxWxKY8npgGpd6TaeM20sEz/qvJPTmA1DQVi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(38350700002)(110136005)(38100700002)(316002)(6512007)(6506007)(9686003)(6666004)(36916002)(26005)(186003)(8676002)(6486002)(66574015)(508600001)(86362001)(8936002)(5660300002)(83380400001)(33716001)(66556008)(66476007)(66946007)(2906002)(4326008)(52116002)(39026012)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gNDqpPuthlN5zCAHbDZXQKBkSUZLhk0a0cTD1MznQ6xy8YrCEhbR7deVeu?=
 =?iso-8859-1?Q?0vBnHGKWbgiMYN68+CsB1YmvQq/fKe/PKZHoKKnaDonewGTHegOmIZzW9c?=
 =?iso-8859-1?Q?h0OGHnq1nZzGI2pB1y0m1Afjr8WzXdVfSB1O7P1MJnY/Z7AwBDcwMDpOJf?=
 =?iso-8859-1?Q?lTBY4I4OJ+6NHJMApO05v+7QPwnKKw7jSOFbQAxlWrBg96wyBYvA4POW7t?=
 =?iso-8859-1?Q?y0y7Pii8NI3gEp30xp+4Pw04n/z044udDhpy1uHK5Pe4Ir/LwUngA5Jqzl?=
 =?iso-8859-1?Q?W0Hq+kFmPWTqT0L1TdALQw4zzjC5vvhmGSD6/Dr+9/BR/YKrxCDr7ko8Hw?=
 =?iso-8859-1?Q?rsw/RpVqEHgGYd8J1hZRO6oqBp+OxDxrmg4uv8oeg31c7XbrVKIj6hV78H?=
 =?iso-8859-1?Q?znyLqqPvtO5NafTMKgvWWC5F1A20Nzo5I3yFjUtarhht3dQt6TC+55K8W6?=
 =?iso-8859-1?Q?cGToO2SI+Hhep+HZcnGhYBzhW2ipniODgtr/zwYB/zz643dLdZ5YVJaAMK?=
 =?iso-8859-1?Q?ue2a/GxCfctltSwa9pDGDKpOkFZMozA4CB0BBgJoLMhZyu+Cy8Jho/J5E/?=
 =?iso-8859-1?Q?JIANeNKzLYtuf5XxJUAyXnW+fwmR0ifl6MIEK3vrr8GmPK5kFFcqzWcHr0?=
 =?iso-8859-1?Q?gw/gEVDrIKRodm7LAqX4Ul2cc10Zp9s3/NNa7BS74SeNmiL0xRbZJm2OBL?=
 =?iso-8859-1?Q?B6hkbA8uOvX7JThb/08PBn3hoJqElJf7qzhvzqYH+YT8DR593zWXJ40l3S?=
 =?iso-8859-1?Q?sZMsKwg9TZppouG5lteamWXEBwRGChF23gYbDG0bBHZQF7OVnxxOGOgoIe?=
 =?iso-8859-1?Q?ogCvAUsGfiX3Yv4Gj/+Gkng+XGtF/uURw8Lz7GXit08mamBv5R0UO14YH1?=
 =?iso-8859-1?Q?GA5Q/aQLDRox8sAq+cR0+/kmLiQ9UG5jtBKP9EHIeLtSOdAh4S0fDSXFOc?=
 =?iso-8859-1?Q?mKXVxHyvxILW6jpyN8Lg4gBr0IyIdgbqbnflCRKJ+RG+Ko3QgWQXvWZma0?=
 =?iso-8859-1?Q?vCRsg6q9eJwH3fsi3uP3hxSnPlg9hzEbUJa8P3GFq7ErzS5Vnuob29C+5h?=
 =?iso-8859-1?Q?dSdBk+duydWDzX/6JG+a1dCVZ/CywZvGriihs/SmFB5jks5r+9bEKykHX+?=
 =?iso-8859-1?Q?rX5Fhkcyai+dm64PkhNhmZelpWFCCf1qT3PxVe9/vZwT4nwwmQzsdnCjTk?=
 =?iso-8859-1?Q?oYUYUR5hM6NWWwxUw8rrvvYFDAz0GoFyNhlRZT+F5oWAauUdx58GTSkqTz?=
 =?iso-8859-1?Q?wHSFoYNHNPRzldQ3q9XSisMcck+Qkj5aZPTMoagxZxtKBIfTKnPssMOjB6?=
 =?iso-8859-1?Q?2Dj5k8ODVLQaKK0s38ZQSnk3sDXUT456UIe4NVsvCEnzYPlFlbR09Im2VB?=
 =?iso-8859-1?Q?9ns2nv1a6Tq1TaHCS377IE4cmCVQ+zvU2Pv81e87GRaQrq7ywggCrd3eNO?=
 =?iso-8859-1?Q?Cydrqxnd3jwAuAQoWhNMlpiunrOq7ziVNhQ5QTt4xz5i0UTdsedV7QBi/M?=
 =?iso-8859-1?Q?pVBGQgvkJP887RJm41BegpihOJF3RQKJ64bNZkQnIBKRQINPlxXQufvw7y?=
 =?iso-8859-1?Q?TSB6GHF+2+A/c+g0jMiFsW/4jj1hTLooY2QzZtjdLCCPoiuB5ea9M1abs1?=
 =?iso-8859-1?Q?HGeJP2daRrhnW1ccdmj0sgTvnhWRk9H6MCEtFxlTQE5MZR2uO6Sv4BOmaJ?=
 =?iso-8859-1?Q?CV2PMVWS18ZDAT7fIrU=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce87822-fdd5-4790-c993-08d9e579d59a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 11:56:08.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkuOWSJu1VCD+X1YPu69AXEJSEfqKwDSmPtU6lCZu8AoxADhx5uS/ntha2DvFXOhkZx8ilKZg1/VQZOKo/iJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3810
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tuesday 1 February 2022 12:33:03 CET Hillf Danton wrote:
> On Tue, 1 Feb 2022 15:09:34 +0800 Jia-Ju Bai wrote:
> > Hello,
> >
> > My static analysis tool reports a possible deadlock in the wfx driver i=
n
> > Linux 5.16:
> >
> > wfx_conf_tx()
> >    mutex_lock(&wdev->conf_mutex); --> Line 225 (Lock A)
> >    wfx_update_pm()
> >      wait_for_completion_timeout(&wvif->set_pm_mode_complete, ...); -->
> > Line 3019 (Wait X)
> >
> > wfx_add_interface()
> >    mutex_lock(&wdev->conf_mutex); --> Line 737 (Lock A)
> >    complete(&wvif->set_pm_mode_complete); --> Line 758 (Wake X)
> >
> > When wfx_conf_tx() is executed, "Wait X" is performed by holding "Lock
> > A". If wfx_add_interface() is executed at this time, "Wake X" cannot be
> > performed to wake up "Wait X" in wfx_conf_tx(), because "Lock A" has
> > been already hold by wfx_conf_tx(), causing a possible deadlock.
> > I find that "Wait X" is performed with a timeout, to relieve the
> > possible deadlock; but I think this timeout can cause inefficient execu=
tion.
> >
> > I am not quite sure whether this possible problem is real and how to fi=
x
> > it if it is real.
> > Any feedback would be appreciated, thanks :)
> >
> >
> > Best wishes,
> > Jia-Ju Bai
>=20
> Hey Jia-Ju
>=20
> Thank you for reporting it.
>=20
> Given the init_completion() prior to complete() in wfx_add_interface(),
> no waiter is waken up by the complete(), so it has nothing to do with
> the waiter in the conf path.

Absolutely. The completion is done by wfx_hif_pm_mode_complete_indication()
(which is not behind a mutex).

> BTW if the unusual wfx init is a real use case then we can add a new help=
er.

Indeed, it could make the code better. I don't know if there would be other
users.


--=20
J=E9r=F4me Pouiller


