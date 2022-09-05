Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530645AD498
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiIEOQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiIEOQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:16:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E52F03C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662387405; x=1693923405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cZK3/hyEv3YgUndyFj+L+MdOQCVYjsFpujDmznaAeDs=;
  b=OuZSiIASNqCJIn7JpBWleUFhBDPzYNLL4LN/UJUWbP1SZT8IdAm3GRtS
   qVt3LixBhM3sxHBy/DBJllzOyX8eQF+7AaSWJclbk1r6Yv97CUWJ7yGx2
   sCkE1WvwkdHW3zt39iPnmAOwXsfAGrwmWNS2JcxJlM03Wz888FDyDpxOd
   Asu5KdNtFoKLHC+tBnFCWCNBIvLwP7spPxnALtpsT0ceOpbaOPcEqezS8
   wuoHX4X9rNZ28iX/0IjiH+loTJkRer1vv0gvZDbLPHwINowGiDfL5UljY
   Bt7tbZwJofK0hamBeVjOa2WRv4ZGRT9iSgPY4AOOmIrUxTkqO/HJcIuGf
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="112230004"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 07:16:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 07:16:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Sep 2022 07:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEj6WjwTfQvwt2h9y6kYOmu1AmofmrAictdqhjvBG2wz6hhai1Li7lalObGtzzgktuHaRw455NCpiYL0eMjWtifPeP02eXc/3dyX/tx0QFuCRN7aurtk5Z8DLnRbn0e6Ct8g2DEXeS0yR/pqlOdk3Rl2aOgLivuamzCeXKRUSMAw9kfqpSZQlGRsqvf24uuJexSp5KTLi9bxH11blO5oL6kvw5Nh/XH+d/EOvzNOCfiQV+JWD7D/qASmEdVjKIhfalQ1MoEtZSaD6/uFU3ANadwYPEWu64H3EKJinFnhgHJBD47XrlY88uv6NfLM0qDmYpfjc3sMdl5CRViNCh9ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZK3/hyEv3YgUndyFj+L+MdOQCVYjsFpujDmznaAeDs=;
 b=VQaZNclTJmEOqQ96n2isOrSijtkaMgxGUsuxUg2n2/Cb20e/vrbDQ+BHjF2u/G+IrHv9yv1l2ajps+9D/muaRP/ACXSpDHRV6CKARa8nJj5kAUBY9APTy0quTummknvsDzOt8cjxpjMH2nH58VyDmIdkIrv78PbJuXPcB1fBKBENMo9bkZfdS+RhiDRRXTcb/e0KO0z1mRcYZwM7kx6Y8IhTzDaC2vUKudo4bAtxYUQSIvIuBNTWJOT58Odx3cglMSnXI8iofdmWaFlf2EyAVJqVVEWmavp0iFPLj2r8NJppw4ASoDMwdpzjuBHH17Lhf01x3yM+FtlJlDmICS7MJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZK3/hyEv3YgUndyFj+L+MdOQCVYjsFpujDmznaAeDs=;
 b=BpYlwbWxOeFlDswX2Oa3nuaeOlJcjgKE3RBKhm9zAKNUxY2jfmLznOWlP84eMMwliZ9iqGUItHKbSOaSrzkk3fXFqwTHp/gMrtu+etD8WQlwFrlXEbDLXryCF9K8veCsSDntW2U3d0iDV+K5jgOCkeSe6Mg4Wb5oYQi1DMZ9fLo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB2557.namprd11.prod.outlook.com (2603:10b6:805:56::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Mon, 5 Sep
 2022 14:16:42 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 14:16:42 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <guoren@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] riscv: use BIT() marco for cpufeature probing
Thread-Topic: [PATCH v2 4/5] riscv: use BIT() marco for cpufeature probing
Thread-Index: AQHYwRg57DMgpYyc+Uef16fLunMs063QsIQAgAABAoCAAC9WAIAAAR2A
Date:   Mon, 5 Sep 2022 14:16:42 +0000
Message-ID: <fe249ea4-f500-2e4d-711e-545418b9d9e6@microchip.com>
References: <20220905111027.2463297-1-heiko@sntech.de>
 <1e61d31a-9bf5-af79-dbc4-87d63d24b497@microchip.com>
 <7693745.aoefvbuG5b@diego> <13885578.y0N7aAr316@diego>
