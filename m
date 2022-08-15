Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA2592C75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiHOKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiHOKYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:24:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A2DF7C;
        Mon, 15 Aug 2022 03:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnaBSFB9k+bb3SA8mIpYH9SRL8xCFd4XH4B2k3mRX/BWN0AjYwta1+T5OMthIRb6oImu0jroKW7XbmV/oE5TvQ5/qjAe3202U5xy94EwwxgL3tdwidbYuxmW8M2jfRz/EVftf3sOP+SCfUi4VlfhYWVznZNWlAZTWtnae7jbq0grCSZkVugymtNE0C89oLC++2U3g3fS7BvwuaBO2IzBD52i0mWhz7QiIHVaXs+NtPEqi1yjTGYLgtoeYhsNIN+Njxde03pL3H7T6hTnOpZmhxQ93ZTgk5fBCdR7tAreJRJkRSMjk2iSF8OOSO2AvZfWB6KI/H+TK6z/XBdyHCxeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t67fWgUcSBjGtxsKXBsCPrMw/+quNcFL/lmfhkP8fhA=;
 b=W+U3pMULeziszEYvV/6fGl/1Uyd5dS3c/AfSzWc1l/UlQ6gaCNr8wZo8oNLvKk+eH5l0acjX2Ng5M/E1nQHaSeL4CBIQkFwFxGwJuwTVCWqbjtkrgIAx1CPTIfrNFEbhBFBSoGZxo4fDZn3UZGu1idr0M3eN/JS/BziAOyYhQxTo5YFpGtgV65PQ0oelUdYjW291qE0od4Cxo5cinxN1l6/vUxGumZrKk03Xl0Xpq7VyIeHyffPtZigOuJ3xWkDNEeaQCN3AaCDT3v6k9xzzy+QNOzgf6L7t6APOguraaB8eP5NcbuDstwwHYXfXFrHIrlDyxhPwFTGSgxc9hNiWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t67fWgUcSBjGtxsKXBsCPrMw/+quNcFL/lmfhkP8fhA=;
 b=eRWKmobIoyzMnWkpJKSYdNQOFyTMibu1LOZtIEs+qJe7tNkt/aesVGsa3nbmxs7RBrZB0hAPZz0zKndSlXq0YVSw5uZdubbnurRsSv3nr1LwtzExS9QIXyJVr6smiWvP/aHVFHbxU36MJ1bxaEF8gqeOjdNBoXdM3+hi/v4uCFk=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by MN2PR03MB5278.namprd03.prod.outlook.com (2603:10b6:208:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 10:24:02 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%9]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 10:24:02 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "derek.chegn@tw.synaptcs.com" <derek.chegn@tw.synaptcs.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>,
        Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: RE: [PATCH] Input: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Thread-Topic: [PATCH] Input: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Thread-Index: AQHYpXJ8vMwPlfHzdU24QeILtzZx+q2vs6UAgAAjVzA=
