Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B012D52302B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiEKKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiEKKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:02:52 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EEC1AF0E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV2VXjHgc7G+a/AIoK6mNVaCgetkSLTLga/F2BYgvA9EFdTaSjZX0YXKlG9pzAZGODRHUEUORbJsCGWdc0M+/A3UI2JXqTwxMmHnTnqGXB+R/Cne8UPr2RaWRmbm/Rf9dvjDtW4rcxeCsNbvvPZtKbd7ZBbi1AZy1cPyVJQAvgUp2OEIioSlg8yUDr5+49FimWfrHtbaK70Ke1HP5Hu263I027eNPbjZzeGyQd63MxAccEMFYTMgiu4ARNGuMJmZusgZh3a1Uw+5lW31p/u0jelQ9tBHoa4gMATiZULji6U82J6pyMGWzvZuesPPyjtW3NMoV88pPalMW1qDYS+azA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qf6XVRCBIrB4QvxtVPfEys0EE9twUwRlyz3TimZOzI=;
 b=A3eIrsA0KhpZm0onAEvDJW8e1eLqYdE4e3bLS7OuuXowhYwMDL0gYAhmU+XVOYvX960amevBZeazN1Ri/myYfTU2eaY/CHaIII4Zd3uuaFQyFvEceCjj/4PTtxXMrMAxx8y8neMhCICzvfrwvGI0PiXc6sBjjUZ8yHVDmLI78C9TUJ/4lOT3JscY0GGvWKzQqcGnl82C0g6nQS10TiWPl7NwGETmut02zIlDbW/vPtUK2fBsQgogs+MCe1WTv0jamjjexEp8P/sclOZKqVULLHtmALzKcLXf8duHcDXWbz2CnTDnNDk7x63a8Ve7ufOR3ftYUgfKuz5AuOp2MhSftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qf6XVRCBIrB4QvxtVPfEys0EE9twUwRlyz3TimZOzI=;
 b=ovBvBcEJ44DkTGLAD9QznyO8DDWEA78IMaewTYoHXMJ0QSfpQHpHcqmfyxoj6DN1O2V5twOF+zzPkYZaNQTnM8VPheRqKgSfeb355q6z0MpTzVtiWziikCySrFpGR8j23E6SFaVggfcVBDlKb4ihTXBfr+IpAtSA8htGp0jsuMGto2OfTIN1w78s3P3z4sbF5i+/q4NmsdZc0/T64hdm4gmsFC4JFTmWFGiLg9/qc9exYHmyoLRW2VdeeTspXAUgy0jRDg0+T2JS8ean/ZfKT+KTm1xXoZqDLuqJ1UBkggNKIZvt+fhXJU0ohtwxBvUTkmsKZKwcLeVYmKxsyv26AA==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Wed, 11 May 2022 10:02:37 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::a196:bbcc:de9d:50a5%9]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 10:02:37 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Subject: RE: [PATCH] vdpa: Warn if MTU configured is too low
Thread-Topic: [PATCH] vdpa: Warn if MTU configured is too low
Thread-Index: AQHYZRPaxDNnxWhxK0yF85+cFflWj60ZanOAgAAHJsA=
Date:   Wed, 11 May 2022 10:02:37 +0000
Message-ID: <DM8PR12MB5400BC33A5ABD2FCBD0CA852ABC89@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220511084804.82482-1-elic@nvidia.com>
 <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
