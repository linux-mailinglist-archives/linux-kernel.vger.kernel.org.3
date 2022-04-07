Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB44F7825
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbiDGHxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiDGHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:53:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C071275AA;
        Thu,  7 Apr 2022 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649317891; x=1680853891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QBdgNg3CkZxz57h4oYZP1B39caJqO+PANLXiVBuL2KU=;
  b=HA6sQTHIrofqXgx2k8iL4zxp1k159J7dE5V2mzNQ5g8KrMtuema/eGDi
   uvZv66lB0XuwIV6P01lo2uke4TtiUnXFXEgjteW8sJ4v8wL6uOVV0TB6T
   nB8E4UV9RMupcKl+wywsatJJsQDZrfMEgGBNJMb9QMiUiwKXEmv7U9Kga
   TjzmKqHVlb7iWsT9rGMWuSNeofYxXgOoIpeoRNLagMkWWIOt+vRoabefk
   o48+BO2IyG4Sl0sUkOfCvBsZXV4vJIN+UR7mKjsNWtlpeqGctglQE1EEY
   f6pKv7gut25/DTedZv+8gaI8y5MmevlkbQcc+uDERdqcmEztxgxGPDh42
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="154737922"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:51:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:51:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Apr 2022 00:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlaXnqdW4yLUwMYTtHCAJHAutW0nJLYJtCvo5B3cp/cIATObpdHC3dcp+F+D2hRmZ3Cumrp4o3KvQWtuNQx5b3O6HJABj0C2hCPsNgsqcgksMIWDIa4g990UGSkdA+5sAThPhGtDFOJtc1zXw3TdIcLgC9cFiLYHTQLdibak4HcY8Shz2AeUc0W2+woFJu/CZo8Vv+RlCpv9wGl5Rew/VCg79QXmnb30bGf7U5H2fALAVLdEe4dnratowwV7ssBZ0mgaJ7KCByzyfXx7GnBazJQNvPAbnH7pKIL/c46qQZ7iXVGCrXH1O0g2U/H4KGUax0Gvh/G3cBIhDgWdJ2RB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBdgNg3CkZxz57h4oYZP1B39caJqO+PANLXiVBuL2KU=;
 b=BRzgdLxWg4zlP7/dV8cnxQg0tLC1sW4pdE98XoQpbO3WITlealaBTbPIGnw6qNPIxw332+HH2ySJtB1HMTSRFBQ23bju+q2hOC7OZk82+yDGbwNEwNlhKSLHtLUIQODdhnj+XuCWggjECa0ncTV1yp7CuKOa0rUnTfFfHbYxkrbI+xdw6EU7Qtc6M7cxz9itHpt34GuSLmCUwtbc8DMAJaikMgK+S/nRcUxtqXy8R1rJFQjkG21j6D5ufapL7y7aEHL7RV9svqjYtmiiWL70YeZx1y7dwSlhrItFzNRSh/2CNvv92AepH68g+6hbAxVF9Ajp3o9qBbLA20OBuiTwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBdgNg3CkZxz57h4oYZP1B39caJqO+PANLXiVBuL2KU=;
 b=SCBVDEQroHX/ciiRiq1ZdCDdiJn4Q5u+ObgUzs2YEKn1wCmXn0kJW4HE+TKkAiPifrTEWfR+hkVzG00bnM3pPfC3w/eMr1RWl3RC1h4qDfLn6h1XNcHlLDk5bK2bcGnQmxvPk0RXD0HUA5imlONiTLdKGFeh+oKhZYdkypoXhhU=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1716.namprd11.prod.outlook.com (2603:10b6:404:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.23; Thu, 7 Apr
 2022 07:51:25 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 07:51:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Mihai.Sain@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the
 QSPI0's HSIO and PCB lines
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the
 QSPI0's HSIO and PCB lines
Thread-Index: AQHYSlRHeFYIcdZvzkefF9wZv787bA==
Date:   Thu, 7 Apr 2022 07:51:24 +0000
Message-ID: <515d14f2-1a3f-1bfe-93e7-2baafc45ce4f@microchip.com>
References: <20220406130505.422042-1-tudor.ambarus@microchip.com>
 <8f778b95-d68e-6575-ff8b-f1dd8d4d8777@microchip.com>
In-Reply-To: <8f778b95-d68e-6575-ff8b-f1dd8d4d8777@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aac90c38-b299-4cce-7a71-08da186b6a33
x-ms-traffictypediagnostic: BN6PR11MB1716:EE_
x-microsoft-antispam-prvs: <BN6PR11MB17166957A41FCCACBD6F8A91F0E69@BN6PR11MB1716.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0AG7Gheuf52ZFIFBzLFnoz5wgFJOJJvJoP3zHK+APMv/UCCE1LyD18Ybs7W9/gHL4H0Z67flBYOAx5whwV9cZ1ESAmDPnlXE/bN5NeA4LpDcyTJ4S1A5Oamq++8LCJLc2ZJ/SpvnfOz6IEIAey7CpPJmIAcskBdhBku1u24gbEdcbiKpvQqUsf9tfutWmUMJZkdts/OJjmWTGjVfK69K6erfE4bEo2bVWbJRxSQELrI/SmeBAc5CNG7Iaq+zNQ+tJOvQiKWDSvXeQPltznSotuDmYzpYIyOtezWRTNFuLt7btfyzmpoO4BfZTE4n336q8PWL6LKR23EjI6W4S9cSJRH3IZ8Y5rB4VyQStD/8EViEcVvavIQqrrH5Rxz8zD+H6a6pe1RAclB4W6PRbe5B6D6tVRgrVwbH+QKMCQ6zlGcmajxlgUvtJPlHUzHhJ7xtznuLoqA9fy3Uo7qTpnWUaKvGxl6+pDflTizRUKJT/fVEDe3fjk+vIxBuixTO96p19uMM0/g5Dcdl5N0ysgvaUnODlW0ssv/Q53ItmsA/CRPGzEQwTvnjbYPPH8Q1Jqj7+Fp9hGdJImlCn9kw1VtU5FiFR1WU5xHQUjbPn3bWYwkVxTxfHtcYN4yU03vK6vGeUmUJUz47CdUIdM1b4QcWTNximLZuxGx8g4+nxJ2gQp8BKrW3sub2pjSIMWhkg1zNAL2Mu7zn1RRRRVYWirBxBTyMQ1D7J5XeoM3T8Ptf3GtxcTGgFdRR1GAF2ENIxKrfNAsarucv2R5j/4JJJeEeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66476007)(31686004)(66556008)(66946007)(91956017)(66446008)(64756008)(122000001)(38100700002)(38070700005)(4326008)(8676002)(316002)(6636002)(110136005)(36756003)(54906003)(2616005)(6506007)(53546011)(6512007)(8936002)(71200400001)(107886003)(86362001)(508600001)(2906002)(83380400001)(31696002)(186003)(26005)(6486002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEhUSHRNYnl6VDk2UWhJR3JpVU1qZ25TeUVwbEd1aTdLS1kxVTlKcVZ6Rldj?=
 =?utf-8?B?OHdPZE1BMnhucDdMYmdsdFhUTllRZzE2Szg3WU1TM2JWUVJ2VkNjY3cwTmJC?=
 =?utf-8?B?Q2haQjZReEFMVVVkRDkrNnp4Q2YvOFVjL1FIS3pRNGVyRml1MklNNURPTjJ2?=
 =?utf-8?B?Ri9lRHdkL2E3TDJOeEVtT1l4T3BYRDVSK1BXcEx1VURFa1Z4Sk45dDFQZERx?=
 =?utf-8?B?YjNoZzJQYzZZc1JMQ0NER2o4UEVON0lRdzhDNkdZRjdwSWVrMEN2QWYwdzF1?=
 =?utf-8?B?NldGUjRBYkY1RG5pR3U5S0Mwd2ZtMXpoZmZRMGRIVmlTQ056L3FkVVdJeFVP?=
 =?utf-8?B?M1lybGt6Z3pQWXBGZnJ4QVNKRGFSYks2YmFKb01hZUJmbTVXSjZHczZnWGF1?=
 =?utf-8?B?WTVOUXIwdlBNR3NNSnQ5WHpwRmZzY2s4akJFS0xyZDdFcnRjUXdrSzUvdGZz?=
 =?utf-8?B?MGIxS0l6bG9rWTljUVRCY1Y4MXU3MjMwUC9wMzhvSWc3UU9UYTlhNC9NTEw2?=
 =?utf-8?B?bjN1dzBadXhxbVYxenhHdjRLZmVBSDdMME5PTElkYVQwbDh3QzQ5N2ZBaTd3?=
 =?utf-8?B?VENYaVl0dUZyVlhBd0ZEMU8vVTk2ZUZnWnBOT281UENjS3NKRFJ2dlg2SHN2?=
 =?utf-8?B?RlJITzVTK2lwcWlaeWpHZzV2cG00eWwrZzNYQ2Z5L0NJb2VqejdTUm5nT3Zk?=
 =?utf-8?B?bGZQVXhGZjFOb3F6amZ5NUsvblNTQXlEVDBQemcrMG55WE95YXdMaU1EUEtn?=
 =?utf-8?B?VWJVMCs2VlFuQ3RGWmZIT29VR1RHdForem5uWWo5S0UyclQzQ0xiejMybTFz?=
 =?utf-8?B?RjhKaklkL2ZkODZwNE55QjNIYXd3cVV2eS8yOW43dndiazJua0JmV0dZalJL?=
 =?utf-8?B?aGRVSU16UFluekYwMjdqa1U1bUV4aTY5a3NCblV0S04xWkFvdmxEbWVWWWwr?=
 =?utf-8?B?OHZLRU9WbUpTSlhNSERUSUdlcTVMeDRqTlhHRlRBRExXZ3h6QWpVZ1MyWEo4?=
 =?utf-8?B?ZkVvdUNlU01vMjc4SnpsYmJxVXl0b244b2wrUnBvWU5pMWg1WjFxbE5KcFdv?=
 =?utf-8?B?c3hEWDRWU3R3TWtHTW9LTHZEVDZWdCtEK2VPTHNyZXBkU05RVHgzK1YrZnFZ?=
 =?utf-8?B?SFBjdWJYTmloWWJLcGh4TmFycG1XTk5DRko4bFJDemQ5NlFZaUZjUWcxUm5r?=
 =?utf-8?B?OERtWDZ1bXY4NUNtZmZsRGxWSHp1eXVLeHYrdGdXc0trNHNvWnBYUFY4UURE?=
 =?utf-8?B?U0p4U3g2dUhUZk50bm4ycDRvd1B4UnpoRkwzeFJ4Tmt2aEF4d3N1UGZRZEpq?=
 =?utf-8?B?K3RuQU5YZE5rS1h4TStJYUNrdk9HUDdUQk82STVzTm9zY2loR3RxWVd6dGtF?=
 =?utf-8?B?c1c5bVJockVyU3NtYUMvTlBZSVpDYkRpWW1wZHZ0cDk4bUh2Yy93bmR5cVZv?=
 =?utf-8?B?UmUyY0xnMmt0VU93NVZyRlk0MVdFdDdzMkRLdnlJRmZJNXl4czlOZkZzZnFj?=
 =?utf-8?B?dGozMnV0NTA3V1hkOERpaTNwd25hbVBkbE9ZMGhmdFNRSHJqanNkcE10UC9K?=
 =?utf-8?B?ZVhVNE9XRmNEQThoREo3bGJTMkFxMFBFbUNkd2hxYnN3Tk5ac0lUcEpDM0hy?=
 =?utf-8?B?Z1p5dFFjWEZmdjRBR0drRHlmS2RaNm0zeDRoYzdLRDhzTXJia3N3TG0zVlpu?=
 =?utf-8?B?V3JsblRXY3BUbjk4SGpuNmt3aDFiYXFZVUhNaFoyNFJUNXEzckZqYnBXVE1F?=
 =?utf-8?B?aUpucXlkUXZ3ODREYXZhcEoySyt4Tk82cHNJRUFHZ0lMUmJYMml2UkNwMlhI?=
 =?utf-8?B?R1FWbVNBLzd5Zk1lOHlnNFlYakdTOXpoTGZUa2JNUTUwUmU0L2RaOWs1cm1q?=
 =?utf-8?B?VVFmT3RiVzR5ckJ4elc3WVRYL3h0WVhRdWFaSWxPM2t5NUxmR2pVazVZejZQ?=
 =?utf-8?B?TnRYdk1HOU03aDVRWG5vdENsMk5hUnNrQkR1Wjhlb3EwY2kvOXdIR1hvdEdI?=
 =?utf-8?B?Y1FhcWF5a1pQVyt3dlJraHBiRVR4YjEyTHViUjg3bTBoYnZBUlNrSktibnJi?=
 =?utf-8?B?ZnJETnNWVkxTS0ZzaERBcjFpZEp6V0x1bWxXZnR0Zzd0MG51RjlacVBOMlQx?=
 =?utf-8?B?c3psL2RTSWV1d3B4SzcvOXQ4Y1lKNTBVMzFMc2d1RVpFRFIyMW9NSVpjVmV5?=
 =?utf-8?B?bDE3YzJqMC8za1Ntb25BdGd4QVUxTVAwczBaM2I2T3Y4bzl1VndObTVjWExh?=
 =?utf-8?B?RkNWYTFOZEZUSDR5UjVOQ3NYTDhuYng1LzVLTytqREJwNnJIcGdBUGVJU2Rx?=
 =?utf-8?B?THdIaE9lVUxSZmtkVkh3WUFCVnV0ZnN5dmRwdmdrLzZVTTIzeWloeW9VbTBP?=
 =?utf-8?Q?xvY/UM2nFyWgXaTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C194E705A8A384BBB53549F0EEF6626@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac90c38-b299-4cce-7a71-08da186b6a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 07:51:24.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOP83TMDKrlrV5gZwrX5Kkvr1pWli8MAEAkXN6YRjRloih4i+PqC6TdXkX5tu6jWC5PO0OFwLf+l2lfbEuWKUDSn10bISZtc4pUV5xT4M4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1716
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC83LzIyIDA5OjI2LCBDbGF1ZGl1IEJlem5lYSAtIE0xODA2MyB3cm90ZToNCj4gSGksIFR1
ZG9yLA0KPiANCj4gT24gMDYuMDQuMjAyMiAxNjowNSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4+
IFRoZSBpbXBlZGFuY2Ugb2YgdGhlIFFTUEkgUENCIGxpbmVzIG9uIHRoZSBzYW1hN2c1ZWsgaXMg
NTAgT2htcy4NCj4+IEFsaWduIHRoZSBvdXRwdXQgaW1wZWRhbmNlIG9mIHRoZSBRU1BJMCBIU0lP
cyBieSBzZXR0aW5nIGEgbWVkaXVtIGRyaXZlDQo+PiBzdHJlbmd0aCB3aGljaCBjb3JyZXNwb25k
cyB0byBhbiBpbXBlZGFuY2Ugb2YgNTYgT2htcyB3aGVuIFZERCBpcyBpbiB0aGUNCj4+IDMuMFYg
LSAzLjZWIHJhbmdlLiBUaGUgaGlnaCBkcml2ZSBzdHJlbmd0aCBzZXR0aW5nIGNvcnJlc3BvbmRz
IHRvIGFuDQo+PiBvdXRwdXQgaW1wZWRhbmNlIG9mIDQyIE9obXMgb24gdGhlIFFTUEkwIEhTSU9z
Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogTWloYWkgU2FpbiA8bWloYWkuc2FpbkBtaWNyb2NoaXAu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNy
b2NoaXAuY29tPg0KPiANCj4gSXMgaXQgbmVjZXNzYXJ5IGEgZml4ZXMgdGFnIGhlcmU/DQo+IA0K
DQpJdCdzIG5vdCBhIGZpeCBwZXIgc2UsIGl0J3MganVzdCBhIGZpbmUgdHVuaW5nIHRoYXQncyB3
aHkgSSBjaG9zZSB0byBkb24ndCBhZGQNCnRoZSBmaXhlcyB0YWcuIFRoZSBtZW1vcnkgdGhhdCB3
ZSBoYXZlIHBvcHVsYXRlZCBvbiBzYW1hN2c1ZWsgd29ya3MgZmluZSBldmVuDQp3aXRoIGhpZ2gg
ZHJpdmUgc3RyZW5ndGgsIGJ1dCBpdCdzIGJldHRlciB0byBhZGp1c3QgaXQgYW5kIHVzZSBtZWRp
dW0gaW5zdGVhZCwNCmluIGNhc2Ugc29tZSBvdGhlciBmbGFzaGVzIHdpdGggaGlnaGVyIGZyZXF1
ZW5jaWVzIGFyZSB0ZXN0ZWQuIElmIHlvdSB0aGluayBhDQpmaXhlcyB0YWcgaXMgbmVlZGVkLCBn
aXZlIG1lIGEgc2lnbiBhbmQgSSdsbCByZXN1Ym1pdC4NCg0KPiANCj4+IC0tLQ0KPj4gIGFyY2gv
YXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hN2c1ZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MS1zYW1hN2c1ZWsuZHRzDQo+PiBpbmRleCAwODY4NWExMGVkYTEuLjhmOTY0MzE3MGJhMyAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cw0KPj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hN2c1ZWsuZHRzDQo+PiBAQCAtNjU1LDcgKzY1
NSw3IEBAIHBpbmN0cmxfcXNwaTogcXNwaSB7DQo+PiAgCQkJIDxQSU5fUEIyMV9fUVNQSTBfSU5U
PjsNCj4+ICAJCWJpYXMtZGlzYWJsZTsNCj4+ICAJCXNsZXctcmF0ZSA9IDwwPjsNCj4+IC0JCWF0
bWVsLGRyaXZlLXN0cmVuZ3RoID0gPEFUTUVMX1BJT19EUlZTVFJfSEk+Ow0KPj4gKwkJYXRtZWws
ZHJpdmUtc3RyZW5ndGggPSA8QVRNRUxfUElPX0RSVlNUUl9NRT47DQo+PiAgCX07DQo+PiAgDQo+
PiAgCXBpbmN0cmxfc2RtbWMwX2RlZmF1bHQ6IHNkbW1jMF9kZWZhdWx0IHsNCj4gDQoNCg==