Date:   Mon, 15 Aug 2022 10:24:02 +0000
Message-ID: <PH0PR03MB5848B9DEE9DF391C1A79E72EA3689@PH0PR03MB5848.namprd03.prod.outlook.com>
References: <1659336403-2546-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <202208142212.QB3fvm5l-lkp@intel.com>
In-Reply-To: <202208142212.QB3fvm5l-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01ZmQzYWMzMC0xYzg0LTExZWQtODJkNi1mODU5NzE0OTljZGNcYW1lLXRlc3RcNWZkM2FjMzItMWM4NC0xMWVkLTgyZDYtZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSI5OTYzIiB0PSIxMzMwNTAzMjYzOTc0OTYwODgiIGg9IjdBaFcyakU3a3p4NDVJRTJBYytSOHA2QXpraz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cede410-f915-45a9-18df-08da7ea84647
x-ms-traffictypediagnostic: MN2PR03MB5278:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+BA+0iioZpUywBvsZQS2slpNG/rmzMHVMZ/6FqQL08417NL27X6y5s95w6SJ/vOtdSfPvvHf1M3/cmjyFWyHOBMM83Auej0QugB1IGAsaS2NUec8s3I89J76AR9tVPyHBUdbFg7od/ygUMSdNTD+gxi2HHyTKsGb3pnpWg/TpGw9kSibEiz+pjlG+Tn13qpMS/Wvzg+H3wCQ0v9uBzIcvJ+do+cOi5gtF9dCfqM8NbcqJ6Q98vgc0eRvlRSXcO6lldZ/bqjpv/TNorVIKlnntRDzmxPTTLyFVK8qWGsWY+7naBpHgIlL1gDClzZc+DkCE95l1gVg/QveX4JeG7NjPf6expJYWu1BWLGGMuhCY3AUEL9WSY7tkXYJU15RH90RhX8tsLbrieMK+NuectZzzFF3ByR9jfo8GdXEGxwcM6nTGYTMl8LWjMUMgmJgujYGMI+u8Y5NNWm40KDfwvrE5qjgBYSY+4DHH/C6rPjysYMxsKVz2LJExCc+cURDFOHnHEx7dSrMy5bDrFkzvz0OcVFekUf2RY7m278ZuwUhk/hs7P0CvPNUuiEhT9NnFk9lOdaRO/ndr9mKy9fUnt7ArB3vkySwxAXO8Ye8hnhjBIDQmXU9aBCzWk8skA8d/2yc0vwH9QZWpuEA6cgN8kvSMeTa5ronoGHQ6bT5HNHI/Mso6RKKUwLKuwyiw4bBanANFQtFCrlH+RQChMP7kPowFpc135JNcdywR5+ZR2gD/23O8WRpjTwjydV1QGmbsvrem3M+5WLfz47GnpMkmzpkN+fJsCFRuu9bahVRC+cAXOr9xPSQ3YDCA9X7jYjKl23aeNa8XmZRo5o/iA4GwZI+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(186003)(38100700002)(41300700001)(71200400001)(53546011)(86362001)(9686003)(7696005)(26005)(55016003)(6506007)(83380400001)(54906003)(110136005)(316002)(76116006)(4326008)(478600001)(66946007)(66446008)(66556008)(66476007)(33656002)(64756008)(966005)(5660300002)(38070700005)(8676002)(52536014)(8936002)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V4MFUc2P0ORhsF0RzcB3zz58rOvv/uNuhwJQ7zrU7v+/Akl4jmq9X2s8rNez?=
 =?us-ascii?Q?6MfDt0P+ruqTAC4mu/LShQ2nY6ZPnjaXr2sI+kQAGHOIoXQRYd500A2PfHv1?=
 =?us-ascii?Q?JA7JbRDOuGnlg738vtORf6nq8eWo5Tq9YhnrN618tyjBW9bevVWlUsmNVekF?=
 =?us-ascii?Q?Jwmn5B1FZWbxterdI3viievjkRcmTQusafaxiF0CUl7E7vfbe5yAkMVhR96+?=
 =?us-ascii?Q?zgYYyF4o2jaY5tWLxhKpgnfYdWJ0wm3JjoPITpkzG7+Wmi94o4SVBu1RVCpt?=
 =?us-ascii?Q?LWbrXUNWaZFTZRP0PYUB9J1Ts4cHj3hi2yWu6mW9jVoT9kILuL+ePdk/vYzZ?=
 =?us-ascii?Q?LsRPomNNst2Ls+cUfb2wKPz66u71sr3DESjGNq4NQsC5tIARYrXf4MAIw6zG?=
 =?us-ascii?Q?bpEe0eMB4VwTT/TKqB0HubN8mcx0gpRuHYVOIF99vWXxZJFaXbZQZmdnZq1V?=
 =?us-ascii?Q?GVtYnxci9wK822LVQzML2GQbJ1WNEB5iD06mS5nAOXgFLQlLNrHg/0jjhhJ7?=
 =?us-ascii?Q?TJ2KwMdz4URFiwkpybQtbz51I7dYcmBxRglkbrc/H4gvMNzMyDx6wioLq9Op?=
 =?us-ascii?Q?YxZ2bqKKfpEwqEipieUP7vR/F/x9kCGKQmhAwdr7VgvbcU+0EbJFAVJcy0Tm?=
 =?us-ascii?Q?LuRKTxLiysiOSAwB07urCXujIJAIhDuTzpEHL44sCKWHbXUdQ5k3GhPrrPSs?=
 =?us-ascii?Q?lJWyLDp40O3unVQ2je6iNWVGHnUqlmP6x/2va0ilK6owDEJZOWe6RtnNo2qI?=
 =?us-ascii?Q?MggR8HHM3hFyfJuknBlAxhdX3ppTkw9hHp0Jgj6JVpvHP7OQqzJE6f//kSS4?=
 =?us-ascii?Q?tuE2WlUFb4LwZd6VCjY2j9hyCA4LpzQ1RmVxncX6uaXoS5HkhBLV7ZxOIpXe?=
 =?us-ascii?Q?pQkspLOQPYIKOH2ZRaiLn5qF9CbWMwV1uj0v6vski3ipL91q+lI9ftHsCfRh?=
 =?us-ascii?Q?7s4Cey5+SJqTkRAKEv6G5OxfyFROgkS27GUzCGq6B9hkmqDf8dTT2imZsNbJ?=
 =?us-ascii?Q?7g1Sa4c3ZfELHqSAVN5QGRHPODxLIVkkZ8en8esTCBtiQWlk5nLbAJnYrD14?=
 =?us-ascii?Q?BqUOrHiN1XHFKCXBQ06Exd/rmZGD5cXzR6Tv/1l4twBb5AnXcUZJX8xyAHBy?=
 =?us-ascii?Q?wG1FuFKmAQqqML4Pe+mYMGqSw7Ru2HnwRS2gLBsQ2/re9wv2Bf7FXP/XEeha?=
 =?us-ascii?Q?snS+YlPJ84Wv+1+GJ14GtdhsRT/XobZlVLaZTGl1wUXaMzxWwc/VP27/YeJH?=
 =?us-ascii?Q?pGkOIA8Q5pEU5idymy7jtemdh3O1QQkKcRk3gM6A9XHabkHeIlZyakUFb0OC?=
 =?us-ascii?Q?/hv6IS5NGDlO4oYXKyu2Lybs18wpF3uKmvYkxXsqvofRXcJtVWfSNd/82UGt?=
 =?us-ascii?Q?M6nVnpIotu50EO0bw3k/HrdcymwbMDXSO7k4V8F8k38U1DzWePtLfHO8DVDo?=
 =?us-ascii?Q?xET9/kL0yx5JDPr88I4u8Gw9XDMFwTqqHBGlFttpu7MdXJfjR6LA/GYKvPYl?=
 =?us-ascii?Q?5gYOp0MoVFpFMGdeiDDFKms0m60nMoj8NRReEGdZeNAUAZPN2Bf8Cf8NTV/4?=
 =?us-ascii?Q?xWAmvF1vTpurx2sr/Oo98P0ClZyUTXffzMiLTddo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cede410-f915-45a9-18df-08da7ea84647
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 10:24:02.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SguECjmz8KdiXDRS6WvDFMD5RHzVCw32W+P4SJyiuCfS2777Ckuu5PiLzPAenUGgKtCHj6kYYoqmDOAMhOt7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5278
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
	Thanks for your information.
	I will fix it on V4 patch.

