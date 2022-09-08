Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8D5B26EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIHTht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiIHThi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:37:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3112105D5D;
        Thu,  8 Sep 2022 12:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNAprcxNtRHHB+FXF0H2YA7g5WMMJbR3Atpbx5TRpFFytOrVbEUeJofhhYKgCXOZPsdT9eIGWZU9Hb83lW0gLDf04IE8By6RM9gWQRY6mUYTIqEo3Ogv7kz2uuORX7dYSCVd4kRP9n0R/O3ci6g+AmApU0KwDtF1K8no3Lh0qYNh0zX2Gs2GscQVY1QkJS/nm/N65Kbku8qPRZsRNybhplJtGjQTRQWvArvQQPnpPYX5oR65069iSKI/lgahoCaLcPyxOIK/qzhv15bmeDUki/zHDyUcGeXW3PoymXPG/cO6gGTa8/mbDZCvMN/aI2JHYMVap3dfjK1cv4YENoq3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NkXXuLSr9czwvpWdFHoWyj+h8QojskaDLguB48zgGM=;
 b=ld0a9JfnFzOK9opkE97VHcf8xGBxgNmm8CfoGfrINF0GKQpzIX4rOzCmH2AOAotXn9O5rAv5E1DKJdXjVXPA69J0y9s3WGdycL0li6xFfGNi3vyWIzJhsnQ3kdZQSjcBHc0mMiWc9b8zg7OCAwkvXN4wyrc1hQQA7JFkn8tr55/6PQZt4+dJS5cJmNmz69RIVafTtcsupIQhjElY3rgjeSAIPQs5chN0wH28Cm/Dh/UtN9+YUpJdZN+Sk+jhvaC6zF9d/m5Cx1SrQRSF01DvkMM7cx+ssQqKNAIX5Imjh4fENUkdLtxUoJY2Ykb//nR9wJKeGsqbmg9hHe2ULBgosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NkXXuLSr9czwvpWdFHoWyj+h8QojskaDLguB48zgGM=;
 b=K6X0rw+8uhpVGHh4UK8OTEpMIcPrIg7R7AC1Fq5Jm/pZXg6v2+SqnQBmLUsxXLF795WDD5w7magBEm97hmHRTKJlYi+KBS7HOWCssXDw0noOrnZMUO+fvadr3WOeujSL0vpY1iZEEIcedypmj6tcAsv5Cgaq6uk59/QHbFyruIoKDNcVYs1i17NAmkrAThqu0yEY+BAHrd34coVC0TMpY+IBpI2WQM3A/M6wIa1UBXcXx7L/Dr3+46+T4TrHv8zSm8qNZWRWlCs6QQhMasc/SqUi7vh7pfRm64ayxvyujyHI3eXF+FZY3lmo1La5C8XlNw5Rg9du8R5BAO+bF1YoBQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 8 Sep
 2022 19:37:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 19:37:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     wangjianli <wangjianli@cdjrlc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi/ibmvscsi_tgt: fix repeated words in comments
