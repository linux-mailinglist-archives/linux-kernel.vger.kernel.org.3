Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CAD567DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiGFFh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiGFFhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:37:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1057021E32;
        Tue,  5 Jul 2022 22:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZCyCR4Dbv996TAel0gMo5VH+5Vk5nOqUHvQugLXr4ErsA6xD/TnbtcuKjoVTvM2K1I4KZuowNzGKEvZxfOLPbXAu7Mr9hZFYTgpCPdQL1ihKFM+87EZwcJ94SxkSqXRBskLxwfiyJM/pS60VQLxPJp8S5MO9vXjAlIjHGxdPqrgZtvBxLTkuENs8/VpKc8bLd3D0ZZWuqasjnUuJ/3VXzS0KuL8Exg5uvlX8GM9wCIke3U2iTlo7ZPAhVpZrjZNMaKYv5yp890rT9j8AgCyuIGHzAcI5tIY5oPjqwqXozwAOPMe+FJOK7S0xmtPq69nS6HL+b7Kyv6NPuAjRevegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3tV/3QfZgKMNXKcAAFrG3js9FthYHEO9H3CkToWcgI=;
 b=IGyBsxMF/sC5Nw/m+7AV/e2lY9tXERpbk0OIOXzZhqEtTwhI+Rg1uqEi/D5eP3q1OK4tfs8VFMyiwaRz6evTFiSERZXrA+aQgGXveHBq6BjOWkJaPDGvhHanrHZlIrj/EyCPe+vRAkVl88n9QGWJOQmvwJ4tet6msqapw3x14Orjtj1ca9Me+jZnGFzkEak7cHmWT4/PBRLHXRHX2MTd4muZHL9i8IhdO+lf33cq0uOfA06afpuaABNzBNlmrJONIgYoJ68U/KMOG6KO31m1nGqbXIA2Rg5Iz1k1ZpKmmbKfooKfktWFS6umqbhSC8ZBuvoeh+dyAhDSGgFhlU8olA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3tV/3QfZgKMNXKcAAFrG3js9FthYHEO9H3CkToWcgI=;
 b=HUyOR9CUjQ6ImBiuOJ+ausYOuiCpHIwDof+EkFP0uHgT2LPxd06uEiNvleXIkYHQP+s/I+ldZTXkZsiZGlQLLa6elJv5Pt0QBa8c+fu1HGWjIUFZnrP39WH1ukDvNAq1SG4cfQGlHVDdkjXDjAQNzqT34TsoKqfmQZkPX/saCyY=
