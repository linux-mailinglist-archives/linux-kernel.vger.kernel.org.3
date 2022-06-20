Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3368551313
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiFTIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiFTIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:44:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B319E9A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655714638; x=1687250638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QFClXA/J+rmxCnfeqXxozRqEhJsxvaFaIXKxmnJ49QM=;
  b=SHdaP52NlBv5DDl/UfK2G6hjDsik8JDL2WCRwMyOMN4gvq5Z7QeCQ6oY
   Y4/hzse1ulbiw6yUb8tiRROzMK1mge11Uow9vwQ0VoxL0yh09kGPxzVf+
   68ueaCxfbt1rGFkGSwyRNmBLXjniDQYIPyAzUnhNl1o/ZJfcTePyR99Hp
   srm/NQKLvQy+WYb1Vi/mN3zhkuC6kzw2bmPDDU4zldL6LrFxxMBnfk7QK
   +UoZMPe0mjwXK/sXf8ci1mcFD5QjFmGVy79KW5ZwGzp57a7VIbCuVkfqB
   RijaUcUB9YAeBJPuZDdYlYUv8PpKSxCzmuK34grFkC8e93YCDtuz5hpPo
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="164122687"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 01:43:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 01:43:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Jun 2022 01:43:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDUtEpI6upv0C94/qVA5d+m2vk9uU8lttl1WSAdsQokkoA3ZGcBu4sHmjG+UD5kPCRpbryI+4BSHk/yUzIJ09lJdIdPzgc9ZMaKp5kB48Y5nhVrUJgeJI+Fl/sSM1JWe5vKtx5T01UDdnuzL1eUFPZI4lUjB6WZbY0NBUdUvBIw96Jq+JPEw0NGHnV6ptKRb2EHjnNOZDI4wZYMIsw60YFnVmn+f8wB8nC6F23sJZQQpqfEb5ZNKPSURRni4Ok2NcBKjmxB8xcMN4ChcMxyrEP+rM/clT9UoonahoQUg7t/k0InTrGpc9Wtzptz7+tOFQQ+Hb4eMrViDH6hEwi5vmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFClXA/J+rmxCnfeqXxozRqEhJsxvaFaIXKxmnJ49QM=;
 b=gr/GPgRsCWcmaz15H5SN+nwFydjmcBUutC2xtX+czinn950DOxDZNpvuY18iosV3hXT0OFGnEzSDFoYR4idi0jGOClSXty4n0Fjo2PSvcp1xTpps8BHjI2+wLVQmt9dFDKOHd6XM6BI5POtdYsuHpNGFKtW42HsNWTZFMWWWMCr8mPWThTVDYEaW0zYol9pE2WGIARzcUakftSPZT6QZRR98tQQhL5iScW+fi0wNf4WnsENj3lDyFuUIAwc5CpGsuKZJihAb29/LRPmYPDThsOBwFdDjhhHC+HQzHayS5KpXdfk+uMWVQzSZ+8yKJ275KZpTEO2VjTlXxnybCQWc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFClXA/J+rmxCnfeqXxozRqEhJsxvaFaIXKxmnJ49QM=;
 b=WWZzWzQE9jRnK1YZ/H1n3b1mu+vdLToTi8bCXe9CSSwEIXmZPsQwAvieoudM2d6QMNNjgQzXGrfSB7uLaefdiQdmvuhEUMo4wlMxNCutZ1yxoUPK3noC70E1W8iyGOAExqlQLebF0WgcKkW+1IGY+rT5WZPIBThj+TV5B4Q+p/s=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM5PR11MB1340.namprd11.prod.outlook.com (2603:10b6:3:15::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Mon, 20 Jun 2022 08:43:51 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5353.014; Mon, 20 Jun 2022
 08:43:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <regressions@leemhuis.info>, <peda@axentia.se>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSfw==
Date:   Mon, 20 Jun 2022 08:43:51 +0000
Message-ID: <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
In-Reply-To: <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7deabc9-dbb6-4e7e-a0f7-08da52990018
x-ms-traffictypediagnostic: DM5PR11MB1340:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1340869095D7386180C2FE65F0B09@DM5PR11MB1340.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VG/+g1NbYjzVax6I/bH+erLjxFJox1TBXzcjs3KZnaKznXeb48LUHXrUQCJrNtmIosiuBokTwP4FuYsJVWfzi73o1WLcK5PUFKaEnVJ1wJuh4pxNX1WY7wktrmLgSz8fLbNEyc5UQF0vMDTV3xxPsd09S4QR8Xhs+C9sgJy1FG3IOR3QPTeQ0Qt5GcDx93K1A/wK3XTW5pvbpKBCvLXjRLJ5d7pC6k68Gr2Pd6Va+W6MlMmNjHrKHDV4aNVGy+dVr2RTj+qmANyDJUgwle6MpIcAp/cg3+9EQetEyLhxvBxNRe9e8yjXCQQQOl3LwPu50u23HQAM6nYQYiVnoxBFxH4Cx6McTHgxiNR1XyZkpdNoFzxG6xq8DrKSk5Yx0rEa7UeWVj0LNOdW5iKw3RzQN5ZxuZTtDu4EkjZ3ne75krCkPagxA851WwTBaZW4zK3kjHyscRytnV82HaxDH9W28jIj9xcTvC1CGSd8KecEbB5gvpNHJwRIiWQyFp6MUCLl3KWNI7ztCtMXPbNA2ZDPO7F8OTNsuLIN8oPdwIWIqAY9tEJarV9QN4IhDqUXOCzH7VMjllJxkN5r7qzu5B/u8U976rLUjJk07Y/Ulk4BOJTEjKuqHPsxZIhy6UHIFKmKN/PYp58lynCyA75ZeIcJGaWhrpbuq7X13L33xZjLSngd5o7aEwdpx4yT2gAyWJue+ZyzdKu7GZYoYYbQLgd+UmlxnkPiYfQbQfzLdtCRZD5Gm6XU7zLnwUQCRt7Tx92aPJU2rDGUmkPvBg2YUBK9HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(31696002)(86362001)(83380400001)(26005)(122000001)(38070700005)(38100700002)(64756008)(91956017)(76116006)(36756003)(66946007)(2906002)(4326008)(66556008)(66476007)(66446008)(53546011)(31686004)(6506007)(8936002)(6486002)(498600001)(5660300002)(71200400001)(2616005)(54906003)(186003)(110136005)(8676002)(316002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QitCTEZydys0SGo5ZGRGeWplbW5qZnovbUl2bVJuTGl6dUtPTjRNZkFsbGFX?=
 =?utf-8?B?L1dmUlkwVW5MZnRaTVZIY01KQzRPZW5hd2Yyak1PODQ1V2FMZFNlMnRick5i?=
 =?utf-8?B?YXM4cXBqbzBkUkVSOWlBVnFIYmxIOWlDUjRacXZEWmswUkJIbjNJZW5PbFph?=
 =?utf-8?B?Q044T01GOGFsVTgwYzZaeG1JY2JPOURuaDFZckpPcXR6Q0liVG9SMHlzNkMr?=
 =?utf-8?B?aVBFamJKa2kwc1pFcExpUWVqT09MY0tVaWYvT2RQQTFkejl4clc2TE9VbTFP?=
 =?utf-8?B?WkN5OWxlMktRMGdPbGFvZzluUG9oNitRMXllc0Y1K3VhRjZQK3NpU0oweXRm?=
 =?utf-8?B?Sk9oQWR5K1VVS0w2Znk0TW91c1pTeGFjMkFFcXlHWFhxaytGalVpdzFyN1Zl?=
 =?utf-8?B?bk9TSU9MQ0hwajNDTjJLS0w5ZW5wVnVDMDVVQVJaVi9tTTMvOEV4Sno4UXNG?=
 =?utf-8?B?aWx6czhZY21Ca0Y2SzB1WkNoMHhJQm5iUkw3a2JVcDRTREorU1NTQWVnd2Y5?=
 =?utf-8?B?c0k2UWxreE9vRnJ4QmVqbU5adjVTTnFnK05CVVdCYmE2dlJnSWtTTjN2NE5q?=
 =?utf-8?B?b214K3RhcllwSVpnZ0xVTnRIMW9oTkdNbUhleWRLNnZncW1wR0ptQ2dGVHRE?=
 =?utf-8?B?NHNmWitlTkxQeGlNNFJDWmpPV1JyczVRK3ZZOE92aU9SaFB1cU5uWGZ4MlJG?=
 =?utf-8?B?MnRCam5jenpoYXFEZVllckRKbVoraS9FdHVIdno0Vk56eDZ4MFhUc0V6d2dn?=
 =?utf-8?B?aHVaMVpRNnFCOU1ubUREZG1lVTNEbDQ4TmxkYmJmVVBacVlGMldvcyt0OW1T?=
 =?utf-8?B?em8veGxaSTZNdEZBeHovRHRwNnFWSGdtYXc5Wkh4NEsxV0lyTWFTRWFzK1Ro?=
 =?utf-8?B?UmxqcEVXZy9uc2U0VkdwblF2Sm9OVURJQnlLc1JoSE9kWDlUS1BVeWprVjRp?=
 =?utf-8?B?cEV4bUJYb083b1BCMW9zdUhkWlEvM0pHN0laamRPb2ZsaHRvU05BZlJPWjNX?=
 =?utf-8?B?Mmk2eEZkUWU2NDhoaEpMMUVEU3Rtd1ZwRk1pZWpBZ0JCOFpRbWpxTzk5aFpi?=
 =?utf-8?B?dmZZWjkxSmtOcDQ0d3hNRlZnVWtXR2tSdFpaN3ZmVU9KTjNPTjIwVkcvZm9i?=
 =?utf-8?B?S0xCMm1uUkVZYnZvZnVWTG1wTVRxMFRUSnBsTjNhTW5EdU8rbHc3OGtuMFdD?=
 =?utf-8?B?dFExOXhiYk56OE4rNzB1L291eXNhYmFiS011Q2s2NDNmdnI4anpGbUZWU05r?=
 =?utf-8?B?c0RXdjN1ZENBVUhGMmFONHMyR2YrMG1uMFpNMFBQcFExNEtQK2F6MGZVL3lj?=
 =?utf-8?B?NlFmZnZVRFJsWXROdXI0RE5MYzlVcGJBRnpQWWhNQzJaZW5UaTNFS0MvZzlh?=
 =?utf-8?B?N3VDbUFCZUdram1NM01ZU28yc21ZRDUxZkl1YjAxZnJ1TjE3dDZDc2RqWkU4?=
 =?utf-8?B?Z25kUlo5Z3dRV3UzdVRJSytzWTBrSlZZd2Y1b3JqZzR0Z2hPaDZTREtQRzRt?=
 =?utf-8?B?QndOMGtncDhrUVdCQ3BUT3BQbEdmeEU2TFUzZ0lWUVpIb0pCcStpbWN4dEt0?=
 =?utf-8?B?WjJBZTh3Ymp5dlIrNEE3bmFVMnBBa3pOL29DcFoxTVN6YjNhS0JmZGtnY3JJ?=
 =?utf-8?B?VGs5NzF5RndrM29BQ3Q0SjhQNkhwc1JHMWNlcTNuQzV4eVNodGJWamVBRHlo?=
 =?utf-8?B?Wi9pSE1NWnJVM1RPNlZEUEpVdkFaVy9YMTN1ZnJ6ZTlqYndDbTRYUEZURFFa?=
 =?utf-8?B?NThnanRJKytLRWtGUTlnQytGQ0QzN3k2aWF1VkdBUmpHSDlqcHdOZU9lMUxj?=
 =?utf-8?B?azNYSjBxTjVMRUxwRS9DQWw5T1BWYWFyRlBrMTB4aXd2SU0rVXJ4NnVadisr?=
 =?utf-8?B?Vkc3Z3dKS1pUamFQbDRBSFpZek0rWEF1bjVYL3FLOXY2bXQxRitEOEV0Z0Jv?=
 =?utf-8?B?aEVXckdwdkptYWpWK2V1eUNjbGhqandMa0JhU2kxTGxZejZESmZoejRxQ25v?=
 =?utf-8?B?YnJaUDh1QnZ5SlpUYjZVOEVpTzdzZUdtbjJTZlFoZWpMNXNIWWpOY0UxUmh3?=
 =?utf-8?B?Zkc5eUFPZkNqeVQxd0hLQUxiSjBkZWtLNlhWZDdOdi9kYWEyYkd3NkpCTHNS?=
 =?utf-8?B?L1lMOU5sMU1hUU9TUUtoMW5wMDVLNmprekM3ZG9rVVRTMjdiM3lxUXpkSVZF?=
 =?utf-8?B?S3cyWTRvZ2NmdVl1Y1dzdEtpb3o5YUJjYzlTTUt0Zmh3Yllvc1RMb0VKNlFu?=
 =?utf-8?B?NXVrWllGNWxyN2Y1N3h6clphVjhPWUJQVlFYaXRjVk5SZ0xuOGdvWlV3L2pz?=
 =?utf-8?B?ZU5Gb3hMR3o1Vk5abGcwTUt0dXhqd2lMcDNMd3cwQTliYU9jangzMFVxcTBU?=
 =?utf-8?Q?xBcZQqkO02g0m8qY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5967FA534641F54EB06C29A99809F141@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7deabc9-dbb6-4e7e-a0f7-08da52990018
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 08:43:51.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gscqVF9d63KDV421vJK7J8rS748QqH3cTrBlYCnWfR8tPNMwPFnUZ+/MJPb9t+Zufb81CVjrMY0me3ePlLwGxUQPjHgzfVNdbHW6tdBzeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1340
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA2LzIwLzIyIDEwOjA0LCBUaG9yc3RlbiBMZWVtaHVpcyB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxOC4wNS4yMiAwOTo1MSwgUGV0ZXIg
Um9zaW4gd3JvdGU6DQo+PiAyMDIyLTA1LTE4IGF0IDA4OjIxLCBUdWRvci5BbWJhcnVzQG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+Pj4gT24gNS8xNy8yMiAxNzo1MCwgUGV0ZXIgUm9zaW4gd3JvdGU6
DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pg0KPj4+PiAyMDIy
LTA0LTExIGF0IDA4OjIxLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+
PiBUaGVyZSBhcmUgc29tZSBjb25jdXJyZW5jeSBidWdzIGluIHRoZSBhdC1oZG1hYyAoRE1BKSBk
cml2ZXIsIEknbSBoYW5kbGluZyB0aGVtDQo+Pj4+PiBhbmQgd2lsbCBjb21lIHdpdGggYSByZXNv
bHV0aW9uLiBEaXNhYmxpbmcgdGhlIERNQSBzaG93ZWQgdGhlIGJ1ZyBpcyBubyBtb3JlDQo+Pj4+
PiByZXByb2R1Y2libGUuDQo+Pj4+DQo+Pj4+IEFueSBuZXdzPw0KPj4+DQo+Pj4gSSdtIG5vdyBh
bGxvY2F0ZWQgb24gdGhpcywgc28gSSBzdGFydGVkIGxvb2tpbmcgYXJvdW5kIHdoYXQgaGFzIHRv
IGJlIGRvbmUuDQo+Pj4gSSdtIHRoaW5raW5nIG9mIHVzaW5nIHZpcnQtZG1hIHRvIG1hbmFnZSB0
aGUgY2hhbm5lbHMgYW5kIHRoZSByZXF1ZXN0IHF1ZXVlcy4NCj4+PiBXaWxsIGdldCBiYWNrIHRv
IHlvdSBhZnRlciBJJ2xsIGhhdmUgc29tZXRoaW5nIHdvcmtpbmcuDQo+Pg0KPj4gU291bmRzIGdv
b2QsIHRoYW5rcyENCj4gDQo+IFRoYXQgd2FzIGFib3V0IGEgbW9udGggYWdvLiBIYXMgYW55IHBy
b2dyZXNzIGJlZW4gbWFkZSB0byBnZXQgdGhpcw0KPiByZWdyZXNzaW9uIGZpeGVkPw0KDQpIaSwg
VGhvcnN0ZW4sIFBldGVyLA0KDQpJIHdhcyBtb3N0bHkgb3V0IG9mIG9mZmljZSBsYXN0IG1vbnRo
LCBhbmQgSSdsbCBzdGlsbCBiZSBvZmZsaW5lIHRoaXMgd2Vlay4NCkkgbWFkZSBzb21lIHByb2dy
ZXNzLCB0cmllZCB0byBhZGRyZXNzIHRoZSBidWdzIGluIGFuIGluY3JlbWVudGFsIHdheS4gSSAg
bm93DQplbmNvdW50ZXIgdGhlIG1lbW9yeSBjb3JydXB0aW9uIGxlc3Mgb2Z0ZW4sIGJ1dCBJIHN0
aWxsIGhpdCBpdC4gSSBtYWRlIHNvbWUNCmRyYWZ0cyBhdCBbMV0gaWYgc29tZW9uZSBpcyBjdXJp
b3MuIEFueXdheSwgSSdtIG1vZGlmeWluZyB0aGUgZHJpdmVyIHRvIHVzZQ0KdmlydC1kbWEgYW5k
IGFsc28gSSdtIHRyeWluZyB0byBtb3ZlIHRoZSBlbGVjdGlvbiBvZiBhIG5ldyB0cmFuc2ZlciBp
biB0aGUNCmlycSBoYW5kbGVyIGluc3RlYWQgb2YgaW4gdGFza2xldC4gSSBjb3VsZG4ndCBmaW5k
IGEgcXVpY2sgbm9uLWludmFzaXZlIGZpeCwNCnNvIHN0aWxsIGluIHByb2dyZXNzLg0KDQpDaGVl
cnMsDQp0YQ0KDQpnaXRAZ2l0aHViLmNvbTphbWJhcnVzL2xpbnV4LTBkYXkuZ2l0LCBicmFuY2gg
ZG1hLXJlZ3Jlc3Npb24taGRtYWMtdjUuMTgtcmM3LTR0aC1hdHRlbXB0DQoNCj4gDQo+IENpYW8s
IFRob3JzdGVuICh3ZWFyaW5nIGhpcyAndGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJh
Y2tlcicgaGF0KQ0KPiANCj4gUC5TLjogQXMgdGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24g
dHJhY2tlciBJIGRlYWwgd2l0aCBhIGxvdCBvZg0KPiByZXBvcnRzIGFuZCBzb21ldGltZXMgbWlz
cyBzb21ldGhpbmcgaW1wb3J0YW50IHdoZW4gd3JpdGluZyBtYWlscyBsaWtlDQo+IHRoaXMuIElm
IHRoYXQncyB0aGUgY2FzZSBoZXJlLCBkb24ndCBoZXNpdGF0ZSB0byB0ZWxsIG1lIGluIGEgcHVi
bGljDQo+IHJlcGx5LCBpdCdzIGluIGV2ZXJ5b25lJ3MgaW50ZXJlc3QgdG8gc2V0IHRoZSBwdWJs
aWMgcmVjb3JkIHN0cmFpZ2h0Lg0KPiANCj4gI3JlZ3pib3QgcG9rZQ0KPiANCj4gDQoNCg==
