Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480375656B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiGDNOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiGDNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:14:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C58FC6E;
        Mon,  4 Jul 2022 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656940437; x=1688476437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AL7UUxS6OlUoGsNC3HySAanNkJNaFq7H8V93IsTPdf0=;
  b=Vw4BU57w9RMSVDXVKOTImGnFvaKOEDIp0kv5e7N8ySR+hJeBfABwDc1w
   vMlyF9SmLUXBuRFEpuwzLKYZC+ICWMQw0+NBbTlFrCIYJgEnF9xqx7sVX
   /DkSUqKeR/pUBywDaFMmwmfyB92g9qWaGhDA94nEf84yFDPBKvxYeuWt4
   ymEJnvYym994/fYZUiH7oPYwB3Zy/pejatERQ/7NhiX+PevOfWvXIxfiU
   NpsjeQVVzgk+RxopU5kKMPYH1LBtVXY8VJw8syuJZ/lNHk16RKEMP4v1p
   Snlag3z4bQwnNtz3XBKs2Q9iXSlpLKzvXMLl/SoMd/yDqJnitVW9Yg5Ca
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="180663412"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 06:13:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 06:13:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 4 Jul 2022 06:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzCII9qeRiOn7cBUQvLsMTOel4EPdB1WCmhxLNsQ4+KZZHgSx7vlq70MVEaTwxmFyBqfeuDndztvdfFvVmM4p4ykReGOeDdU71GuRruXRznc+Un3y+bxPABgiHDA1S2eWK0BgMzoKX9NHQhJlqrPCXUYqIRbKzMfV/QNskgKyZQtaJe8dAxCxjXt/ehGccf/UMQq5OipJ165OQo8c9UlB6/joT8eF6Dk40x6xN1WAyfsdq/LCYmXZjC34BtQFbJ69tQfQUtGfjhpJ7ZuGyHEkUB1YUhvZNsTE51bNVhzaZN+BtY4zfs98TDqMYS0g206OpygUGh6F/dckodDtaVyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL7UUxS6OlUoGsNC3HySAanNkJNaFq7H8V93IsTPdf0=;
 b=F+D6x9vwFpKNu+FXrdXXndq6pT+aEek/Z5VV36moovfqp/r0U+RsM5o8VZO8pmogBnddJ59509ja1OMgC/P5P+M7TqpEQXTQ8wUEOcW1GnGga71XLBdNfwFvL6D6Tr3vC+M29mX8ZBju0swhMKIlzVu4iddt6JdoBwK7I6xi0d1ZxOqzMaVMb0CjiXn0tFGag7hKj0Ct+IU79npO7rJrwhp3ucboGVXYNsPAiCBOuJ2DmnGW/pMXiVKp7kaJ44KhK5g3Vc/HHyh53Z1ksQQL+1Sb4pWF/ZbTrju18khEiDdtMxC8zsm69c7te5/wSi/JQUkCFp8stBKbiE8jR4dBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL7UUxS6OlUoGsNC3HySAanNkJNaFq7H8V93IsTPdf0=;
 b=ck2/mTrC/4AcugELzbQtvNGikXRw9HzbypANbdW+B7WnNVPVF1sORoHg1VzXOQQIbLHWpobhR4f1T1UXJczeBw3EN/7Z5sAZuQXMdBkfvIKWHsAwWWWEqAnQ02oGzo4eB0CbPo2M7G2tSui7Ejayb+wZQLEpR19Q6oiYSfg16Kg=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:13:50 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:13:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Sergiu.Moga@microchip.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Topic: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Thread-Index: AQHYj6fmyEfz8IaAgkGnXypBN+A8Yg==
Date:   Mon, 4 Jul 2022 13:13:50 +0000
Message-ID: <7198ee29-95a4-db21-eb25-b5d9e07cd0fe@microchip.com>
References: <20220704083143.56150-1-sergiu.moga@microchip.com>
 <315d4fd3-4f50-5d3e-ef83-e4c8604814af@linaro.org>
