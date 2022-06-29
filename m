Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA80C5609D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiF2S4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiF2S4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:56:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989402BB19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656529006; x=1688065006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hh77io0eb8E4om6Bi30U59MY8r6yPN4M5qKDdCZaX3k=;
  b=rH7EXoMIE3vwn9rEEVCdocZzsnXKdJiGA+nW6cyj4R/EWwg3Uo0d675h
   6y2axBGuBGKOzfbtMEGsjHoPYTaWS4jJaBBeI6iPq0bHU1FafHuxwA7ty
   eJJamO5av+o8RJ/RG40p7ka7WJZwNifiHUkSnr/qoyjWzas/Xbc+gxDCD
   gKB7bMg5BA/k+uA+mvVa7VQ6J3FAxlJmlXv6pFWDR/iamWWCa/HJXsNqx
   wrOufQyD9R0x8UFMou0VGlfHUItPI7nVOJ3oooSfcHAeJfUIAXIYUR+qh
   QYBpC+OMDnmvTkN3EZ3qpYn2qlXJhE864GvR9mdMeFfMe2LlMsF5BtHYL
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="102341092"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 11:56:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 11:56:43 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 11:56:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMfZWG+LBegJma2JLZx8VDg01xM1r+9iFGrejapRm5Tya3IFxmQNtcUJ5fRkyehd6Qcq9OkvHYyVgl4WBsqCRBhyKdnzs9NR4Bv/ZlbleZLuwJuKUVB0nL05YVplQQlS92j6EmzSHz2JfUMcNf2DQb01Fb9tzPh3hZfQQUATXYVZcty+GQPEnnz67rBbtmUyklMpkxLNPxBL6b5a+9f+fXzsBC1+WDMmDIfJ/Bq/YBOMD/mFGUC/Gu+wKqGlAXG47SPb4nE94Vt0HKjiVNSP9I91hdY6pM17shIKCibr4Jyk3BtfiC7DiC5svybUTyRLJIvOjjoC9Is4WQsUaOf1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh77io0eb8E4om6Bi30U59MY8r6yPN4M5qKDdCZaX3k=;
 b=oJcISOuGYGEsFw+3oC0H98LVg0UDMpPa2gYr5+emp6f0Kjj7upPjcYCY2+oNVKNVy5+Aix3LFtr6hheOGp9Z0GwUbKaeihZbEXyOff8gDT6LobMLgPJEvHmw/a5nGMGtKNv0s2Qnu4rGLieGPFjAEBGuxrY9seUITBNF12xG1F60ohg889YL7oyPFaJS1SDMJCCI6SOFQM83FULGnCEv7AOJC11DhwcFThbXrvcx3/7dDg2aglWfDwl81nh7wtb+VAlQgCZeO2vItLO4v05eVitazUCPt0d9t1FOylaMKxzo12qsqbArLIBazWX/evPtYn8qsvz/Nuxv1iN+TNbZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh77io0eb8E4om6Bi30U59MY8r6yPN4M5qKDdCZaX3k=;
 b=oobhJgNvWC6D29MMW774fPI2H3NTcmy+gXOGmFKQV7GENYhk4vWZH3Nf5n3YOeJYm62IHBlfLRhfqyn5LDhqR+qXl+wqkGX8IQ8dxXq+IE6+ApexzgLbaJO4keQBXEDVQOZGHljYG8IeAtg4LGQTUxz2PHe4fgfczt6cIw5uW1Q=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2298.namprd11.prod.outlook.com (2603:10b6:4:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 18:56:29 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 18:56:29 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAgGAIAAAp2A
Date:   Wed, 29 Jun 2022 18:56:29 +0000
Message-ID: <88ef07ea-fbde-b997-6c0c-99f5fb7be201@microchip.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184708.x5exgjoy4sblyqml@bogus>
In-Reply-To: <20220629184708.x5exgjoy4sblyqml@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70957042-bf3d-4e45-b9f4-08da5a01139e
x-ms-traffictypediagnostic: DM5PR1101MB2298:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WEKsjGinm/B/yabfeunvDNK3SrHs1aoNuXl3UJMcmElYcmSp6m5NWvpLwH2sLv/ow61BQyw5aHrgXKyy5uOO/VdvbfPqbwb1dlNYw7E8Du/2topd3KjP8Abu3KW7j994nB62cCYlDTF+IIdV4+r2czh+jaUiPijD1X++E0Os41kdgnFUXmJikmFeUN+bhprYTzNabFsvcxOip9yaqn1TgSpqHDhbJES+zvQJguQRg6woi/2u2YOC18ec9P+zSGvH/706BlstVFSm0iF3j6RE4OIYPypyhRRSyFr/gBvUxxq1HRl78L39ewVGw6xMEa8ACcpOZri/9vBYXEEEoroLbWcbK+a3kOQfBQH7wiFIGe55PbxKigdG+K4nM5d6GD57GKHNM2YL54oRQ3AYnty3W9iu4bD0GsKNpxzNCJEN4aEcl2Nd2EJOsgz0EccA2C/NX1GuTZ99NyL4/Zu0/Zqu3ByP01PytQUIQtt8hwr71kXeTox3D7uCrfmGCK3q2HDOf3IomcyU3mPipj7RltGnI+7vwmXB6xI8hoV1kkXTRABKht+GKS4TaL8Qm80j6+oO3Jdew6H0l80ucyGsFQBx2u5aBnxv0yGPINUTNyxmcCgeIxnC4fbQTT8Jp1ux53cliNaEMFb3rcSzb9LvaM8PN+eAru3IrZ7oAn+e7oPiB1uapvgJ88qKUy1wn4czo5Qma8UZtEacGJqS2NLL+H6q1+5lUZC2eo0d7y2n9vkG0SOUiuyq3xxB7C6EGoysHPb2mOQIe8BGWwW1LfPINgHxDEbFgQJngTXm0WDIT9RyNWdvtc2gkx+1JScDNy4o7l6qs08DWSzjIYs9NOJtUQZjSj0fFd9GvyplSBYT0RYELLc999ny66alYOcCcXf/ExeWLjb58Aepyo9KXD0OkfA3rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(39860400002)(366004)(186003)(966005)(8676002)(107886003)(6512007)(91956017)(66946007)(31696002)(66556008)(122000001)(53546011)(4326008)(66476007)(6506007)(8936002)(26005)(5660300002)(66446008)(64756008)(6486002)(76116006)(71200400001)(478600001)(36756003)(86362001)(316002)(31686004)(7416002)(2616005)(110136005)(38100700002)(41300700001)(54906003)(38070700005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVYrMGpMcWs5eFQyV25aU3lZWjhpWlQ2QVZqUldhY1IzQ0MxNnlRN2pFb2My?=
 =?utf-8?B?bWlWZGo3WmxZN1NmL093ZTNwWElveURPdVQ0cGpyL2YyK3RPUUhaQWNvcGww?=
 =?utf-8?B?ZzVqVW9LREFyeTZKTzNRZUFzTnNyTkFjTG1IVENxbHN5ZW41YTBGNURFQis5?=
 =?utf-8?B?N1FBbEVVdUN4VkdTOVI4TlRuc0Z5TDRKSDlWc3UzcEwrSFpnTG5UV290WmNT?=
 =?utf-8?B?RWgrcXQwL3FycmlQVWtEU3N2N21jOVZad3hNTm5lcU9WTTcvVlNFS1hLWW1G?=
 =?utf-8?B?ekc5SnNucWlKU09JRzNlaGYvbnhnNWF5RDFnZGpTRFZyczJIZ1MzaVVUVTlN?=
 =?utf-8?B?cUlWQjh0cklYOWVROFloZnNYUUdXMGRWdzJ0cm83UUhON2g0RjFPOWt6VzNi?=
 =?utf-8?B?eUlFTXJCaXVOS05NS3o4UW1hVGRzSloybVZVcGlPblp4WVNrOW5nNzVGc0lp?=
 =?utf-8?B?WUpPSVVqRjZDSm01TFhydU93bEdCbVQ1cllzd0RGdE5GWDV4SEdBVU5ZTmVW?=
 =?utf-8?B?RmJ3TThTVkY0VVdIQ3JRRXdSSkIvRzNnTXRQTnZGdVlDc2kyemdkY2hSeExy?=
 =?utf-8?B?VElEMUJyazU5V1BDSUFscEVGZDBOdHg0SFRTMW5yVi9RTnEvZnlpMDgyTDFy?=
 =?utf-8?B?cFRPR25UTStSR1FTOS9GdCtWVFFJYU5vYjVTNVl1OG5Fb0hPUWlTby9YQmxJ?=
 =?utf-8?B?Q3lYWWNIV1Y5SmU0NkNKL0hacmZpays5dmRFcXovRllOUWo3VlludU9vVHRV?=
 =?utf-8?B?dThGZisvN001Zld1NXBWZmdCTmtlWjJ5eTFOTGVYZGNZN0RNNzNuazRIYk9E?=
 =?utf-8?B?UnFkVFpmQnloekx5dHhvbmltOENoWkNoRzRpMXNoZE11T1BvYjV0NFhoV3B0?=
 =?utf-8?B?YlU0ZGpwNTFTYmdmSEhDc3hzaWNHR09BaVc0amVFdHdQR09zcWVTbnYzeENR?=
 =?utf-8?B?SDhRcHY0dVNxY1l4T0hYQloyZG94V1RET0RtTmpnK0crNFZLUExxRUFWZVNV?=
 =?utf-8?B?Q3pLM3EwQzVvcDhFeUwwWmZPbjZQT2dnRmh2VzRJcit2SGRNSHZydUhGWWkv?=
 =?utf-8?B?Zk9Oa0VEUk9ybmJqZXEzdzhuVkNSb2NFYW1TMWxPaVdyMWtVQS9ObDJtdVlH?=
 =?utf-8?B?azFIY291WjFtYUNSU0ZpOTZuYkh3WGRIL3lpK0FNQ2FQNWxwMEhpV3M3S2sv?=
 =?utf-8?B?ZFp3VVpua3MvaGtjQTdnRDRJSUtWcWZNajdGVC9zQWViTlBjaHU3TTU0RFd6?=
 =?utf-8?B?NWI5RGk4TEpnOXVKOEJSU2ZFTDRjL3BEelNNOVUvcGF4czk2eWJmQzRxT29v?=
 =?utf-8?B?cFdrSnZUaWNLdi9yWjJrWmpGYXdCbllLdi9abUhyR0Z2cFZJT3I2Q1dQK0p0?=
 =?utf-8?B?U3RyMldqb0dWblJUU3Z3Y1AyVE56cVRiSEludnpUNHZlcW51TUpvQkpGRjFj?=
 =?utf-8?B?bjJZMUR1VlFGcXZ3QVVYYW1mV200ZjdqeDhXZTdOUDh3bDFSSmh5djlsbVdk?=
 =?utf-8?B?VzZ4Y0VOYVJTdlQ3MUFwTWlIa0VyaFBDamd2RTZZdndKdm5zbVFwS3BBS3hn?=
 =?utf-8?B?Sy9OM0lGZUExSkNxeS9oNTh2b0NoRVRHMEFMUmxtdGVRVWdzdWQ2WnM2Q251?=
 =?utf-8?B?eFlRbjRvWnR3Szk2TEhQM1BuVlE1aU5nT2QvZi9EOW9NUTdoaEdKaXlLUklx?=
 =?utf-8?B?WGhDK2dwNW80bVcyMWF0U3ZneDBtNnFOblZydkorZmZ6VVBXdXRaaXJGQnBY?=
 =?utf-8?B?ZTFJUEpudy81RzRsbWNIVGd0QlJONnJvZnF1d21GQTRVR3pZT09CV2lDdHps?=
 =?utf-8?B?VHpoNGdEVU9RbElpUVlyRXBEKzdiOVVPbUx0dFVGR0NpRkx6L1hDQ2UvSTdS?=
 =?utf-8?B?VHlHWHNzTFZEMGRZQk5mMWdhVklzeWE3YXcrMUZGT20xc0ZEc0EwdlRUNUl1?=
 =?utf-8?B?dnFlU0t6dWNzNTk1cHkzb3FycXhuUHUwQkxRenRnTHV0WUZuNHVpV3BCQ0pl?=
 =?utf-8?B?NVBqamtjWms3VXViK0N4SE9jM08rNkJrVkxnNExKVXRvRVN0ZWNPMklwK01l?=
 =?utf-8?B?M3VsRDdibnZtaW9leUxYTlluUXFaeExDQ2lwdi93Nkc2dFdhZGkrL2ZuOUdl?=
 =?utf-8?B?N0tXRHNHSkJ5MHRwanRuOGhIZmVuR1IreWpFVlZ0TW0ycndtZHRuNlovbng3?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A0A16713BDD1E4B82B1BD64C2777575@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70957042-bf3d-4e45-b9f4-08da5a01139e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 18:56:29.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDjpaG/jYzySNbLchaAQKdGNCySkz8w7+eVo1kLhOaz6SzLGe6fYVt5y8UuOEIDYEflo6OUnVLMas5PAE8l4+o7mlrc5PNZaGVTIVKKJXyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDYvMjAyMiAxOTo0NywgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBPbiBXZWQsIEp1biAy
OSwgMjAyMiBhdCAwNjoxODoyNVBNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4+IE9uIDI5LzA2LzIwMjIgMTg6NDksIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29t
IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4g
T24gMjcvMDYvMjAyMiAxNzo1MCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+PiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4NCj4+Pj4gVGhlIGNhY2hlaW5mbyBpcyBub3cg
aW5pdGlhbGlzZWQgZWFybHkgYWxvbmcgd2l0aCB0aGUgQ1BVIHRvcG9sb2d5DQo+Pj4+IGluaXRp
YWxpc2F0aW9uLiBJbnN0ZWFkIG9mIHJlbHlpbmcgb24gdGhlIExMQyBJRCBpbmZvcm1hdGlvbiBw
YXJzZWQNCj4+Pj4gc2VwYXJhdGVseSBvbmx5IHdpdGggQUNQSSBQUFRUIGVsc2V3aGVyZSwgbWln
cmF0ZSB0byB1c2UgdGhlIHNpbWlsYXINCj4+Pj4gaW5mb3JtYXRpb24gZnJvbSB0aGUgY2FjaGVp
bmZvLg0KPj4+Pg0KPj4+PiBUaGlzIGlzIGdlbmVyaWMgZm9yIGJvdGggRFQgYW5kIEFDUEkgc3lz
dGVtcy4gVGhlIEFDUEkgTExDIElEIGluZm9ybWF0aW9uDQo+Pj4+IHBhcnNlZCBzZXBhcmF0ZWx5
IGNhbiBub3cgYmUgcmVtb3ZlZCBmcm9tIGFyY2ggc3BlY2lmaWMgY29kZS4NCj4+Pg0KPj4+IEhl
eSBTdWRlZXAsDQo+Pj4gSSBiaXNlY3RlZCBicm9rZW4gYm9vdCBvbiBQb2xhckZpcmUgU29DIHRv
IHRoaXMgcGF0Y2ggaW4gbmV4dC0yMDIyMDYyOSA6Lw0KPj4+IEkgc3VzcGVjdCB0aGUgaXNzdWUg
aXMgYSBtaXNzaW5nICJuZXh0LWxldmVsLWNhY2hlIiBpbiB0aGUgdGhlIGR0Og0KPj4+IGFyY2gv
cmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMuZHRzaQ0KPiANCj4gR29vZCB0aGF0IEkgaW5j
bHVkZWQgdGhpcyBpbiAtbmV4dCwgSSBoYWQgbm90IHJlY2VpdmVkIGFueSBmZWVkYmFjayBmcm9t
DQo+IFJJU0MtViBldmVuIGFmdGVyIDUgaXRlcmF0aW9ucy4NCg0KSSdsbCBiZSBob25lc3QsIEkg
c2F3IHRoZSB0aXRsZXMgYW5kIENDIGxpc3QgYW5kIG1hZGUgc29tZSBpbmNvcnJlY3QNCmFzc3Vt
cHRpb25zIGFzIHRvIHdoZXRoZXIgbG9va2luZyBhdCBpdCB3YXMgd29ydGh3aGlsZSEgSSBhbSBu
b3QgYXQNCnRoaXMgYWxsIHRvbyBsb25nIGFuZCB3aGF0IGlzL2lzbid0IGltcG9ydGFudCB0byBs
b29rIGF0IG9mdGVuIGlzIG5vdA0Kb2J2aW91cyB0byBtZS4gQnV0IGhleSwgb3VyIENJIGJvb3Rz
IC1uZXh0IGV2ZXJ5IGRheSBmb3IgYSByZWFzb24gOykNCg0KPiBJIGFsc28gc2VlIHRoaXMgRFRT
IGlzIHZlcnkgb2RkLiBJdCBhbHNvDQo+IHN0YXRlcyBDUFUwIGRvZXNuJ3QgaGF2ZSBMMS1EJCB3
aGlsZSB0aGUgb3RoZXIgNCBDUFVzIGhhdmUgTDEtRCQuIElzIHRoYXQNCj4gYSBtaXN0YWtlIG9y
IGlzIGl0IHRoZSByZWFsaXR5ID8NCg0KQUZBSUssIHJlYWxpdHkuIEl0J3MgdGhlIHNhbWUgZm9y
IHRoZSBTaUZpdmUgZnU1NDAgKHdpdGggd2hpY2ggdGhpcyBzaGFyZXMNCmEgY29yZSBjb21wbGV4
LiBTZWUgcGFnZSAxMjoNCmh0dHBzOi8vc3RhdGljLmRldi5zaWZpdmUuY29tL0ZVNTQwLUMwMDAt
djEuMC5wZGYNCg0KPiBBbm90aGVyIGJyZWFrYWdlIGluIHVzZXJzcGFjZSBjYWNoZWluZm8NCj4g
c3lzZnMgZW50cnkgb2YgY3B1MCBoYXMgYm90aCBJJCBhbmQgRCQuDQoNCkNvdWxkIHlvdSBjbGFy
aWZ5IHdoYXQgdGhpcyBtZWFucyBwbGVhc2U/DQpUaGFua3MsDQpDb25vci4NCg==