Thanks
Marge Yang

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Monday, August 15, 2022 4:16 PM
To: kbuild@lists.01.org; margeyang <marge.yang@synaptics.corp-partner.googl=
e.com>; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org; linux-kerne=
l@vger.kernel.org
Cc: lkp@intel.com; kbuild-all@lists.01.org; Marge Yang <Marge.Yang@tw.synap=
tics.com>; derek.chegn@tw.synaptcs.com; Vincent Huang <Vincent.huang@tw.syn=
aptics.com>; Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: Re: [PATCH] Input: HID-rmi - ignore to rmi_hid_read_block after sy=
stem resumes.

CAUTION: Email originated externally, do not click links or open attachment=
s unless you recognize the sender and know the content is safe.


Hi margeyang,

https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git-2Dscm.com_docs_g=
it-2Dformat-2Dpatch-23-5Fbase-5Ftree-5Finformation&d=3DDwIBAg&c=3D7dfBJ8cXb=
Wjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3Dddk_91asmhyAjxFmXHNIQZ2mVcW0D_eq4tb4=
409nZ94&m=3DnlgT-3IvgCsBjboEk2pLpv9NTbEPA_DBxNCtUS1pfsH-sX4rFp4vWip9TKD5bZg=
D&s=3DZPw8UPZC7QjdIlIk0NorBFkiiDexM8yXIDSCUXyvUoI&e=3D  ]

url:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_i=
ntel-2Dlab-2Dlkp_linux_commits_margeyang_Input-2DHID-2Drmi-2Dignore-2Dto-2D=
rmi-5Fhid-5Fread-5Fblock-2Dafter-2Dsystem-2Dresumes_20220801-2D145006&d=3DD=
wIBAg&c=3D7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3Dddk_91asmhyAjxFmX=
HNIQZ2mVcW0D_eq4tb4409nZ94&m=3DnlgT-3IvgCsBjboEk2pLpv9NTbEPA_DBxNCtUS1pfsH-=
sX4rFp4vWip9TKD5bZgD&s=3DqM9oqLWIocmeg-um8b7KrQ7lKvYhttRHtsckOGgVlpg&e=3D
base:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.o=
rg_pub_scm_linux_kernel_git_hid_hid.git&d=3DDwIBAg&c=3D7dfBJ8cXbWjhc0BhImu8=
wVIoUFmBzj1s88r8EGyM0UY&r=3Dddk_91asmhyAjxFmXHNIQZ2mVcW0D_eq4tb4409nZ94&m=
=3DnlgT-3IvgCsBjboEk2pLpv9NTbEPA_DBxNCtUS1pfsH-sX4rFp4vWip9TKD5bZgD&s=3Dm7w=
3BRuQqsSi92tD7Gu4x5PdJHLoevCdc3u2UZbKD4s&e=3D   for-next
config: x86_64-randconfig-m001-20220801 (https://urldefense.proofpoint.com/=
v2/url?u=3Dhttps-3A__download.01.org_0day-2Dci_archive_20220814_20220814221=
2.QB3fvm5l-2Dlkp-40intel.com_config&d=3DDwIBAg&c=3D7dfBJ8cXbWjhc0BhImu8wVIo=
UFmBzj1s88r8EGyM0UY&r=3Dddk_91asmhyAjxFmXHNIQZ2mVcW0D_eq4tb4409nZ94&m=3Dnlg=
T-3IvgCsBjboEk2pLpv9NTbEPA_DBxNCtUS1pfsH-sX4rFp4vWip9TKD5bZgD&s=3D7qqbxHlAk=
9YvxOzNvBC00oePmwYwpvxsoq9bF7lgg3w&e=3D  )
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/hid/hid-rmi.c:263 rmi_hid_read_block() error: uninitialized symbol =
'ret'.

vim +/ret +263 drivers/hid/hid-rmi.c

