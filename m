Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEE4CCEF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiCDHUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiCDHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:20:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77C1795F4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646378392; x=1677914392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I4YlRobCUpr2PMhD0/JlaSzdAF5IAFDjEquHKW6hqEc=;
  b=zBTCJMTR2has4bWNmZzcUlJOlWwUhwHV5W5UZ5a9llXjSfaHPRpw6HnC
   w8Equi38kuaE8pUsliAxDUQFCVpX5Yw+4gfKc173PxafbuiJOwfhJbT9s
   Rt/Bk9YyFJn3Zj6POYOubQl8TDYWiNi1gHBbKsleyzO8y4VaFzACEXDrY
   gGAGFxvSWE5WjahOwkbhz3EnuqPnkUXOy4YYQht2HYvoODFAc5CQbQMTv
   Q6gsSBCgea1a0UQ8pOrmvwBYzVAO7vZ6byBm8FsHnuyaAwTw/eOGIDxjP
   rOCnkc+qTkQ+PiPPmZAvsUnRICXw7jpSvAOi6BKCYVSYx7PukYokJO9FX
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="155238288"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 00:19:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 00:19:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 00:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blzj+NGeKxm+HGkxV16J5citz50P5mI9wt5sA6GGvWjsDTMPnzRrImLIWyk/28PVtGqdEwDK+qb3FnPvfJOSK8a2YylAujphpDTp7MrFEGhmPyHvGMdipLYDzIjWVUkdX8GuOUDiSChC4Z/yW4fhxX/W3X8771ymmmNG4GUi6NDe7B7Zab4acULcYLhbaHZydw2l0YnI/Euw6JEAcIM+dwiw68CDdfnQsXfLT1ZWovLd3INmqmu6RrDFcse4YAe8hNf8ZiKNbR9nVYc6R0njg4ei7q9qw2aRvmN+V2yco+Z3QRO+iuZn5pkXttAnCBmp5nQK3Yd2UEnUdGdrxwlMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4YlRobCUpr2PMhD0/JlaSzdAF5IAFDjEquHKW6hqEc=;
 b=LP6tpqhlNS+xGI51S1gA2G9AuKT3sMiEJYjYjzJ4fIv33N2pDFUhX25ymaPx62sTgjb3mZDQ7kKofthgSN9vuCIHDpfYUtVzRGxWog1zE6nP28WKV4zzN1rkrXgSqxEX++Qz/zxV6z5dmx0Ze+dYcGx/PMT4wUCzCfHfjPQ7uvkGeYUzfqOiS9HKtOIH2wsONnEgRQ0f+G06ZT9XK1q5qzaN7v8LFGP4oblfOlemcwn/19G4uNWe1Gvs8kd4NHyGjgseyc3GA8UQC4PJXGRzCNzpka7M0PwXN+/hD6jeWhue6JCe6dsIRbXo/WAZMtizLEKhk1jIEURAOS613lfTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4YlRobCUpr2PMhD0/JlaSzdAF5IAFDjEquHKW6hqEc=;
 b=IWfQR2wjHnOof+E8CQMDoKXoTAr/Ej3mc+No2h8XpDYhF1d2fgtRCgz7Wiz3K/i/JJXNnU3aTR2lH1NJ1VAyHQl0AeBOKhOQz+t3tnk5IxZosFJZxB5p2Nsa73QADMLzcwMiKhqtj3Cr0RW5U9bsIAf75B3jihAHNOTwj57Wcro=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 07:19:45 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 07:19:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>
