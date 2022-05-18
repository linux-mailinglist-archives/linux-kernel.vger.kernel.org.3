Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BD752B715
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiERJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiERJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:40:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6B14A276;
        Wed, 18 May 2022 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652866801; x=1684402801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tLKkOEpKA7DCH/1WACOJu6ZtX7Rfj3Tg/45/U1FTTic=;
  b=NKOJBXH1ALYO1fAETe1nkq3SERbp/Lbc+kqGCaG/FxDnSb4oIZdI5jYk
   3CtgEQOOQP3ZcNML3NGBI9cKfXS4x0LOfS8Z9yulwTFBmPRtLk0qn1wQS
   PZf69ldfP7IERK9LUDDEj/dRhzVUlbBizWaf4460wonOGZvwjxQszP//o
   cxtAp2xWZTsDHxeBGD7Qp5jsunMac78djAvYH8I7bI1lWZNe5bNfq24i3
   CJ6lzI5B0/6+PZK0cpKcj1+Nsrq7ap2R5+m05kG9H9BS/lZ4hxEpKqQ6y
   xqprFKT4NQHzfg8/7NqUEg5aqLzauGPF58BWErNMkuZGLgHh5DcRGJcoR
   g==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="164568558"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2022 02:39:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 18 May 2022 02:39:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 18 May 2022 02:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKMJWK6UbmZsfhta/WATQyfVvxkwX5K7pX+ibFoX6RN6CPQN9FQSUFIfHCaLUywSsbgFE0YupReoCcBPlRzaDS9jtne+/woSlXWgHC9YQ9UHhYkLSA2LDruS9CE1mDNH0DPKiLcoZcGxCgyze4okvTAjismkG6MceTrxu6Pbi2qiMAY7FukpIfrUIy3OgYm/ipPfi+TaNeZFeCKJQ13ZDYld3k3FPd0jVJRUYEFb24pqPmTkVsDWtUNR23P5n0Xu+ECLI0MLXHXFko8Gd1/9ehuE+5qOsQ2jYWsf/hrs5qOu28X/BttScd/oiAoyRdP3/ADuApsRTyl7che2wEk5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLKkOEpKA7DCH/1WACOJu6ZtX7Rfj3Tg/45/U1FTTic=;
 b=L72FZ8V9pLxWWTj+P5rAk047U31vTgE87Kc+JcCHesxCgNgQHv91/lsm6ee+jLwEfFWS64yDEYqz+ot0xiHNdRHdeU4ztVqCpsoVVrqROPyU7M5phF+wxEeyt2rV1Nw7sBrCqEsHP95+WitsiRbnN03gaHHGzh36aHCrt9amn+NsgzkYr5mzz2PVt+ER/qaODdUi8NmqImd0iybXybKtzqCRagwVTdSRfyGIEQp0ygIrZDLfSZg8g3dMRilILAWiNGQ63PcvklnCFJ1EBno0ZxKcJBOFW2JLP+kM3rqYLqDMPTkN6vi4t5nEtvtRQC1MHik2niQh6rimg8i1DllBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLKkOEpKA7DCH/1WACOJu6ZtX7Rfj3Tg/45/U1FTTic=;
 b=rCgNNQRKPzTpdRm8kDKtFYRfaVSVeb5JCmd+SIAEqMgCwJMx8RTQxpbE5jtbJnAWgZwob5VEqJKgNLYUA6SyTLhj/TBkDMtGRizirlfR/DnKD6+CR/rD7xH7rhdyWq9B8WQNd2YYaHQJwcCD7EtW2MsKvd17VJHUL++UTvnHiZY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1593.namprd11.prod.outlook.com (2603:10b6:4:6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Wed, 18 May 2022 09:39:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%5]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 09:39:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i@zenithal.me>, <palmer@rivosinc.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <heiko@sntech.de>
CC:     <atishp@rivosinc.com>, <anup@brainfault.org>,
        <ebiederm@xmission.com>, <keescook@chromium.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <mtk.manpages@gmail.com>, <linux-man@vger.kernel.org>,
        <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH -next v2 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar
 Crypto