0b2c7a897378f1 Andrew Duggan      2017-01-05  188  static int rmi_hid_read_=
block(struct rmi_transport_dev *xport, u16 addr,
0b2c7a897378f1 Andrew Duggan      2017-01-05  189               void *buf, =
size_t len)
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  190  {
0b2c7a897378f1 Andrew Duggan      2017-01-05  191       struct rmi_data *da=
ta =3D container_of(xport, struct rmi_data, xport);
0b2c7a897378f1 Andrew Duggan      2017-01-05  192       struct hid_device *=
hdev =3D data->hdev;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  193       int ret;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  194       int bytes_read;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  195       int bytes_needed;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  196       int retries;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  197       int read_input_coun=
t;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  198
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  199       mutex_lock(&data->p=
age_mutex);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  200
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  201       if (RMI_PAGE(addr) =
!=3D data->page) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  202               ret =3D rmi=
_set_page(hdev, RMI_PAGE(addr));
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  203               if (ret < 0=
)
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  204                       got=
o exit;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  205       }
30a3df7ece6145 Marge Yang         2022-08-01  206       if (ignoreonce =3D=
=3D 1) {
30a3df7ece6145 Marge Yang         2022-08-01  207               dev_err(&hd=
ev->dev,
30a3df7ece6145 Marge Yang         2022-08-01  208                       "ig=
noreonce (%d)\n",
30a3df7ece6145 Marge Yang         2022-08-01  209                       ign=
oreonce);
30a3df7ece6145 Marge Yang         2022-08-01  210               ignoreonce =
=3D 0;

"ret" not initialized here.

30a3df7ece6145 Marge Yang         2022-08-01  211               goto exit;
30a3df7ece6145 Marge Yang         2022-08-01  212       }
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  213       for (retries =3D 5;=
 retries > 0; retries--) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  214               data->write=
Report[0] =3D RMI_READ_ADDR_REPORT_ID;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  215               data->write=
Report[1] =3D 0; /* old 1 byte read count */
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  216               data->write=
Report[2] =3D addr & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  217               data->write=
Report[3] =3D (addr >> 8) & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  218               data->write=
Report[4] =3D len  & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  219               data->write=
Report[5] =3D (len >> 8) & 0xFF;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  220
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  221               set_bit(RMI=
_READ_REQUEST_PENDING, &data->flags);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  222
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  223               ret =3D rmi=
_write_report(hdev, data->writeReport,
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  224                          =
                     data->output_report_size);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  225               if (ret !=
=3D data->output_report_size) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  226                       dev=
_err(&hdev->dev,
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  227                          =
     "failed to write request output report (%d)\n",
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  228                          =
     ret);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  229                       got=
o exit;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  230               }
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  231
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  232               bytes_read =
=3D 0;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  233               bytes_neede=
d =3D len;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  234               while (byte=
s_read < len) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  235                       if =
(!wait_event_timeout(data->wait,
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  236                          =
     test_bit(RMI_READ_DATA_PENDING, &data->flags),
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  237                          =
             msecs_to_jiffies(1000))) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  238                          =
     hid_warn(hdev, "%s: timeout elapsed\n",
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  239                          =
              __func__);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  240                          =
     ret =3D -EAGAIN;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  241                          =
     break;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  242                       }
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  243
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  244                       rea=
d_input_count =3D data->readReport[1];
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  245                       mem=
cpy(buf + bytes_read, &data->readReport[2],
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  246                          =
     read_input_count < bytes_needed ?
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  247                          =
             read_input_count : bytes_needed);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  248
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  249                       byt=
es_read +=3D read_input_count;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  250                       byt=
es_needed -=3D read_input_count;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  251                       cle=
ar_bit(RMI_READ_DATA_PENDING, &data->flags);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  252               }
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  253
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  254               if (ret >=
=3D 0) {
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  255                       ret=
 =3D 0;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  256                       bre=
ak;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  257               }
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  258       }
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  259
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  260  exit:
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  261       clear_bit(RMI_READ_=
REQUEST_PENDING, &data->flags);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  262       mutex_unlock(&data-=
>page_mutex);
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07 @263       return ret;
9fb6bf02e3ad04 Benjamin Tissoires 2014-04-07  264  }

--
0-DAY CI Kernel Test Service
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__01.org_lkp&d=3DDwIBA=
g&c=3D7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3Dddk_91asmhyAjxFmXHNIQ=
Z2mVcW0D_eq4tb4409nZ94&m=3DnlgT-3IvgCsBjboEk2pLpv9NTbEPA_DBxNCtUS1pfsH-sX4r=
Fp4vWip9TKD5bZgD&s=3DiqPMCIB5YYZdhSl4lFrcKmwdNU-RU2DL046Inhx7mPM&e=3D