In-Reply-To: <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f9297fe-09d2-472f-85c3-08da33356084
x-ms-traffictypediagnostic: DS0PR12MB6558:EE_
x-microsoft-antispam-prvs: <DS0PR12MB6558E11B5F973E14C1E37FD5ABC89@DS0PR12MB6558.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5CZrDlBwbdE6rSfKK4aBVqJZ2TsC9Iz2VYwUzaU7RZYSqdZbgA2BdFXqdVkSwqDy+93Oena6JaTwO/9ZgqTJOpBrJ3pS3Tr3ymas2OVF99t7YvlevISXUh7AT20gYpDpZOM2Ya9ifDMaICrXwRpOvbjQIjjghyiDnhzEhtGK8tFh3hDr2CKtEOq4uM5VEhbFaIyCscCjgzp6USjoXJnBokgwayJatCgByc2LRXzKh5U7VZ8AO6ILTmOWsoD8yidd1CT2i9yh7maujJQIN+/AVugOCAdhRpIuLIuU61E/2vINU2mv8cgvwXen/jebraJzvNPANmROEI0gi0zmHa18vzte2buIOnzRF12rkBmOiTSkHgZ7iLdp0zneXPlY+SS6CGlpYm5iBB4gJYKMzmHQNwJHWjK5lyKWldaJVOOXYPo4e3OMYf/iLQSelYqUrIyyRCX+73Y7fjrJwOP9WGgJPS8Ldz8MdFpMrYcLpFdkVifMTKK8wh4ud1QLJC7gkc/JU2C8W0ZwgDapNwyYQ3rNKMh811tyyfrYeLA1iRPgtgBedHuLSFCbK1CM99U3fNRE7uhW2d6SD3G0RnMAfcCcBq2999Tnse618bnLeVoeJLQBrfwGFBnpWqnu7BBcGGrNH3/Nw4rpIr+z6MjPVAJ81AgEwpwbgTm/elmZ4ZOZkldqKV3olxeKvm4XJJ3SfDGx2OByJSoYHFi/yNjKdPy1+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(122000001)(2906002)(33656002)(38100700002)(38070700005)(55016003)(71200400001)(7696005)(53546011)(6506007)(76116006)(83380400001)(66476007)(9686003)(66556008)(54906003)(6916009)(186003)(66946007)(52536014)(8936002)(86362001)(5660300002)(64756008)(508600001)(8676002)(4326008)(66446008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWZHU2xlbVUvNGQyc0dneCtlcG51VFNJd0RPak9BN2JBZlo3ZnYrMnR6dUl1?=
 =?utf-8?B?QXNSTGlJbEZMd3ErbU94K1EzTE1mVENySDNzNUpmNXdYRjVqejJaZmtlN2FU?=
 =?utf-8?B?TnRleXR5V1N3QnNvZExEeHJHWEhjdDJ1RXcrd2xvMWNNbXROVkFCaldPcVY5?=
 =?utf-8?B?YkFVSkNGV1NtRlZEa3MwUjlOVW9vOVI5MW0wVTI3M0pwa1lCQ1h0ZmV4ajJS?=
 =?utf-8?B?THJ3UWNncW1vMWdWRnZMZXZpQjdWdHdOamhSZGNidDFtY2o3NytvaUVlL29v?=
 =?utf-8?B?cEVUUE1yT1lCNVBIeTlnQko0UzdnR1RBdVRqMFQ3eFdtL1FWNlVFZlg3S2xK?=
 =?utf-8?B?L3VQVUJYc2FOT3JqUElUcElPbnJzZ2wxR0t2Y1NWdFZSTUUza05HNXBiVklW?=
 =?utf-8?B?blg5a1ZpN0Ivbnc5eERzMkxhMTdxdWhicUtEelh6cFpkeFpvaFNEcGNQMUFY?=
 =?utf-8?B?TDFEQlBKVFVXYnRCZVlFa29jWjZVMXMweG1iNHo0M3FFYXZkVE5lWXlYdFB1?=
 =?utf-8?B?bWFhNWxDRTZlSVNpUFlLMHA5cGliWG4yUmpDZ2FGa0hyWmNLSDhSenFIRU90?=
 =?utf-8?B?bVEwdW1yRkdOYTExTmhBWVN4Y1lLRTRjb0pncURwK1JPRkVRTGh3eS9QUmdq?=
 =?utf-8?B?dE8vZU5wQ2dSa0V5TmFaZGpZcXdDd0tnWSt6ZkJqeE9yZlptQm00UDVoSGY4?=
 =?utf-8?B?VFVKeXBrazdvcFhwOWllK3YyVVZIc1E4ZDV4cUdJbHJvTkpQU1QzVEU1TXM3?=
 =?utf-8?B?ZVQvTmVkT0cyMEorS3FQTE5tckRhNEQvSE1jOUxGNk5BSjh2R01SdlZpcUVN?=
 =?utf-8?B?VkYzM09BY3hrUmlkL3NHSnBnb3lrcGE5ZE9heVFzU0hZQVlXWGE5WktBSklN?=
 =?utf-8?B?R2xEVUNNaDhzUzRkMmg2QWhOWDRIZ2h3eG90SDU4aE5BejV4TXdzS1dIZ0Jp?=
 =?utf-8?B?Z2xmbTNRSGt6TUtkZ3llSkNqNFhINFdITzFKYWRBRTZGTEJEN3hrT05YRHlV?=
 =?utf-8?B?Z2tBTHFPR0g4aUh2eWNtVlM1aGlIVVFNN2ptekZTWVBDYjFXbDcvL21wNVJJ?=
 =?utf-8?B?UTY3TnpobzhWbWZkZ1g0b3doeVMwZDBaeDRQQjhVcGo5UU9PbVlaNTNneTlI?=
 =?utf-8?B?bGpRb0FDVzc0ZnVCUWYyY3UwTmtBaE5sOTZwbmk3RW1uYmhjKysrSWhaLzNw?=
 =?utf-8?B?bzZsNzFlMU0zUGFlcTl2NVE3cUU5YTlUTEVhdHkzRzlCck9XTnpqQ0FzTzFa?=
 =?utf-8?B?Q2VEZ0dxSWdrWjNjaFVVNEVIQnZ0YUUzS0VZQUwvdXd4NUMyNTNuQmJBWDRZ?=
 =?utf-8?B?SVc2aWFXK0UzOFoyYUlkU0RuRmcyRlhOV2xOb09oUGhUMEZETVNWeUVjNi9l?=
 =?utf-8?B?ZDk1ZnEzbXB4c3g1UzJxM1hlc2dnYTN4Und0NFZHUmd6cHdlWGYxZDloZjVQ?=
 =?utf-8?B?bTRzUTR5czB2bXRvQ2gySDVJTlNDMXFZYUxaZDlZbnQ4WENCZEdTdWpEYi8x?=
 =?utf-8?B?YW9mQ09ZNnM2QVhPbTBES25zZmFLdGVGOFFDNUFBczhVdG50TWZrQVVFbDBP?=
 =?utf-8?B?QTNrM3FLZXZHYU93aG1rZS9XakpLdWRvRm5NOTlhRUlQWUswYTZkZnRFMlpE?=
 =?utf-8?B?aVJnUkRVVlFJdWxpSmFGWEVjdXBORmNYZzhmVEpCaVE0cm1veDE3VFczS2cr?=
 =?utf-8?B?a0YzZHMzLytGbmNDeXJQOXdSelViYi9xMzN1Y29vL1lDSVhESWl0aEpieWsr?=
 =?utf-8?B?aUErSFE5b0hVc3Zkdm5iUzkwUmpubmFhRlA0dktaWlBOYmRKUUo3c3YvbE1G?=
 =?utf-8?B?VTJpZGE2SnhKMnVjWTdJNlZ0VDNWeUNDeFJhUlVFUkdkWExzYXA1SWY4NXRz?=
 =?utf-8?B?OWpyZlBjUmp3cWd5aWs0a2lIWTd1MlQydXpYbGt2cjJWeWV3c2tOUDJYZVAv?=
 =?utf-8?B?VlR5bmtSZzlKcVJqNElPTFgyUmRaTXRlcCs2alIxU3JIbWszRzBidnhyendp?=
 =?utf-8?B?d3c1WmNERjlraEpHSXdCeThvM2FsK3FWUFk0UVV4dCsyOS8yY09hTzdyMFNw?=
 =?utf-8?B?YjE4T0JuOUlqTzl1QUxHWjlKL2tHWEZxdndRREJVUTVIUHl4bW95Q21pOENa?=
 =?utf-8?B?bmVjcDZJaHh5YjFEaHRCOGhCcWhHR2FYazlKMzExbHBnWElSdm80THp0QzVR?=
 =?utf-8?B?R25RUkVCUXRXc2RsQmpiU2l4dmVmZC9LSE9lWStEUngrZ20xVHFCQjJZdDNU?=
 =?utf-8?B?bWNtMk95WXVCL29OZjRjeHM0dU10bVBWQkpoVEdnQ2pIa2o1SXJmOWJtLzZG?=
 =?utf-8?Q?UbTNolJqi+q1g7nx6J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9297fe-09d2-472f-85c3-08da33356084
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 10:02:37.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +umRxQ6lfU/X0K3oXuY8HjRNHTbvTETtWhnNXkQyHsXMJjWpVbx57KDiyQfxdIx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE1heSAxMSwgMjAyMiAxMjozNCBQTQ0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5j
b20+DQo+IENjOiBtc3QgPG1zdEByZWRoYXQuY29tPjsgdmlydHVhbGl6YXRpb24gPHZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPjsgbGludXgta2VybmVsIDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU2ktDQo+IFdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xl
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdmRwYTogV2FybiBpZiBNVFUgY29uZmlndXJl
ZCBpcyB0b28gbG93DQo+IA0KPiBPbiBXZWQsIE1heSAxMSwgMjAyMiBhdCA0OjQ4IFBNIEVsaSBD
b2hlbiA8ZWxpY0BudmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZvbGxvd2luZyB0aGUgcmVj
b21tZW5kYXRpb24gaW4gdmlyaW8gc3BlYyAxLjEsIGEgZGV2aWNlIG9mZmVyaW5nDQo+ID4gVklS
VElPX05FVF9GX01UVSBzaG91bGQgc2V0IHRoZSBtdHUgdG8gYXQgbGVhc3QgMTI4MCBieXRlcy4N
Cj4gPg0KPiA+IFByaW50IGEgd2FybmluZyBpZiB0aGlzIHJlY29tbWVuZGF0aW9uIGlzIG5vdCBt
ZXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4N
Cj4gDQo+IEkgd29uZGVyIHdoeSBpdCdzIGEgbXVzdD8NCg0KSXQncyBkZWZpbml0ZWx5IG5vdCBh
IG11c3QgYnV0IEkgdGhvdWdodCBpZiB0aGUgc3BlYyBzYXlzICJzaG91bGQiIGl0IGRlc2VydmVz
IGEgd2FybmluZw0KYnV0IHdlIGNhbiBkcm9wIHRoaXMgaWYgeW91IHRoaW5rIHRoZSB3YXJuaW5n
IGlzIG5vdCBpbiBwbGFjZS4NCg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy92ZHBhL3ZkcGEu
YyB8IDkgKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIv
ZHJpdmVycy92ZHBhL3ZkcGEuYw0KPiA+IGluZGV4IDkxZjRjMTNjN2M3Yy4uOTYxMTY4ZmU5MDk0
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMNCj4gPiArKysgYi9kcml2ZXJz
L3ZkcGEvdmRwYS5jDQo+ID4gQEAgLTU4Myw2ICs1ODMsOSBAQCB2ZHBhX25sX2NtZF9tZ210ZGV2
X2dldF9kdW1waXQoc3RydWN0IHNrX2J1ZmYgKm1zZywgc3RydWN0IG5ldGxpbmtfY2FsbGJhY2sg
KmNiKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01UVSkgICAgIHwgXA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApKQ0KPiA+DQo+
ID4gKy8qIFJlY29tbWVuZGVkIHZpcnRpbyBzcGVjIDEuMSBzZWN0aW9uIDUuMS40LjEgKi8NCj4g
PiArI2RlZmluZSBWSVJUSU9fTUlOX1BSRUZFUlJFRF9NVFUgMTI4MA0KPiA+ICsNCj4gPiAgc3Rh
dGljIGludCB2ZHBhX25sX2NtZF9kZXZfYWRkX3NldF9kb2l0KHN0cnVjdCBza19idWZmICpza2Is
IHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCB2ZHBh
X2Rldl9zZXRfY29uZmlnIGNvbmZpZyA9IHt9Ow0KPiA+IEBAIC02MzQsNiArNjM3LDEwIEBAIHN0
YXRpYyBpbnQgdmRwYV9ubF9jbWRfZGV2X2FkZF9zZXRfZG9pdChzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCBzdHJ1Y3QgZ2VubF9pbmZvICppDQo+ID4gICAgICAgICAgICAgICAgIGVyciA9IFBUUl9FUlIo
bWRldik7DQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICAgICAgICAgfQ0KPiA+
ICsgICAgICAgaWYgKChtZGV2LT5zdXBwb3J0ZWRfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19O
RVRfRl9NVFUpKSAmJg0KPiA+ICsgICAgICAgICAgIChjb25maWcubWFzayAmIEJJVF9VTEwoVkRQ
QV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSkgJiYNCj4gPiArICAgICAgICAgICBjb25maWcubmV0Lm10
dSA8IFZJUlRJT19NSU5fUFJFRkVSUkVEX01UVSkpDQo+IA0KPiBTaG91bGQgYmUgPD0gPw0KDQpJ
IGRvbid0IHRoaW5rIHNvLiBJZiBpdCBlcXVhbHMgMTI4MCB5b3UgZG9uJ3Qgd2FudCB0byB3YXJu
Lg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHByX3dhcm4oIk1UVSBp
cyBiZWxvdyByZWNvbW1lbmRlZCB2YWx1ZVxuIik7DQo+ID4gICAgICAgICBpZiAoKGNvbmZpZy5t
YXNrICYgbWRldi0+Y29uZmlnX2F0dHJfbWFzaykgIT0gY29uZmlnLm1hc2spIHsNCj4gPiAgICAg
ICAgICAgICAgICAgTkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJBbGwgcHJvdmlkZWQgYXR0cmlidXRlcyBhcmUg
bm90IHN1cHBvcnRlZCIpOw0KPiA+IEBAIC0xMTM1LDcgKzExNDIsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IG5sYV9wb2xpY3kgdmRwYV9ubF9wb2xpY3lbVkRQQV9BVFRSX01BWCArIDFdID0gew0K
PiA+ICAgICAgICAgW1ZEUEFfQVRUUl9ERVZfTkFNRV0gPSB7IC50eXBlID0gTkxBX1NUUklORyB9
LA0KPiA+ICAgICAgICAgW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSXSA9IE5MQV9QT0xJ
Q1lfRVRIX0FERFIsDQo+ID4gICAgICAgICAvKiB2aXJ0aW8gc3BlYyAxLjEgc2VjdGlvbiA1LjEu
NC4xIGZvciB2YWxpZCBNVFUgcmFuZ2UgKi8NCj4gPiAtICAgICAgIFtWRFBBX0FUVFJfREVWX05F
VF9DRkdfTVRVXSA9IE5MQV9QT0xJQ1lfTUlOKE5MQV9VMTYsIDY4KSwNCj4gPiArICAgICAgIFtW
RFBBX0FUVFJfREVWX05FVF9DRkdfTVRVXSA9IE5MQV9QT0xJQ1lfTUlOKE5MQV9VMTYsIEVUSF9N
SU5fTVRVKSwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGdlbmxfb3Bz
IHZkcGFfbmxfb3BzW10gPSB7DQo+ID4gLS0NCj4gPiAyLjM1LjENCj4gPg0KDQo=
