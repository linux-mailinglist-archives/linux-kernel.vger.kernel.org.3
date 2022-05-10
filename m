Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5393F521DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiEJPPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbiEJPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:14:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC75199490;
        Tue, 10 May 2022 07:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKT7IuXLio383topEGUOKGNySrdgd39T+5MxCuNTqUgkoZor3ISwupvighCAgsYVx506sfI1Ygx7Mqe+F9NMDXCnYiao2OcitnoBgv5nMMly1qDaiEb/VBjH4xaY0gvYtyefl1lCSzuS1sXOsa41ctK1FfUtlIK2duqDioSyciywrjSyrd5HNxZYyEURJuai/3lW4+o0cVOcqUXYo7gkpDeho85s8jTRybLqnOhtwFVd0i9oLR8jNg6QRWxM0s8j5thS+EOBqtXJ3oOyttOiLF/7AD84vWgSvVKUixdJNmuGf6RhxqbavRbaNu1jCTA+0a4cVwkIPrh36lOTX5f/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV3onSRfAJC6+Oa1dlRSLYhRsHS9dhYQwaHTJpO40Zg=;
 b=IpNZQinwYyTh6Whpsx08xaDMx275eDPBFXmpJcWJyLbgb/norXYbYw6a5hoeCSMZYE7gcohPp16U8+7NtQJ4NIhFGfp9KiMRq9P1poVP3NgyXynQOI6zkvGJQ1wO1LWtTgTg+lMt85cbHmdXv3W0IFB2vagwR+hxgKunocrEtbUMX1V7OvqH28Ayxfs0OH+QpocefQVZPrQylXZk6VCHj0aMZk9nEzfMX0E9uB7qI6+YUWu+ImVNq+OaVmNo1HZ6b8Dkl3n6Vx7T3ctdycPkCrigvI9/ahNGaXlWsuDZQEIK5AiY32kmggJabEMcrP6cDL31ZM183zQdM2omNRGAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV3onSRfAJC6+Oa1dlRSLYhRsHS9dhYQwaHTJpO40Zg=;
 b=zpMuIVYlRDQAL+mPkVvDZY26MYtyoY6iQl3L464qYNujFfplxgKQu/pPgOrGcYP2FaPsQs2fMQeJMR0rJ1XUo2AHSHUUD35OumwqLibp8PgxvUHy5dQ7wUgq+hqwaLk79Z+YEb8AEbji0AZOk9BzkBWXn86BnxNcxAzdhr1ufPg=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3167.namprd12.prod.outlook.com (2603:10b6:208:a9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 14:49:13 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:49:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "erhard_f@mailbox.org" <erhard_f@mailbox.org>
Subject: RE: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address
 sanitizer
Thread-Topic: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address
 sanitizer
Thread-Index: AQHYY6+CumXwSyvUc0i7ZZsU2I7mLK0YMjcAgAAARLA=
Date:   Tue, 10 May 2022 14:49:12 +0000
Message-ID: <BL1PR12MB5157994820103C599B3E2565E2C99@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220509141716.1270-1-mario.limonciello@amd.com>
 <20220510144656.nxbayvxdfcia3ykm@bogus>
In-Reply-To: <20220510144656.nxbayvxdfcia3ykm@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-10T14:47:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=30bef2b3-380c-4ddc-ae1a-9ce2292fd1b4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-10T14:49:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 68656751-7e6d-4b74-b219-8aaaea33c741
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bcb5386-4f47-437d-f4f9-08da32943fa0
x-ms-traffictypediagnostic: MN2PR12MB3167:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3167BB4078B90FC41E3F8A57E2C99@MN2PR12MB3167.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJg0Tez6shdcccyflp4tgZbvySHXa0a3NOHLFHH0uUvedWYK4oX16A3H/v/+XUloSVMCL9ds/xzj5r8Sk4zwDpRTiY20OK0s/maXwQsoG7upR1O6XumiMF9UdFNptg5fFzInfDgEG96HUL1xkNM+ZgdKK4MvuXGkr9G+zw06v+AMFDJsrDFDMO772F0DZCnSE856vpvgf+YXQA94BtGZvqlEUry/li0+Cw38WFZ4XzwTLofODYCK04+ql9hEz6vbVtOG+03GXSuCniNF9l/boGT7mZhARlEoDM2tdU5alUXEZ9QDZKcRjc1ID33M6fyK6A4a35Ozxd9uoIAl7QpcMnYE8EcjG+DcQ4SeDhJd80gZfWdXTcdUQ8Lr/ktPWIiDWGPpKoux37NeXeh/69kXmY3VFVDI5h2gWRQTa17Po1F+dweJ+TDw9I16nR5X4yaMT6jWdbZguyaaS2A10kDb9c7cP3oPm+DGpE4SDjG9BwHRQY0wm+QJnMQOlOtH6NdRLeHsOuuTq6YN59VOpaGEexLgPEaYmuPLSJrkYcMH1zotqtYklKP7gNoTzSmzbVKiTz/DzEJ4IIpVKJJ/5G8yFHaDL8GaSaQ+EPaFXPgoV3Dk0xfKAHcfCU4kKq8k3Dg7nVaMQiDq19E3EgQEy9/GXDLAFx3bj6ebWiiIqxmO0kdSc4VHPlVYjsbMwQC12zFE4YL7ABb2Jg7lBj9WJ5IuIvgIxzT/UsSYfPgB3H33TXkCfdlcBquhuJ+c5vAmwfJbuDrJCKZLeqmBcHelSoojyLIEQu9y7AuY2URQ5kjFlzD0BwUd9Zhcacq/J8A5WkFb9Lf+V7pkZLrwgF2Wpoxetg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(64756008)(66476007)(54906003)(6916009)(86362001)(316002)(4326008)(66556008)(8676002)(66946007)(8936002)(66446008)(53546011)(6506007)(122000001)(9686003)(52536014)(45080400002)(26005)(7696005)(71200400001)(15650500001)(2906002)(508600001)(38100700002)(966005)(83380400001)(33656002)(5660300002)(186003)(55016003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?65BBu4NqqtzqVRlK7M+Zkm8ZNFuSdtyOOUMYL73n7rYoSgjsf5+Yjbn3tqZ6?=
 =?us-ascii?Q?fm/Jsqb5lZkCh1i4yZALACAl+KvpkKDitnAU21uUjywxrEB5jHHB3kRn6452?=
 =?us-ascii?Q?tGPxXNZRLY+5RjwMbHpCWsyfcS/QqX5cIOtMTs9eQH3qGC8vvsMl/vAu7EF8?=
 =?us-ascii?Q?nQ5et7r7FkR5haadMBAa6NxhpQyxDSTcvDxa+7hKOCh2Q+BEriwrHM98YiD+?=
 =?us-ascii?Q?P0/wbF8R6hjqHZwXInzx5iHYg1JzxJQw3SwmRZjIZkmQSWexCrqfKqKqyaUl?=
 =?us-ascii?Q?buQG/3mGUuDqbqQgtwXdeVJjgpOzBN+De1fsPxOXm8J8jTMf87sN7jf+NSG2?=
 =?us-ascii?Q?efcNHTMWmFuWwPKPtn01Uh14G1BE4IOAmkAAowxsI0CWb1IjPCj+K/aYxPbV?=
 =?us-ascii?Q?v6STyy6YgPXcG2j9A8eYPR3Au1AtCZVR/guZ5ejOCkGAG90cHQhulkJRytEx?=
 =?us-ascii?Q?YNsiJLo/ffSPjZ1jpDa60HIvpImis/matjGBDcLf8le5CogvtsKEjsxTWeVg?=
 =?us-ascii?Q?GJqgiD5EoxY6Esd8lFgVjQUuNrgQunPDVreumLv06vbtB3x54w+UqecSCF1Q?=
 =?us-ascii?Q?+oo61oiIWA0d0Xau2cAd70ws4nfNeGOvh00yoVarHVnblJWI1Lv1FYW/yPem?=
 =?us-ascii?Q?DHxTmbjsPucL6h6oKbkkEbpgQo8vwPJPq5Pfd5tO6kGa/CMa2IsdlAjK3MG0?=
 =?us-ascii?Q?2dGgk1YczgKpfjfCEzqSlVlsymiO5alAuMQdzMYCdrCWEo35I9vOCWoqMDw3?=
 =?us-ascii?Q?4Jlj/w8voNhPkVBDTQBwKRG6DT/VvIHfvtheNkxHt0+Z95fKulBWi8AOFcxX?=
 =?us-ascii?Q?EOWIucT+LIEB5NEGeYZdc1iidU1+WTXwRGOgsoRmOI+Hz/AzOhKg6LoomFZu?=
 =?us-ascii?Q?YtO+oRacCcQOqNGMNiJGDu106zWbW3qu1gNPMAeWPo6SslgZXiyVxIDqHVNV?=
 =?us-ascii?Q?3meycfwjmxLDmEQPn7ha2YD+WiTGO4gT310N+uAiLp0Z8iO9Eamk/SdABMaM?=
 =?us-ascii?Q?YpyWbz/rAVqBE8ouaQfCs/AevdUk1u+WQANG3/EUliZtt9qXjvdOcTEviN5T?=
 =?us-ascii?Q?3vyVucOVol/JT7sADJLJ4NIcR1SuCqhdMAN38DEItpx9SayffcGjIlfWdCNb?=
 =?us-ascii?Q?vmfn9mgLysOp66jaWHnotld2UFq4aChNhJ76qO+PlreMMTTGdI/5+q1eOd/L?=
 =?us-ascii?Q?Tp2/xgxGpjXJp6+jPmf2cBObtf4S0dVRUPjZUcSHfqHaWP5hBUB8JTThN6XV?=
 =?us-ascii?Q?KDFEiui1p1RpKbogBvGOHKP/DM5uYLEl2p9S00Lh08Jb3jw+/i2uo9ym0knF?=
 =?us-ascii?Q?WrdabwD1JsKEX+UIVjm6pKBsBwi7IEUF1eINAqZ/3GGO4hXlFpcSTqUxP7Iz?=
 =?us-ascii?Q?aIAhwItXiXy9Q9rV3zbb2WW68TfkP8R8lDOl3UCba0h9BJx66Ck2R3txet9v?=
 =?us-ascii?Q?9GhGCU/MSKqXE3AuAIdPOk7QCZqALPxoKf2h+P3JINS7svWNIpCACfomVw9X?=
 =?us-ascii?Q?DVUcM3TTvGh9R1mTfKjB7IXNU7NIQmjzx2R6ncC64FLB+SeSdGZYHaK0CWD2?=
 =?us-ascii?Q?tMK/n22caUs26/gMejpjRwWZVkfM/Y/7pssUZl205BcNDd/PVJAn1S2LYg7F?=
 =?us-ascii?Q?ok2v2675BqEt/9UD5njURNs+6vyjKQf7wC7jeQVI0YqsqSZhYZ2OWMq7dPwj?=
 =?us-ascii?Q?Uk3dViN9VUe0l9VMEOtM+MYPfnPQKh/2PXTx8RndlEmZ4t1HoxTbdPsejgq7?=
 =?us-ascii?Q?VH5/p2EtJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb5386-4f47-437d-f4f9-08da32943fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 14:49:13.0095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvsT2teJl2QeE0Zb1RaJnrQ8J1bZCX+LrtvKHmyviQuig43BewgmFDyj4pHu4Li9A3nEG0Uo+sikdXbjkYIbnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, May 10, 2022 09:47
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>; Sudeep Holla
> <sudeep.holla@arm.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] mailbox: pcc: Fix an invalid-load caught by the addr=
ess
> sanitizer
>=20
> On Mon, May 09, 2022 at 09:17:16AM -0500, Mario Limonciello wrote:
> > `pcc_mailbox_probe` doesn't initialize all memory that has been allocat=
ed
> > before the first time that one of it's members `txdone_irq` may be
> > accessed.
> >
> > This leads to a an invalid load any time that this member is accessed:
> > [    2.429769] UBSAN: invalid-load in drivers/mailbox/pcc.c:684:22
> > [    2.430324] UBSAN: invalid-load in drivers/mailbox/mailbox.c:486:12
> > [    4.276782] UBSAN: invalid-load in drivers/acpi/cppc_acpi.c:314:45
> >
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215587&amp;data=3D05%7C01%7Cm
> ario.limonciello%40amd.com%7C2a6407ffdf5944577aee08da3293f29b%7C3dd
> 8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877908262860256%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DlTXBFYCNnM
> Pt6KnL34rQWXT%2BZvdEwvmIdMWGI%2BfluCo%3D&amp;reserved=3D0
> > Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into
> pcc_mbox_probe")
>=20
> Thanks for catching and fixing this.
>=20
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>=20
> --
> Regards,
> Sudeep

I'll take the credit for fixing, but I realized I forgot to add a link and =
attribution=20
to the original reporter.  Here are some more tags to add:

Reported-by: erhard_f@mailbox.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215587
