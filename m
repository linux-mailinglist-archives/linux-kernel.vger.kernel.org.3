Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A910C5510AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbiFTGp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbiFTGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:43:05 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616AB7665
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojexgj0sqoTJKsD/GWhLC3hcphLfdyauSgI2VdifJyqGC+uNXwOk35WSYRbyfRFdP1tWc+ZkYbMNu1spU9NnXq+/ZPkeGPaVrMU4x5VXBVRYGmwUsKQlt+mbduEnMUaBqclWWPJVJVYUyAGhBaTPwdZKk+9qLmDc3fn4+7zLq7D/FemjurD4BdPu1F9Ti8R9cb/Gu0y2bjr3lkYO5rJQfiLn2ay57/YiiY2tYF+2ihDWF/KzrcFOG02sEOVytO4PmpO/SUED27z9BlDSCPMeIjfom3e9qHiaJoQDqWbrPqdhTPk17VqiShrcxB6HwapwNuGOVLKnyYh9zJwax4Ztqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIrj3NEaLWRKYEXQssKEQDDV+c0zsX2KrRSkCtrPTSs=;
 b=PPhpJ5Nwrs0C8IHiz3nItRNeTiNTfqdq22mD0M4J86LJgUgqYIrgl7NmMAufNglaG6VRbqfza7TriHsnuDokmwnrSIxXxoKjxOVrcJnr7p7Px+CFr7qrKv9LPtG2dO7B2q/nUsRNZUOVd1e+lyiQW4/ZyaJzilwPK3gvZPdHHuqRSl3P0Hab3Sj5NXXlHt4MwhQYPmfcE4cj2KsJ5vLPz7LElTZkV26yKCVS5WUpPXzMMwHQGZCOu9BlAX5abDmvLxIoOXn6OEspdpN1HunJj3Lhl28NkVPV37hggOHhzipVSqx1CU64gHQqydcDT1JLxL2I6ehfhxlmcIah27jAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIrj3NEaLWRKYEXQssKEQDDV+c0zsX2KrRSkCtrPTSs=;
 b=nMeeLCi/TfLtpNTX/dXtvN4XB/kNYFbzbk9P1lSsYIgH3U5mnEgwZIwsVMIpmscVRuRuVjcyHrxtL8fPAZwZi84P32xkVyzacnBruLSS7ntUzJ/BAZznUfD6WgcNZDpafXxqj+yLXQ5jVFRZAYXMTUkHBcDnEgr9MrIlzL59tN6iOH5Vj0g4mdP7UBRLgs7ipsR6k/KbTlt0Mn0n+L1PLEBd1jLZiGsSYT0BtteUVsgXXnoAsepLkdc1Xo3mYcxVSJjr7UsNYsz+LusM1LFwmIekl8wDNOEQrhVngiURV0WMjwbP68Pxx05firvpFDOEHrXk1Z3iRSGBucDBl6/39A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3931.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:25a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 06:43:01 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 06:43:01 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        kernel test robot <lkp@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/2] mm/mmap: Restrict generic protection_map[] array
 visibility
Thread-Topic: [PATCH V3 1/2] mm/mmap: Restrict generic protection_map[] array
 visibility
Thread-Index: AQHYgTbnl64fdvvm+kuWk4WKkbugyq1R+xoAgAXDnICAACDUgA==
Date:   Mon, 20 Jun 2022 06:43:01 +0000
Message-ID: <9dd7e0b5-c5ce-cdea-c519-b15313337c3b@csgroup.eu>
References: <20220616040924.1022607-2-anshuman.khandual@arm.com>
 <202206162004.ak9KTfMD-lkp@intel.com>
 <da75a2d1-afc5-b6ff-dce0-ef0b20dbfde0@arm.com>
