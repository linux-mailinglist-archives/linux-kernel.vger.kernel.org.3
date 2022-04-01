Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6E4EE65B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiDADA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbiDADAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:00:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180E513E430;
        Thu, 31 Mar 2022 19:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh+8r5cynXHPNq9tYYRdmO1/G557a+dkA8Fx2Ay/lN0PCdmxKLD9N3WV5Ng8WtfLrww2pgSsiRVnIa1HLknTp2TPwrV0hpGLV7YfNyLvMdcYlCH1kk+owZhualgPsDXPhHZKdKQL7MvsnYp6u0DmGPV5t8jS4R2OITxNNgMwiOeXt+lLJyyQBoj3Qc+iU/yAf5Xx26HvtnEghyVny44CFk0x7Kb7WfknzZnsWyl1fE/tmYtyT8QAyBjgQvaKQ9qhwMrpvS1g3ZTbET4PgMvM9PS+xRJ/ofOGASVK6+W9U8aufJPlRlDg9XdcTV+ztmID1EoY/3uITGxVDKwpNVtFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH87abgXgaKhHeaoRMgBOm7FfUU9jV0vzaUx3C7Ub1k=;
 b=bJoi8bA5YoL/+T4smWZdcJCIDzxFBIkLAL7i7G5WASIDTycrxz16caIgS9NDSTNjjmZ5pSVA3e2dCHD2MXlhXE+Z8s45zKrRWLG6Fwelv/3js/ax+8FGwkdGClA4KSE0Eiau8R26H3SfaSk8fqs2o6Ee/J2Azl4d3Yec9KajxtYKUSYL3W041VCNk18p6Njz3kQgy2IbGXW1Sr5BrTfaRkD6a+nO29PGkhDVmsqU6oBAjVvWwo7QDpZVur5CHkjeFaXcNxZ8CPNBj39OuzfHs+BFjfp0WsYnxh0YFqhPBXpQ/ztJ0wM7oXP8wVIUqV++z76xH1XOFSLB4hlcPM4+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH87abgXgaKhHeaoRMgBOm7FfUU9jV0vzaUx3C7Ub1k=;
 b=JJXmDh1oo2iOmspsiKCspcQItFE0nIdJKdAeRrj4nMi6fipcKp9+GhIUxigWZg6eZLespOep5QOlT+r4tKJtzfH4fYFXPnDFOw9Uwrl+UtBsaPWBlOtEGKMAup45fCU3CG821SyUdQSavd/DqoY38vc3B5NSDeZOylJz8A09WY6S/kP+aZbrORwxe+Z5Ms/2MPjB6nlBkXD9PWFzAB/IoggZN6sQF/FT379PKywko1X76Ntdbr0Vx/by5XhdLK39w4qsV/GyJLAbh9T2d1arC+Zi3QEgITUOLdD49PqKVFS5ETmy2Az1PRm8KG/XM1AbCgeJLlHa5SoClgdAPEcRkQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 1 Apr
 2022 02:59:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.019; Fri, 1 Apr 2022
 02:59:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Michael Marod <michael@michaelmarod.com>
CC:     Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: NVME performance regression in Linux 5.x due to lack of block
 level IO queueing
Thread-Topic: NVME performance regression in Linux 5.x due to lack of block
 level IO queueing
Thread-Index: AQHYRJPdEASHqlgOOkeQA9+5bxa47KzY6EUAgAE61YCAADOygIAACOsA
Date:   Fri, 1 Apr 2022 02:59:00 +0000
Message-ID: <a00e3a0d-8dff-c845-ed3b-9dc435187ecd@nvidia.com>
References: <51E3A396-F68B-496D-AE36-B0457A3B0968@michaelmarod.com>
 <847D3821-1D92-468C-88C3-34284BA7922E@michaelmarod.com>
 <C06B8EF0-BF3B-4F14-994F-F80B5102D538@michaelmarod.com>
 <YkUvgu6VxNORv8M6@infradead.org>
 <4034AD9F-2A6A-4AE6-B5FC-58FC2BC238F5@michaelmarod.com>
 <YkZi+co1HchfRafa@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YkZi+co1HchfRafa@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9dc105d-cb90-48ef-8417-08da138b92be
