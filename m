Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252174D3178
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiCIPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiCIPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:09:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E69554AA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646838535; x=1678374535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VqrVHsaPW33TQwL8beCjaFtV2eXCv7JMIAWdZgsQ0ag=;
  b=2Ixpf9XPwvyplB/Zdk2KrejOHdtO/J1XPmaRn2vPi0VzFcklM00UtyOh
   HBaUWTHS3wkzQRDfNAknORlpANndtPyvE5+xO8G2HLAKudqvlKeL3eL3L
   O2Tf4aqijYoHgq+bnFSO15SZN2RB3jWqe2kGv97zlvJxTC0LNyU+Ectjz
   qWhCYj1wkvPiUkuaC8EMC3ziUVfbgeVwquxspAZes0nsvVkvIz8OFjqxT
   0fYKLEUbL08Dy1KYF9tmsb3HrPP7Sy4ZccSLQLEQAF5Sgvrj5TXNOAdo4
   RE+9Gjm1HOc1Xzkn2cc1uXyE9FrhMPBx3z5ODXCsljJyxJq9bDwB9chJD
   A==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="155817244"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 08:08:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 08:08:54 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Mar 2022 08:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR7OXiQOdNAaKmusP503k8rVGOq/320VLsEhnyMUlDY2RCLEQWMlX6rh7FHVEHiuNkGJCbeDtEZw0ke9YR43u5TVsOdZMDXDpEulWW71PIbaw0jkJ4cpjpdgEMagkWpFXPt9yFv8iEm+/KHorn5OCUZvwmhSeiD9kK83Cjsk+Mfya7hhkNUE8wJD0uQQ1zCkW58WWhjI05yrdSWxP7IETAhCo7xeQCo5jk2K+j4+ab+fBK2KHkcz/hfL4VKja5B+rhxIpHjq6A4z2IujMVlukhBQXeVx7lLvlqJlbyTNOqw2grDgmD4VpGdHv1JSgCsAR4WD2Yrfd4KaGEvCW3P3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqrVHsaPW33TQwL8beCjaFtV2eXCv7JMIAWdZgsQ0ag=;
 b=LmuwhpvprdHsIuCF6pQwMSJ7iRhQbbeOU5ZFiEne+MY9PeGuVD1g19UR1Z1bmXQdllRkAzT/wZQFql/8ep7YVKpyQk5tGg7dLzytPWbJ1MuCO0fosV15xS+lKj9G4HQsPDXw9sy+RavXiWxFx30uoWyq/hUwAeipD57D3r/Ge172hhY6pOLyIDjal2VVcbsN7KT/b/rACQkNniSnZhTDR+rn3LZJJZK5Erjddg/uOWN1/GGLLDRFeshGO++MK7RrCZYeAtGH3776ZHFb0GUf1wh8mwMCPOAGJqYgTZIYAQrYBTlPKP4Rq+1MXcRP9LQsCktwSN+n9c5PBoOjx5eLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqrVHsaPW33TQwL8beCjaFtV2eXCv7JMIAWdZgsQ0ag=;
 b=po2uMpj/pqD12dV0YYospaz5Hz+fzyylqQpM/of74OKsrhLXieZQ7HsPAeQYKsKzUoWwdOS8GfyVrgEM5xuSqwivTLBwC3ev8lI1UBEdleAyvH4CeMeoVL9eIJmZW7cDhYmtFhhtH+6srR0Ab632fm0sptL4cgqHGSJAJDktcls=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by CH0PR11MB5267.namprd11.prod.outlook.com (2603:10b6:610:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 15:08:49 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 15:08:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <xiongx18@fudan.edu.cn>, <Tudor.Ambarus@microchip.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yuanxzhang@fudan.edu.cn>, <xiyuyang19@fudan.edu.cn>,
        <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v4] mtd: rawnand: atmel: fix refcount issue in
 atmel_nand_controller_init
Thread-Topic: [PATCH v4] mtd: rawnand: atmel: fix refcount issue in
 atmel_nand_controller_init
