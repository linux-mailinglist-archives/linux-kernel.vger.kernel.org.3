Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33F54C8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbiFOMmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbiFOMmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:42:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2AAE5F;
        Wed, 15 Jun 2022 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655296954; x=1686832954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sct/L/c1ILHkqk5ZyR0w7MgXzCne5Pwd/E5LHwIZPkM=;
  b=ZO1/Cu6jfLL/nbo2ZAj6ZIJc1fkOZkBQT8lBhTUnV54l3makX0+LSAPL
   jdt2PkOLt9vy7irPFRldW/84TRhQeICGS6K9a+ruxL3z/5txR0RQrAKZi
   /wHLV45o//vlIyE0FhLK6IGsUgs6rsKssYPeEQ3w2vbVWqwCbgd5xlT+O
   wHwwI9rPKnRbYeN6b4NcDYQRksN8KfpXLgzpqnPWlVtBFcut7njhcZyqt
   01E6Aly07gXAxSfoeklsA23qkE5j4GDrEilJc37nvr5XPURNNlfbKL9k8
   xerujwNTvBYbj8/aQGsoAVmzAO8cTAU5dtGsNnlNxQ0iV+GfO7JaRgqOG
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="160432192"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 05:42:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 05:42:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 05:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQcou8kfJ1tQRjndz5MoMAFd4GIGRwyWFcp0++lksk+sT8lsZShXemt59fV417etYjW7J0E2v+meZtsLKkBwLuuiKkHUI+Fv0U26fukA4hK9iEgCWvfXBvPdH6+VHwX388nluD5LX7gRbhHXIDSB1yhDrL109tdC6EGSZhaM1lKIPI7kwGqvD/xEjVTFPf7wSny3AQXhbabRU75BnIHtTWE8A2pyz5r5Dr+oZcoEAbtIeMDdE/n0YHRoEOnNgq9AK0mTsKn9+sLfLgWwS6pm7LXlpnfNbKiGebFYWq/yz7cRUGNBiK5sLgcLtxv4iRShubrTS+XgoljgO+fGZ10qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sct/L/c1ILHkqk5ZyR0w7MgXzCne5Pwd/E5LHwIZPkM=;
 b=kFmquIGSklobUC6NYdz+du0hzDCLP9uF1vwP8JlQ88m8/90y5nFdhFVnunVXoY6ePJQYuVexxfa3rJabHDjVYO8ys+DSGUpjWgRG6RqhReXj3wvwBgSq8oL2tLsupl4fyXktGqk7gIVeRcJlaTgccmKd1kUsUZmWn6keyz+MV0m4TKLyO0uu7RCGuF3uwdXdg2c6ENLMX1mfTCBLQoIbPGJghuSdMv1LmfAfilFRj+kd9T7yP8N/4Nlz5P941auBdGt7aMkIdTCAd1I4Ay40Ba1UgShOh+e8ObkEP/aLOP7AFx8teV6ihOqh90pR3pxKhVWY7Qe0HJAnYNMzWa+7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sct/L/c1ILHkqk5ZyR0w7MgXzCne5Pwd/E5LHwIZPkM=;
 b=eWofnM+JFaLHKFqqEiW1YDBTzZDQPY65yQ/MG+H/iSt2IP6PnL3dioKbvxxPj2YFlUe4IjY2o1tgHLuC82Dw7qkcV0ZJO/Eqro/IfrjZ3LilQBQgnD+tmuhfD2/sj9flR7zyKlzfLHTetSGpdOgwWn7AlEnhm9plZH/p40Nbp2k=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4351.namprd11.prod.outlook.com (2603:10b6:208:193::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 12:42:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 12:42:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <broonie@kernel.org>
CC:     <Daire.McNamara@microchip.com>, <Lewis.Hanly@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>
Subject: Re: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Thread-Topic: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Thread-Index: AQHYgKu0NnUyv6HMX02qK3OEv15VZq1QWBQAgAAEXYCAAAueAIAAAOiA
Date:   Wed, 15 Jun 2022 12:42:27 +0000
Message-ID: <630d60bc-1322-21a9-e4d1-3eb5af40f8a4@microchip.com>
References: <20220615113021.2493586-1-conor.dooley@microchip.com>
 <YqnFLCbvrTxNbG1+@sirena.org.uk>
 <7eda95bd-c7f5-767a-fe88-9f7109467cd8@microchip.com>
 <YqnSlIcAadwxt1Q5@sirena.org.uk>
In-Reply-To: <YqnSlIcAadwxt1Q5@sirena.org.uk>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c34a8129-c1ee-4a3b-d872-08da4ecc812e
x-ms-traffictypediagnostic: MN2PR11MB4351:EE_
x-microsoft-antispam-prvs: <MN2PR11MB43514BB6DB93580307AEBEC198AD9@MN2PR11MB4351.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7caZNvvNUU6pSyKCaOtWJO9fpT9vtyXqjHuTmM9zYQolMVZaQopumDv/6in4vDmL+pk0D7eAhPLuILOusF7u6S3PBug67YE6n/7S6/VK/7+VKc2bhafCS+9C106DNMnNQLTbGNO/H2G4/gkptXEtTlC2gfhrrv0uWPeCSbVlbIDY38Cr1JWsWZSQK3Guf0aqLKoVn3u4TOaeGmXYAKvE5afYE2lFdEiFUClFjlgd0RLdct1cq911ovUntXtDxPdxd97A0aBg6o2JX6HG8uvoD8iQG8r6w/gaj/4YD9ipxKaHZIeMXxNcIYZraVIW+YDlvuqLF78eqkyIPG3Wi8dao0ynoPRaFTXQrBBXnoL5E5V1z8TrmQNiTvxe6EbfD4h/Raemh4Jyfah/Dhk4a9eYznCPVE3SiR7RzR6EfYoU/ihQXhJ8E3r6FSeeZB3/TxTsW114jNArJqFoDm2o1I5gzu5DJsvLZgDFNiVxpCBNzJhaNay/4mggKRPFSPqJJznnVmM//wPgcH4Ol0Ig8DGJokBBmJ/wiN0WWb+Pznx6zXBbqqE3XxI1aNU6mKphesf0Ko17uE9Dq2pXScRWyMwtGe45IiGSQb3xQqzGTUJsn3/WddXaHMMGfS4iODmO+PxjAYtKWTMj9dkIwHp4mFiunp0tfA1XKP4lwZs8yWJspsPGNNeIADWJrM8V2Et7eR2JL24uBjmQ8qykeGli07iBsyRRP84Tgrlc8M9u/w/ylJN2Ijju3yNIrCYpZgpwjW0kZjXL4XVD3+Q0uaP1XI03nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38100700002)(186003)(2616005)(66446008)(66476007)(86362001)(31696002)(76116006)(66556008)(91956017)(31686004)(36756003)(38070700005)(6916009)(8676002)(316002)(71200400001)(4326008)(54906003)(64756008)(66946007)(6506007)(5660300002)(122000001)(508600001)(53546011)(6486002)(26005)(8936002)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1FEUTN0V3JzUnhYUG00R1VPWXlNcmhNSDlINC9KNUFRK2ltNU4zbjVhMDUz?=
 =?utf-8?B?Tzdna3hkcWJwUFU4NjBVQUR5Sk1XUHltT0JoclMzMy85Y3hoejJ3Y2tVaUtw?=
 =?utf-8?B?U212bVArWlhySms2czkwWXFKd1FNaldvQlY5bnR3eDNjTHl3Yit1em5HdlNR?=
 =?utf-8?B?aDU3VVFJTG5SaEpFOXdvcUZ2Yk1mZW9SeFRzZE4yN0FJWjBDT3JhY014aHhQ?=
 =?utf-8?B?ZHN5NWpjaHlOVnFIYytLLzVCOEhudjMwWXh6UGJTNzdwdHRlcCtOLzZ1Vm9v?=
 =?utf-8?B?czZONnBNQ1RMc00vZGRGTCtOSElWZm9xZ2RKblRGRVEvVk91SlJITytGZHNU?=
 =?utf-8?B?c2FKSjIrL05neEJwNEhXVkczeTdkWnZwSCtLdnppdlRxOTV3bjZmU0JVRkgy?=
 =?utf-8?B?VVB0YnZDVHVEdTVpOURtWERiZm9EcnIybWZjVWMzV1RwR3NHc2t0NzJxSG03?=
 =?utf-8?B?THpuWGttSDJNS2VnMGRpSkxVVlFZc3BLczJGQlhPc2JrVjl0WnRLVWdzNWpD?=
 =?utf-8?B?cThXbVBGRitocHAwRnJjdUg3cVNPamx2WWIrMEMyWTlEVW9CN1J3aVhoaWVv?=
 =?utf-8?B?emVmb24yWUxudVRmdkJPeHhkRUkyTDRlZTdsWXdidDB4enl3K0lOWWV0bkJ0?=
 =?utf-8?B?bmdrU1Q4eDduSHVZcG8xWDdRcWtEOUdTL0dBVnE2TlZjYWI1TjNBODNQQk1K?=
 =?utf-8?B?TmwzUE1rdHdaWC92Yms3MlhPWE9iSmVRaS9xYVVvSmt3RzloeXBpa0MwOHpw?=
 =?utf-8?B?Rk9Wc2pWeEUyUzFVcTBGSDhnUHBwS2p3NnNyUGpMcWdFY0Y1QnlyMCtaeFFq?=
 =?utf-8?B?Yk1CL1p4cWVUcTE5bjAzNS8xVERLb3hqRFB1OGVwbU9mQnVnN2RKeTl6YkVH?=
 =?utf-8?B?Y0NpR0FYamlOZ3dsM0dqbUdra1NQRGVEZ21KWkgxNFZYRzh4M0dHY0swNnlO?=
 =?utf-8?B?TEhOTndFMko5NE95RzFUTCtzS25QQVloTFk2c3BKSXQrdVN3WEUwdEZCbEhu?=
 =?utf-8?B?UFcyQ1BBWWc5RkJjVkFCM1dMZEZSY0tqbTd4SkdTNTg4YVlTcVpTNW00ZVg5?=
 =?utf-8?B?NytLMmxDZWdKb0lDcnd3aVg4RlRuSUdNUW1YTngrZnovVHJPd1BXbzFMRWlo?=
 =?utf-8?B?NjhjLzMyUVNZZUtYcC9EaFJxZFludjBnS1hBRmROR1IwY0I2NmpjVlk3c1Fq?=
 =?utf-8?B?R0NzV2FJRlcyVEZ5cGwzaHM3d05rMHNhZWhabzJNU2QyWUxlVmo3QnhKZ2Vj?=
 =?utf-8?B?UXpJSnpoeHpwUGcreklyVVdIYk9MYWUzeHhDeXVOMkg0OEdZV0JLNm5DTEZj?=
 =?utf-8?B?QzhQaTZ5NXh4MXZ4cmp2VkNIWkFQanV5MktsZEVURXpSL2V1cmIyUlVNNlgz?=
 =?utf-8?B?U2hOakwrK2d5cDBVVG84RVUxeUVVeWNZcGFtNi9FYkpQOUZxMS8xNFcyeEd1?=
 =?utf-8?B?dHZ6RmFFeFQ2YjIrZEFTbGlCdkJVc2lOMWRrWlFkTjFmUzhUR0xhYzZaYzNU?=
 =?utf-8?B?ZEU2RUY1SGtwM1RzVnhSYTgycDVXdk16alNUK2FTODlMeVRBS3dmRlA0NXpm?=
 =?utf-8?B?YWJWR0hYMVg0NmhhMU90L3kycWtKWndyeCsyL3lCMTVkbjJ1RjZRdU5idlBj?=
 =?utf-8?B?MWZORHVlMFhQMEtQbEdpSzJCNmtmR0o1Uk1vSTZLYVI5T0xDOVdBRUxlTVdL?=
 =?utf-8?B?bHBUREh0L3BOUjlCWlFDSktxOFVWaDVJY28zemJrdXNmMDF2WmQ1TW43ZmlV?=
 =?utf-8?B?RXY3bXB0UEg5cS9CQkJzV2lJMXlMWERIekFhNE5BMm5lcmxJQ3JZSWw5cVdG?=
 =?utf-8?B?bElKK2E3Z3Q2ZmRjNnJNS1Z3ZjlZWWRnMCtKeDkrV3dxR2toYzJzUWYzSjBP?=
 =?utf-8?B?YnQxNDAxMU1md2JtY3BwTnFDcGlHRTNsUXJYMFpOTFNuRkRkR2U0dkZ3OFJD?=
 =?utf-8?B?dnJpM2hZUDB6R2R3VmprYzBHMmtwcjFYVE41K0xJUGZwdDZHMU9laXZjdWtS?=
 =?utf-8?B?eklkTWxkVEZVNHpDVkxsZXB4ZkgrUk9yL0Q1YWRZbkkrZzJxT0xwUWw0YXNM?=
 =?utf-8?B?L2lvN1dUTUdoaG5ucmoycUpqUFlMUHdqaDlCOC96dzJtdlQrbUhCTDBPQkVn?=
 =?utf-8?B?M3UvMGYyV3B6TURnVXpxVHpkNDBHNG1tVDNweEp2MDhVV1U3bXBkU3BaTU1a?=
 =?utf-8?B?UmRMdFJDa3IxMkNqcW0zZnovYnM1aDJuQ1FqenpzRzVhWDZsanpUbXo0MGxu?=
 =?utf-8?B?eDN0MXMvNzF3M0w2d2U4MkRLVTJlby80OEdvajN2cGpWTDRoMkU3eU1TTURq?=
 =?utf-8?B?amllRGcwbC9vdGgwaVFaQjVZMHJ6cWFLbDNKbzFZbmxVNnFIR2d2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <175480358B582240B42BF6EB72C980EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34a8129-c1ee-4a3b-d872-08da4ecc812e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 12:42:27.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgoiLEuBRxVcUGRTcLeNmyxGTDbXidQJOcDNWroG0Ocha7SlCW3lgcSmbD72swdIxU25yg3hPB6zMFYpfZlEzainJQAPQQ56XAaFw25NONs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4351
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDYvMjAyMiAxMzozNywgTWFyayBCcm93biB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEp1biAxNSwgMjAyMiBhdCAxMTo1Nzoz
N0FNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDE1LzA2
LzIwMjIgMTI6NDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlDQo+Pj4gT24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMTI6MzA6MjJQTSArMDEw
MCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiANCj4+Pj4gLSAgICAgICAgICAgICByZXQgPSBQVFJf
RVJSKHNwaS0+Y2xrKTsNCj4+Pj4gKyAgICAgICAgICAgICByZXQgPSAhc3BpLT5jbGsgPyAtRU5Y
SU8gOiBQVFJfRVJSKHNwaS0+Y2xrKTsNCj4gDQo+Pj4gSSB0aGluayB5b3UncmUgbG9va2luZyBm
b3IgUFRSX0VSUl9PUl9aRVJPKCkgaGVyZT8NCj4gDQo+PiBNYXliZSBJIGRvbid0IHVuZGVyc3Rh
bmQsIHNvIGxldCBtZSBleHBsYWluIHdoYXQgSSB0aGluayB5b3UncmUNCj4+IHN1Z2dlc3Rpbmcg
JiBtYXliZSB5b3UgY2FuIGNvcnJlY3QgbWU6DQo+IA0KPj4+IC0gICAgICAgICAgICAgcmV0ID0g
UFRSX0VSUihzcGktPmNsayk7DQo+Pj4gKyAgICAgICAgICAgICByZXQgPSBQVFJfRVJSX09SX1pF
Uk8oc3BpLT5jbGspOw0KPiANCj4+IEJ1dCBpZiBzcGktPmNsayBpcyBOVUxMLCB0aGlzIHdpbGwg
cmV0dXJuIDAgZnJvbSB0aGUgcHJvYmUNCj4+IHJhdGhlciB0aGFuIHJldHVybmluZyBhbiBlcnJv
cj8NCj4+IElmIHRoYXQncyBub3Qgd2hhdCB5b3UgbWVhbnQsIGxtaw0KPiANCj4gT2gsIGhhbmcg
b24gLSB3aGF0IGVycm9yIGNvbmRpdGlvbnMgY2FuIGNsa19nZXQoKSByZXR1cm4gMCBpbj8gIFRo
ZQ0KPiBkb2N1bWVudGF0aW9uIGRvZXNuJ3QgbWVudGlvbiBhbnkuLi4NCg0KSWYgIUNPTkZJR19I
QVZFX0NMSywgKHdpdGhvdXQgd2hpY2ggaXQgd29uJ3QgYm9vdCBvbiB0aGUgY29yZXBsZXgpDQpi
dXQgSSBkb24ndCB0aGluayBJIGNhbiBiZSBzdXJlIHRoYXQgQ09ORklHX0hBVkVfQ0xLIHdpbGwg
L2Fsd2F5cy8NCmJlIGVuYWJsZWQgZm9yIG90aGVyIHVzZXMgb2YgdGhlIEZQR0EuDQoNCg==