x-ms-traffictypediagnostic: MN2PR12MB3759:EE_
x-microsoft-antispam-prvs: <MN2PR12MB37598020C179062E17E04A94A3E09@MN2PR12MB3759.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iyzX/iZGXsD11/sF7oyQf9soCKjM1d54QclsJZ+FlrAyF77q45yDlsaDwgybMgG7uXMPVRffDPAfiKczktlDQQfQ3pr3aH89SjF6c85TcMW3QKUGoVi0ZxI2RzENsmO/nSOsCEul40dYr1mJhPvdGxjFG4OOK3Ka+JSk8K9fJhL8W+oUyFKebo10JuQKDUTT9rBeGKlcWCVZ2d5gXujrDVpp2jj5c2GchJ8CQgu7a50wjQz3K7UYTp7DXRhrtqlB9rq3JV785mHsinL8NWIpb7D1uly6ikh6uz+dVWxSVhhlVwpY8NrXaJapp+q9iIeT+9gRRD/qZn4xMpOvycj+jq6pZ/tIzWqqsKAGvM0628DwAD10JaUOLaR38Jt7fnCuhi3CDOaolBOaDuBojwOMhkX/ipMzkBU/zBiz1+ogygMa6WaCing4O3cKFv9dcCEvEjds+iTUMxIxNPyqBRekrNcVZuO6D3RWCdetkWtqo2hoOOS0FSvZ/hH3zXvPmvD7ZiQndEcrKRz79sTBgiglR8jRSHxC/7wxW5nU/Y5mRKi57IpnZeqhihE0Mj5RG81Ydl3eZXuFkD9UA78jPdB/LVOn8byMIaOusHqqo59Ilh4yaOSiP7E9N4/DM13bFXMx2A7FTOxtQrS9yg0+Sr/UjyTKdBMpP5lN99D2vsWm9xUB018JCQkQg1mRnK993e4OGRafCE44co9MxyHBszW5SXHe5PWxgHMatPIIGOwqfJqOP3EI/d4PbxcHB7tE+EFa7umaqyA0jRzcC3zJBxE2ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(76116006)(36756003)(8676002)(91956017)(66446008)(66476007)(6916009)(316002)(31696002)(54906003)(86362001)(4326008)(122000001)(66556008)(38100700002)(64756008)(6512007)(8936002)(83380400001)(6506007)(38070700005)(4744005)(5660300002)(508600001)(2616005)(66946007)(2906002)(71200400001)(186003)(6486002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkdOcnd1dWFYM1pTcG9uaVdRSUxVYXZVQXk3WmhQbDBYd2VJdm9jSXF0UFVr?=
 =?utf-8?B?QlBYaDBFN2JjRGFrektkeUdpbFVVNld5SWV3OHlCUmFHQ3h3aUM1SEhVY0Z6?=
 =?utf-8?B?TjZyMjVvTmJEcXIvUFY1QVp2VGRwQXdISmdSRGMzSnliVUNMUzNFUmxvK1c2?=
 =?utf-8?B?RTNzZkNBTkZhMXFaSjFwZ0ZGMVUxbTBvQzRwOExsUHQ4MnQwVUw1a0hLaE9k?=
 =?utf-8?B?VGZHUlFLMzNkTGg1SUFKZ3liNzEvR2RUU1BaU2JCSnY0UVRUbFpFMUI3a2VT?=
 =?utf-8?B?WEkwb3E5UEgvSnlRL0xBVEpsbktjbjR5QlJ0a3pOVmMya2x2ZGZaeXNiNjV3?=
 =?utf-8?B?OFZodXhNVG1id3JoVjd0U0JlTFRyU0NuWDNLMXdNMVdTNXoyVk51TjBhSzdF?=
 =?utf-8?B?K3gxS2V5VUZWNVJ4SllFcFY1aFl6KzdyWjU4c2tMTmdEbnhUSHdRYU95VzMz?=
 =?utf-8?B?YTVKQnducGxqMDZYam1NTW1HZkxMcHNZSHBRd04rVnk1UVVDa0pUNURFeENK?=
 =?utf-8?B?M1dDVXFFVFFURFBUcDNkdmREQ2JUZERuaGxkSkt4NG9rYThXeDdaSUx5cmlh?=
 =?utf-8?B?Ny8rZjlITHFSNzVBWnRucnVjYVg3U2JSbTVCaGJnR2FNUlFXMzNDZDU4d05q?=
 =?utf-8?B?TkVSdVltL0tSNlRjZVpwVjBwTk9yRWp6UytKZm5sV2pNbFpZK0dSeHJCallu?=
 =?utf-8?B?NHpFTlZXaloxY1cvOWc2TlJLVG1WbFJCbDhpMDNPKzlzeEZsQmd5Ui9HbzNG?=
 =?utf-8?B?aEJLeWlCb3RxazhVWU81bjJnb2ZRNUhQczNEWFlIcGZSSmRqdE9yUE0rMmZH?=
 =?utf-8?B?NzRDRVlXdjF4aHovTXRqRXltbmRyZ2hVTXZFZXZiMC9GUm8yOFNQU0JxYmI4?=
 =?utf-8?B?N3owc0U5R1F3OEhmTWp3NmRLWGFLcUZ5U2FnSEI1djJRZ0RoMkhlVmdldkxl?=
 =?utf-8?B?eTA3aXVHMU9lUHdDUEMyYzFLR2dBbllDOGlUQU9tWE1vRWtaOXdKWVZsWUw4?=
 =?utf-8?B?bVY0K2JZOFNTUHBOQ25pclk5amxiNldJeEErbndJUGxrVDgvRUJ0YVNXZlhF?=
 =?utf-8?B?TC94UjQ2Zzd3RVdTc2FyaTZvbi8yaHNCZWRQYkNiS01TWjRaMHlJSTBZY2dO?=
 =?utf-8?B?TnZSNEtHWG1wQXM1bnVnL044QStUbk1xLzB3TEpPQVRUanQrcEhUZDA0SzFm?=
 =?utf-8?B?bmpkK1BnOUlXSm5xT3dlVHVMT1p5ai8wTEdDM2xxUlFIbm52eklacFd0ZG9U?=
 =?utf-8?B?ek9RUUo0dzBGYWQxc1FoRDJRT0VDa1Z5cEx5MjBmM1Z1bG8xTk9hTkp1MUhY?=
 =?utf-8?B?SGhuZXBlVHFMN1ZjT0NOdmMwemdPckFiaFIzMTNNNWY5MG9NbFd3RnJ3VGEv?=
 =?utf-8?B?OVF6d1ZFTXdmd1pLSFVlbmh2ckZZWXNCSjRXTzVKTjlLZ1VkSXppcGsvdDEr?=
 =?utf-8?B?dVkzSG1XN2R0MU1DL1FBbGxZTlN0MHBtakg2SDMraXRXWGdPUEI2RngyRXl4?=
 =?utf-8?B?WjExWjUvOWpjYXNxNFMrTU0vblo2RjhvQStHT0lydmowTEJ2czJRQXhLQ004?=
 =?utf-8?B?b2NsRmdMZGtPdmllbWw4VUUxTXI4OWgyQ1VqSkRqcHA3enlqOGhTYzc4Zm5t?=
 =?utf-8?B?d0w4OHltMkF4T2NNSDlpZ3VJTll4czZGandRZ2dGcEFEUlFMbVRnYVBnWDE5?=
 =?utf-8?B?YVhtWmFZWHpmL3Z0UUhqYXJxWnk3bVRoY3RtS09HKzBhYWlYSFllSzc1Tm9v?=
 =?utf-8?B?M2tFaHYzSEgyTU03MFFxYnBoNnJsN2t6RUhNY0plTkx6S2pjOVZWVnZRVTBx?=
 =?utf-8?B?SGRVRmJoNlQwSkdGZ090TjdKdXZ6Rnp3ZXRJcTZLZVZETTVyRzhqMVZhbnVv?=
 =?utf-8?B?OVFOa0VrZHJqM0VzL0U1OHM1REduRC94Q2NSYnpTcUpvN3dJMXJnTEpIbzN3?=
 =?utf-8?B?OEdZN09MQ1oyUG91TERaT3d5WUY1ZlQzWHpFVjE3ZGJwMGl5enBqRFM0dmV2?=
 =?utf-8?B?aVRrS3FsM3BRTmdTQW1ZMlI3c2RZNytZYUVkSmVleUlSblhsbVE3S0JiUTFu?=
 =?utf-8?B?UzBFR0haRGlOcExjQm5paFFReG9XZ0puelF2Qzg3QzV4UzgyUG9jZlBHeGxF?=
 =?utf-8?B?a1ExM1hRc29vS1IvLzlaK2ZrR01lcTNUeTg1d2hEVFlJMGw0NkRKRVIyd00r?=
 =?utf-8?B?YVp0ZHFMZ3Rnd3dFU0ozWGZhMm1nNFBBU250V1R6eXB5SE1saXp0QkVnVW9h?=
 =?utf-8?B?eS84MjAwaDVvVWVEcmpiajRMQXJ6NG9JNWd5U0VCakJBbytobGJscTMzWTdH?=
 =?utf-8?B?Qk41enpBYnZnVCt2bjRzY1c5QVZIaXpmK3FqbkZYZzNhc3phdjlvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15BE18793FA91245B52938A38ED65B84@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dc105d-cb90-48ef-8417-08da138b92be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 02:59:00.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaYuMZ3lXx+ICgYckHbIfcswr0bx/BfeqIoVpR78OXSxFtIDQ9r58qubV5GTPU1XEEHCJexktYxyFe+oCgoZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFRoYW5rcyBmb3IgdGhlIGluZm8uIEkgZG9uJ3Qga25vdyBvZiBhbnl0aGluZyBibG9jayBv
ciBudm1lIHNwZWNpZmljIHRoYXQgbWlnaHQNCj4gZXhwbGFpbiBhbiBvcmRlciBvZiBtYWduaXR1
ZGUgcGVyZiBkaWZmZXJlbmNlLg0KPiANCj4gQ291bGQgeW91IHRyeSB0aGUgc2FtZSB0ZXN0IHdp
dGhvdXQgdGhlIGZpbGVzeXRlbXM/IFlvdSBtZW50aW9uZWQgdXNpbmcgbWRyYWlkLA0KPiBzbyB0
cnkgJy0tZmlsZW5hbWU9L2Rldi9tZFgnLiBJZiB0aGF0IGFsc28gc2hvd3Mgc2ltaWxpYXIgcGVy
Zm9ybWFuY2UNCj4gZGlmZmVyZW5jZSwgdHJ5IHVzaW5nIG9uZSBvZiB5b3VyIG52bWUgbWVtYmVy
IGRyaXZlcyBkaXJlY3RseSwgbGlrZQ0KPiAnLS1maWxlbmFtZT0vZGV2L252bWUxbjEnLiBUaGF0
IHNob3VsZCBpc29sYXRlIHdoaWNoIHN1YnN5c3RlbSBpcyBjb250cmlidXRpbmcNCj4gdG8gdGhl
IGRpZmZlcmVuY2UuDQo+IA0KDQpXaXRoIEtlaXRoJ3Mgc3VnZ2VzdGlvbnMgeW91IGNhbiBhbHdh
eXMgdGFrZSB0aGUgcGVyZiBudW1iZXJzIGFuZA0KY29tcGFyZSBiZWZvcmUgYW5kIGFmdGVyIG1h
aW5seSBmb3IgbnZtZV9xdWV1ZV9ycSgpIGFuZCBudm1lX2lycSgpLg0KDQotY2sNCg0KDQo=
