Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2724658DD68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbiHIRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHIRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:44:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475AC25C64
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAMRFK2n3PoPmKt2y8HOltZheUJwdEHywNi6L/UndrcFq8dZ/JzZqOSULx+Q3rUHT/lbaCPw6EnhL28mcVkw/TleG++ES105UiTm7n+neVGPSusS/cFppvquuJ3C5uDkJnK7ytX+DZBTMXph5bLiHS/d+Bq1TcxQpW1KoiFwLg24tCpW2D5NYOzLfLwkpOSxUZqD3MivVvRtd4MKzQ7yQEKYn+O2vcQZ51raBhmrs95j97GsRJ7K5ZJSnyPysY6ZiGBkoT4c5v928+bYK5C7ErlDc1FLGYK3kGOSxRw4qU9pg2VLHOEKmjKTScCZaK36qv2gUV4ZdDjvRY8gVjiFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg6IU8V8XTPkT7qgQ3Qf2vuyBo4s0aLldmbRo3j7GLw=;
 b=MrXyiI8HRSKkVKYRnRdDW89XmtfvmiPnyQZkOnoCcIIEfiXqC4upY5S5WmzTkynOFfgmqUJN/jqu9HybDlNU21Hsa7zlUGJwPMSpBtE34lsBPqK9OKjrcJqw1TEvy1jaDqoDQPL75Dk0kdwvAeDNxwh0r3BCoLYr+nyvM9rBt34XeYU2C6pU3ilTEq1uF/0yMaPqDSdwiRo06Xd+GcJkWdZrIZHNrv2E/tfTdfXpuvNxrf+M2oMCBWgDeskNrxO/E8qeZACL1rAtYUcJRs2bF8GGXeCvwpVlTnOdCMMsgtOJjnkWQISmQOi9m/V7TivV652bq++CJUhJ9WX4+XF+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg6IU8V8XTPkT7qgQ3Qf2vuyBo4s0aLldmbRo3j7GLw=;
 b=un1AWhCuaV/pCG/PGVl2BydMzPk9I2Y5gcqzwtVzDWrqWtPlx+2TpmQcW+DNlMIx1Ri2MlFPrj/z3JkEAlRGaJ+inmPvb+1HbM+CSZaiXaEa1lHIK9QMdOvGm7yA/tDROh9o+co+GKBIyYjenZUtni8NT+4mGgYayjHJF7QFYwA=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6138.namprd05.prod.outlook.com (2603:10b6:5:3a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.9; Tue, 9 Aug
 2022 17:44:50 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%8]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 17:44:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "kernel@openvz.org" <kernel@openvz.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH v1 2/2] Drivers: virtio: balloon: Report inflated memory