In-Reply-To: <315d4fd3-4f50-5d3e-ef83-e4c8604814af@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32469ace-64b1-458c-9963-08da5dbf0946
x-ms-traffictypediagnostic: BYAPR11MB3495:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?bzlBK3lMclBtOWNFNlJydkhkNVphclZFbVJqZHE4aEk1TnlQcWVFdms2Sytr?=
 =?utf-8?B?Mm9vUlFDOVBHaW84aWprTEJTTVVyVmhIL2x1ZzJPWmtlVk1RcWZtRkJUaTRO?=
 =?utf-8?B?TWRVNGF5Q1hTUVBoaUxZMnRXVm1QdzdFckgycGszTW0yZUVqYWZZOE9JUlNU?=
 =?utf-8?B?TW9ReEZJR3JIRjlIMzlwRmJuclhSMnhBWFk4L3I1MjBLRUVJLzUxL1VVSVhx?=
 =?utf-8?B?cit4ZjZydTUxRyt3R2w4V3l4c2s1U3cyS3dESno5alJRa1VZMVkrZ0w5YnlE?=
 =?utf-8?B?OHY1bGVyelhGSlhNTWx0VnZnbjQ5bUdZSnRMdkQ5YmtWcXlKbk1QNDQ4OUpX?=
 =?utf-8?B?M2dtaG56Y1JRR2srYUhOeWsvYUorejZWQ1BHMkRoNkQ1RnllQ2hEN0VMYXpm?=
 =?utf-8?B?c3dyT2NxeWhJRzRGWUVVY04wcE9tRmpPZUVvb1BuQURvdS9SRUZBZkRISi9i?=
 =?utf-8?B?RXNwYk91WVlOUjBJbzBtVVBsYUNDOWgxSkdEUGg5dURsOTJ3UWFjZjRJRUZU?=
 =?utf-8?B?UmlvQTZ5aG03QWF4c3NORUgyWW1mUzhWZGoxb0gvZ2RiRnNjRXk1ZmhuaWFt?=
 =?utf-8?B?bjd6WHpuc1BCQ0xhdlpQOEZDRmRZc0NoY0t5Szg5L1FqczNZVFJkZ21wUUc5?=
 =?utf-8?B?eTZUbjRISnduTlBYeG5rWDBJRzdqN2FZK2c1aERYSzRuc0Jod09aNmZ2Zkk0?=
 =?utf-8?B?S1M0bHgwL0NWK0NFNy82VmZWd0YzaGRCT3d2QjVrOTNFYVdCcTNHVDBCaldK?=
 =?utf-8?B?OHMxREJHMERuNWpCRGlHanhackFvS1YvYVhWTlFEUTVtejVPdnBOT3JiaitZ?=
 =?utf-8?B?QWNiSHR0OWZyUkExTWQxZHFUK2JWSW9yQ2d1Y21pT3EvLzFXZnA3WmxFRERh?=
 =?utf-8?B?SDRIUGFzYSs1V0tSTFQwTFRDU0ZiTkt4RVBYeU1mRDFHYzdtLzlVTDY5S29G?=
 =?utf-8?B?SXp4YzVwdzBxY25ESVZ3S2VlQUFmcTBKVENDLzNNeFNKQXpYZ0Jvc3JqS2VO?=
 =?utf-8?B?R0w2SjgvVldlK2h0RDdtQTBKV3o4VXVrVFdvam1KZW8rT3hBSThCMkFjQ0lE?=
 =?utf-8?B?SHhtT0NDUTErYTRyTDZaR0ZLN00ycGVodkpKUSs4VXU2OWNsdGQyaHJVRlBN?=
 =?utf-8?B?c2llemRVN2lYYkFCYWpjbDFqZjdJak8wcjEvc3VxOHE5UHByRzZ4andiSWky?=
 =?utf-8?B?U2xKMU1xNWZkU1lpUXlqVXA3K1BFWlh1QnVRNXgzTThHaWlHdlk4VTlJeWpU?=
 =?utf-8?B?OGhJbDZtb1lCN091MmhtL1lRVVdzWGloT2hGRVpvWmNVdTlJd3lkNlpXc0dR?=
 =?utf-8?Q?o2nQZ+5QAi8Ac=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(38100700002)(31696002)(41300700001)(122000001)(86362001)(53546011)(26005)(6512007)(6506007)(107886003)(2616005)(186003)(83380400001)(38070700005)(966005)(8936002)(66446008)(4326008)(64756008)(66476007)(91956017)(8676002)(66946007)(66556008)(31686004)(76116006)(5660300002)(71200400001)(2906002)(36756003)(54906003)(110136005)(478600001)(316002)(6486002)(87944003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3ZFbjJIOVhmQXNRQkd4eW9PTVpuNHZpOHpzZTV4NTlkVHNGVWN5eHo5azlC?=
 =?utf-8?B?bmIycGFkTHgzWUdKcHQxZFlEY01SalU4cmJZRE1KbWE5L09SYlNVR3phKysr?=
 =?utf-8?B?YUxoaEF0Wmdha212YmsxSzBXeS9OVmNqVktDYnpkRWFFYnNBSVZ4aFBlL3d3?=
 =?utf-8?B?MzJFUGhSdHEwTmR2U3A4dERLZTB2RmVDbmh0dGRhbXF0cEM5aDNpZ1hOTXcw?=
 =?utf-8?B?UzRENmR0cm9iTWk5SUFoemI1SWRvRXp2UkVYdTFYTXdKd1hrYmJuTTJtWnBh?=
 =?utf-8?B?aThkUHJTYTd2SGV0NVA2bERIUkpIY3hXTEtyVjBSd1o2NUFyMkw0Y1g3NG9n?=
 =?utf-8?B?TDdudEJzOG00RDZHOE5NUklqOHo3UUN0OWRMTW41bm52TlJEZFIza3kwMFR0?=
 =?utf-8?B?TUhLYkV6aUZSeXcvais4S2wyV0wzUE52eVhWSUE0RDdPc21zMVlIL1Z2eHVM?=
 =?utf-8?B?MjlEMklKZ2wxLzZJZHlrOWlQMTUvQ1VVUFhzZVhvVDBWeVQzYWZMUHIwblhN?=
 =?utf-8?B?am52aC9QMmhOZlZNV0c3TlliaHpLaExhWnNCUlFUZS9HL0I4cTlJZitqZURI?=
 =?utf-8?B?a3djOThFcFNONkVWdVdkR2NqdVZSZmk2M05wNWNsbUp1U2Vob1ZWNkZBd1hF?=
 =?utf-8?B?Unc0N0t0ektrWm1GZzdWTmpZamQ0elVCcWVseDNWdEFQUCtQeUh2bUtGV0Ry?=
 =?utf-8?B?bDIxNnlGSWZWSUVSQVY1VTNZZEVpR0Z3dGFoTk1wMzZyYk5EcWFWdnVpbzFT?=
 =?utf-8?B?OEsvbFpVaUVNZzZHcVdUKzREKzFUQUlRWEMvUGJBQmpzMnFXS0RUZTBCQmc1?=
 =?utf-8?B?MlhlRStnSzMyODhlVy9LK0t2dG9ua1liaG52MWtGRmhNMHoyaW5USmZzUDZ0?=
 =?utf-8?B?ak5FQkhZMXNlY2pNME8rc3RaQnBKd2R1cDVkZXhTY3UxZjFXQ3FxU0x4cWtH?=
 =?utf-8?B?VzVRNFRPTHU5UDBzUkRvWGF1NlljTmhSeGo2d01WTlZBWFdYQTJlcXN1SlRK?=
 =?utf-8?B?M2RRbnZzK1V6OFdYaDhZdyt2bUlJRHdFbkg2VlBQb29BejdlMzJyZE1yZ1Vy?=
 =?utf-8?B?bURJdUpVMWpnWHZ2VC9Sc1kyRFBMVmFGcU5VOVhsUEtvSVJRVm82azRsNzFh?=
 =?utf-8?B?ZlZ1Y25MUjlseGd0azMzMDcySVlSOGRYZVpVd0xQd3hOVlZwYWZTVVN5Vk9Z?=
 =?utf-8?B?M3dHY0NvMDFESjRxR2Fxd1E2ZzdmaDlkdTFBV3hORndaZ1FiVk1MM1FBckVn?=
 =?utf-8?B?dkV5TDliMGZKODZkazZSR25wdHR5cndXSXpJdVNNdGRjRjdxTmhORjRGa0hr?=
 =?utf-8?B?ajI0dG5FQkFOcVlOZTE4eDZQUWQ0cjEwZ2VCcEI0enJoVTRmNGxUYnlBeTJW?=
 =?utf-8?B?R2k1eFV2b0xxaEtQZXBGL3RRcVNRN0ROb0FhREZhazAvNks3dFhvOXEycXVw?=
 =?utf-8?B?bVIzRXJMRndzSFdSYlVGOXpFWUZmOXN4ZU9jWjVoV0pCVDJGSVRiRStRaXM1?=
 =?utf-8?B?MzU3VVEraWNMelliQVloV3VzcFpyQmozQ0ZvMko2OHg2eERNdVBEdTZqYlVj?=
 =?utf-8?B?TlhrL1NzSi94MVVsRmpLOFM3UER0bUg1UHF0K2UrRjgzcHg4UVZpblgwVGlP?=
 =?utf-8?B?TUFRbVNyUU5rZFphR1IxWkVTMTJSajA0WEdzbUdlMXNoNUNxUHNHa0xXZVVM?=
 =?utf-8?B?UThSTVdXRXVleS90aU42QXNUYVhyL2IxcjdBK08vS1djcnBUbnFGTWorYTN6?=
 =?utf-8?B?aVYxVUVBZUVRK2VNaVJRcHRGVE9kTXdaa3hES2loSGNOeGpQM1ZVY2ZST3lJ?=
 =?utf-8?B?MFJ3MEpPbzl2cEhxNkhXNUFXdTNkVk9yZGVDVDk3NlVuL2wxNGxuMzN1c3Yw?=
 =?utf-8?B?RHR6TEczdXRXMGUyMHJYeTN1aHU5elFQMERsK3NSVkY4dXlCQ281RitLbmN3?=
 =?utf-8?B?M0NFME9CYTBRcUVSanZYcWplK2Q1ZlFianRIVmE0VGM0Y09wNjBjdkpmbWg2?=
 =?utf-8?B?TSs0cVgxL011cG1wQWpLcC91dmlVSlRCQXdHbmkzU3prNmxiZXlEN2FhTG8y?=
 =?utf-8?B?VHZGT2JLSk1WOHF1T1I0STBpMzlsMWh3eVFFWUFHNzZGVjJQWTlsdU1ET0lh?=
 =?utf-8?B?TUtSdllLZ1UyYmFwZGpYb1B5VE9YSlVFcFFvSDFTbGRWOGloeWZTTjhiY0c0?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC16A440D8EF4A438986C08E1D92D2A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32469ace-64b1-458c-9963-08da5dbf0946
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:13:50.1792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEwMdnpXQz2r0JMLr0L8smNeJ1NR2LhDS2P1fFDaXNPDlefZtl9+lqsZ2NlqTMqflGoBIVHN2xZjgbezHh1A1TYuh/6riNs3akylK80/zNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3495
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAxNTo1MiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNC8wNy8yMDIyIDEwOjMxLCBT
ZXJnaXUgTW9nYSB3cm90ZToNCj4+IENvbnZlcnQgU1BJIERUIGJpbmRpbmcgZm9yIEF0bWVsL01p
Y3JvY2hpcCBTb0NzIHRvIFlBTUwgc2NoZW1hLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdp
dSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+Pg0KPj4gdjEgLT4g
djI6DQo+PiAtIGNoYW5nZSBzdWJqZWN0IGhlYWRsaW5lIHByZWZpeCBmcm9tICJkdC1iaW5kaW5n
czogc3BpIiB0byAic3BpOiBhdG1lbCINCj4gDQo+IFNob3VsZCBiZToNCj4gc3BpOiBkdC1iaW5k
aW5nczogYXRtZWwsc3BpOiBjb252ZXJ0IHRvIGpzb24tc2NoZW1hDQo+IChvciB0byBEVCBzY2hl
bWEpDQo+IA0KPiANCj4+IC0gY2hhbmdlIG1haW50YWluZXINCj4+IC0ga2VwdCB0aGUgY29tcGF0
YmlsZSBhcyBpdGVtcyAoaW5zdGVhZCBvZiBzd2l0Y2hpbmcgdG8gZW51bXMpIGFuZCBhdDkxcm05
MjAwDQo+PiBhcyBmYWxsYmFjayBmb3Igc2FtOXg2MCwgc2luY2UgdGhlIGV2b2x1dGlvbiBvZiBJ
UCdzIGlzIGluY3JlbWVudGFsLg0KPj4gLSByZW1vdmVkIHVubmVjZXNzYXkgImNzLWdwaW9zIiBw
cm9wZXJ0eSBhbmQgZGVzY3JpcHRpb25zDQo+PiAtIGFkZGVkIG1pbi9tYXggZm9yIGZpZm8tc2l6
ZSBwcm9wZXJ0eS4NCj4+DQo+Pg0KPj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1l
bCxzcGkueWFtbCAgICB8IDc3ICsrKysrKysrKysrKysrKysrKysNCg0KUmVnYXJkaW5nIGZpbGUg
bmFtZSwgc2hvdWxkbid0IGl0IGJlIGF0bWVsLGF0OTFybTkyMDAtc3BpLnlhbWwgb3Igc29tZXRo
aW5nDQpzaW1pbGFyPw0KDQo+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1l
bC50eHQgICAgIHwgMzYgLS0tLS0tLS0tDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA3NyBpbnNlcnRp
b25zKCspLCAzNiBkZWxldGlvbnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxzcGkueWFtbA0KPj4gIGRlbGV0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1l
bC50eHQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9hdG1lbCxzcGkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvYXRtZWwsc3BpLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAw
MDAwMDAwMDAwMDAuLmQ2MjdmYzkzMTViYw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxzcGkueWFtbA0KPj4gQEAg
LTAsMCArMSw3NyBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9u
bHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyMgQ29weXJpZ2h0IChDKSAyMDIyIE1pY3JvY2hpcCBU
ZWNobm9sb2d5LCBJbmMuIGFuZCBpdHMgc3Vic2lkaWFyaWVzDQo+PiArJVlBTUwgMS4yDQo+PiAr
LS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zcGkvYXRtZWwsc3Bp
LnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9j
b3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IEF0bWVsIFNQSSBkZXZpY2UNCj4+ICsNCj4+ICtt
YWludGFpbmVyczoNCj4+ICsgIC0gVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2No
aXAuY29tPg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiBzcGktY29udHJvbGxlci55
YW1sIw0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBv
bmVPZjoNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxh
dDkxcm05MjAwLXNwaQ0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29uc3Q6
IG1pY3JvY2hpcCxzYW05eDYwLXNwaQ0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxhdDkx
cm05MjAwLXNwaQ0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0K
Pj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNsb2Nr
LW5hbWVzOg0KPj4gKyAgICBjb250YWluczoNCj4+ICsgICAgICBjb25zdDogc3BpX2Nsaw0KPj4g
Kw0KPj4gKyAgY2xvY2tzOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgYXRtZWws
Zmlmby1zaXplOg0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBNYXhpbXVtIG51bWJl
ciBvZiBkYXRhIHRoZSBSWCBhbmQgVFggRklGT3MgY2FuIHN0b3JlIGZvciBGSUZPDQo+PiArICAg
ICAgY2FwYWJsZSBTUEkgY29udHJvbGxlcnMuDQo+PiArICAgIG1pbmltdW06IDE2DQo+PiArICAg
IG1heGltdW06IDMyDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+
ICsgIC0gcmVnDQo+PiArICAtIGludGVycnVwdHMNCj4+ICsgIC0gY2xvY2stbmFtZXMNCj4+ICsg
IC0gY2xvY2tzDQo+IA0KPiBJbiBwcm9wZXJ0aWVzIGl0J3MgY2xvY2stbmFtZXMgZm9sbG93ZWQg
YnkgY2xvY2tzLCBzbyBiZXR0ZXIgdG8ga2VlcA0KPiBzYW1lIG9yZGVyIGhlcmUuDQo+IA0KPj4g
Kw0KPj4gK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4gDQo+IA0KPiANCj4g
UmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