Thread-Topic: [PATCH] scsi/ibmvscsi_tgt: fix repeated words in comments
Thread-Index: AQHYw4Rz+zvcH6OSkUKQDLSeGhS7tK3V7c+A
Date:   Thu, 8 Sep 2022 19:37:25 +0000
Message-ID: <415605c8-d075-facc-0fe9-5f212976ef6a@nvidia.com>
References: <20220908130910.35680-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220908130910.35680-1-wangjianli@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6959:EE_
x-ms-office365-filtering-correlation-id: 26d83673-32e8-4b89-ab0d-08da91d18ef8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3u4EHwl92v4RZEUeARW1uoFsmxDoqrL+Ng7cWxZ18p4mTU5mNNH/L5jISk6FWk8v3yaBC7OIQ59HrOUUmMf1ektcGsJVF+ttn3dyoKkz/rZTY7+DGqT6eaSY21qEauyH8sVRMuZsJkDaAtzUP2vAartySbs2L2KI6NBxzdd77mxYh3AhF6wPS20/F2VK/XOwzmbkcRPJHkqT3CXwDU5uwrxONfxt6N8bohwZLGM97nTzLBKkf2goJ591tfATT9uQNTOinJfvlVHojL1z4z7WF4LXYZMY1WnEhhjgVohvj1fuOmpbcdGh7YRewwiu8WLmrNGQp+jjNYjlXr0PAuus7tnuiGHVDoEFWsSmpdo7okPH3eAdcOvPgrC5zz0tzxdrwANP1ACjhXzJ/2jVGoKkea3B2QZf2vge4qr4m6Heiq8R7sD5cxq+nVnvLVJbCRiwCQDxXiXNs8LkivV0qfPxqzeNIBPEiyxKBhFGgX/Mhz9q76ngX1jdLRFjvlJItEJaDEtTJzZTwFNpt78SPpr3N0L7qiSukeETSNEz7xnvoVrfn55y1MeSBX0JiHyHNa9Lr1ecmQsQHTnK6HUKUfe4y3Z6BtKtJgwv54aGtDxyx7AZVzDFTiE5MZ/fIF60waLgGLq/o8csVzkotHZu1UJyQaCacNcWhwlbtMktHGgEbHg1hFGIoJ+z4eohqdz3mMGzEsAJPiQznZu5pZ+4+R0SNM9zE46h+CKzqTTzzHpfCpsRIxZUYd1GA8NrNiPG9xZWbAYmfwBYaFAM07wTPmndEdHabXyfjXP95OXgQ+l/NJt+NK9UbnIO2Aol9W0fmbMgx9x0IimIL3pdlYPsza9wxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(6512007)(36756003)(558084003)(2616005)(186003)(41300700001)(38100700002)(83380400001)(31686004)(53546011)(6506007)(478600001)(2906002)(5660300002)(64756008)(8936002)(66556008)(66476007)(6486002)(66946007)(76116006)(71200400001)(66446008)(122000001)(31696002)(110136005)(8676002)(4326008)(86362001)(54906003)(38070700005)(316002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHpDNk9CaU1OMnA2dmltb3NGbFdrbnJ0YUtjZXZsY3FwK3BqTENrc29LM3Nu?=
 =?utf-8?B?WURIU2FoSmZDOXg4NEo3OCtMb2hrNmVhcE4vdW9zc2Z5b2htaWtkS2RadzVO?=
 =?utf-8?B?Slg2NGN0Vk9VM3N2RXRsdXNlUGgrbmhjam1IdUhBREtFMlduU09UWitmc1Vk?=
 =?utf-8?B?ckJvM0V5SXRVM0FWVjZwZzdRZ0lJODBmcmNiM1NEbTVLTWxkbFBkMlNuNDBr?=
 =?utf-8?B?QTBkY2c4dmlXeWFKN2ErdU1jYnJ1QVFVUjNPWkRwT0NuR2JpZHV2TXRRb200?=
 =?utf-8?B?bUt5K0thRFAvRmtGK1ZpVStqOVB1Q2RFQ2pVL2w0Rkh5TmQxOVZRMUduWnlI?=
 =?utf-8?B?Nkx5QytwZFNwMEZjYUY4QmNZaGtvandzd2hEMndtb3N6azR5RDh1eGhHbUVP?=
 =?utf-8?B?d1Iwckt1Zms3cGZJUmZ1SzYrRmQzY3J5akFBZ1ladjFMMHU5QUVGd0M3a1lj?=
 =?utf-8?B?cWNIK044dlVkMWh3VnZwVmZlc0E5WHBjK3VOQ2txZnNicE95UlBXMXM3Zlhw?=
 =?utf-8?B?TlRBSnVjRWcxT2diVjRNVHNWUVFVcFgxajFTcUQvN1JveXJ2cEYzcUs4YUtw?=
 =?utf-8?B?WFhpditDQzUzbzQwV2xFTU0ya3JnZU8zRFRiSnNwWE96NDRtMG9zUEo5YThM?=
 =?utf-8?B?NjJsVjF1OGpXYXJ4WkUzVEMzRFRNS2dNSUF2K3FCMlQwajFQT1FNclBhRmxF?=
 =?utf-8?B?dkxNOXpwZm9pdXR2WnVHNjcwL3JRTnVMRFZSRGgwRWtwd1Y2dXh4YS9GZHR4?=
 =?utf-8?B?MFZSak5QZ21LbEY5Rmg4NVdZQ25Cak5RaUlzR205N0xKcTBJVzNzOG5MSzF1?=
 =?utf-8?B?TjFOb21mMjFoN1dHSkJhZGFsaWxOS25LZFYvcGhrVW9HVngySzluZ3ZFOGxl?=
 =?utf-8?B?RlVTK2R0NzdVaDdlQ2x0Sk1UOTh3RElVTWIzWDQycnJGNFFvTXUwSHdZTUpw?=
 =?utf-8?B?ZFA4WmovZWhGQmErVFNWb2FMTi8ybGE4Q21GUDdLMWUxdSt2WExtZXB2UlNz?=
 =?utf-8?B?R2dGS25LZ09ORmdoUzkwR1Z1ZXJBaWh5c2EzNGJEVytRWjU0Ym9WNGs3RWVE?=
 =?utf-8?B?SVpMY21hZEU1ZzEzbDB1aXBQeGh4eG9LaWNlV3pLQzE2OFp6bkplQk1iVUZ3?=
 =?utf-8?B?TkdzMDMxZElPeGRyUzdxblNtSkZsaFptdlYvNHF2eGIxUTZodVFUQnR4eGpy?=
 =?utf-8?B?RkhDVU5jYlhFSmN0UFlvRjRxWC9JbnEyWDJPUTdMNjNuZ3dkVTJUcnRKOE9G?=
 =?utf-8?B?STFEUUZydEwzQzMwcUlCTGJnVWt5eXVhWldEMmhQWUNwL0E0WWgvaTE2bU5Z?=
 =?utf-8?B?Z3JIU0ZrV3Y5RmF6VnVGdGh0WWJ4b2VUdEFaaTljVHN5ZUZKY3NoVWNyWmkr?=
 =?utf-8?B?M21vdzFxYVNjdXg1NXVLSnJqcWoxdDZrSTJkbk14ZVBSNU53bXhiV3RDSTBa?=
 =?utf-8?B?TE4vZEZPajkwdHBMci9xV29TZEpLWjhicFg5SEhpQTdCM1loSVhwemZWK2NM?=
 =?utf-8?B?L2w0REordHVURGZFYWdzRDQyT0UvdloxM2pscWZOSVcrdzB3WkxHNkttQnlq?=
 =?utf-8?B?ZUdkaFptOTltOUFIVEFWcHpsUUtOMms3Zlc4MnR0TWd3UWM1UnpiTWVYRlNQ?=
 =?utf-8?B?QkhRM2k3WnNsYVNWenFvcURGL2I1c1dCaUNMYU9GNzBGaFU0cjRCK2wvYUh2?=
 =?utf-8?B?djMyZkgxekxWd2xmVFFUTjVBRHJWaTFveVZPanBWU2M4eGtpTmFPNHRPUUNX?=
 =?utf-8?B?VU1kQ1dpQU90emhPeUpFRGF1ZUdva25Fd2lObXRvQ2JMUnRZWUZYUFQ3Ri8y?=
 =?utf-8?B?ZjJFdm5QTU1vajJNUWR4Y0xhZnY1S3hmM3VZWStTR00vdWd3MXQ2cEJuV3hX?=
 =?utf-8?B?U3ZaRVo2cUdGRVBBNzJ3T3RBYUJCajBxV25vZ204L0RhaTAxT1ZrV0JYaHRV?=
 =?utf-8?B?ZXhGZFVZeUJWRUhkcUsrRHFKRGxUQjYwUjlYcTVLVk13ZjFqYXVoUkJxR1VG?=
 =?utf-8?B?VDVNSnFwcU5BdXB1djYzTU9FV2FyVXprL2VIWm5mQXNQamJGVHFsUDRiemMv?=
 =?utf-8?B?RTYyL0FxY3BJY1B0dTlaZ2FnTm85SmViYnBPU0xha296LzZ4NGJ6VzQyL0xn?=
 =?utf-8?B?eUVQNHdRUUE2NTAzdVJLZFBFc29GZzYraXNVMkNkUXg4QXNBVVZ4eVhKOHBk?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F161E73A0EC5F4FB3B906A7EAFE6BBD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d83673-32e8-4b89-ab0d-08da91d18ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 19:37:25.9044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JX7jBCoMG2XsmpayjG5LE7ixDM9Bb1eED2JB+QG6aiMl9phoh70MM+Ao7kV3AYGypHSSYZRbr7w3ohG/4CtBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS84LzIyIDA2OjA5LCB3YW5namlhbmxpIHdyb3RlOg0KPiBEZWxldGUgdGhlIHJlZHVuZGFu
dCB3b3JkICd0bycuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB3YW5namlhbmxpIDx3YW5namlhbmxp
QGNkanJsYy5jb20+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