In-Reply-To: <da75a2d1-afc5-b6ff-dce0-ef0b20dbfde0@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c26b214-cb71-4416-5f52-08da52881f1b
x-ms-traffictypediagnostic: PR0P264MB3931:EE_
x-microsoft-antispam-prvs: <PR0P264MB393179E7032C7F5C03CD91B0EDB09@PR0P264MB3931.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SAhyBFTB56kJhufm08nKIcr9OfnH38uTXCCU8czyhjr8PS0jlYfhCURoF49p96POU2KUMJPmAmwnk2wszwDrupvg5fhQHYTBqcHiV49TsPjujWp4XLtjBB7sz06I0XPZpp2+DqiDmcP+NB1FQDHHtDrsTUGwWnNztjVlvDdPzZ0hfIzNVCr1r1E/j8MJ62pG5QI5N7FkQswULFBUIwdBpDMOYjNygb6Fcx+ExRLG1xDr07toN+hC/h6TNuZpUk64T2e27GVeJgfgChFApZ8Fe7ZMCset+iFb5/xoQTetZ/8MxolimNwCChKkX1qf1krZPkRqqiq+jiuzvqIgyWb9R1p1wnoDebDFPnJVWBJDwqwQDk7L5uMRfprnZL3XOs/vv2mAYrQv3IzMemaRaHxvv3XeJLeWP1vwuv4b0kQNHcoSlc4PCVjvQCSKotNhtpaw+CaXRhywWlAtDAHKS2lXSxV/jMpcYgaGTJrDwWDS7TjoY/mcGtEShfPNYzCC6O8oQ2v1c9ZSDn/qEUKUtFwnEV2gAtklGV88rDB1tyODWMB7OGhIVUCBGNvwqGdmxDdS21UdGpMlx4JBD21k2E8FFMuVsWy06DW5ejNuEbyonxsR2B/Q4S7aCjIpDQguw/2GMKfRAI6hppiDcCXmc/p4m/I/eQVSpt8ZKPezhsxAG/Bbo/GGC+p7E7lJ4YzXenRywg2FGb7lJXOJRDCdUDVRbJsd0Xql2sqhnUf/3sWU4cutXa8DE1A+Vau2sEFop8IvySJ/3+RqGjOpRJdpfaSMIQY/cYL7SafY1GmIcXxB9KKvRr9RuPb0zoFkextSbRFPXNg+kiRDT7G80yy7MaZhbjDBOQZZw6sBXLOwMUPVs6N5fXu7MEA5Wtg2ythWQ1hTh2Yu/lemEuXv/Mv8Zk5VHZuVTv4b2VsH5QRT0SLt/lg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39850400004)(376002)(346002)(41300700001)(86362001)(54906003)(53546011)(38100700002)(71200400001)(122000001)(44832011)(2906002)(110136005)(2616005)(478600001)(6486002)(316002)(83380400001)(966005)(8936002)(31686004)(64756008)(36756003)(186003)(38070700005)(31696002)(6506007)(26005)(91956017)(6512007)(8676002)(4326008)(66574015)(5660300002)(76116006)(66446008)(66556008)(66476007)(66946007)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlJrVUw1MXlPYXJYKzVuOFhldExTWWZZQXUyUzRwWURNM1JXazlCaUM4Uk1t?=
 =?utf-8?B?cTJQWFpGc2RnYTNIMCtRQTd3SythYml6bGdpUnh6a21sNzZrU3lqUlJINHh4?=
 =?utf-8?B?dDdHRnoxWlNiTmNJcWFyaWZpVU0waG5BcFM1MWxsZktSNk9HcVU0eE5qMmRZ?=
 =?utf-8?B?RkNrYWZtSzQ0SFg5dVkrS1lyd3BRQlJXUDZjTW5mR09xK0JTRDRSOHB2Zyth?=
 =?utf-8?B?MEFhTnpBYkJuQzZsVEFBUkhOemhKVUhqNzZ3TEhrcStmYTVNQjI5YzZrTE1o?=
 =?utf-8?B?bDI2NHduZ1M5SjZJb2FmMEthOCtJV1czOHUrL3BUdmVSSGlyT0VjaGFWZkYr?=
 =?utf-8?B?TXQ0azRBcEMxbkhRTzVvY1VFR0RnM3VLUy9IeW1JcTh0S0RNaENmeEY3a2p4?=
 =?utf-8?B?NVRMSjBsUmVuQUpJRm9jRXFXdnNoa05tMEpMWHVzSzZodkozaGZIaHFsM2Vs?=
 =?utf-8?B?NnVxREhqSjRrQnF4OUk1U2I3YzZhOW5YeU9ZY2ZsVXpzd3ZrOHVRdWVGVmZy?=
 =?utf-8?B?TXdiVW1KV0NTTXVVN2xndENoYjBueWR5SzJOQU50aGhnZ0VVNGlncVV2SUZa?=
 =?utf-8?B?VGdRWVIwbEhQSGtuSWV1MG5NNnBlZUNuY2hRSDJuVEdLMGMwcVJDYWFvTVVP?=
 =?utf-8?B?M2p2dVFQZ2l0bmd6Sjl5UnBONUJkVWtQUXk2K3dCSW9wbUlqbXdJTi9mRTJa?=
 =?utf-8?B?Nnl5d2k4UGdaVFR5aWxQQ1I0RHBkWmthdnlGZk9DczcwcE1vWVVaNDVBTk8z?=
 =?utf-8?B?ZlZORm1oNitUWFd3YnZPTi9vQTdTL1RHUnQ3UldmVUJ1a2JobzVHVVFJbmhL?=
 =?utf-8?B?SkJSbndPT0hjejFXZ1N4UXNUOUI0VXJjVjk4TWg5SjlLK3V5VjE0ZVE3ZCtW?=
 =?utf-8?B?bzZaVDdwMDdnOEoxRTNLUTBub2pFck5rbWUxM0RodEV0cllNVkxYL0FrWXl5?=
 =?utf-8?B?SEdpY29wVU1qWWhoNzBWajVnaFFQMnpVOXM0THJJdkhkQW0vcmlwV0l4KytG?=
 =?utf-8?B?R2QxNkdZbklsTC8xZEc4RFhMWDB6N0RUTFRsdWQ5SHlKNWtaalVzWjJ5RkJH?=
 =?utf-8?B?ZGk1eW5ZQkN2dnN1U1JPV3BSeG9JL1lPN2NCOFhXNkM2bktIcTM3cjRvSlh6?=
 =?utf-8?B?V2h6cGJvbEdVY2dqd3lncUJ0ZmlrZTlydGo1TENTaGpDOEFKdEVsNjRvSTBR?=
 =?utf-8?B?YzBsTm40TFBkTWRzZEczaE5xVnBSMXN6WWU0cVVsTG56UmdHYlJYTnlOb1k3?=
 =?utf-8?B?dkN6TmROb1Q5RkpUams1TDZSOVhyeWNyelJkcGxRYmZwMmc4ellTcFVzOEtp?=
 =?utf-8?B?b1lSMkxGd0lZNWRseUlFRmlPR2pJS05WYUt2eUVtalRZWjEzRWE5K0JOQXNT?=
 =?utf-8?B?eHJyQll5enc4U3pnbXVSM1Z2Y2tWZTBPbXRneURaOENDeVR6U083eklUVXpa?=
 =?utf-8?B?b2swaDVteGtoVTlnSThvb0RXb1lrSzhmc2t6cEJXcXFWanRGRjVJWUloMlBY?=
 =?utf-8?B?b1NjcWlweFNTKzVoVndPd1JRMGo0NGlpQXlvZlNQWG1NZEVYdDd1Z2tNV3Av?=
 =?utf-8?B?YjVBamd2cEZSMjRkZXFiYTZYWHo4clg3aTJyQ3hxbXlXbnV0SlFrWVZjZXpH?=
 =?utf-8?B?T0wvZkxzZEZ1d0MxWW9rTUtzSzRkSXZKOW9hbDRLQmkyTzlwTSs3dFNFODE3?=
 =?utf-8?B?ckcwK0ZrVEtkNWlFUWRmNG1JSndrdHNoNDlWWWFRSklkZUQwV1M2ODR1c3FQ?=
 =?utf-8?B?WFI1U2RzSmhFUC9sL1JPcWlyM21XbnkxamQrZ09nMFdPbGxMbnVjYlJHN3k0?=
 =?utf-8?B?dHo4R2N1N2tLb3ZMdXNocjNhN2N4WitWazhIK205MWliTU5sVlJRdndsVHk5?=
 =?utf-8?B?MXZRbGdGaWdHYXBSLzlta3E0cTdrblh6YWJpL3Z3UThCb3VkNk8xTEN3Skpm?=
 =?utf-8?B?REo4cFl5K3RvTXlKNURwREc1THpMVGVCb1dqSzhBdTFmNzRQOUJCUmxBZkMx?=
 =?utf-8?B?WERrazNWUWlrdVA3U3lvRU1obzNXMVFlZ1NldTczTk85L2xmVGYya2o4ZHNu?=
 =?utf-8?B?ZW5ZaEhSMXlRWkNVdU1CUmpuQ2JUTnJ0Y3N6ZUtiTnpiRUFyanJ5eGNKWWZj?=
 =?utf-8?B?eDZwZVozclBKNTRHMmRHK0FBTFVycVJFWW93ZVBWR08vN3l4cWlTV0FuaTJD?=
 =?utf-8?B?dWdUTjUyNUJ6RjdWdUJtNk5tZ3dZTG5HREQ0QW50MnNMN21sYmJJNVVUN3Fx?=
 =?utf-8?B?Uzd0MUJTY0phU2RTaXNYUnVmNHJOVUc4a0pnb2NRcFZaNlNRMkNhNjdicnAv?=
 =?utf-8?B?dytFSk04aDJMQno1M2FneXpTZDBvRWxFVkM1N0hQcWJRN3Jwb2NjUlZ6eUlC?=
 =?utf-8?Q?GbjTKzgPaBFBPdfPwy/wUC32afXhgNqTIHefx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D603F191C50C8F4F8614F63CB6E78D4A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c26b214-cb71-4416-5f52-08da52881f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 06:43:01.6795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBOCF6e5zPPEbAMQR//03oLJGt78Tj6hWRAz/98Q8FTzYQ6xMwKRM+5p7RHSmL5WfHDYYbHWL5HnbgvdgRSZILv1kbuwv5SVQ6+5go5HNXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIwLzA2LzIwMjIgw6AgMDY6NDUsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IA0KPiBPbiA2LzE2LzIyIDE4OjE0LCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToNCj4+IEhp
