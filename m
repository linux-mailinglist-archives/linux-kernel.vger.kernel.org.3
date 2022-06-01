Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112053A599
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353138AbiFANAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353107AbiFANAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:00:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB6193C7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654088410; x=1685624410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h25mSvn6nZC5aRuZjmN6YLWbBoE7e7rZ8J/dOUAOVP0=;
  b=WdAeBKi7ayyx5ZWbCS6A3FPqMYeL/tAIGkBVFApGAzCAWiN0b06HyslS
   t4TaTFy1Ww+57BukQ1ArGA2lpARlNuWZU7sm4VnpJzVOykZ2eQO2wWU12
   bBv6NkbrSI/5YecZrAWGxH3lVbU1PeQzl9L3SQ11KDfMEoZQymt1tazi4
   hYyav0PJLHKotJambvPCT198LthV86vTxOrudJ6M18otV5JePC5vtd77M
   ncrP7zO/balHO5iVgWVSxC8rHI5OKEfAl5S20JncsUwA9qdJWIe2gQHXY
   VecB9diJHGgNGh1aNQGCFbOewYmBt5E283F2B4cIHmCJFiYiLItsrtphj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300931200"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="300931200"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="707044732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2022 06:00:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 06:00:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 06:00:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 06:00:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 06:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2uEfUJjNSpynz349dj4lI+PbV7ZvGp1KlS2HYnDpgbJcFwUxhbX5vb5IMPa6/TPz2llj2ddb8vAcPwZy3lVgw+tiPYKCizTk08tdEX4AzRh1wSlFqKtWdkbCFx5pbNdb0CjXFMXEhKrTZHAuNZ65UUQHBO55WsCon49YgBXVwOROnEXn3JtCPz+S4+cP+Zj2HnozqmUJqDruo5bn/I1ZrGXUQ5wHGTZ1SHcbSn5yxiPjrJNWuhND0R6JgFHlVYvVe/ZW8z4aJZG5nmg9+72PjtPN1n44QocTxAWgOtt7kOBw3F8AgfF3VEgMRex0le76V/MRxMfhNHTPJOSxS1+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h25mSvn6nZC5aRuZjmN6YLWbBoE7e7rZ8J/dOUAOVP0=;
 b=gI3ev3eG1v9ZstVs8ABfVsi+1p+MjHpcEf2rjow+neZPa00hV7a14QHuPGs2/YO52hQiMY83I+JzJFIhwvwa4OIQiLW0+eGiZW3hDkKSwMPbuuCDYQhMBCFGZ/WeCQDuVFVK3Vtt46dFUrF7GZJOgKxq5bfWwifN0B2YExOPaGDYIBNgqzDLmtzopjeWfM17Az40aOayxYaGxJ2lVSYl+lRGgCJv2wXAgC6HAOUx2kfo7YKNUc+bRCteSbGuE8G4kYWiSGT0k3SgkaBwu6nbR2aE5UNoDOcT1ybRRxzhhIy6zQnafeo2PbckemPi665D3v2K59FeTPFS5GbLMqG/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 13:00:06 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::2915:b18:a349:665c]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::2915:b18:a349:665c%5]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 13:00:06 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "liu, xiang" <xiang.liu@cirrus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: Intel: cirrus-common: fix incorrect channel mapping
Thread-Topic: [PATCH] ASoC: Intel: cirrus-common: fix incorrect channel
 mapping
Thread-Index: AQHYdCT81hgHHTuSyEq0kpB6yhCppK05E5AAgAFxCRA=
Date:   Wed, 1 Jun 2022 13:00:06 +0000
Message-ID: <CY5PR11MB625789E6558FA1A0956A7E8197DF9@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20220530125421.885236-1-brent.lu@intel.com>
 <8a8a6bd9-aabf-6f27-0422-a47b01556276@linux.intel.com>