Received: from TY2P153MB0238.APCP153.PROD.OUTLOOK.COM (2603:1096:404:e4::23)
 by HKAP153MB0355.APCP153.PROD.OUTLOOK.COM (2603:1096:203:d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.1; Wed, 6 Jul
 2022 05:37:18 +0000
Received: from TY2P153MB0238.APCP153.PROD.OUTLOOK.COM
 ([fe80::71c2:9c27:b23c:5282]) by TY2P153MB0238.APCP153.PROD.OUTLOOK.COM
 ([fe80::71c2:9c27:b23c:5282%7]) with mapi id 15.20.5438.003; Wed, 6 Jul 2022
 05:37:18 +0000
From:   Shyam Prasad <Shyam.Prasad@microsoft.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: [EXTERNAL] linux-next: Fixes tag needs some work in the cifs tree
Thread-Topic: [EXTERNAL] linux-next: Fixes tag needs some work in the cifs
 tree
Thread-Index: AQHYkLw/nkY32AlJc0u/i8tN8fVyoq1w0uug
Date:   Wed, 6 Jul 2022 05:37:17 +0000
Message-ID: <TY2P153MB0238EBC99422B2008BA0916C94809@TY2P153MB0238.APCP153.PROD.OUTLOOK.COM>
References: <20220706080615.11c5ede3@canb.auug.org.au>
In-Reply-To: <20220706080615.11c5ede3@canb.auug.org.au>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f7e702a2-baf7-4740-8692-2cc9beb7bc84;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-06T05:35:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d589d84-f621-4190-48d9-08da5f11970e
x-ms-traffictypediagnostic: HKAP153MB0355:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjOum0UIRN7gkraQbXOtt0K6rOZxRoA+RG1Ol/z4oseEjRfdfVnsog/SHKbOrWzrTfWwwkTnl2SMqYAVcfsVC156zM+83T2NKm+x5mPp8Fx/3Fy5b5DfeglANhgwlapcw3g9xuAkRj0YN8DkSIpyHguW8PEv+hBkE34gmF27rHyF0yvfime0x1r1SewsTD6f0eXhsv80tAvkABSZXmcwm/pp7voMs5mBMa8qd7LWEjkVj6DXqXSlAYuHraYpVTYQjIzXH9/2ckpYxSdLPjqHVjPXJvRPD4rLo/vjNHpdAamecOQqma5OYX5Ge6dA1Oih7eN1Y/LwMWqPKccuuwdQwPKM1i7OK/yH8OpygiU9Sl9vkuE2AIyN77k6e4rub6oNN/EStrtBhg+8+P+wPq9W5iuLElAaVYhEwS/vOHulkKbFNUYF26KutbELfC5VZQgv3gUDgKIIDuruc7CeXtCzYxbdCZ05j22aNlGIYUimWZGdmDgSpZnEHQnEm75pw0q14Y3CrPu+o8JlOs1e2SadfyembqvJHc0Dv67DlaeY3RdZ/wBNnJxWpEUgxOPCMTGw8S4eLz66reJ3azeZ+pzWMD1u02a9lmC7A0eenDqKAgPxZu3xxWDEwaY3x8Za7KGQVQG84JtQLe3wfvbgp1G2f9FwRA8LutMFhf/KZez3UMvdlqe23YdYcvpolFH/pLholQwYurRMuaVrie6oBVAtUBn2eWQyUy/oPcWFb6xtvGlIN///J+owqTb6KDxK4beb936OzZmLJEcsguGQiadViLZvYIx1+puS0rfnlgmJXMgBEBNkfzpuFiOY+3dD2X/QN88BGEX87CI/zqe5epJdx6ua/k/eG1a2LbUrJWwr9YfBe/CH4N8P6FdpN5okclfJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2P153MB0238.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199009)(316002)(38070700005)(55016003)(82950400001)(122000001)(82960400001)(41300700001)(53546011)(110136005)(54906003)(6506007)(38100700002)(10290500003)(7696005)(8676002)(4326008)(66946007)(71200400001)(2906002)(5660300002)(83380400001)(66556008)(66476007)(64756008)(76116006)(66446008)(86362001)(478600001)(8990500004)(9686003)(52536014)(33656002)(8936002)(186003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j9NyCW6Ozg7wyKpbcCo/w+wKHgyLuB20zGNuYmKs/aC30UuxHen+3Ad32o/5?=
 =?us-ascii?Q?B4U9SNmMI1hGqU8xC5kEIdk8VLWn8gvyw0SuaBAJYa6gx9a6TvmTb/F8Lc9s?=
 =?us-ascii?Q?zw+uoqu3jmzjFNwxyEwguhsY/N2VJW3aeclqumwdGUH1PJZTislTPL8jCJ1l?=
 =?us-ascii?Q?d/dQDYf8HcLg3K+d9u8vK5167FZThURmtWgvtmQ36U33+a2UAYlKHNHFXBVz?=
 =?us-ascii?Q?NVUswIokItUiU9adGTav8kvzBTegGdkworhds4WUQ5SumclF0gWJ/80RMHzE?=
 =?us-ascii?Q?h1+trYqeaO4jETfZXIgYDbjqIMNkoJT2ekuV30hldrQpK+6Hx/EXkFYZk261?=
 =?us-ascii?Q?aGNuSyBxGOZjAjLz73tcl4cjflpvB0n1EMb1wQFb4msblxJtaAEAQ8Z7/FRz?=
 =?us-ascii?Q?+h1aBXQHtzMrYp0rpHRW8C44AbGZh+7IW3oT1l12PLsCuQCFQONEt6sMHroK?=
 =?us-ascii?Q?lBTz7Iozh7v+1btdfbcQgjSOAXcuXAUQTIZBjm8jfMg+BHChaN6Fc56bVsNg?=
 =?us-ascii?Q?WI+/h+fKJ/ZiR1gX4m/52SGwKK4bHN/os4JFrJqq2ySIZkJpHTyyUhRc+bl1?=
 =?us-ascii?Q?CVCtzauCAJagWQHkEsBVFU44Vem0akCcHranDeJ/s40v2qHHoXg0V7rOnEw+?=
 =?us-ascii?Q?2SKkPowvbES/i7PXOSiG+7eMFZU5PuU6MSDHcROqKjBgz7rkzbdCvOIuv9fv?=
 =?us-ascii?Q?Bjb3ZawP+g9xkMxy7iCHuDF7PLZeli4+ZxE9WE6WfpJpdcCKrIQD8+xY39W+?=
 =?us-ascii?Q?1dBPafHMibk3NWFwZzcHWs0WHqxfT1bv3hVczHyEi5F0vKzC/O8z/b/VwmEr?=
 =?us-ascii?Q?RgmJIlzFI2XvLApxT94qjlaXWo5dfmMTMyQXgrcxtU6kTNKIw6Ut4Y4OUfqg?=
 =?us-ascii?Q?srtYsOBoh5TZ/wI/BsnuHtqNYaYEZ70F0MjIXcoOBZD4eVqF3nyKvbcehIKf?=
 =?us-ascii?Q?eXKU0r/gofreQjn5Ob6tTNw8j0ufV2z9/v20+cCNCLsO0SirP+x3cqALGhFG?=
 =?us-ascii?Q?PGNQRz0LHs4WXYgwG/iRg4yLtZ+3NdOWqf8ROAqc/8V/FEdTnNzqWWr1ztN0?=
 =?us-ascii?Q?+1xGVPE7v37Y8MSqAfMoIAy+Ayw+GUvqTUN9QMD6CajOfpnroEI5K6zLH0uZ?=
 =?us-ascii?Q?SMHDPAZCUTfRShWd9eEdYKV5PMGQRd3+gIWj4u6xY24tw+mtISF57E9AflOZ?=
 =?us-ascii?Q?o8xGoR3orycekpUA4Id9bCtXRtsVdbk6ZGJ0CqYo3Mv9sjQiUDwjyOG0gveK?=
 =?us-ascii?Q?yQce6iq4lCJaHTwk0MSF3NF5byjRUuTqTPBX1RJBniOsb3v5LdaSG9U71ooV?=
 =?us-ascii?Q?E+xF4pTpXEwfofpDm5eFRPHVFzTaYjClUWgnwvGz5epWum3EkP7H/s2JJ5Of?=
 =?us-ascii?Q?1K31sPqae+ParEsAxPSTqy08F4BEWJ5HoX+adO/Svtef2X0g3rRvrxqnX8yZ?=
 =?us-ascii?Q?RFqQ1mFqF1n1CS6xY7L+2FgG04U9ZchSmGIiaOX5J4rcg6hB2RI6yGyB61Bu?=
 =?us-ascii?Q?P/mluIBbiSYssgOc6WzN5Ax6tmvSK3PT/O3aPZukbZNAA7APN1Br0vrk3Flb?=
 =?us-ascii?Q?LaBS8OhYK5+Gus2MePCewlU5IBQL30Xnx0+BagFw1fSujj7RO2wbZqpPi0wC?=
 =?us-ascii?Q?y3mrSPuBGA9rbctF7mmg5CLZzM844EFvF0MyV9Y4qu9N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2P153MB0238.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d589d84-f621-4190-48d9-08da5f11970e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 05:37:17.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCH6Rb1ucCKb2+ktj8ipGYa0aFNDW9jkOzqkykVH+aSowPfVj4pbbzJecj/ZEWhIMfEAzaIfzCnWwyc/AZ4YTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAP153MB0355
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Wednesday, July 6, 2022 3:36 AM
To: Steve French <smfrench@gmail.com>; CIFS <linux-cifs@vger.kernel.org>
Cc: Shyam Prasad <Shyam.Prasad@microsoft.com>; Linux Kernel Mailing List <l=
inux-kernel@vger.kernel.org>; Linux Next Mailing List <linux-next@vger.kern=
el.org>
Subject: [EXTERNAL] linux-next: Fixes tag needs some work in the cifs tree

Hi all,

In commit

  37c1ad516f2c ("cifs: fix race condition with delayed threads")

Fixes tag

  Fixes: 37d488b3d38c ("cifs: change iface_list from array to sorted linked=
 list")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: aa45dadd34e4 ("cifs: change iface_list from array to sorted linked l=
ist")

--=20
Cheers,
Stephen Rothwell

-------------------------------------

Good catch. I must have used a different branch.
Steve, can you please fix the SHA1 in your branch?

Regards,
Shyam