In-Reply-To: <13885578.y0N7aAr316@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b1ed75d-1ad8-4aca-27ec-08da8f4941f6
x-ms-traffictypediagnostic: SN6PR11MB2557:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CLZxwaGL1F7ycah7HdewxSEqf3WRMM38xHLPr9yO3clA5y6MiOwu+JE962yw8NVI6GAKLNgW1uniBs6E/ddtrRqxVtjfgqWcj3S4cxQy8D2aupyqR3aq9O/TqXOL4aspXNxpIaKvCpkVWCelZNR5TqJ5BaP9saj4xyWBLcPCcyj+EDBPmJ3q5lk1phChidB8/4jN5IxJxIDLUpnWoL9pPBRGLEC+LsU5QQ4+4r+1a3XemKS/ZxMOAx1QYimweWDPJr0Bzs4yq7lDCuWWvcEN6Yl75CruzGPK2l3B6LPc6JqLtmnzU8eYxURt0c8DC75p5Ab7z8lxu0yXF3WNR/A+y37mJOSXHW5dxSDIuH3UrTzMBkdtuc0LBVfQzVPu26bLTkn5nqfUHIhaDk5FYJRZm1MsqaPvLltu2KuHtgc+xr+EZhADqKhFZbz+XW6hV6nvjBJCfP5m9FTcucvZGB1OUDeWOMnxeOvCWZi/49JblDBLHaPrV0dNnGPuN4I7J2TGk9T7rr+IpFjiCC/ZcQk2zOx1gzXGacZbqFSPLwfKyD1g+NuZVkquWRSA9ALEE/dlqaAlPDhI6/hQuJ68em7XEyt0yrCvYccVOl4N0CQRAVLZwM6n3LOmGnYVNm2eyv43FtDrgR4VanBUTQOEx58ST13e07Kp4OoN4b2lj0Ck8Hs9ILN69Ucct7QbqEpfJoPK4vfp7G/YfLhB9By239MCQl7TNcngUjhaCeD2IY8LrxKjSVv8wFdfI1Av+NfvlvN2aQnRm0gx+nAi7yG9Yi1QHZbgswyS3kE5N1EE0UifFcYC7nVZaqXJu4m95I0M3sTLCrpKcHSx+yQgVUG0n1emQufPAWolJ3qg5H44Bk9Dceg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(136003)(39860400002)(366004)(376002)(86362001)(2906002)(38070700005)(31696002)(8936002)(122000001)(36756003)(83380400001)(38100700002)(2616005)(186003)(316002)(71200400001)(110136005)(66476007)(54906003)(76116006)(8676002)(4326008)(66446008)(91956017)(64756008)(6486002)(66556008)(66946007)(31686004)(478600001)(6506007)(26005)(6512007)(5660300002)(966005)(53546011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUhDMnp0am0vSWdFdlpFS2ZOMXV5Q0h1WkNQZDlISDlONVdzdFJsTDlwV05u?=
 =?utf-8?B?QUs4VnpaSFVtVy9JVzhZd1RRazRtM3YwOEplZkMwNTVHbHNDWjMvOFNFMHly?=
 =?utf-8?B?K0NYTFZlVUhJTUVlOWpVT0pLZ2FQUTY2U21RWTlxLzJ4b2tGRVU5eVVZWkg4?=
 =?utf-8?B?dlhiT3FaTjMvUEpFUmlnbVhORnFrMWZqVXR2a3hDYmhzSFFVRFBZSE1uRzMw?=
 =?utf-8?B?Rmt1SUtrR3crZ0lsbzBQV3RnNko1OU5JRnhPbU1aaDU1eW5PN3NRQlA2aERs?=
 =?utf-8?B?cS9zUkZrZ3IyUXZPNnlJTFNUME9ydkNzMDQ5anFlaEdLamhnQ3NCdjUrS0ha?=
 =?utf-8?B?UVplSVY4V0pYanNKZm1nUDlqSlhWL1NrUUlJRGlMVVJOTU5YZVFXT2pmdUNu?=
 =?utf-8?B?RU9KN083ZzBpSlRwUTQ3ZFh0RDIzUTFKb3gzbTlwMndQRjRVQ2tEYldvWDRr?=
 =?utf-8?B?eWVBODgxUjg0d2h1NGl6ZFFuS1JCWDZGUStIc1F2Q1RsUFNCbDlUUWh1c0gr?=
 =?utf-8?B?aWsySWJybTNqMklaYWh5VlQ4aStwaWNoVjltbVNaeGdSUU1Nemd5ODZkMjBp?=
 =?utf-8?B?QmIyb3NvcmZMS0JvdzR1UTNaYzR3MU5MeXJZdkZMeWFHWDRQU1NNcGhpY0My?=
 =?utf-8?B?TVZ1QlZxYTFqS1ZXa0UyM21lNGlaSExtSGd6cTdyMFJXTEoremE0Zms2YUlQ?=
 =?utf-8?B?TUVIQXNhc1lVS0gvUzZLSEdLbkFyempHZWc2eHhPNS9UOXRKNDFyNElwZVhK?=
 =?utf-8?B?eU52amd5S2Zuc3ZLdVJ6dSs2VUxvL2tXVXlhcnJ0Mmlyd2NrR2hjQTlocm1V?=
 =?utf-8?B?RGs3YzViRjRIeUNyUzRSeWtscVoyNm5GZlJJaFRQY1ROd0JiWWhSSHAvMkpR?=
 =?utf-8?B?Y0U1Qmp2djdodGZhOGxtU1FzbzllM0JuWDd3dGhUdlNBbWRwUEFCUFdJNFI5?=
 =?utf-8?B?MHhzdmNFZDh0cVVHUFNkRncwb1BuT3djZkpWb2FCTldpR0kyaWp4akxkc3ZK?=
 =?utf-8?B?MEkyMy8wUEp4bFNwRFErVmxRMEdpY0pwOGpKa1dMSDUyQTgyb3N4a2JzNHYr?=
 =?utf-8?B?dGNMY3UxL2t2MHZicXhFSUVmMUtEQ3ErcGF2WDhBam9TTnhsTnNrVmRUOGcr?=
 =?utf-8?B?VnVTRmNWa1QvQlZNcFMzOVRyQk5IVXN2dGRKYjF6YktleGx4YnAvZWhDSDFG?=
 =?utf-8?B?clRnV2pxcmVpVFBaQWVyUnVDbUtFbThiSURGUThCK2dPYnh6ZjhLS2dFbm5j?=
 =?utf-8?B?Y3JRanNrYjR6Z01mT2VPcDFXNmhtVXMvSzZQeldqa2ZCVGIxTEFSMlRYS25O?=
 =?utf-8?B?c25CcVRoVGplVHo4bG1abDVNd3pPNi9XTkh1dGU5Z1ZnRXRFRHNsYURoTTk4?=
 =?utf-8?B?VGwwTGpBcVcySzVWamsyT2EyeUIxQU5EZGhIVGpPdlFOMlAwaElBZUJZdVhV?=
 =?utf-8?B?dHRIVkowVnd0eE9CMHp2SXlNUXMxVnFWRkxkSnJPajB5YmZSMGdVeHdLK0la?=
 =?utf-8?B?UDhTam1xWk11VURSOGRYZEY3SS82YS9XdlJMVTFVZ1dTM1lvQm1xa1h5QXJQ?=
 =?utf-8?B?Q21JUkQ1eFVZclNHdW0ycmtnNXg2VFRJUzlPaDNybk1TcEtBVk83ZXNaOXpN?=
 =?utf-8?B?TldRb01Hb3VnekhaQ3doS09BMm1lTTNLNENvSTJ0M1NndFZPYlc4Tm5HYWZS?=
 =?utf-8?B?ZDNqeTByZ2d5Z1ZZL21BRGRCNUxhM0RyejZzWUlZdTRtWjhEQlZabWtaY2Iv?=
 =?utf-8?B?Njd3M21pMjlKN2U2SzNGK3k0VUt1TVdlSk5vUytLZ1ZLd3lFbjVFSUdYVW95?=
 =?utf-8?B?VmIvYk4rK2xNemsvWjVaZGtpRWlOT1JaZUw0UStKczNoZkR3RVBvZUhmTDF3?=
 =?utf-8?B?RjNVUzFXMXFYUFY3d1JlTlJhaTEvcWxqNlU4Kzh0ejRzbjNhUERFZnBHWU1O?=
 =?utf-8?B?Z1JKTWdxNlNwL0NPRHpPK09la2cwNWhCU3dlSzR3NlQrZXdjcEJ6VXRhOXl4?=
 =?utf-8?B?Uk16eGM3Y28yRWc1cTE0alo5NU12ZGliM3E5UngrRUEyTHNIdHhuMTBWRVRB?=
 =?utf-8?B?N1dZTkVaRk5rT1pDeFpLM0NFcksrRDROcjVKRmRhQ3dJcG5jcW1qV3JpTUk5?=
 =?utf-8?Q?UQVUBSPpFFb3UfaMC+B7zA4Xr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDF14E0531296D40A3123FCEF0759930@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1ed75d-1ad8-4aca-27ec-08da8f4941f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 14:16:42.7757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NayrzoK4raMvAotKSfMC1affuI1irzKZ64HN1cU0OkvVylxc2hEgX8Rga+WHTB011lyjYiXSHsjGJgai4Gv8krdVYs45pV5wP2Xi/W1neRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2557
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDkvMjAyMiAxNToxMiwgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gTW9udGFnLCA1LiBTZXB0ZW1iZXIgMjAy
MiwgMTM6MjM6MDEgQ0VTVCBzY2hyaWViIEhlaWtvIFN0w7xibmVyOg0KPj4gQW0gTW9udGFnLCA1
LiBTZXB0ZW1iZXIgMjAyMiwgMTM6MTk6NDEgQ0VTVCBzY2hyaWViIENvbm9yLkRvb2xleUBtaWNy
b2NoaXAuY29tOg0KPj4+IE9uIDA1LzA5LzIwMjIgMTI6MTAsIEhlaWtvIFN0dWVibmVyIHdyb3Rl
Og0KPj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4NCj4+Pj4gVXNp
bmcgdGhlIGFwcHJvcHJpYXRlIEJJVCBtYWNybyBtYWtlcyB0aGUgY29kZSBiZXR0ZXIgcmVhZGFi
bGUuDQo+Pj4+DQo+Pj4+IFN1Z2dlc3RlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlA
bWljcm9jaGlwLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSGVpa28gU3R1ZWJuZXIgPGhlaWtv
QHNudGVjaC5kZT4NCj4+Pg0KPj4+IE1pc3NpbmcgdGhlIGNvdmVyLWxldHRlciB3aXRoIHRoZSBj
aGFuZ2Vsb2c/DQo+Pj4gQXQgbGVhc3QsIEkgZGlkbid0IGdldCBpdCBpbiBteSBpbmJveC4NCj4+
DQo+PiBkYXJuIGdpdCBzZW5kLWVtYWlsIGFuZCBpdHMgYXV0b21hdGljIHNlbGVjdGlvbiA7LSkN
Cj4+DQo+PiBJLmUuIEkgX3Nob3VsZF8gaGF2ZSBhZGRlZCB5b3UgdG8gdGhlIGhhcmQgcmVjaXBp
ZW50IGxpc3QgZm9yIG15IHNlcmllcw0KPj4gaW4gdGhlIGZpcnN0IHBsYWNlLCBidXQgaW5zdGVh
ZCBnaXQgc2VuZC1lbWFpbCBzZWxlY3RlZCB5b3UgYmFzZWQgb24NCj4+IHRoZSBTdWdnZXN0ZWQt
YnkgLi4uIGJ1dCBpdCBsb29rcyBsaWtlIHRoZXNlIHNlbGVjdG9pb25zIGRvbid0IGdldA0KPj4g
YXBwbGllZCB0byB0aGUgY292ZXItbGV0dGVyIC4uLiBzb3JyeSBhYm91dCB0aGF0DQo+IA0KPiBG
b3IgdGhlIHJlY29yZCwgdGhlIHNlcmllcyBpcyBoZXJlOg0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMjA5MDUxMTEwMjcuMjQ2MzI5Ny0xLWhlaWtvQHNudGVjaC5kZS8NCj4gDQo+
IFRob3VnaCByaWdodCBub3csIEkgZG9uJ3Qgc2VlIGl0IGluIHRoZSBsaW51eC1yaXNjdiBsaXN0
LWFyY2hpdmUgb3IgbXkNCj4gb3duIGluYm94IG9mIHRoYXQgbGlzdC4gTWF5YmUgaW5mcmFkZWFk
IGhhcyBzb21lIGlzc3VlIHRvZGF5Lg0KDQpJIGVuZGVkIHVwIHNlZWluZyBpdCBpbiBvbmUgb2Yg
bXkgcmFuZG9tIGZvbGRlcnMgYnV0IG5vdCBteSBsaW51eC1yaXNjdg0Kd2hpY2ggaXMgd2hlcmUg
SSBjaGVja2VkIGFmdGVyIGl0IGRpZG50IGNvbWUgZGlyZWN0bHkuDQoNCj4+PiBFaXRoZXIgd2F5
LA0KPj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQoNCmJ0dywganVzdCBub3RpY2VkIC0gcy9tYXJjby9tYWNybyBpbiB0aGUgc3Vi
amVjdC4uLg0KDQpDb25vci4NCg==
