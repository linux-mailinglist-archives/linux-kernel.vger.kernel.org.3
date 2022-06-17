Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7554F839
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381678AbiFQNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381709AbiFQNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:13:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64572ED70;
        Fri, 17 Jun 2022 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655471602; x=1687007602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H5W1MvPLfKGnKS6Em2gX4ubOwqR2V5zglyhXFgvT4qY=;
  b=dP2F876/jUSHqfXw1lBEd1xuUh14qB/2z5w/0g6iJ/FVE4SIoDryrbnt
   8BeziD8z00gE1gwXu/XPK4NYJj37+3Av+WI8z7Ew7ZiCL5tUczVW2vTjo
   phnVjycFSNo9ToEo0h5sE1Ty9nF094ISqO/SY2JR7wYaHStWax+XM2YAx
   7TGLv4dgVb6e2oSGDybUY9+SDjUc487IpJYXZfEBZ40WKfZPdMaQs7QAk
   LrU2BgHfr4Zifpf8Ic7pzpOXGPi5nC16BZqs2oghsjhJG5EcX5aj0K0Np
   YRyHq16nWSp3HrI2255IAobYqN7TBqFtM4GJY26pV0HGv4gqx5tJ3e9Z3
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="178398702"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 06:13:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 06:13:22 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Jun 2022 06:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hStu/sCwqS+mmCel3QK4xyXJdhrc4cZbbw2Ic5fn5w219D69r4HOZB/KzIM+8sfhusHYci+fsDySryWGhrxNU5xt+xHcwLlUNiYO9FqowyymxS0Uyv784hOnG9pTFvE1uTpP9tAd75JtiTEIu2cuxeS74qnSRPqbNo2F8nu1m9LQ8ylx2ARFRh/XQkU0O3qlccpt6LzMORkfqeb4ZwiXawg1dmWCxepkJy/hnZfL85X0TDf4Kpd8xAaHb4XnowQYsCfMe6eu4d1urLEFoZcR3N/LS3bLFW1pn9KrigqF04Y0s+3Y88UnVaOzcxRZcC1O6LF5Fix7u0Qk7+BmflyR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5W1MvPLfKGnKS6Em2gX4ubOwqR2V5zglyhXFgvT4qY=;
 b=nWXHMk2J3kmMGGvmQGXNa8u9oeexv9Emj+bKjXlvJ6CVR/AkPL3NhDs60I7ViP/X+zZnHlkdz9VosTm2FXcPEpyBs9QJU4Tjt9O84wQCEYbeQztoEKQew4RQmOp5wEc7CSxb5LEp2TYOUSKBi4WhW52hnRJ7K9GiWkR2AaxHUhP40jz9kOwYrmTfbTRLXy9ng5hEHXOUxhois+y32WPhiRPG7R+uEfnw5Rsl1f1KhnQyyeosHmadj8IyGO8uqr3cTrKkt9sFFKGutqUQgdzYClXb9lnJ2xHhQ7NIj5SsijaEA7Wh0VszK6Nk+DnIEvlnfFmF8odVkT33SOpYqrk2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5W1MvPLfKGnKS6Em2gX4ubOwqR2V5zglyhXFgvT4qY=;
 b=VxMssfP69R0Z486tdhyVp1SvHLSo+sF6gxnigetKdK4LQNymUOb/6Ju9nyEqTH1CSvglKBGf7HCOY9f15MfiG1O+SzyG3OI89vQ+UvbsJjN+n4ID+mE22X2+uj3DTOYhp78mQFvTYQU0y3nTH39Uah4XrW6Q7lYSDYRtgpkKDXI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 13:13:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Fri, 17 Jun 2022
 13:13:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v3 0/2] Add support for Microchip's pwm fpga core
Thread-Topic: [PATCH v3 0/2] Add support for Microchip's pwm fpga core
Thread-Index: AQHYgj/xR/Z8Ogp3NEW1l6/5WqQ9pq1Te+GAgAAWlYCAAACYAA==
Date:   Fri, 17 Jun 2022 13:13:11 +0000
Message-ID: <13e546a2-37d8-f0a2-4651-d6ecf60de0ef@microchip.com>
References: <20220617114442.998357-1-conor.dooley@microchip.com>
 <a2d97203-dd8a-69ea-fdb5-b25f3937163f@microchip.com>
 <20220617130931.3rdaj4p3d54p4ynz@pengutronix.de>