In-Reply-To: <8a8a6bd9-aabf-6f27-0422-a47b01556276@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b766e367-7c1b-43c9-ef18-08da43cea66d
x-ms-traffictypediagnostic: CO1PR11MB5140:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB5140AE3D81C5AD5739DFC95497DF9@CO1PR11MB5140.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSvxQstZxGkabyFYqan1A6Hsy7cjaMm3uFdvAKyB0vgiG/GxD5goGEHPi/eAWrEKsVkSGOyoAmroAlo8rkorIP8XCRzgrz4cDnqQghM6DNRp42jXo1YBKwhVVxOIR2MzymgBIJuYVtsDSIXdc+A/gr2nkzS8zBvaY+e698YJX/VcMEAyDAPIv4dy8IDhoDzOhYsH9lt9wBtZ/Ar5dAgSH8XKpMRSekCXqRYcsIy+n1/7ALJ90OaZzdbzMNareeFpkmlAiEs3TgWBSFM+PqQtTf4nKjA5F0cFss2jBYmAUUeESODekyMltF9xR6wr+tacH4TWgmTsV5goWps1w+NLIxWa3VGs6pCsTOLvhbWiOLmo6U3arm4Cq2MhB+yiSbjMUL18t6RZCLRwKjeE0jgTHLXzrIjeRYZmNDRT0SVV3RUUOgkMEcfNa8Zfx5ZUn3bjojrIWBl7h+7e/U1wVC1l3yazyFDBlTfh9vtasda3Pic2b5D5mb8FypqkIwOA/0EZMdeGEwd+3NTeHA+HhbCOYq3q2AsKX8VliIc/177dMkYmZmCAZPaIfhiSB/b4/3TgCt/KT4jamTYCcaa3/VfduX6lBLXAi2HZq2lgYoqvhACqeHhx3PTRf0e7UqtUM0UNpRB0SyljyypwG31NZPRLf9l9xX/UR7k+AYt0IdBHH7w7NpVI1m/FFkZ3LdxRjl7eyv6xORsEM7xbhEr3NYPTtgZBJGNA4Rdwvcce+n6Za2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(38070700005)(2906002)(9686003)(38100700002)(82960400001)(186003)(122000001)(86362001)(52536014)(54906003)(33656002)(110136005)(8936002)(66556008)(76116006)(66476007)(66946007)(316002)(8676002)(4326008)(66446008)(64756008)(7416002)(7696005)(5660300002)(6506007)(508600001)(55016003)(71200400001)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlN0UUxMQlR1aW5zU21QRGx4dGJQU2tCQXBRU1U0MEFrR3RFdWc5VS9zTzJ2?=
 =?utf-8?B?L3JKNDhWN2hJU2VLckVoL2NiR3hFbUsyOHloYTlCcXpjd1pZMlpEVHFqUE5t?=
 =?utf-8?B?WHdRNXBDWjl0a3JUbmd4QVdCeDZjQmlRV2NZRm5naWNuVzdtaFNFTmxwdnda?=
 =?utf-8?B?SHdjYVg2Wk5PRWNLRDlSbWhJcUczbkhjcXNCVlRkWEVydElIS2dRdC92ejZs?=
 =?utf-8?B?QWMyblpsSk1MVndRL0tNaHQzamxqSVNjeERTVjlTVDR5VFZtL1M1S1ExZXVM?=
 =?utf-8?B?SkN5NFViTVZQcUZ4eTR3a3FseUp3UFAydVByaXdranU4V1ZGbnhBbmFCSzZt?=
 =?utf-8?B?SXNGeFExSkRQc1ZGUDBNMG5VUHVobWFrOXNpRjY5TDJSU3FMWEdieG9CWTJa?=
 =?utf-8?B?cnFVMDJyd2hkM3p0aHkvZWtjTlUydHJXbXlaUThZK2huSVF5a2VWYVNpU0VT?=
 =?utf-8?B?Zmo3VXJCeW9RUFk5T1NneCtUdjBEUFFtY2hWb2N3WWhJTzJhb2dhT0Z2NjRo?=
 =?utf-8?B?UzVuY2FHOEsveFFSOHhkVzhubFcyY2ZBSXloeElFVlpLOHYxcURITTBDNEpr?=
 =?utf-8?B?L0RBU1lYaGh2RnVSeGtnTE1PdGlpYktaN2h4ajA3R3BlV2F3bmN4aHZKTUJL?=
 =?utf-8?B?SVd2elkwcERUbHVKb05jRzhJZkUvT2RVTUhuUTcwNUR6ZmZrZURFcjMxMThC?=
 =?utf-8?B?VHY1cGZ4cStnS3JZM0o5bjk2QmE3T29Ibys1Q1ZWOWlCOHh0K3gxZzVPQ0dv?=
 =?utf-8?B?Q2FxamhYMWxXTnpWc1Z4K095blBQNWp0SlJIdkszT3d0NkRaenZ4WkNEYXhY?=
 =?utf-8?B?VUxRdW4rNUxZcGM2a2lFV3RibGhJd0wvSGRyUHRmRk1CRFhCQmFlZFhORk5h?=
 =?utf-8?B?SHBSQXRReUcxcEJrb1FXZERWNDlPSjlNUXV3aEg0TlhYamp2bFZybjNjOHFE?=
 =?utf-8?B?ZXVyUlJ1dWUvdS95SG5YRFBhcEJJMTNBbjhtaWtwaFVaZzNzRWxjdDJydkIz?=
 =?utf-8?B?WlBINll4UFdZZkZkemp1SlNlaXQwa1hUSkhRbXJrS3NwN1E4cERlRjg4aFl3?=
 =?utf-8?B?cFhXSU5EWUdzdDBNNjB4ci9BWHFvdFhZUWw5ZVBJYUd3cXZWS2NFbkNHT1NX?=
 =?utf-8?B?eHN5a3hsYndVd0hGdlIyYlRFSHRnVXdQQzJsVTMrZUtnQm83L3N1YXBaV1Zx?=
 =?utf-8?B?L0F2ZGRoTVdsdlR1NncvanNFMWJlUkZvNnJPMmZ3clVqT1dvTXc2eXdsQUpI?=
 =?utf-8?B?QVlWM2gwTGxFRFpJMlFGamx3MlZReGVHeW9tb3h5b2hGN3NOdVRsZ0ZaY29T?=
 =?utf-8?B?dVlmYW5IRCtFakpISGRoVUV4N3JGTU9la2VVaVNXd3czL1FJV091bEFqNm1a?=
 =?utf-8?B?eVo2RjhiT2ZaOG5GaTdjWGQzTXlFdHZyWGdhcVFUV2dZQlFNMWxhMjE4YUxs?=
 =?utf-8?B?enltRU51dmdsWFVmeDgxSXNVRWNCMTNkOWRTSEU3eWVOQ2VyYmVmajRxZUw0?=
 =?utf-8?B?ek9ocXBhZGVGTEI4TEd5Mml0cGN4bU02ZXhHZmN0alZnZU82Y0NVcDkyWkUz?=
 =?utf-8?B?SXFQSFZQTUhQZGNQZDdBZHpGVVpPT1RnUGpMYmwwblZkWk9EWXdoTTRZWUFG?=
 =?utf-8?B?ZzZ2R1dTY1hmVDFkeGd2WjJ5WHRMeWM2Nk52QytyMXBzaHhiVVROdkR1REp4?=
 =?utf-8?B?NnB2K3pUSkIzWXJRVHlaRVhWS0VGdnZ2UzBNSkhhbUZKQlIvT290a1o1anRI?=
 =?utf-8?B?Rk5xUnZaV3FLL25qN3FuajBJL1lrY2JET2wwY0VGS0N5eDJzckFZSytJZjQy?=
 =?utf-8?B?YVF0QVR0VndQdW04bHRHUXlMbTltVXhQbmJEU0dUM0U2VWlKWnBIc2dzYno0?=
 =?utf-8?B?UElrT0ExbWxtVGFmdDFTM3dWYm9GREQxMkhTQlVQR2FONEsrNExqU01HVitI?=
 =?utf-8?B?ODFYb2FHcFQvSkUxZHdPdkVIb3VEelpmRXBrL3NCVmUrK2tJTG9PeFRpUGY1?=
 =?utf-8?B?Wk53UDNKRURLSEpwUnhXdGFEQVgrVG1jU1NqYkp5clNoWmVBZU1JRmpTSFpT?=
 =?utf-8?B?cWpUdGFnVnE2ZFpvWU5lRGpnUVhmUFhmZkdyNXp6SDZwM3JST2JjcnlUK2Uy?=
 =?utf-8?B?L2hoSzVLU01pWmRwOFUrMys1dUJLYkVTTWMwRmh1NkNlRzk2Yy9oWjBHS0x5?=
 =?utf-8?B?ZzZRUkJUZFpvR3ZheGJ3T2E4V0xOUGxVYkUvUklpYi9JMUZHdGExWGg2M0hP?=
 =?utf-8?B?by9ZK3I2NGdFL2pVRnBuMFpTL3NicnN3eVR5WWwzZ0Y1TlFTL1Q2Ti9KWFpI?=
 =?utf-8?B?ZWdUU1dsYmhnRWtBQ1gxR3VtU2lBWlZnWWVxVHJQUGlKQU84VFcxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b766e367-7c1b-43c9-ef18-08da43cea66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 13:00:06.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99UJJ/L2WqmCfLVczXLSZg4XbNikQgeAzBYncD2OFcXMD6Kcg6mYP+7IWIO4MStjS8hrAi2LwupopXxJck3U9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJaW50IHJ4X2NoWzJdID0gezEsIDB9Ow0KPiANCj4gU2hvdWxkIHRoaXMgYmUgJ2NvbnN0