Thread-Topic: [PATCH -next v2 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar
 Crypto
Thread-Index: AQHYaplfm3lmpHbpY0WLoNY3ZgIZ8a0kYNWA
Date:   Wed, 18 May 2022 09:39:53 +0000
Message-ID: <fba8ab6e-17bf-1fe1-ad5f-339276907298@microchip.com>
References: <YoS6qRhxGuwHmK7q@Sun> <YoS7lgTmcRT0q9y+@Sun>
In-Reply-To: <YoS7lgTmcRT0q9y+@Sun>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4254991-d8de-43db-3d2f-08da38b25c5f
x-ms-traffictypediagnostic: DM5PR11MB1593:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1593EEC9B66E437ECF07FEC498D19@DM5PR11MB1593.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEgUMfng3GeczvnWQXH29Tka1JQc7jqrHS889s6JBZCfG2lwhz1pOG6Gd+p8ol9wZifWw86atW+mr1vCPbkJGmAL8UBV0/q0rPbJrRZkge3IgBpYIx5O3VAHJ0Vy2Hup8yIhe4RhVHEqzGGxw7hGxLuj3nEIzo76XnxWOyTjcsLv63kKGkURw827qy1U92qn7xw45vNREyuyrQ12tsd+GIhyAh+9G5ZCqhx5jS5li7kPujQms0jWtmxlNnmkfaNANC/yo27DBvBwA5tgBSlgZrMqdio9PVZ+CIYE1aPq7gg0MicHGkW2Df9GMiyjBlxmgrMpZgKKguwZ8Wj9HSd3LO/l0mpxQPchth3Wf1WMEJFO178JwxdZbTZASlgf11kLLoFzH9qzf16/rYSntYS/0sEnQjCnhW217vjq3qEjpIYJT4UimkHDRwAwxVxXS091ndSN/aETKI3Fzv3Ipm61ynhn0Xonra1gFQa9MXQMGcgZTZ3p9LfpOGld/GNzT8fOg7juV45QJYjvgLqZnoHrHn84VJd8fzXXfgmxwQNYyYE8aqfAhBkVM/MNItxeFm9GN0HFuFCCL9+igKgGkT6lg3NR2Q+EusH8C/tcK0XFEbXQhdYnRCTVJLYuCazk2Uh+wXd5n2kvW2lrRfNcz21VZBAtQUu9VFoioxVpUNgZfZZIBrcPvCsuma6zapnqdXCGonu1A4fMLfBnmpXj/AAHarFo6b3lz9lj4ZDZuQ6clweRSvqRDw5B1VRNKCFIwhHzZKuwTX9I5an0Qrow6xElBAD2mA5cB/yfFV6aYd3jDRjO6EGG7ninAo2dwl2SWCum6nLBkiVIMcP2LmoKYoz39keAoRTRJxz8uFBcWiRrz/pt2pdZayNja6DTx1EULkbJ+thUQAoulTuw22g3WdwqY4mFfDF1Fd4dAxRvgniVOZ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(31696002)(38100700002)(66946007)(508600001)(5660300002)(86362001)(91956017)(7416002)(54906003)(66446008)(110136005)(8936002)(38070700005)(122000001)(64756008)(186003)(6512007)(26005)(2906002)(2616005)(66476007)(66556008)(4326008)(966005)(8676002)(6486002)(316002)(36756003)(71200400001)(53546011)(6506007)(83380400001)(31686004)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEpCMUZoUmozMndNaUJIdG8zRnFGQjU1NGl0bExJVG9GRkduOEQ3a2lyWUxz?=
 =?utf-8?B?SnVYeWxPckUrQXNEc2VJNTJ3Q3VsRldKKzdPT2xiVHVYMmtQOXZ3d2VsSFpX?=
 =?utf-8?B?bmlSRXNGcVFTdUFhWVU2YTZLMENIenc4N0V1ZzZWMW1LemY3VDFpMVlyNU5V?=
 =?utf-8?B?NGFBRzYyTVg3K2VQai9kZWYxQXZ2M3YzRmE4MDErQU9pdWNnWldOLzlUVUtw?=
 =?utf-8?B?M05CdGZycFFqdlA5bzRPdzB5RUI1UU9MNHM2SGtKMTdRdkJqM1g4R0VEL3Rk?=
 =?utf-8?B?NVZnRVRYck5JQWVjYW9EcG14Y0dGTEhNSEp0cDJsRUZFU0Z6Y1lTUnljK2xl?=
 =?utf-8?B?cUVXdWMyVEtoMGZQL1NaclZuaDc4V0ovL0NoYWR6RlZyc3ZoaFBaYnJ3Sitx?=
 =?utf-8?B?d0tsVXkrY1E5cWpCNU5RMGszb3pnZXpJTCtydDdlUDlkdnZ5M0djcE5ucXlU?=
 =?utf-8?B?VFo0YjR6TzVDWmJVYm5GNFV3bHRqdlpiSnAxNDJ0amlmVnNqM2dWSUdlM0dZ?=
 =?utf-8?B?NHNrRFZqUW0wVDhUNTQ4dWVTSUJJT1JNZ3p6MzNQK3Vwc3Nnc0lMYWhOTWNO?=
 =?utf-8?B?VlVldDJuOHBDTDZJVEtFUU9jTTVOdHVzZ0JteGZTQSsxL1lxQm5paC9FUTdo?=
 =?utf-8?B?cWl4U3AyZVUvQVhvODNVUm5SaCtxVnZPWWRTWCsvMzIzdVg3T29ncVU3dklr?=
 =?utf-8?B?YzMxREJ4Z3ZRK0lkalNqT1FNL1p6amVtZ0taeVpUWXJYUTZJTFJMSWpUQlZn?=
 =?utf-8?B?ZGZLalIzMlRjYThYTnd3cGp3b1VkTklzUkZlVWFVVHhISkFIWTU1cFhmVGNE?=
 =?utf-8?B?Mis0T2NHYXo0bk9hVTV4UzJZSGQzTTdlNXNwSFFEdVgrbk1MNDg2K0pQWDFT?=
 =?utf-8?B?OU1pZ1Q4SUZqWURQQzVqWXp6UnluZzlwcmltb3VzRUxmenFmd3ptSHBDSEdn?=
 =?utf-8?B?ak44VjA3U3piNmtYclh5Sm0razRjeXk5ZCtOc1JOTXJBdTl2VE14ajVwakJr?=
 =?utf-8?B?ejlkRy9yUHZFUm5TdHJBQ1V3aTJSSXZxS1liTzg5d3RPRDlaSU5HWTBQcy9N?=
 =?utf-8?B?bksza1ZPMFdBTWhuVGhCRmtuMWpTMUlKTHRwR1dWWWlaKy9IOUpsd1dxUmtN?=
 =?utf-8?B?ZVVEMVVFSmMvYjlJQjMwdStES0E0MU1WeXVZTXViczQ3N2ZuUTI4U0ZEckFv?=
 =?utf-8?B?MU9Hc2NVUm90R2pHTEdrazZxRC9mSnRTRCtvYTcyMm14MEtTZ0QxS3pHR05O?=
 =?utf-8?B?R1ZGTWhRWGJTTVVNTTFDb0JPODZGb210TEJRdVo5MDhNZkJVc0Z1N255dHVD?=
 =?utf-8?B?MlhRMWVBaG9GM2s1aUd1TkVWN0ptTWROeXMxeUVWVDdndFNsNGdrQUJ6RlpX?=
 =?utf-8?B?VEwwd1c3OTIzQy9sT3Vxc0RsTEttMUdsRUNrb1UyL1JMNEZ4bDFYVWFmS3lE?=
 =?utf-8?B?eUlPb2hhR25CMnBWZnZZNGx4eGdZV2JuZ0Nvd2l1cVlTVFQrY1hvaGZKNWlS?=
 =?utf-8?B?MzU2UmJhMEV3MWYrOFRwZlhhamJJbmIrUTd1VUt2R2RuQlJLM3RsMFcvOC8x?=
 =?utf-8?B?SDRIcXFYQ0RWWXJ2UFNNM3N5azBNSXNmdURzSXIzQmJHRERrME5OSkUyT21n?=
 =?utf-8?B?bitOR1V2V2ZUTHUzdkVmcmNwV2c4K3FDMmN0MDhxVFhvd2NSRDBzeXBVUFJB?=
 =?utf-8?B?S3RBZDNScHpFdmZzM084L0pFTGJ5WWYyY21TQ3ZsMmdwRDlmclNHSjI0RGd1?=
 =?utf-8?B?VWJyTERQNHFNNndhKzhDTWc1MmIxWlZNc3NWWmVEd28rZkZuQTN1bkNFL2pB?=
 =?utf-8?B?bzRlWnFZc0JpcDc5SHV0ZDYxS0NBNmM5cDU3MmV6ZXZKYlVnaDZNdmNJOVBp?=
 =?utf-8?B?Vkozb2s4b2I5a2JOdmUrWjAzbjFtNjd2TEFlSEtMcGxRQ3YrelZXSnY4RXVL?=
 =?utf-8?B?Y3UxWkNuekc1c1NaYjZ5YWZaaWZ3RXBhdGh4cFNYbEJMZEZZL1QrSDh4Z21n?=
 =?utf-8?B?ZUNRN0QyYkR5TjBBdDhOdDdUVE1ta2VkTHV2SkZMbEVtSjkzTjRlcjB6cmtj?=
 =?utf-8?B?Q3NOYnFVdnkyaVAzMHBLOHZiUnJxRUk3bk5YbG1LSG1aU09SUVRybDFRYm1s?=
 =?utf-8?B?SFB4QTY4QmQ4TE1RMDRLTUNOMHlxMGxRRitoeVNzZzQxUCtob1pRL1ljaDRB?=
 =?utf-8?B?N1R1QitxTUR5Wi9MblJoTk9aTFo5M2ltOHZuc1FPQzAvaDJGQWQxN21EVnl3?=
 =?utf-8?B?bmRUTFgxTjFvejdmeFNDU09vU2xUZ0RGbjhVQVVnSmNobTJqUHdQQWhMQzln?=
 =?utf-8?B?cGRJR1JVWjhzQXBkMlNjTG9jam81dG9rdGU5UU9qakhqd2ora3ovRjZGeHZB?=
 =?utf-8?Q?FXvgcvzs88XMRs4U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B81FC87D44EF744F9E46CE1D80C796FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4254991-d8de-43db-3d2f-08da38b25c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 09:39:53.0957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niEwlq+a7vJrNFLKA+w9JX+QBjhDfwe3Bka9CK7h9yP2N1wpetYvSOD+oqEIStrEUgHGyN89xJPdBoxs/KvsHEq/ZntcT0O1J4mKuYYTFQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1593
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDUvMjAyMiAxMDoyNSwgSG9uZ3JlbiAoWmVuaXRoYWwpIFpoZW5nIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IHVzZXJzcGFjZSBjdXJyZW50
bHkgbGFja3MgYSB3YXkgdG8gZGV0ZWN0IHdoZXRoZXIgdGhlDQo+IHBsYXRmb3JtIGhhcyBCaXRt
YW5pcC9TY2FsYXIgQ3J5cHRvIGNhcGFiaWxpdHksDQo+IHRoaXMgY29tbWl0IHByb3ZpZGVzIGEg
d2F5IHN1Y2ggdGhhdCB0aGUgdXNlcnNwYWNlDQo+IGNhbiBkZXRlY3QgaXQuDQo+IA0KPiBSSVND
LVYgY3VycmVudGx5IHN0aWxsIGhhcyBubyBtYXR1cmUgbWVjaGFuaXNtLA0KPiBidXQgbm8gbWF0
dGVyIGhvdyB0aGluZ3MgaW4gdGhlIHNwZWMgY2hhbmdlcywNCj4gKG5vIG1hdHRlciBob3cgIk0i
IG1vZGUgdGhpbmdzIGNoYW5nZSksIHRoZSBrZXJuZWwNCj4gc3RpbGwgbmVlZHMgdG8gb2ZmZXIg
c29tZSBBUEkgdG8gdGhlIHVzZXJzcGFjZS4NCj4gDQo+IE1vcmUgZGlzY3Vzc2lvbiBjYW4gYmUg
Zm91bmQgYXQNCj4gaHR0cHM6Ly9naXRodWIuY29tL29wZW5zc2wvb3BlbnNzbC9wdWxsLzE4MTk3
DQo+IFVzZXJzcGFjZSBjdXJyZW50bHkgaGFzIHRvIHVzZSBlbnYgdmFyIHRvIGRldGVjdCB0aGVt
Lg0KPiANCj4gVGhpcyBjb21taXQgYWxvbmcgZG9lcyBub3QgYXNzdW1lIGFueSBzcGVjaWZpYyBt
ZWNoYW5pc20NCj4gYmVsb3cga2VybmVsLg0KDQpzL2Fsb25nL2Fsb25lPw0KDQpCdXQgSSB0aGlu
ayB5b3UgY291bGQgcmV3cml0ZSB0aGlzIHNlbnRlbmNlIHRvIG1ha2UgaXQNCmNsZWFyZXIsIEkg
aGFkIHRvIHJlYWQgaXQgbW9yZSB0aGFuIG9uY2UgdG8gc2VlIGlmIHRoYXQgd2FzDQphY3R1YWxs
eSBhIHR5cG8gb3Igbm90Lg0KUG9zc2libHkgc3dhcCAiVGhpcyBjb21taXQiIGZvciAiVGhpcyBp
bnRlcmZhY2UiIG9yIHNpbWlsYXIsDQpib3RoIGhlcmUgYW5kIGluIHRoZSBmaXJzdCBwYXJhZ3Jh
cGguDQpNYXliZSBzb21ldGhpbmcgbGlrZToNCg0KIlRoaXMgaW50ZXJmYWNlIGRvZXMgbm90IG1h
a2UgYW55IGFzc3VtcHRpb25zIGFib3V0IHRoZQ0KdW5kZXJseWluZyBoYXJkd2FyZSINCg0KVGhh
bmtzLA0KQ29ub3IuDQoNCj4gDQo+IFRlc3RlZC1ieTogSmlhdGFpIEhlIDxqaWF0YWkyMDIxQGlz
Y2FzLmFjLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBIb25ncmVuIChaZW5pdGhhbCkgWmhlbmcgPGlA
emVuaXRoYWwubWU+DQo+IC0tLQ0KPiAgIGFyY2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS9od2Nh
cC5oIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL3VhcGkv
YXNtL2h3Y2FwLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvdWFwaS9hc20vaHdjYXAuaA0KPiBpbmRl
eCA0NmRjM2Y1ZWU5OWYuLmJmZWQzZTVjMzM4YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9p
bmNsdWRlL3VhcGkvYXNtL2h3Y2FwLmgNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL3VhcGkv
YXNtL2h3Y2FwLmgNCj4gQEAgLTIyLDQgKzIyLDI2IEBADQo+ICAgI2RlZmluZSBDT01QQVRfSFdD
QVBfSVNBX0QgICAgICgxIDw8ICgnRCcgLSAnQScpKQ0KPiAgICNkZWZpbmUgQ09NUEFUX0hXQ0FQ
X0lTQV9DICAgICAoMSA8PCAoJ0MnIC0gJ0EnKSkNCj4gDQo+ICsvKg0KPiArICogSFdDQVAyIGZs
YWdzIC0gZm9yIGVsZl9od2NhcDIgKGluIGtlcm5lbCkgYW5kIEFUX0hXQ0FQMg0KPiArICoNCj4g
KyAqIEFzIG9ubHkgMzIgYml0cyBvZiBlbGZfaHdjYXAgKGluIGtlcm5lbCkgY291bGQgYmUgdXNl
ZA0KPiArICogYW5kIFJJU0MtViBoYXMgcmVzZXJ2ZWQgMjYgYml0cyBvZiBpdCwgb3RoZXIgY2Fw
cyBsaWtlDQo+ICsgKiBiaXRtYW5pcCBhbmQgY3J5cHRvIGNhbiBub3QgYmUgcGxhY2VkIGluIEFU
X0hXQ0FQDQo+ICsgKi8NCj4gKyNkZWZpbmUgQ09NUEFUX0hXQ0FQMl9JU0FfWkJBICAgKDEgPDwg
IDApDQo+ICsjZGVmaW5lIENPTVBBVF9IV0NBUDJfSVNBX1pCQiAgICgxIDw8ICAxKQ0KPiArI2Rl
ZmluZSBDT01QQVRfSFdDQVAyX0lTQV9aQkMgICAoMSA8PCAgMikNCj4gKyNkZWZpbmUgQ09NUEFU
X0hXQ0FQMl9JU0FfWkJTICAgKDEgPDwgIDMpDQo+ICsjZGVmaW5lIENPTVBBVF9IV0NBUDJfSVNB
X1pCS0IgICgxIDw8ICA0KQ0KPiArI2RlZmluZSBDT01QQVRfSFdDQVAyX0lTQV9aQktDICAoMSA8
PCAgNSkNCj4gKyNkZWZpbmUgQ09NUEFUX0hXQ0FQMl9JU0FfWkJLWCAgKDEgPDwgIDYpDQo+ICsj
ZGVmaW5lIENPTVBBVF9IV0NBUDJfSVNBX1pLTkQgICgxIDw8ICA3KQ0KPiArI2RlZmluZSBDT01Q
QVRfSFdDQVAyX0lTQV9aS05FICAoMSA8PCAgOCkNCj4gKyNkZWZpbmUgQ09NUEFUX0hXQ0FQMl9J
U0FfWktOSCAgKDEgPDwgIDkpDQo+ICsjZGVmaW5lIENPTVBBVF9IV0NBUDJfSVNBX1pLU0VEICgx
IDw8IDEwKQ0KPiArI2RlZmluZSBDT01QQVRfSFdDQVAyX0lTQV9aS1NIICAoMSA8PCAxMSkNCj4g
KyNkZWZpbmUgQ09NUEFUX0hXQ0FQMl9JU0FfWktSICAgKDEgPDwgMTIpDQo+ICsjZGVmaW5lIENP
TVBBVF9IV0NBUDJfSVNBX1pLVCAgICgxIDw8IDEzKQ0KPiArDQo+ICAgI2VuZGlmIC8qIF9VQVBJ
X0FTTV9SSVNDVl9IV0NBUF9IICovDQo+IC0tDQo+IDIuMzUuMQ0KPiANCj4gDQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1h
aWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0K