In-Reply-To: <20220617130931.3rdaj4p3d54p4ynz@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c80f76f2-89dc-4d50-bd48-08da506320fe
x-ms-traffictypediagnostic: SA0PR11MB4701:EE_
x-microsoft-antispam-prvs: <SA0PR11MB4701AC7655CD645F8D10970698AF9@SA0PR11MB4701.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMxPeF5mLEoJ/9d9xJL6RGaN1mUmnUgv00/wE2s1SCTl7SDT2j4+w707p6RJrf8C8VI0EFVItfzjGSX/8dZHM/J57p9ZIZ9CleL8QMvrPIg0e55Gbd/Oo3b0Wg07LlnIBIsDbcnOKCC2FTIK+/WmFL6nyh0wKTAShCzXVVZ7cPlduOcuYa6+dP/Tsv/IxLDOy4hfc0shMIWz8r4Lo2dD7c8GLn/9S0ZVuXu56yTdjuLnrOXkjPeAnFxQyvPJDaHI0o4DCDTWiOdICb3Io/DV8lqo4Cy5MBSUsW7kHUqV746/jfAovsVPU2Yfc7vbhSWiHCdorc2CxKZK500iMvrCo7Z8SQCHMeOnMC/VhOpLLX6C79SqU0GN/B3IGjpkkprILyg4OS/5mixSLm0bwVJrZ2eaBZw8B+KBpjs2QMQimB7biLEv5H79Tp+Fr/VPEIAwKtYcmklrIX+OGKg2IkTH5wdJ69PII7TUyg/Da2irf4GS2HTP2n63BEAdcdOPs5uAN9LEbqicqpQl3TccdXOv7rswUFcnnru6r6kUeZIp4h/+x52Pea9x5b7q5svxDD4Ij8KHrKBOJsVOacg0fpMVMoUZSftZ8QZJOCFW+cJXbAd7YOSkdy3roGk0Ke8obNfs4BItOu2s7zkeHrHejiHo5NecbXHQTXrupTKF7W03NUC0cfK+Q8sxQHaxhFGqpzX37pt4g9shx8Q+oIKTi3rXHMF9YiACdnK7pm0GhvzF8NLwFueF7oz/KzM1esjKr9HAdx+AfLAX9/aWrMCiHbiCkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38070700005)(6916009)(54906003)(316002)(66446008)(36756003)(71200400001)(53546011)(4326008)(498600001)(6486002)(6506007)(38100700002)(6512007)(66556008)(186003)(86362001)(8676002)(83380400001)(5660300002)(31696002)(66946007)(76116006)(66476007)(8936002)(31686004)(64756008)(26005)(91956017)(2616005)(66574015)(107886003)(2906002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFcxQWF1ZmQ1QkpFL2ZtRGltL3FYUVFZUHgzNktWbmE2bFlWSmNmUkNtY0xN?=
 =?utf-8?B?TUd3Rjlwd0FVbms3R0h1S2pyN2VRMHlYdkxyaVdBZXVjZEttTGgzSy9tbGRT?=
 =?utf-8?B?c1BpUFFkRTlONmFDcFBpZHpXRU42ZGtaL21xc3M0ckpEbldYV0JaT0ZSYS9j?=
 =?utf-8?B?S1R1Rlc2d24wN1lPcStWcmF4cVlRYUdzYzAzeFNIV29wTUhTM0l5d2MyVjA5?=
 =?utf-8?B?QnhJcm4vS0E0WUJibzhHc0thZTJJQzRtS20rRklLRlBGc0tWWW1nK25aU3gy?=
 =?utf-8?B?ZVRzS2VzUURZak1xelpqVXVJWkk2R09ma1oxb25tT1RSa2o0SWFiYVgxNU83?=
 =?utf-8?B?MXZYcFhHR0FIMWtsV0N1V2toa0JCbll0Z05nOUhtYXNmZ09lRlRJc01CZXlM?=
 =?utf-8?B?MWgzWTg3UE5nZFE1bHZRZHNCSWkvNUlqNlNhYWNoanRPVlFwNitUQnJFcHhm?=
 =?utf-8?B?azRuRnV5LzJvY3lXdWNIZEE2ZlY4S0F6QnJPTjM0UHp0Y0FUVjZwWG82MkNi?=
 =?utf-8?B?NTJjSVc2bkYrQlNiamRKYzd2a2pKcGpWZGFxVzM1UnhwaElvbGsvajhCUi9k?=
 =?utf-8?B?SEltQnliMFNuMXVCU2VXdXhtMlc3MEthb0N4eFRNSi9TVFMxTllrMFBkVjkx?=
 =?utf-8?B?YytrNENRVnZwUk9RTnNyTGZmT3ZTVUNnYTJyazBNd3pyUURHSDNuQTVXR0lx?=
 =?utf-8?B?UnBvQldCajFaYlRDTFk2eDNLVTczTm1DWU40V2RPZjhTUExtUUxkOVBwcmxy?=
 =?utf-8?B?aEw5ZUp1UE5WSFpvK0ZUdUFFcm5sWTVrbXdmanRpWC83OUZWMmJ2Tm5vNmEy?=
 =?utf-8?B?eEMwL3owZHRCa0ZSR3YzTnRoVldaa3J1MUIyTVdIelp6c1BYM2RmSHZhR2RN?=
 =?utf-8?B?bTA4UjlqU0RSc2dGeVlpUHNIcnNlWTBTNVQ0aW9wYlJHQnp4enRVM3VLUHNM?=
 =?utf-8?B?Njg4TjBTbGRGYUI5U3oxWDN2dDFYQVFsa1hTNlRWNlBsTnEzUkY3MFJ5MGZy?=
 =?utf-8?B?WEVBeGN6c0d0QmlNOEFLYWx5WVVMS1d1N29GbFJYQjBEbWRDanBUZEk4NE9h?=
 =?utf-8?B?NEl4SDJuS2QrYjQ4YmtUdWtOOXd2bFJEMUNJNjlqdWhvcGRyV08yM3ZuSlJP?=
 =?utf-8?B?Ykc1VmxoMUl3NnhBSmg2WVJNSzFBY1ZSZlZib0pMdTE3WFcrMjRjanJJVG5Q?=
 =?utf-8?B?L3NpUUJwQUdTVUhEbisra0FreUVYdk9ENEJBbGlBTStlUWhOeXZkOG4wWGhC?=
 =?utf-8?B?dkNmK1NJWEJXeXNJYnpNOGVDNkhBU3RkUEpXRysyKzdLUEVHQ3B3aEN2T3JT?=
 =?utf-8?B?Z01KQTNEODBvSEM4S2FOcUFqZm1KbkNSUFJROXZzbzU5aXRxcUQ0QWN5OHJW?=
 =?utf-8?B?dFluWjc1UzBYMituRThuN09BRHAxSTB3UjkxNkE0SkFUZFphQVM3TFc0aGxz?=
 =?utf-8?B?anRVaVZJTEhiUmtnVjZmRFMwSGhhNjNLUWZSYkFXZ3NmNG5FTDhmK2pDWjEy?=
 =?utf-8?B?QmppempVTTluS1FYVmdHSWFXWENQN2ErMHZoYVRpRHliNWh6TWJ2bTJLdmVh?=
 =?utf-8?B?aWFFL0piQUdDUkVVOFdvL2h0T3NKaXFzS1drZHM4WXY1eERFOVRhd3BlYkNj?=
 =?utf-8?B?WEJ4UCtYbFR1VXBmQXJNL0txSDBvNjgrbmU3eWZCOFlRdE9Xc2loQk01ODdv?=
 =?utf-8?B?Y1VnVE5BYkc2MndjcFp0R1VQWFFjSmdzZXRyNHNPMlFaZzBTSVVub2xHOCtF?=
 =?utf-8?B?R0dmV0lPMDZ1LzNBdlB0NlRRK3dSczg2OW0zMHVVL01Cdzg1OTFhaEpIajAy?=
 =?utf-8?B?QzcrdTI2MGJWRXdvK0tLeWFXZWNmazlzTllkdXVTQVN1UEhmTHVGdk15SmRu?=
 =?utf-8?B?K0xGRmZGYjQ0cW1FQnUvK0QvdlE3cEU0UG12REk4cmtxaVkyamxQbTl1MXFQ?=
 =?utf-8?B?TXRKem02ZGxqS0hyQVZSWS9oeEp4YnpBbjh1UHArZVdHMkVNRlNkWFd2VlVj?=
 =?utf-8?B?VEVKbDU1cmVOMzMraEpNeDBjZ1BoMzJvTkMzU3R6a2tIL2RXbmdxaWdMV0I0?=
 =?utf-8?B?dmhpNllRUDJ3SWt3SFNFMHNXa1NFYWpSQnRXbkRubGVESUtWcmV4MythODBJ?=
 =?utf-8?B?VDRHUGp5VnFqQ3FqdmdTMlgreC9LanZXN3hPc1JMZUo5QnEra0d2dU13QXdK?=
 =?utf-8?B?NjdoaGZKb285VnhUNGNvM212aWVwbFBya3lJUmxnWTdVdnRzTXZ5NE9jTTBy?=
 =?utf-8?B?Q3htb3NJYS95d1JuK2dRdGJyV0lsemRwNitNWGVJYVJ3TXl2TXo1R0RPSUlp?=
 =?utf-8?B?cm4xWlNjTVdIQTZFbkR0Z0N0UVpNNTcvaE1tMFlXNFVnT1B3dVJxVS9YbVFB?=
 =?utf-8?Q?lhKlKYN5SEm4waHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB88645300822F43AD6C9B47BD4FBB32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80f76f2-89dc-4d50-bd48-08da506320fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 13:13:11.1271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzwnRcpU6AZy9JstPP5Nik7gBhVmYpnUAkpfcL6ul+8eO0UsBOuKcmxfiVJQ6G5aCsc+/4xiRwd6FEkyz1DhFOBO+ksmIEdnSfkJXW1Nsbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE3LzA2LzIwMjIgMTQ6MDksIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxs
bywNCj4gDQo+IE9uIEZyaSwgSnVuIDE3LCAyMDIyIGF0IDExOjUwOjEzQU0gKzAwMDAsIENvbm9y
LkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTcvMDYvMjAyMiAxMjo0NCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPj4+IEhleSBVd2UsDQo+Pj4gR290IGEgfnYyfiB2MyBmb3IgeW91
Li4uDQo+Pj4gSSBhZGRlZCBzb21lIGNvbW1lbnRzIGV4cGxhaW5pbmcgdGhlIGNhbGN1bGF0aW9u
cyBhbmQgYSBkb2N1bWVudGF0aW9uIGxpbmsNCj4+PiBzbyBob3BlZnVsbHkgdGhpbmdzIGFyZSBh
IGJpdCBlYXNpZXIgdG8gZm9sbG93Lg0KPj4+DQo+Pj4gQ29kZSB3aXNlLCBJIHdlbnQgdGhyb3Vn
aCBhbmQgc29ydGVkIG91dCBhIGJ1bmNoIG9mIGlzc3VlcyB0aGF0IGN5Y2xpbmcNCj4+PiB0aHJv
dWdoIHRoZSBkaWZmZXJlbnQgcGVyaW9kcy9kdXRpZXMgdGhyZXcgdXAuIEFsb25nIHRoZSB3YXkg
SSBmb3VuZA0KPj4+IHNvbWUgb3RoZXIgcHJvYmxlbXMgLSBlc3BlY2lhbGx5IHdpdGggdGhlIGxv
bmdlciBwZXJpb2RzIHdoaWNoIEkgaGF2ZQ0KPj4+IGZpeGVkLiBJIGFsc28gYWRkZWQgYSB3cml0
ZSB0byB0aGUgc3luYyByZWdpc3RlciBpbiB0aGUgYXBwbHkgZnVuY3Rpb24sDQo+Pj4gd2hpY2gg
d2lsbCByZXNvbHZlIHRvIGEgTk9QIGZvciBjaGFubmVscyB3aXRob3V0ICJzaGFkb3cgcmVnaXN0
ZXJzIi4NCj4+Pg0KPj4+IE90aGVyIHRoYW4gdGhhdCwgSSBtYW5hZ2VkIHRvIGRpdGNoIHRoZSBt
Y2hwX2NvcmVfcHdtX3JlZ2lzdGVycyBzdHJ1Y3QNCj4+PiBlbnRpcmVseSBidXQgaGFkIHRvIGFk
ZCBhIHNob3J0IGRlbGF5IGJlZm9yZSByZWFkaW5nIGJhY2sgdGhlIHJlZ2lzdGVycw0KPj4+IGlu
IG9yZGVyIHRvIGNvbXB1dGUgdGhlIGR1dHkuDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gQ29ub3Iu
DQo+Pg0KPj4gKnNpZ2gqIHlldCBhZ2FpbiBJIGZvcmdvdCB0byBtZW50aW9uIHRoZSBwb3RlbnRp
YWwgbWFpbnRhaW5lcnMgY29uZmxpY3QNCj4+IHdpdGggc3BpLW5leHQuLg0KPiANCj4gSSdtIG5v
dCBhIG1haW50YWluZXIgb2YgYSB2ZXJ5IGFjdGl2ZSBzdWJzeXN0ZW0gd2hlcmUgTUFJTlRBSU5F
Ug0KPiBjb25mbGljdHMgYXJlIG5vcm1hbCwgYnV0IG15IGV4cGVjdGF0aW9uIHVwIHRvIG5vdyB3
YXMgdGhhdCBjb25mbGljdHMgaW4NCj4gdGhhdCBmaWxlIGFyZSBxdWl0ZSB1c3VhbCBhbmQgdHJp
dmlhbCB0byByZXNvbHZlIHN1Y2ggdGhhdCBtZW50aW9uaW5nDQo+IHRoZXNlIGlzbid0IHZlcnkg
aW1wb3J0YW50Lg0KPiANCg0KWWVhaCwgSSBmaWd1cmVkIHN1Y2ggY29uZmxpY3RzIHdlcmUgcmF0
aGVyIG5vcm1hbCBidXQgZmVsdCBsaWtlIGl0IHdhcw0KYmV0dGVyIHRvIHNheSBpdCBqdXN0IGlu
IGNhc2UuDQpUaGFua3MsDQpDb25vci4NCg==