Thread-Index: AQHYM8eU0erNZQ8vkUyJNG+lqp1kdw==
Date:   Wed, 9 Mar 2022 15:08:48 +0000
Message-ID: <42569c41-909e-559f-317f-660c6a4ddca0@microchip.com>
References: <20220304085330.3610-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20220304085330.3610-1-xiongx18@fudan.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d571ddaf-4dd7-40bb-c799-08da01deb6e5
x-ms-traffictypediagnostic: CH0PR11MB5267:EE_
x-microsoft-antispam-prvs: <CH0PR11MB526714210C2D0B853734692E870A9@CH0PR11MB5267.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gghxX+ER9IfafUIWbwRKyiDp/IMQZFhvx6Dcr93LzSPR/3MHyPAW47HNpW5c7hs182NUPgp+u8MT6hCeb/qsxe6zF9eDhOaqtp1P2DDlEbqSjnVhxUBLVGjrfi3W8bdCMhj2L4BqFRUW/KflbXIKnr5fKvCJLpmPqkpWNHRyStGC18ZzODVf583Aqec5Er1k8spkUEevrTcvEb7dfTVV1sjrdwiwIeI+sqsYgAiiZ5CpTOK1+wuTaPcdHvmuR+b9hFTdDSs7Jv9OAO2OzljYl3g39bIGkN4I9NcyVSMSMCwztRJ6xy7tuZK8oWLVKx7xfarzHDBDhoFJwXResoZe97ogSf2Qg/CQazmgXwS8sP2/lGPsBN4QPi003Mess42l1UPY2Bg5ikPgm4UN+CwxSVjHDVGQRKg7gzYFgWI56ogiYcy60eZ9wCZglDGvPW4qEmWhUeuOhfhy0q4hCHTXmr663dpl+qa3O1FPFSezpjGh2XWNfnZdt6bvJSC1QSWSJxJnC80ma7AtfF6ormPx+MMAoWs1iWtDFcSVuR0w0HXLFGviK9fWdQmFJ+ZBMgN92TuOUwfPK2h9jq7zXDkEWNK3o77qw7il46k5UAxAD3GdVO5NFlXUSXmH/8vfo5IH5MccuRCUFwgs2UAiqOBln/JoGK3god/8w5OkuJYGHlPOz/U2HD9Bx2h3Byq1Jq2Uoyc4k+dM69O5hIt24JFjNaLLSQuSfetK1jW67r8VFRhYcEoPVJVaBASm7e5VmhM7m4iIL5yeRK67tOAC2VSBit/9eCweX2FgHjMvOXuFT54=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(53546011)(8676002)(64756008)(76116006)(2906002)(86362001)(91956017)(66556008)(38100700002)(66946007)(66476007)(4326008)(921005)(54906003)(122000001)(71200400001)(110136005)(38070700005)(8936002)(5660300002)(7416002)(31696002)(6486002)(508600001)(316002)(6506007)(186003)(26005)(36756003)(31686004)(83380400001)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THRlSTFMSHBUai9hZ2swVHF6NUVyTmVZdlBoeUhCdWgzWVN4SUJDUUJGREFL?=
 =?utf-8?B?VU5XN2psQzNsOFAyU3NmOFJaQjNNRU1xNWhMNmRkcjdGMW5SYytyNkw0ZUVs?=
 =?utf-8?B?V2gxdW5zQndQT2tEcXMzdEwya0R2aHdXbU5BdzRON3k2ZmxWWG16TTRNYjAw?=
 =?utf-8?B?ZjZPcWNOMFBSNmk0cEdISDlGVHdldGU5UDBYNWdSZVV6T3I5czVuNCs2ZVNW?=
 =?utf-8?B?S2JGbnVuOGtCMnpqdjNQTGN5K3p3cTFUKzRSTHF5Wmc3Z3NCTkNqcGd4dzQ1?=
 =?utf-8?B?VUd1TEo0bis1WWQwaEV0RWdsOU1wYkhHeWFLLzR6Zm5zV20zRGh3NkdYbVlG?=
 =?utf-8?B?L1pzREpNRWdmUUFuZnRNbVpleGtqZHhWSmliZ3F2WDRORmRKS1ZoZCszVkNs?=
 =?utf-8?B?VEtyOHFQK0IzMjZGNGMzUUlndUVxOGYxUHpROC9tcTlzVjd0ekloU2kzeGlp?=
 =?utf-8?B?N1p3Ulp6c3NMV3JqR1RDdmZyRzhYYTUzOHAyanRuMUZJc1VacWZoVTBheXpo?=
 =?utf-8?B?QktQTjlIYVF4NWY2R0pzbGU2OEpnUEZDdzBKY2ZNOXh4eUsrSkRxVzlkdTdX?=
 =?utf-8?B?ZW1vL3ZGMGFwbWVuQmNSQ0piTkFMR29sK0Ewc3RqdDduQVB4YXlvNzdWRlJz?=
 =?utf-8?B?R0pQR1pWUjcvU1pzdWxMV2M1U05oSE5RK2lXNVR4K0VjN01KV1JDTnFlVXB0?=
 =?utf-8?B?OHlFTmFWTlhUbjVaVHQ5bGVHKzhqMWZ3RDV3OUNmNTdBZUJJVEhVMVRLaVk1?=
 =?utf-8?B?MDN2V3FJRWt6V3pJeHQzMFcvTUU4bm5oMXlhK013QkxNUkFDNWVjODhLM2hi?=
 =?utf-8?B?VUpWVm1BSnVoVnRHMFVyOHc5OUNUeUM0Mjh4cFRKb2o2UG9ibXZiRDNBMzE3?=
 =?utf-8?B?UU5xME5hM3RVRFYrMUJCWURJNnJiYmJ1Q2lhTkFSZ25DSllPdHYxc1M5L2Rl?=
 =?utf-8?B?eGZLdngvYXUyTmFidG5STWVEZUtrQTZ3VDYyZGxzRWQ3R1RUQTZiZ2VPUmZv?=
 =?utf-8?B?MXFnV1lZNGtieUNoYzFjUXAyMVkxZXVyTE5SVXlXajJhTXRxKy9BaXhtVkRi?=
 =?utf-8?B?c2Q4UDBGcTBWZ1VCamQwK3Rqanp6cU5qZ2EvSWFRM3ZDZUt5d0ZQeWFuWWhy?=
 =?utf-8?B?VVoweEVwR2d5WlhtbFJFRGtuUEpQbWRoYmw1Q09zMEpjc0ZyQTNycHVFbEUz?=
 =?utf-8?B?Q0dRU1RTN3dpZEwxVEpNazFKNEZNZWdhNFMwb2t1eGVwWXBOVDRPS0dyT3BL?=
 =?utf-8?B?MCs4UTJ1M3VmUmFxVFVHZ3pEanhxeHFEQnQzbnUzbUdIeTk0VGtGWWdYSUVM?=
 =?utf-8?B?SnhWNWRKa0krYU1wYy9kNWxlUjRud29peldYeklLRi9iUm55MjJhbzA3OXE3?=
 =?utf-8?B?d3BsWXU5OVdHZGF6TkFscHhEc0JoVTRtSmpGajhUOE5LbVIwaEs1SlpmZ1Zx?=
 =?utf-8?B?VUJLc0E1UDdkQ29wSjBYSFVDcVNUMVhpV2hHRmRDN2ZoNWlScXhqUEFDYzlV?=
 =?utf-8?B?TUdseW55Mlc3Zm16ZW41eHpxTGRCMUNUZ2U0cld2VkRPRjJrK3hXNzFpcDRh?=
 =?utf-8?B?eDd1aHpCY0NaL2FyZis2MXNLZ3VFM1Rid2dka2VtRnZmN0F3RmYwU1RBME1P?=
 =?utf-8?B?MjBzVjduQS9wVWpxbEsxR3J3SzVPcU5LVStGb1NBQ2JCRmxvTjc4ODNyVGtP?=
 =?utf-8?B?TGFYK2dCektzMVA3SkxLZmgwd2FrbG1JWW4ramJrNVVPRmtmMlZPUVRTYWlN?=
 =?utf-8?B?V0srWG1CTzBtb083Q0JsQTE5VUhITFp0ajhKNkQyOXVWclRjSmNKV0ZXK0Ev?=
 =?utf-8?B?UnMxWkUzYkNvRlErNWN6Q2UwUDUxQThCZFBpWkpHQlBtS1czQ2lrbHpMWWtF?=
 =?utf-8?B?ejFMbWExaUlwaG9Jem50WklKQlpZL096T0VJUzJnb1ZaSUlzNStiVW1KV1Z4?=
 =?utf-8?B?YWRGU1Y5VHpzemFpQ0plK3E5WHNCSXVLdEVVd09teU43azFBV3R1RWFaZmts?=
 =?utf-8?B?dzFZOHR3MysrQzhVNVd4ZUJCZWVNbGJmNXc0c0g1S3BWQ1IzR0hHcU9KeCth?=
 =?utf-8?B?ZjdSTFhLYndmOElUUDFsQ1hrMklKcXlmYzR4UHc0U2tFd2JuRzEyaXQ4T1Z6?=
 =?utf-8?B?NG50KzNjdjFaL21oTS9EZXdmeERmOFI0RXExYWFrOUtQSFJ1YjVqNWZidC9o?=
 =?utf-8?B?OFlxZEJkSnkxajFPSFUxd0tFeUZLTC9UNmxBYVBiRkxoQTNJZTV0Q09FK0Zy?=
 =?utf-8?B?bkFtZStIZjQweDZKeVZ3YWw0dTNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2933F3934373BA4AAC76AF73FDAAE763@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d571ddaf-4dd7-40bb-c799-08da01deb6e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 15:08:48.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmBxB/ppyHkyIT16r6YtBvk6fd4lWJ07Lr523INoGcNAOgUkMz8VdIYHULxkWCLSWZD3qsIkluXzEQBO24x3HAvZpkFAEN3sxU9Rl1JwGds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5267
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAxMDo1MywgWGluIFhpb25nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSByZWZlcmVuY2UgY291bnRpbmcgaXNzdWUgaGFw
cGVucyBpbiBzZXZlcmFsIGVycm9yIGhhbmRsaW5nIHBhdGhzDQo+IG9uIGEgcmVmY291bnRlZCBv
YmplY3QgIm5jLT5kbWFjIi4gSW4gdGhlc2UgcGF0aHMsIHRoZSBmdW5jdGlvbiBzaW1wbHkNCj4g
cmV0dXJucyB0aGUgZXJyb3IgY29kZSwgZm9yZ2V0dGluZyB0byBiYWxhbmNlIHRoZSByZWZlcmVu
Y2UgY291bnQgb2YNCj4gIm5jLT5kbWFjIiwgaW5jcmVhc2VkIGVhcmxpZXIgYnkgZG1hX3JlcXVl
c3RfY2hhbm5lbCgpLCB3aGljaCBtYXkNCj4gY2F1c2UgcmVmY291bnQgbGVha3MuDQo+IA0KPiBG
aXggaXQgYnkgZGVjcmVtZW50aW5nIHRoZSByZWZjb3VudCBvZiBzcGVjaWZpYyBvYmplY3QgaW4g
dGhvc2UgZXJyb3INCj4gcGF0aHMuDQo+IA0KPiBGaXhlczogZjg4ZmMxMjJjYzM0ICgibXRkOiBu
YW5kOiBDbGVhbnVwL3Jld29yayB0aGUgYXRtZWxfbmFuZCBkcml2ZXIiKQ0KPiBDby1kZXZlbG9w
ZWQtYnk6IFhpeXUgWWFuZyA8eGl5dXlhbmcxOUBmdWRhbi5lZHUuY24+DQo+IFNpZ25lZC1vZmYt
Ynk6IFhpeXUgWWFuZyA8eGl5dXlhbmcxOUBmdWRhbi5lZHUuY24+DQo+IENvLWRldmVsb3BlZC1i
eTogWGluIFRhbiA8dGFueGluLmN0ZkBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpbiBU
YW4gPHRhbnhpbi5jdGZAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBYaW4gWGlvbmcgPHhp
b25neDE4QGZ1ZGFuLmVkdS5jbj4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiBWMyAtPiBWNDogUmVtb3ZlZCB1
c2VsZXNzIGNvbmRpdGlvbiBjaGVjaw0KPiBWMiAtPiBWMzogUmVtb3ZlZCByZWR1bmRhbnQgbGlu
ZXMNCj4gVjEgLT4gVjI6IFJld3JpdGVkIHRoZSBlcnJvciBoYW5kbGluZyBibG9jaw0KPiAtLS0N
Cj4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29udHJvbGxlci5jIHwgMTQgKysr
KysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25h
bmQtY29udHJvbGxlci5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9s
bGVyLmMNCj4gaW5kZXggZjMyNzZlZTllNGZlLi5kZGQ5M2JjMzhlYTYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29udHJvbGxlci5jDQo+ICsrKyBiL2Ry
aXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL25hbmQtY29udHJvbGxlci5jDQo+IEBAIC0yMDYwLDEz
ICsyMDYwLDE1IEBAIHN0YXRpYyBpbnQgYXRtZWxfbmFuZF9jb250cm9sbGVyX2luaXQoc3RydWN0
IGF0bWVsX25hbmRfY29udHJvbGxlciAqbmMsDQo+ICAgICAgICAgbmMtPm1jayA9IG9mX2Nsa19n
ZXQoZGV2LT5wYXJlbnQtPm9mX25vZGUsIDApOw0KPiAgICAgICAgIGlmIChJU19FUlIobmMtPm1j
aykpIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJldHJpZXZl
IE1DSyBjbGtcbiIpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIobmMtPm1jayk7
DQo+ICsgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKG5jLT5tY2spOw0KPiArICAgICAgICAg
ICAgICAgZ290byBvdXRfcmVsZWFzZV9kbWE7DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICBu
cCA9IG9mX3BhcnNlX3BoYW5kbGUoZGV2LT5wYXJlbnQtPm9mX25vZGUsICJhdG1lbCxzbWMiLCAw
KTsNCj4gICAgICAgICBpZiAoIW5wKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwg
Ik1pc3Npbmcgb3IgaW52YWxpZCBhdG1lbCxzbWMgcHJvcGVydHlcbiIpOw0KPiAtICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0K
PiArICAgICAgICAgICAgICAgZ290byBvdXRfcmVsZWFzZV9kbWE7DQo+ICAgICAgICAgfQ0KPiAN
Cj4gICAgICAgICBuYy0+c21jID0gc3lzY29uX25vZGVfdG9fcmVnbWFwKG5wKTsNCj4gQEAgLTIw
NzQsMTAgKzIwNzYsMTYgQEAgc3RhdGljIGludCBhdG1lbF9uYW5kX2NvbnRyb2xsZXJfaW5pdChz
dHJ1Y3QgYXRtZWxfbmFuZF9jb250cm9sbGVyICpuYywNCj4gICAgICAgICBpZiAoSVNfRVJSKG5j
LT5zbWMpKSB7DQo+ICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKG5jLT5zbWMpOw0KPiAg
ICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJDb3VsZCBub3QgZ2V0IFNNQyByZWdtYXAgKGVy
ciA9ICVkKVxuIiwgcmV0KTsNCj4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAg
ICAgICAgICAgICBnb3RvIG91dF9yZWxlYXNlX2RtYTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAg
ICAgIHJldHVybiAwOw0KPiArDQo+ICtvdXRfcmVsZWFzZV9kbWE6DQo+ICsgICAgICAgaWYgKG5j
LT5kbWFjKQ0KPiArICAgICAgICAgICAgICAgZG1hX3JlbGVhc2VfY2hhbm5lbChuYy0+ZG1hYyk7
DQo+ICsNCj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gIHN0YXRpYyBpbnQNCj4g
LS0NCj4gMi4yNS4xDQo+IA0KDQo=