Subject: Re: [PATCH v2] mtd: core: Remove partid and partname debugfs files
Thread-Topic: [PATCH v2] mtd: core: Remove partid and partname debugfs files
Thread-Index: AQHYL5g5cRRasti+jECAK2OJBo20tw==
Date:   Fri, 4 Mar 2022 07:19:45 +0000
Message-ID: <787ca51d-fc85-dfe1-0c2d-dc8ab6234aa2@microchip.com>
References: <20220225144656.634682-1-tudor.ambarus@microchip.com>
In-Reply-To: <20220225144656.634682-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d8861a7-f62a-4b93-d58d-08d9fdaf5be6
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_
x-microsoft-antispam-prvs: <MW5PR11MB58818C41881BCF110372A5C8F0059@MW5PR11MB5881.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRPpEwop0GPYhZTZOWx5VJ9FINmVhDbd1jQ4wTp/Xs50+t/VovqK4cezL7LN2txhy/zZXa50t6LhcMEXl8kF6cyZYBzUVOyj5hT73Nk1YrCSagFSnvRbrJEA8AiG/3B5LHsXB6GiEe6D5j0sEVyujQXJvgH4Dvo80xduVVpabTYGrMlm8fi3Z9vaCAloPsK4CeF19KcU/SihGZt9SIbIHt9uP05c2S8vUz0I5RofekdWuK74AUd42J/ktGtr5rzTTYLuKk6ABL5pynN2RoEZ/ht3AWgDHQMHoTRGqMPg2hahamesqp77iAQZI37/JmoCZqgLIiVETrNcOGFMAujCM+dbUf/so3GCa8k4cmSESUN/UT1JIm58l6TLUJ8xlOXg6XI60zAFF2jSCWzITPZDjPohhYH7ww92PvCwtpuRCyz+pEZeA6QYm7RyOgnqIDrP7oChJCFKRGPTyAp28WEXaxS8MTPn72l8tNGclGgtBMhdxuWjbKnrUzgau3CF2Y1N5+Sp+6ci7c83g6KASOvdK2DotFULxtNAj6DV+MR8aBEAhJSKaBqs8p3xp5Ufvz8rfZGawqz3XhI3NEutQRpjj5d097cy9fU9HRAaghvyutSVJszlPXenc2mQCuBg3+YX8HJva81KcWagx25KKv5oeA2Gz1wDhdz9hBwSVfidxp49YY18/UNerGPVB9REjWoB6Kbm4xEOEc4O3/0ZIRljJVNjNQZKXajXpRWqAH8mSVUfRUwl3exmPHE8o0Xu5GDFNiMwm/oksFu/9tt34WGUmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(31686004)(36756003)(38100700002)(186003)(4326008)(122000001)(8676002)(2906002)(66476007)(66556008)(66946007)(26005)(76116006)(66446008)(64756008)(91956017)(6486002)(6506007)(83380400001)(31696002)(86362001)(316002)(38070700005)(54906003)(53546011)(71200400001)(110136005)(6512007)(2616005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGVvcnJUQWU4bkpuRzI1UUx6Q01YT2JCR01uZkFEVmtOZUtvSDhZak15bG12?=
 =?utf-8?B?QWo2OGxndk9KWEhSYmN1WFRJMGY4ZVd4S1BOcjNsVkh1VFc3Y3pCSkJoNy9V?=
 =?utf-8?B?VHdMZGhKZFowT0RIUHJNNXo3WDRmNWRNS0dTdEFZODhrVldDNmVkdUdSdXRj?=
 =?utf-8?B?V21tS1BoenNmeGYyMFJiVVdzeVlXaG42Tk1pWTBXMVk0YU1KMkFpV241dVFp?=
 =?utf-8?B?V29qMDYwUFdBQ3pUSlUxeUdsSDB2VnZ0VXRlQ1c3V1ZkL21vTUdSeWNlZjdJ?=
 =?utf-8?B?YWZNdkVIYW1abDhDK3FIc2lHOTlZa0FHUDNuUkpReFBNazhTK25pZXljMVBx?=
 =?utf-8?B?STQ1bDd4TjF0bUFJa2I4T0tyT1g1eTExSzQwdUVaZXl6RklNNHVaQ0hXZGZo?=
 =?utf-8?B?K3A1VkJUQkhYOEtxMXlkL2t1QjA3U3BIREtZbVJMZlE3T0g5UktBdmtLYmlG?=
 =?utf-8?B?dno4Z1ZYM3NWQkNCOE9vRFgzZmJraTdSam1BR0RyOWpzMmttY1hPZGpmV1BR?=
 =?utf-8?B?NWZ1VE16OTFkTXdueEVHcHJVcVE4UGtSSDlpZTlzZHF2MWI1M1hadWRYaTBR?=
 =?utf-8?B?Q1E0Um83QkRjRGlWUmhMQUFxMllTT0tFa0MxU01MNk16eHptUzF3UUFoMk1l?=
 =?utf-8?B?S25OMTgzT0o0T2hjVTYybEEvekJjZmdDSVllOFVOQ1F0V2JoRlF6VDE1d1pk?=
 =?utf-8?B?Rm9yeU1jSXRmMHhXNzJlbmgvaUJwSzMwZU5xUEdxL0QvcHVKNm1oc2pIeVRD?=
 =?utf-8?B?d21BcWF4V1BwK29kYTUwNWUrZDJjOFBBWWp2RW9UVXJLTmZDRDBrblA2bmNT?=
 =?utf-8?B?NDNFbXc0VzFFVVBYTVlRaW5UZTdKVzBxYWFZMW1pMUtKMVA4QklnaDVZdkZ1?=
 =?utf-8?B?S2lvMDRXbTdELzF4cHNFZTFPUTlmTHVnZFNSQ2E1TXBKaGpNZXpKWUNKVTZa?=
 =?utf-8?B?N0NscTZNNWVJaEMvQXhKcjJ6WlNVbHZwdnZJYTZ5NmM4TkwxY0wwNnVkcUlX?=
 =?utf-8?B?RHpnc0RsY0E1eEo0U2ZiNDZiMXZKcGJVNjczaHhLUUQzcDFURWJFbWpjL2Fn?=
 =?utf-8?B?MytlVjJjNHFPU3RDOUYwbjhXNkxWT1p3cjY5ajhma0RIN0ZhWVhtWUI4cTJB?=
 =?utf-8?B?dk9TcTRhbjhzL0kzanZUeG13SmpuYS83bCtZc2l0S2g3ZHQ0NHM2QnZjZlhp?=
 =?utf-8?B?SmhSR1FRM2dCRkhFNW8vWStxNjJ0NVZkb2RicmN2N2NpU3l3NnoxcmRsU0I4?=
 =?utf-8?B?TE9yTzI3VlFaRzQyekhzcTQzSUU4MUhYZFpFTStRZHRWOTIycHVUQjYycmxF?=
 =?utf-8?B?bG9sd2FGd29SNUZPK3RxZWtKa2t1UHpITFlLbUlVU0dBUU5OUS9jY3h1UGFx?=
 =?utf-8?B?UGVoU2kvV2lmT0Y0aWRWamtHSjdXYXJTNlhXYjBldDNuM3dMTkhnb2lEVG5x?=
 =?utf-8?B?T05xR1M1YXorSHhjMnQzdUJtQno1R2l2T1RFV2k0R0lZem5qWDUwY3QxTXF5?=
 =?utf-8?B?RkIvOXVtTno2eHViM1QyaXQrSXAxQkdKYStScW9zVzR2T1BYdHRpU0daem9h?=
 =?utf-8?B?eC9iL2ordlUyK1lTMmVwSk5jN0NoRzBKT09pb0dMcXFwUVJkN3JFd3JJZkJY?=
 =?utf-8?B?aE50WEFmQVNsSXpoelFScnRlRmcvTEpvVmQ3VlRvWUZ2RTFuMG8wdTlGOC9m?=
 =?utf-8?B?MFBBclZHVzF2dU1LMlAwZ2lvQ3ZZRklUdndGQ1VXaEoxK2NrTGQvYmh5WmNm?=
 =?utf-8?B?MTNDM0I5RlZPTXhRbWEzeU96czM2dXd2d2FZenJ0SEszeVBmcGxHOTF3SmNX?=
 =?utf-8?B?TTB5Uk95UGhaanlXeDIxa2YwcVNBTHBjdFBWR1lUSWFGaFo3eW8xYkRVVFdi?=
 =?utf-8?B?V3ZWdXZqOUtpb3RzT2hhdkNvM2pPT05pbkhKMnlldlgrODFGWmNlYk0yOXdk?=
 =?utf-8?B?YTlnSXlXc2o0NHpvS0grd1BWRmxqT2g2MFZmVExYWXBhZVFvRmJlaWlUT3pW?=
 =?utf-8?B?MnhGZzdHUkpSazB0TW5DNTNYRXowNUJMb2dVRFl2N1R2ZkFLVU9xZE1ReCts?=
 =?utf-8?B?TFVYSGFNZzdZWFI1cjY1L2NudW1SSnljc0lsVHhDdGUwWW1BVXhNekFyQmhB?=
 =?utf-8?B?U0NSZFhWMjdUK3pFNXNLK0swSzl0SngwZ002Nko0ZDVvRTA4dUZoZkJCWTZW?=
 =?utf-8?B?RS84cCtLNjJSWGZKVkZGNlN3dW50V3paYnlxQmF0NmhjOWYvT2lFZEN1TXQ1?=
 =?utf-8?B?UkZVRXludXd5b25YZVZQWG9HWGZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <342A39A804A6F5429BA92BB89E96352B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8861a7-f62a-4b93-d58d-08d9fdaf5be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 07:19:45.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCBFr63Jdko/rB3ewLAACnziJ21PcynkqQZndjjDCp1BS0iDK+cC38WSacB4bNpnYAULkWfYu8Z9yPoIC89dLNx2izOM9Rsh79pF/JLF0p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmljaGFyZCwNCg0KSSB0YWxrZWQgd2l0aCBNaXF1ZWwgb24gaXJjIGFuZCBzYWlkIHRoYXQgaGUg
d291bGQgbGlrZSB5b3UgdG8gcmV2aWV3IHRoaXMgcGF0Y2gNCmJlZm9yZSBjb25zaWRlcmluZyBp
dCBmb3IgbmV4dC4gTm8gcHJlc3N1cmUgd2hlbiwganVzdCB3YW50ZWQgdG8gYXNrIHlvdSBpZiB5
b3UNCmNhbiBhZGQgaXQgdG8geW91ciBwZW5kaW5nIHJldmlldyBsaXN0Lg0KDQpDaGVlcnMsDQp0
YQ0KDQpPbiAyLzI1LzIyIDE2OjQ2LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBwYXJ0aWQgYW5k
IHBhcnRuYW1lIGRlYnVnZnMgZmlsZXMgd2VyZSB1c2VkIGp1c3QgYnkgU1BJIE5PUiwgYnV0IHRo
ZXkgd2VyZQ0KPiByZXBsYWNlZCBieSBzeXNmcyBlbnRyaWVzLiBTaW5jZSB0aGVzZSBkZWJ1Z2Zz
IGZpbGVzIGFyZSBubyBsb25nZXIgdXNlZCBpbg0KPiBtdGQsIHJlbW92ZSBkZWFkIGNvZGUuIFRo
ZSBkaXJlY3RvcnkgaXMga2VwdCBhcyBpdCBpcyB1c2VkIGJ5IG5hbmRzaW0sDQo+IG10ZHN3YXAg
YW5kIGRvY2czLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1i
YXJ1c0BtaWNyb2NoaXAuY29tPg0KPiBSZXZpZXdlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFk
YXZAdGkuY29tPg0KPiAtLS0NCj4gdjI6DQo+IC0gdXBkYXRlIGNvbW1pdCBtZXNzYWdlDQo+IC0g
Y29sbGVjdCBSLWIgdGFnDQo+IA0KPiAgZHJpdmVycy9tdGQvbXRkY29yZS5jICAgfCAzNSArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9saW51eC9tdGQvbXRk
LmggfCAgMyAtLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDM3IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL210ZGNvcmUuYyBiL2RyaXZl
cnMvbXRkL210ZGNvcmUuYw0KPiBpbmRleCAxZTdmM2JiZjg0N2UuLjdkZDEwNWRhZjE5ZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvbXRkY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL210
ZGNvcmUuYw0KPiBAQCAtMzM2LDI4ICszMzYsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldmlj
ZV90eXBlIG10ZF9kZXZ0eXBlID0gew0KPiAgCS5yZWxlYXNlCT0gbXRkX3JlbGVhc2UsDQo+ICB9
Ow0KPiAgDQo+IC1zdGF0aWMgaW50IG10ZF9wYXJ0aWRfZGVidWdfc2hvdyhzdHJ1Y3Qgc2VxX2Zp
bGUgKnMsIHZvaWQgKnApDQo+IC17DQo+IC0Jc3RydWN0IG10ZF9pbmZvICptdGQgPSBzLT5wcml2
YXRlOw0KPiAtDQo+IC0Jc2VxX3ByaW50ZihzLCAiJXNcbiIsIG10ZC0+ZGJnLnBhcnRpZCk7DQo+
IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAtREVGSU5FX1NIT1dfQVRUUklCVVRFKG10
ZF9wYXJ0aWRfZGVidWcpOw0KPiAtDQo+IC1zdGF0aWMgaW50IG10ZF9wYXJ0bmFtZV9kZWJ1Z19z
aG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqcCkNCj4gLXsNCj4gLQlzdHJ1Y3QgbXRkX2lu
Zm8gKm10ZCA9IHMtPnByaXZhdGU7DQo+IC0NCj4gLQlzZXFfcHJpbnRmKHMsICIlc1xuIiwgbXRk
LT5kYmcucGFydG5hbWUpOw0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gLURFRklO
RV9TSE9XX0FUVFJJQlVURShtdGRfcGFydG5hbWVfZGVidWcpOw0KPiAtDQo+ICBzdGF0aWMgYm9v
bCBtdGRfZXhwZXJ0X2FuYWx5c2lzX21vZGU7DQo+ICANCj4gICNpZmRlZiBDT05GSUdfREVCVUdf
RlMNCj4gQEAgLTM3NywyMyArMzU1LDEyIEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpkZnNfZGly
X210ZDsNCj4gIA0KPiAgc3RhdGljIHZvaWQgbXRkX2RlYnVnZnNfcG9wdWxhdGUoc3RydWN0IG10
ZF9pbmZvICptdGQpDQo+ICB7DQo+IC0Jc3RydWN0IG10ZF9pbmZvICptYXN0ZXIgPSBtdGRfZ2V0
X21hc3RlcihtdGQpOw0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZtdGQtPmRldjsNCj4gLQlz
dHJ1Y3QgZGVudHJ5ICpyb290Ow0KPiAgDQo+ICAJaWYgKElTX0VSUl9PUl9OVUxMKGRmc19kaXJf
bXRkKSkNCj4gIAkJcmV0dXJuOw0KPiAgDQo+IC0Jcm9vdCA9IGRlYnVnZnNfY3JlYXRlX2Rpcihk
ZXZfbmFtZShkZXYpLCBkZnNfZGlyX210ZCk7DQo+IC0JbXRkLT5kYmcuZGZzX2RpciA9IHJvb3Q7
DQo+IC0NCj4gLQlpZiAobWFzdGVyLT5kYmcucGFydGlkKQ0KPiAtCQlkZWJ1Z2ZzX2NyZWF0ZV9m
aWxlKCJwYXJ0aWQiLCAwNDAwLCByb290LCBtYXN0ZXIsDQo+IC0JCQkJICAgICZtdGRfcGFydGlk
X2RlYnVnX2ZvcHMpOw0KPiAtDQo+IC0JaWYgKG1hc3Rlci0+ZGJnLnBhcnRuYW1lKQ0KPiAtCQlk
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJwYXJ0bmFtZSIsIDA0MDAsIHJvb3QsIG1hc3RlciwNCj4gLQkJ
CQkgICAgJm10ZF9wYXJ0bmFtZV9kZWJ1Z19mb3BzKTsNCj4gKwltdGQtPmRiZy5kZnNfZGlyID0g
ZGVidWdmc19jcmVhdGVfZGlyKGRldl9uYW1lKGRldiksIGRmc19kaXJfbXRkKTsNCj4gIH0NCj4g
IA0KPiAgI2lmbmRlZiBDT05GSUdfTU1VDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L210
ZC9tdGQuaCBiL2luY2x1ZGUvbGludXgvbXRkL210ZC5oDQo+IGluZGV4IDFiM2ZjOGM3MWFiMy4u
MTUxNjA3ZTlkNjRhIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L210ZC9tdGQuaA0KPiAr
KysgYi9pbmNsdWRlL2xpbnV4L210ZC9tdGQuaA0KPiBAQCAtMTg4LDkgKzE4OCw2IEBAIHN0cnVj
dCBtb2R1bGU7CS8qIG9ubHkgbmVlZGVkIGZvciBvd25lciBmaWVsZCBpbiBtdGRfaW5mbyAqLw0K
PiAgICovDQo+ICBzdHJ1Y3QgbXRkX2RlYnVnX2luZm8gew0KPiAgCXN0cnVjdCBkZW50cnkgKmRm
c19kaXI7DQo+IC0NCj4gLQljb25zdCBjaGFyICpwYXJ0bmFtZTsNCj4gLQljb25zdCBjaGFyICpw
YXJ0aWQ7DQo+ICB9Ow0KPiAgDQo+ICAvKioNCg0K