IEFuc2h1bWFuLA0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoISBZZXQgc29tZXRoaW5n
IHRvIGltcHJvdmU6DQo+Pg0KPj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiBha3BtLW1tL21t
LWV2ZXJ5dGhpbmddDQo+Pg0KPj4gdXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFi
LWxrcC9saW51eC9jb21taXRzL0Fuc2h1bWFuLUtoYW5kdWFsL21tLW1tYXAtRHJvcC1fX1NYWFgt
X19QWFhYLW1hY3Jvcy1mcm9tLWFjcm9zcy1wbGF0Zm9ybXMvMjAyMjA2MTYtMTIxMTMyDQo+PiBi
YXNlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Fr
cG0vbW0uZ2l0IG1tLWV2ZXJ5dGhpbmcNCj4+IGNvbmZpZzogeDg2XzY0LWFsbHllc2NvbmZpZyAo
aHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjIwNjE2LzIwMjIwNjE2
MjAwNC5hazlLVGZNRC1sa3BAaW50ZWwuY29tL2NvbmZpZykNCj4+IGNvbXBpbGVyOiBnY2MtMTEg
KERlYmlhbiAxMS4zLjAtMykgMTEuMy4wDQo+PiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVp
bGQpOg0KPj4gICAgICAgICAgIyBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9saW51
eC9jb21taXQvNGViODkzNjhiMTMwZmUyMzVkNWU1ODdiY2MyZWVjMThiYjY4OGUyZA0KPj4gICAg
ICAgICAgZ2l0IHJlbW90ZSBhZGQgbGludXgtcmV2aWV3IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRl
bC1sYWItbGtwL2xpbnV4DQo+PiAgICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIGxpbnV4LXJl
dmlldyBBbnNodW1hbi1LaGFuZHVhbC9tbS1tbWFwLURyb3AtX19TWFhYLV9fUFhYWC1tYWNyb3Mt
ZnJvbS1hY3Jvc3MtcGxhdGZvcm1zLzIwMjIwNjE2LTEyMTEzMg0KPj4gICAgICAgICAgZ2l0IGNo
ZWNrb3V0IDRlYjg5MzY4YjEzMGZlMjM1ZDVlNTg3YmNjMmVlYzE4YmI2ODhlMmQNCj4+ICAgICAg
ICAgICMgc2F2ZSB0aGUgY29uZmlnIGZpbGUNCj4+ICAgICAgICAgIG1rZGlyIGJ1aWxkX2RpciAm
JiBjcCBjb25maWcgYnVpbGRfZGlyLy5jb25maWcNCj4+ICAgICAgICAgIG1ha2UgVz0xIE89YnVp
bGRfZGlyIEFSQ0g9eDg2XzY0IFNIRUxMPS9iaW4vYmFzaCBhcmNoL3g4Ni8NCj4+DQo+PiBJZiB5
b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIHdoZXJlIGFwcGxpY2Fi
bGUNCj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+
DQo+PiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+Pg0KPj4gICAgIElu
IGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaDoyNywNCj4+
ICAgICAgICAgICAgICAgICAgICAgIGZyb20gYXJjaC94ODYvaW5jbHVkZS9hc20vcHJlZW1wdC5o
OjYsDQo+PiAgICAgICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvbGludXgvcHJlZW1wdC5o
Ojc4LA0KPj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L3NwaW5sb2Nr
Lmg6NTUsDQo+PiAgICAgICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvbGludXgvbW16b25l
Lmg6OCwNCj4+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9nZnAuaDo2
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L21tLmg6NywNCj4+
ICAgICAgICAgICAgICAgICAgICAgIGZyb20gYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1kLmM6
MTQ6DQo+PiAgICAgYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1kLmM6IEluIGZ1bmN0aW9uICdz
bWVfZWFybHlfaW5pdCc6DQo+Pj4+IGFyY2gveDg2L21tL21lbV9lbmNyeXB0X2FtZC5jOjQ5OToz
NjogZXJyb3I6ICdwcm90ZWN0aW9uX21hcCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMg
ZnVuY3Rpb24pDQo+PiAgICAgICA0OTkgfCAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKHByb3RlY3Rpb25fbWFwKTsgaSsrKQ0KPj4gICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KPj4gICAgIGluY2x1ZGUvbGludXgv
a2VybmVsLmg6NTU6MzM6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8gJ0FSUkFZX1NJWkUn
DQo+PiAgICAgICAgNTUgfCAjZGVmaW5lIEFSUkFZX1NJWkUoYXJyKSAoc2l6ZW9mKGFycikgLyBz
aXplb2YoKGFycilbMF0pICsgX19tdXN0X2JlX2FycmF5KGFycikpDQo+PiAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fg0KPj4gICAgIGFyY2gveDg2L21tL21l
bV9lbmNyeXB0X2FtZC5jOjQ5OTozNjogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIg
aXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4NCj4+
ICAgICAgIDQ5OSB8ICAgICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocHJvdGVjdGlv
bl9tYXApOyBpKyspDQo+PiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+DQo+PiAgICAgaW5jbHVkZS9saW51eC9rZXJuZWwuaDo1NToz
Mzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAnQVJSQVlfU0laRScNCj4+ICAgICAgICA1
NSB8ICNkZWZpbmUgQVJSQVlfU0laRShhcnIpIChzaXplb2YoYXJyKSAvIHNpemVvZigoYXJyKVsw
XSkgKyBfX211c3RfYmVfYXJyYXkoYXJyKSkNCj4+ICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn5+DQo+PiAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1
ZGUvbGludXgvYml0cy5oOjIyLA0KPj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRl
L2xpbnV4L3JhdGVsaW1pdF90eXBlcy5oOjUsDQo+PiAgICAgICAgICAgICAgICAgICAgICBmcm9t
IGluY2x1ZGUvbGludXgvcHJpbnRrLmg6OSwNCj4+ICAgICAgICAgICAgICAgICAgICAgIGZyb20g
aW5jbHVkZS9hc20tZ2VuZXJpYy9idWcuaDoyMiwNCj4+ICAgICAgICAgICAgICAgICAgICAgIGZy
b20gYXJjaC94ODYvaW5jbHVkZS9hc20vYnVnLmg6ODcsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICBmcm9tIGluY2x1ZGUvbGludXgvYnVnLmg6NSwNCj4+ICAgICAgICAgICAgICAgICAgICAgIGZy
b20gaW5jbHVkZS9saW51eC9tbWRlYnVnLmg6NSwNCj4+ICAgICAgICAgICAgICAgICAgICAgIGZy
b20gaW5jbHVkZS9saW51eC9tbS5oOjYsDQo+PiAgICAgICAgICAgICAgICAgICAgICBmcm9tIGFy
Y2gveDg2L21tL21lbV9lbmNyeXB0X2FtZC5jOjE0Og0KPj4gICAgIGluY2x1ZGUvbGludXgvYnVp
bGRfYnVnLmg6MTY6NTE6IGVycm9yOiBiaXQtZmllbGQgJzxhbm9ueW1vdXM+JyB3aWR0aCBub3Qg
YW4gaW50ZWdlciBjb25zdGFudA0KPj4gICAgICAgIDE2IHwgI2RlZmluZSBCVUlMRF9CVUdfT05f
WkVSTyhlKSAoKGludCkoc2l6ZW9mKHN0cnVjdCB7IGludDooLSEhKGUpKTsgfSkpKQ0KPj4gICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeDQo+PiAgICAgaW5jbHVkZS9saW51eC9jb21waWxlci5oOjI0MDozMzogbm90ZTogaW4gZXhw
YW5zaW9uIG9mIG1hY3JvICdCVUlMRF9CVUdfT05fWkVSTycNCj4+ICAgICAgIDI0MCB8ICNkZWZp
bmUgX19tdXN0X2JlX2FycmF5KGEpICAgICAgQlVJTERfQlVHX09OX1pFUk8oX19zYW1lX3R5cGUo
KGEpLCAmKGEpWzBdKSkNCj4+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn4NCj4+ICAgICBpbmNsdWRlL2xpbnV4L2tlcm5lbC5oOjU1
OjU5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ19fbXVzdF9iZV9hcnJheScNCj4+ICAg
ICAgICA1NSB8ICNkZWZpbmUgQVJSQVlfU0laRShhcnIpIChzaXplb2YoYXJyKSAvIHNpemVvZigo
YXJyKVswXSkgKyBfX211c3RfYmVfYXJyYXkoYXJyKSkNCj4+ICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+
fn5+fn5+fn4NCj4+ICAgICBhcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9hbWQuYzo0OTk6MjU6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnQVJSQVlfU0laRScNCj4+ICAgICAgIDQ5OSB8ICAg
ICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocHJvdGVjdGlvbl9tYXApOyBpKyspDQo+
PiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+DQo+IA0KPiBU
aGlzIHBhdGNoIGZpeGVzIHRoZSBidWlsZCBmYWlsdXJlIGhlcmUuDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1kLmMgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlw
dF9hbWQuYw0KPiBpbmRleCBmNmQwMzhlMmNkOGUuLmQwYzJlYzFiYjY1OSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1kLmMNCj4gKysrIGIvYXJjaC94ODYvbW0vbWVt
X2VuY3J5cHRfYW1kLmMNCj4gQEAgLTQ4NCw2ICs0ODQsOCBAQCB2b2lkIF9faW5pdCBlYXJseV9z
ZXRfbWVtX2VuY19kZWNfaHlwZXJjYWxsKHVuc2lnbmVkIGxvbmcgdmFkZHIsIGludCBucGFnZXMs
IGJvbw0KPiAgICAgICAgICBlbmNfZGVjX2h5cGVyY2FsbCh2YWRkciwgbnBhZ2VzLCBlbmMpOw0K
PiAgIH0NCj4gICANCj4gK2V4dGVybiBwZ3Byb3RfdCBwcm90ZWN0aW9uX21hcFsxNl07DQoNCkFk
ZGluZyBleHRlcm4gZGVjbGFyYXRpb24gaW4gQyBmaWxlcyBpcyBub3QgdGhlIGJlc3Qgc29sdXRp
b24uIElzbid0IA0KdGhlcmUgYSBIIGhlYWRlciB3aXRoIHRoYXQgZGVjbGFyYXRpb24gPw0KDQo+
ICsNCj4gICB2b2lkIF9faW5pdCBzbWVfZWFybHlfaW5pdCh2b2lkKQ0KPiAgIHsNCj4gICAgICAg
ICAgdW5zaWduZWQgaW50IGk7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wZ3Byb3QuYyBi
L2FyY2gveDg2L21tL3BncHJvdC5jDQo+IGluZGV4IDdlY2ExYjAwOWFmNi4uOTZlY2EwYjJlYzkw
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9tbS9wZ3Byb3QuYw0KPiArKysgYi9hcmNoL3g4Ni9t
bS9wZ3Byb3QuYw0KPiBAQCAtNCw3ICs0LDcgQEANCj4gICAjaW5jbHVkZSA8bGludXgvbW0uaD4N
Cj4gICAjaW5jbHVkZSA8YXNtL3BndGFibGUuaD4NCj4gICANCj4gLXN0YXRpYyBwZ3Byb3RfdCBw
cm90ZWN0aW9uX21hcFsxNl0gX19yb19hZnRlcl9pbml0ID0gew0KPiArcGdwcm90X3QgcHJvdGVj
dGlvbl9tYXBbMTZdIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCj4gICAgICAgICAgW1ZNX05PTkVdICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSBQQUdFX05PTkUsDQo+ICAgICAg
ICAgIFtWTV9SRUFEXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gUEFH
RV9SRUFET05MWSwNCj4gICAgICAgICAgW1ZNX1dSSVRFXSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSBQQUdFX0NPUFksDQo+IA==
