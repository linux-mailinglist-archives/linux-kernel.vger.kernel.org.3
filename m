Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460257527A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbiGNQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbiGNQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:10:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7922453D0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657815041; x=1689351041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xxuJAe+CI2uet20Fcj3lBElkHoj92fBZJeSqt3yej6I=;
  b=OPBuIGsSjhRI314v5cMzudFmRTNyEfIa6k7IWwmNOIHO2/c6XVqKnfFl
   HHWiKEbizdQUYmRJIBx6LOpXmQwKvVeh65TIOmBWyzLwJWDHSo7j3DnY3
   nyEhJgXQkLHpSqLxDFVDx4EIb9sMAa0O4HxqHbb+NiyazR+BAh5ju6fnN
   GaXpeu0lxMiEGAHYNJEQAr6do33y7QtoWc/OnfNnT8Y5z0EkVD5Yl0yF5
   qy6qxddCucriYiZAjskw29A5qKBlm2ElVEZIBERET5yKt8iHuF0smez+b
   5NVk5ISkC6c6py9r2yzKE2n2xc+A1KkoSc1/VfAuO73hOA7Ecl7/2vjG0
   A==;
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="104491637"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2022 09:10:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Jul 2022 09:10:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Jul 2022 09:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9vRNvq/KBkbCw/gea4zzgoIduRSqcSW47Sbpnq0Nw4/4y9+vFkqldj/ObxwM+spafH7HATAw0Z8uYQZXUIs/hCUcroO2S+yYvJ3uo7Scb/gR8rKXda3gjcztMa+7DEQl8gggF39d5amIDKzmyxynQyQjfaMUmXJfWWIukCh1oFHY61C5tzgEo1+XrR/P5M/XN0QGjyhsSYNqOMYGGoN4cEjWm6f3Ec+3vAbfYBtE2IA0Y3UWjaaFw5HBK/80Okl66iJG4gv9YWlqUtZWCX1r9EBLM+LcRcyb2Hsv6O7e21xN9CIQ5ZaozFu/QSd/aeBTAb38dHXpxq0rcaQgwyNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxuJAe+CI2uet20Fcj3lBElkHoj92fBZJeSqt3yej6I=;
 b=Ni5F0qzpZQc9txN3tefmvZ+WEtLUAcoRI/T1EFh8QcxvobzRk5qhaBKv8SmHG5iIjkXC/Xqdpa6+ATzeCAKYNnwtWpODjoCgyLCfKJ8hwb/OsM9XbzsfDh+gm262duyrZqKEgkl/tpJHKXSjhw0V1V5nGpqirQpdh1bcEwUqLG5HEIe8kTwsueqbzhgRYISrbn/GtciKQFeEGTi8Rkv5RMLE/Vot7Y66WlC4vhSxvRG6yxmnMoJBPF8nut9EaNA1DPiRhVs9i0WNuBKl3tc32zwCTstCy+EyN/Vau+Q8PNqQnENYRt2gSjxTH+fWKUSnPNwv3QHw9QZmZ+AXdQOiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxuJAe+CI2uet20Fcj3lBElkHoj92fBZJeSqt3yej6I=;
 b=q2cqnDoacRI8I6TMfzC76mFchjTQn2Xc7lIsoWFA5ompoeUYMDWSosYaFepo8Xa60N/Ic3Ys3RvuMgoHMKBBw/7EN70h61AvDT1Oyubt1w+biBrRp+f6AieRKXGSjGqhZRi/pp+5B+ydlzoxmWiXWafagO4QInrh21C4h6Iz4QY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3067.namprd11.prod.outlook.com (2603:10b6:5:6a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 16:10:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 16:10:36 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Topic: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Index: AQHYlr1LjktvAhTwm0O5ibr9nGIi2q19638AgAAMFQCAAAdOgIAACUEAgAAC4oA=
Date:   Thu, 14 Jul 2022 16:10:36 +0000
Message-ID: <50b3316b-aed0-2ef1-a7ff-69aa3991d7e4@microchip.com>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <0abd0acf-70a1-d546-a517-19efe60042d1@microchip.com>
 <20220714150100.aqvmdgjkymc2dr5t@bogus>
 <f9b13298-5a0b-34ee-44b9-90168205cc59@microchip.com>
 <20220714160016.honjpzg35ccq4fto@bogus>
In-Reply-To: <20220714160016.honjpzg35ccq4fto@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9396dee6-9185-411b-ba85-08da65b3631e
x-ms-traffictypediagnostic: DM6PR11MB3067:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lnY0CrrZkDEjaPp6wQsBY1Nm/BeSoaK+3znhTUrcLXFvf7J5Hq148tw6iBHOj5rkSPSCGRiJxG4HKiTjBFJHB/wOd9v0fzHAbw6PWe4eCssWloony/qmcgyShe9vFFp++tcuq0efRun9t1LcRIJ58si0kaOIHZBLyOXFeqi2gPLQWWboSZHmt/zGOn57I2824JB4qS0Yq1Pobik4KEjx+KPN9jTKbVeWy0y6sz1CX4usytymX7CE3YVH2Z9Zh/d9+Fa7EwIXKIbndmyn5g/f8e8ltin9Vpk75HvYUs4GsdM7LZFepsdGuDcMb0fDReysV3JvfU2LY3ZVdzSDuPEN7uC9D4INZOm+z1PLeossGs1llyXm1XdD9sLaUC6KYCIiqMosf0+d2NlfmU8eOJWwTbS/GcuMk21rRJrhWNpTXiVmKcUaxrk7Uo3IUc8vRhVEAb/wrd9IJh5Ur6Gr2SeUkfFevnoZFrQyMzCK/0Nytkf4vCDn4vYJQBnDrlmXKbaT/AeNLThnfxDPUQhFQ6LKiha8s1jyAmbinVs/Dyy04sd/NlL2dq1ImeYQz3o2YRnjsopuqt15LV/4IzPGbSJ5j1ADGpGVEXlaT4TRmg0s2aj2/Z5ePr/C13zS+0EzXDwq3/VycwemQnTOoWpdCDOcit4o2XPt0jTIU8VuIMdHGK3YHq5QoJCp00Sqv2GzrTM7cUGydqe791VCvct9RXifbEfLQ7axi/69AQ9kEAvFaGYSqDrbFK85RdESMjzDAtl1tfRLe5ZnWWt+ZKp78Jz/lkGyxtz2YNKzxa42fedkaUg3M1PUeXgaSe8xUliOrpSEi2kMbbBfvKGjQbpkBNiQqpYqPuQU0GzoBLvETbX3vWVTb8jR8/LrtA0CV6YWpoNb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(136003)(39860400002)(53546011)(66476007)(66946007)(122000001)(71200400001)(6506007)(64756008)(66446008)(86362001)(91956017)(5660300002)(8676002)(76116006)(4326008)(31696002)(66556008)(41300700001)(478600001)(8936002)(83380400001)(38070700005)(2906002)(6486002)(6916009)(36756003)(38100700002)(54906003)(186003)(316002)(31686004)(2616005)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0EzT29ucy8rLzVmOE1LeFJtYWFqbi9tVS9VeWRzWHpVcUZWNHpEYjJpYkho?=
 =?utf-8?B?VHYrNmpWb2VYRU5hM3ExMEladDB3S25kYVNHTnNocU10clpKUHpoWXAvS2Fr?=
 =?utf-8?B?M0NTZ1pVQ29JdVJjYTZIQW5jNmdxL2U4NVNVckRpbVpvV0FDWjNHakEyOVRP?=
 =?utf-8?B?eDIvU2tGRnc2aDRtVTAxaDQ1Um43VXgrMHA3cC9CWUs2ZXFzVGxpMWNhVElW?=
 =?utf-8?B?MzRPd0ljb3lSNU5RZDc0TmxmT1Q5OXo3V2xlTjhDNHB6Nk1pQzFYVVVlcHZu?=
 =?utf-8?B?UTBzbUdFOTMrR0Zva1R0RzllR00yVzVtclRVdTJ4TTh2dGt6bEgyMnlGVkRM?=
 =?utf-8?B?b1pZSGErVFd3WWpIQThnaEIvbVdVZ054MlJqVURqZmkzM3FSZ2psNTR0NUh2?=
 =?utf-8?B?YkUxUjRqZHRqT3JrY1lONmlwUkFPQlZRSDFGYk1GMVVVckpNTlNKdzRIM0tY?=
 =?utf-8?B?d2RiYmdCMm8xOHV1WDl1OVFCN2lCL3hZbytHUWozcS9jbnIwRDQrYU9HcGh6?=
 =?utf-8?B?L2ZRaG9uS2w4bVVoeWpiTVNuVzd0eXRUMkxVeEpRdHdLWXlabG0wZ1RMeEpV?=
 =?utf-8?B?M3lwY0FEQ3V1cXRkL2prYlFOSWxaeDhwdGRYYzVRU1FPRlMza1NtSGVhNFRz?=
 =?utf-8?B?NC9EdlBSRHdiQSswMnlISzd3UEU4Rml0Z2lydS9lcVpTRGpiMndJcWtZMCtG?=
 =?utf-8?B?c2lGaDRSVzNJNlpOUk5GbnJBVVJTTHVkMEFyaFpzdWVPZXB5TUYwdXJRdWxI?=
 =?utf-8?B?R2Q1NW80SUR6eFBicm1pMUFDdnZYUCs2ZldqMElBWE9PTlp1VVQ1bzRocHJi?=
 =?utf-8?B?L05OYmNJR1NpaFJ2eXc1VjNQME9heHozMCt4ZVIzOFc0RXVQa084QituTjIy?=
 =?utf-8?B?MlJNMzc3WlNjSTlkcGd1WlFhOFBUZXB0TVVHakU0MXNVMHl5bW8wNW9Xb1pr?=
 =?utf-8?B?bjh1bHkxRDkvKzh1OHIzRkZjMko2b1I4VUxFZnpFdDc5ekg0YWFzbzdiSnkz?=
 =?utf-8?B?TVpyQzk1ajIwZit6QjdxZjdRMG4reXJmTHlEcjFOTTVSazhiQnFQa2c5Z3dz?=
 =?utf-8?B?OE5vQ0ZEREYwdzh1aEc4WnozN1B5dkF4TU91UWM2aFBGK3ZFMUhOL1gvQURl?=
 =?utf-8?B?ZkgycUZqYkt1QllVUlNTK0I5SHlaTGJSb2pvNktTUEgrSDVJQXJpYVNDaGl5?=
 =?utf-8?B?bCswNFZDM3pCL0llV0lSUm9VTnhMbDRqTWc2MnZhT0szVllobkhTL1NaMWZ2?=
 =?utf-8?B?T01RcytxQjRJV0dkeTlheGw4aHRlY0U0NDNIYXdGeGtXTGRTK2dZYmdRQW50?=
 =?utf-8?B?V1Nuc0lDd3NmQmZBMVNWTGVxNG9NTjdLQ0pEdFJNMVhYRjNyT2llV0ZlTS9k?=
 =?utf-8?B?QXNiVkNXdDRLYUhKTU1GanoxZjI4U3dwVkNudTdjTmdlYnBSeWhvWXE1NkRX?=
 =?utf-8?B?UXJmblZmaXRNN2NrSVNWTHQreXlRT3lVaUcxVGtmRWxUREZ5UVZyVlM0T0hP?=
 =?utf-8?B?ejV0b3RtU2NzN2h5SUxVeENTTWloRkZMakZLTGpHM0FpVFRxNG5GNnNwM0Rl?=
 =?utf-8?B?bytYcm5mQ0JIejNHcWtldVovejJNUGYveUpOZFp3bER1ejM4UFV6TnNJOFc0?=
 =?utf-8?B?VXkzN0hQdTRVU0lGUi9HWXI4TXAvekdpNDlpZ0hKbnMwWGVqYkJWZlZPWHZD?=
 =?utf-8?B?SEltbmNVcWdxdEE0K1k0YXYwUUVpVW9VVXQ5NlRKVWxGUnZsb0dodHlidGVE?=
 =?utf-8?B?VVVGd1VMTnRzdlNURy9sNUsrdlNSaUdzWkFhQzBCampYZm5EVHh6S2xWcVEx?=
 =?utf-8?B?MDc4TjFjbE4ySVpWR1VJOUx1aDhxVTdqWVN4UUNqdjBLcjVWdUpLNjJ2MWFK?=
 =?utf-8?B?cUVQOTZjL0ZOQm0xSCtEUC9RNzV5SW9RenpLdytQWGFsQnVYN2tyQnhZa2Y3?=
 =?utf-8?B?ZmY4NDdzOGNDSldGTFZRTXEwNjByNGUzeHlQNHZCa21MTlVvbmFTdzZTZTJj?=
 =?utf-8?B?NHR6a0hCRXVzaVpZQUFmd2hld0VVVVN0Y3VDM0hvZGR6MTl1RDRHQWNGdXMx?=
 =?utf-8?B?TWp1YWFFSGE5Uys2eFltODNCdlFEd05hZXYxWjJFSDNDZFZJUVYzb0dOTG9s?=
 =?utf-8?B?dWtKWWZxTHNwcGVkVzZraDRPaWJTQStVMkM0d2J4ci83NnVIQ1lBNy9jNGR0?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57CDA9D15FF07146B2C19FCDBA0CAA21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9396dee6-9185-411b-ba85-08da65b3631e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 16:10:36.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfcBtzRPxlsh7TJkQAV1Lo7E+NYBkXeIXNqNTaQN2/Y/xic+kye+nok4r4N7+Gqhw2pgd7f3NsVQUKbUSl803TDWNnrw+0yof2iRFXuIq50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3067
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDcvMjAyMiAxNzowMCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgSnVsIDE0LCAyMDIyIGF0IDAzOjI3
OjA5UE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTQv
MDcvMjAyMiAxNjowMSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+DQo+Pj4gSW50ZXJlc3Rpbmcs
IG5lZWQgdG8gY2hlY2sgaWYgaXQgaXMgbm90IGluIGF0b21pYyBjb250ZXh0IG9uIGFybTY0Lg0K
Pj4+IFdvbmRlciBpZiBzb21lIGNvbmZpZ3MgYXJlIGRpc2FibGVkIGFuZCBtYWtpbmcgdGhpcyBi
dWcgaGlkZGVuLiBMZXQgbWUNCj4+PiBjaGVjay4NCj4+Pg0KPiANCj4gT0ssIGl0IHR1cm5zIEkg
ZGlkbid0IGhhdmUgbmVjZXNzYXJ5IGNvbmZpZyBvcHRpb25zIGVuYWJsZWQuIEVuYWJsaW5nDQo+
IHRoZW0sIEkgZGlkIHNlZSB0aGUgQlVHIHNwbGF0IGFuZCBjaGFuZ2luZyBhbGxvY2F0aW9uIHRv
IEdGUF9BVE9NSUMNCj4gZml4ZWQgdGhlIHNhbWUuIENhbiB5b3UgdHJ5IHRoYXQgcGxlYXNlIHNv
IHRoYXQgeW91IGNhbiB0ZXN0IGlmIG90aGVyDQo+IHRoaW5ncyBhcmUgZmluZS4NCj4gDQo+Pj4g
T25lIHBvc3NpYmxlIHNvbHV0aW9uIGlzIHRvIGFkZCBHRlBfQVRPTUlDIHRvIHRoZSBhbGxvY2F0
aW9uIGJ1dCBJIHdhbnQNCj4+PiB0byBtYWtlIHN1cmUgaWYgaXQgaXMgbGVnYWwgdG8gYmUgaW4g
YXRvbWljIGNvbnRleHQgd2hlbiBjYWxsaW5nDQo+Pj4gdXBkYXRlX3NpYmxpbmdzX21hc2tzLg0K
Pj4+DQo+IA0KPiBTbyBJIHRha2UgaXMgYXMgbGVnYWwgYW5kIG5lZWRzIHRvIGJlIGZpeGVkIHRv
IHB1c2ggbXkgcGF0Y2guDQo+IA0KDQpXaXRoIHRoZSBHRlBfQVRPTUlDLCBiZWhhdmlvdXIgaXMg
dGhlIHNhbWUgYXMgYmVmb3JlIGZvciBtZS4NCg0KVGhlcmVmb3JlLCB3aXRoIHRoZSBmb2xsb3dp
bmcgZGlmZiAmIGZvciBSSVNDLVYvRFQ6DQoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNv
bm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2Nh
Y2hlaW5mby5jIGIvZHJpdmVycy9iYXNlL2NhY2hlaW5mby5jDQppbmRleCA2NWQ1NjZmZjI0YzQu
LjRiNWNkMDhjNWE2NSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYmFzZS9jYWNoZWluZm8uYw0KKysr
IGIvZHJpdmVycy9iYXNlL2NhY2hlaW5mby5jDQpAQCAtMzU2LDcgKzM1Niw3IEBAIGludCBkZXRl
Y3RfY2FjaGVfYXR0cmlidXRlcyh1bnNpZ25lZCBpbnQgY3B1KQ0KICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PRU5UOw0KIA0KICAgICAgICBwZXJfY3B1X2NhY2hlaW5mbyhjcHUpID0ga2NhbGxv
YyhjYWNoZV9sZWF2ZXMoY3B1KSwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZW9mKHN0cnVjdCBjYWNoZWluZm8pLCBHRlBfS0VSTkVMKTsNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCBjYWNoZWluZm8pLCBH
RlBfQVRPTUlDKTsNCiAgICAgICAgaWYgKHBlcl9jcHVfY2FjaGVpbmZvKGNwdSkgPT0gTlVMTCkg
ew0KICAgICAgICAgICAgICAgIGNhY2hlX2xlYXZlcyhjcHUpID0gMDsNCiAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsNCg==