Thread-Topic: [PATCH v1 2/2] Drivers: virtio: balloon: Report inflated memory
Thread-Index: AQHYq9YDdj/O5CsJlUeEIqWy1OYxe62m18WA
Date:   Tue, 9 Aug 2022 17:44:49 +0000
Message-ID: <83B75FC4-595D-496B-91EF-ECCE16D1E2CE@vmware.com>
References: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <20220809095358.2203355-1-alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220809095358.2203355-1-alexander.atanasov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 303aab6b-d480-4a62-207a-08da7a2edbae
x-ms-traffictypediagnostic: DM6PR05MB6138:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jT79iX1FuqmQ/L1/bLdQV+N0DSli4XWp9TZedG/lm+oHxAg+x4zGZNVRC44gtD7zJ2Dbbbv8HZunkPscH69eXLjIDrFlRUbpi4UmxNHXGKKU6aYes4aXX436Evu0sGoQBLafudKFWb6i0vDGCfOVKMsbcVe3axs4JZhjbCm+r0kJzl76raXJ+Lqri+Oqq5Ptl9zKDX0MoXly+T94fy5Ab64oWlIxzw4uU2r0WfjxOqB/UnN4HvECnlCeOd1NhoiPTdhfX8EjYB9FfplAVMHlXdv6GreCVO/xI7dtKQjzY9tHF8o6d7GOfw/6Zqab/WvBfZ/ZCdNTl4YEaGLznZiShIbJS3x28KBKelGQ8QunYYrWYU2l2ZLi8OTKN3dsUfDCfoMslLPBM2AXgXMDTxR6ANCjCzYRrnRwglTnRyW/nHCh4+UtUKBnq91V2OsDxFSrWUuKA14Y6Tap7X7WLQp8Hybjmyb12dCm5YwIH+sRQkFDHbMjlfabytRPLqx73TxLDnxvfTZVF4uS1nwS/zLSmNCY28PC/3rUEQ+I6FKaHeVwuUczOdanjRiIHLLZZPRn3iGPfIyUiG3ilfYLzXErDYmZD9P1PbNGkma6xHgt9Jdsy415oJ+KkcVlLGXGPNx6iC2AhtuM89HrMlvIACaS6JezHLpuDJb5CfHGC+/iXNFrg5cG7Kl/+8YJHaUjKXwP/T29V2jMzfCPrnJ3DywsdCbhBxooATQ04qivr1VyHnVStxwLxESJZ8AuoUaPy5Fg80d80ApWJPpfNUMl2/rvXnVn/YjNC7ewaFKQ50tCbjlaL38eKQIeWuvC4kxfxuHX0ljRXgInYY3rLpxeAsLiNU3ItFUoICSWF5sVfaD6pe+R+4oAWgcN5UMk2MBx8Gf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(86362001)(38070700005)(478600001)(107886003)(2616005)(33656002)(186003)(6506007)(53546011)(2906002)(6512007)(26005)(38100700002)(122000001)(83380400001)(36756003)(4326008)(316002)(8936002)(41300700001)(8676002)(71200400001)(66476007)(66446008)(76116006)(64756008)(66556008)(6916009)(5660300002)(54906003)(66946007)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U93gbqmn+N7iRz9xIw33KfBGCP4YMlVbYnBZuUnx8/cGnp+Zd2PfiGZUUnTd?=
 =?us-ascii?Q?zsjzjD7gaOjeiujoIZqVGyvEOS1Sg3bmBQjTlozF8dSUrS0OlhQdniv6TxfA?=
 =?us-ascii?Q?5WMvB/hgEFjF6ZN1sO4deJhAaRYBla4w3dvLRqN9G9sh3B9IaLZtk7xE4Mr9?=
 =?us-ascii?Q?2W3H/jiPsZ/Lf6I77cIhUw+8PgWEPlKiAZwgpCPSIDUIlC1IKYeaOaIFtoDe?=
 =?us-ascii?Q?oyKOl0169T5k/XsuqasJZ3bLRl+XpL89bGrvq1tzGK3RdvuDGb9jHKAWSpcO?=
 =?us-ascii?Q?kjeWixTklfA4EjpOYn7OQv/BEPNcHLCig/BNR8nMnw2kNrq2ea5+LL3pVMsM?=
 =?us-ascii?Q?+Xht9aQabBaFwUMxVknxp8I4ajZOYky38hRTCovEisBtQ2La/+D/mhrpioKn?=
 =?us-ascii?Q?ltK47Zyl+expOPxbrqJpZ7/++guT58rjitgx0dugpKKRwi8TDIRosdTOwgSt?=
 =?us-ascii?Q?NzjHspADexgj946MFm1I/Jp1tX8WGhvfuOnjbhwX2wfEYHegw99m9ew9dgNo?=
 =?us-ascii?Q?4fu1wGbTwo57dwEyiFt6ilp4qKPpuuTJuAmBPwtknYXR75OTX6BiBWexAGBv?=
 =?us-ascii?Q?30hS1TajBgwrx5GKTZXiNyRaQ6SxF8m/LpUsN5ASklwOE0tNLWc/rCB2oWms?=
 =?us-ascii?Q?So8qMklPXRL0ogVRRZCqByVXXobhkZoSlYlzT/I91S2dyv4bGnMiL/zalcLT?=
 =?us-ascii?Q?revW4JumqwPrIBCapkKTM+yXubDqauCGBb4xoQwMye0aziDFtd1BDRg2npvg?=
 =?us-ascii?Q?ajS5QSQKrYTxcHWvAk2wawdLAAd4wecfNNtA3YHL8gaNNDZpeqHjwfHKvH/c?=
 =?us-ascii?Q?S0/hgE+3o+j6rM4ZBV+A4Cxanir/5BPFRST4M3OCr+LYoNsYVPpuT+1rpgbg?=
 =?us-ascii?Q?TaTcpN/UmViJx05xibc8pmcM8mL94dEonygBMkabLXEnTZ+wr+o0pX3Iv4kR?=
 =?us-ascii?Q?azJ308begDjQVhuyO22pV/IKzuR6REeRgWdnp5jCEesalzOJFy7NVmmrEySd?=
 =?us-ascii?Q?DfWS05mMx2b3fcV4/OSSNmk7b+/fgNXYBykv1VjOmZTQqmNTOFSk1LFZ1fyF?=
 =?us-ascii?Q?gwuoehulMKdjGpiU4jD+kSudc4jqRGmqdLWhq1aWeRhoMIUF7cbNtEjLaIzl?=
 =?us-ascii?Q?USKPakxt39EO5ODykNsQEKNR5cFwDgqjheepo5ssJ7d9jTy1ymSoTv20pn2d?=
 =?us-ascii?Q?CA+NH5nTRQ2Qi5a2MI8mzdVwbPZm3O3ZKpwizt4y/nBi/Xr8MGFOP+LTVjgQ?=
 =?us-ascii?Q?BxMc4hwbNzYlC4mRxu8qt6aF1jC+E2MY5YT6Q5VaIZZ+RoPZNYQvwfXIZUfI?=
 =?us-ascii?Q?+XgATGE/iG4S2iNVN8OrYRMNLS8QcaPN8smY7QLVytwsDHYUX520y5uuKEod?=
 =?us-ascii?Q?0d8ZFCF3IGukTMhfDysNXwNYtFqIW5fe9t1balP7DZoXrmxAsoRrhhgXoO1z?=
 =?us-ascii?Q?RDPimO+eTQnoqTnn8e5Y7gxEtf9PYbhiaR6qPmu7fMOR0oFgIADbCNAxsG3u?=
 =?us-ascii?Q?SNUDhn1cIOZpAG1Tg98eqVvrm2zwSgTFlRoxKmO55X9zAZZGinOUA6j/y8eL?=
 =?us-ascii?Q?oq6uPULqyMAp4t6kFgGz2vg37sI8MrT6P1o3ZKLa?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1861A4A63DD4A64B9B033801D11B954E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303aab6b-d480-4a62-207a-08da7a2edbae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 17:44:49.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edeNf4Qmm09nP9L9URFVa8dJuU01MhniL/XpEvFRPG3IbXzyN2R8P5Yr9SjWfa4NWsNHBMVAjzH09BiVOM15xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6138
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 9, 2022, at 2:53 AM, Alexander Atanasov <alexander.atanasov@virtuozz=
o.com> wrote:

> Update the value in page_alloc on balloon fill/leak.

Some general comments if this patch goes forward.

Please cc pv-drivers@vmware.com in the future.

>=20
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Nadav Amit <namit@vmware.com>
>=20
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
> drivers/virtio/virtio_balloon.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>=20
> Firts user, other balloons i will do if it is accepted to avoid too much =
emails.
>=20
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index b9737da6c4dd..e2693ffbd48b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -208,6 +208,16 @@ static void set_page_pfns(struct virtio_balloon *vb,
> 					  page_to_balloon_pfn(page) + i);
> }
>=20
> +static void update_meminfo(struct virtio_balloon *vb)

Putting aside the less-than-optimal function name, I would like to ask that
any new generic balloon logic would go into balloon_compaction.[hc] as much
as possible. I made the effort to reuse this infrastructure (which is now
used by both VMware and virtio), and would prefer to share as much code as
possible.

For instance, I would appreciate if the update upon inflate would go into
balloon_page_list_enqueue() and balloon_page_enqueue(). VMware's 2MB pages
logic is not shared, so it would require a change that is specific for
VMware code.