Jz8NCldpbGwgZml4IGl0Lg0KDQo+IA0KPiBJIGFtIGFsc28gbm90IGNsZWFyIG9uIHRoZSBtYXBw
aW5nLCBob3cgZG9lcyB0aGlzIHNlbGVjdCB0aGUgcmlnaHQgY2hhbm5lbD8NCj4gVGhpcyBzZWxl
Y3RzIHNsb3QwIGFuZCB0aGUgbGVmdCBjaGFubmVsLCB3aGF0IGFtIEkgbWlzc2luZz8NCg0KVGhl
cmUgYXJlIHR3byBEQUMgc291cmNlcyBBU1BSWDEgYW5kIEFTUFJYMiB3aGljaCBpcyBvbiBzbG90
IDAgYW5kIHNsb3QgMSBieQ0KZGVmYXVsdC4gQW5kIHRoZSBEQUMgaXMgdXNpbmcgQVNQUlgxIGFz
IHNvdXJjZS4gVGhlIHsxLCAwfSB3aWxsIHNldHVwIEFTUFJYMSB0bw0KYmUgb24gc2xvdCAxIGFu
ZCBBU1BSWDIgb24gc2xvdCAwIHNvIHRoZSBhbXBzIHdpbGwgYmUgdXNpbmcgc2xvdCAxIGFzIERB
QyBzb3VyY2UuDQoNCg0KPiA+IEBAIC0xMzQsNiArMTM1LDE3IEBAIHN0YXRpYyBpbnQgY3MzNWw0
MV9od19wYXJhbXMoc3RydWN0DQo+IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sDQo+ID4g
IAkJCQlyZXQpOw0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJCX0NCj4gPiArDQo+ID4gKwkJ
LyogU2V0dXAgZm9yIFIgY2hhbm5lbCBTbG90OiBXUiBhbmQgVFIgKi8NCj4gPiArCQlpZiAoaSAl
IDIpIHsNCj4gPiArCQkJcmV0ID0gc25kX3NvY19kYWlfc2V0X2NoYW5uZWxfbWFwKGNvZGVjX2Rh
aSwgMCwNCj4gTlVMTCwNCj4gPiArCQkJCQkJCSAgQVJSQVlfU0laRShyeF9jaCksDQo+IHJ4X2No
KTsNCj4gPiArCQkJaWYgKHJldCA8IDApIHsNCj4gPiArCQkJCWRldl9lcnIoY29kZWNfZGFpLT5k
ZXYsICJmYWlsIHRvIHNldCBjaGFubmVsDQo+IG1hcCwgcmV0ICVkXG4iLA0KPiA+ICsJCQkJCXJl
dCk7DQo+ID4gKwkJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCQl9DQo+ID4gKwkJfQ0KPiANCj4gU2hv
dWxkIHdlIGRvIHRoaXMgbG9vcCBmb3IgdGhlIGxlZnQgY2hhbm5lbHMgYXMgd2VsbCB0byBoYXZl
IGFuIGV4cGxpY2l0IHNldHRpbmc/DQoNCldpbGwgZG8gaXQgaW4gVjIgcGF0Y2guDQoNCj4gDQo+
ID4gIAl9DQo+ID4NCj4gPiAgCXJldHVybiAwOw0K
