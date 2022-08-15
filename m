Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEB59274E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiHOBCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHOBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:02:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CEE6340
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660525360; x=1692061360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g1uwNEbzs8NUsPyZHn92+ryhkzcj8HoNMjMZe8h5Yy8=;
  b=APRevGtmQC1P+aHenL7bh2D/NuLWHfidofTGhSh2uCmPiC+ujn5o3I8k
   dUNXADNpd1OwedoUQExx0xWh7PzXyZAGiULiduKORRBTtgbydCAYVBuOS
   oF8o0Yb14y73Otzq4Y/peuHN5BoUpjtfJGiFhVjNAKfj2BfgMFFIDI7Cp
   NnJ8XdBmUGTkx3yhXrI3STWfqlt2Jao+FnqJ7msPSKzYmmf1Ct2PGo9jT
   mqxMcX4s42KkXJ9Wl6IvbxeuGGJDP0+Zv5XrD3S+TnsXFAyaa2NjUkmtl
   ya1EAglXq8Funr+k8SIZ1TpHV9rmOtloAbvvWs5IFs2yqtiTcZefIogAh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290619608"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="290619608"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="674678091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 18:02:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 18:02:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 18:02:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 18:02:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 18:02:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcXRJu2nTECDW+n7SB9BuVWqOISqDZBHvEc2DIoDw/CClG+tc7kPWgU+FZFREXwWD2hYUwOT5IPO7sp8MnP9IF1D+oR4rpnyuobYA+bL43sN0MODa7WhtldjVnzouMVJqOQKWP5tZ8fD+2guaeKdbTXdxLgxRtDGHjb6BjLeLwiGyrxm5A/TW+rRLTK2DmQIA40FP6fpncG9PBrBGZuYa98CRY5mQE7YEQL4JVAVBjdHAu7RTg1p3gsAKeypQ3Toxvx2MVYB+/HnX4rmHJzVKkt97hhNq0j4UzZHMJQjVgjA8zbhqpWO4yUNQYyBBFlAmwbwF1O38RHjegIHZWbRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1uwNEbzs8NUsPyZHn92+ryhkzcj8HoNMjMZe8h5Yy8=;
 b=VozWdciuvDk8NmrhcBYnyOgRyn13alsp5PbNlFmQQ3nuIA+E4z8t+boyLNMWdUnEOx33wV7Gw7q3oCg62LwSnwVhI2WZ8R3C1tSDuNDfmMojhyofMfVTDgsPbydsuo3lTwfxAII9NJQOvT2WPcVHOqkwO0uHmvd3QrMAR/scauvM1gxiguAySUYzY8DdE5PCQ+lAh0AO7fujHYjumObt7wE/XiAqPkIyWV+Jtv5K1cfpLygnvdu9aaEG/1BlAXy2snqaE/7cGA/eZoO2ov+ClO0GKs0dnsGUr+ATYVn5OGg6EgLuGRAvPqHbIXbBqUEP2wXpxVqzu/yri7is3hkjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 01:02:32 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:02:32 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: RE: [PATCH v2 1/3] mm: revert handling Non-LRU pages returned by
 follow_page
Thread-Topic: [PATCH v2 1/3] mm: revert handling Non-LRU pages returned by
 follow_page
Thread-Index: AQHYr+brptYcn8hxYEm8tnuvhrQmf62ulpKAgACOlKA=
Date:   Mon, 15 Aug 2022 01:02:32 +0000
Message-ID: <BYAPR11MB34955999A195AAD2614A9339F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220814140534.363348-1-haiyue.wang@intel.com>
 <20220814140534.363348-2-haiyue.wang@intel.com>
 <2298704f-03f9-c932-e00e-4e6006a6dffa@redhat.com>
In-Reply-To: <2298704f-03f9-c932-e00e-4e6006a6dffa@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8657607-c5f0-4ab5-96fa-08da7e59d54b
x-ms-traffictypediagnostic: MN2PR11MB4533:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WByMOey7Z+VP8Tgithq6ZV6kpkg8WJh7Io7vApYBiZ2t34FTJ5q9qePxkiDl/wJW5/h3movqri84b7a9g0QrUZ4lAPingoNnXUwPEKbxzBpksC/t828iesnxsP2etBS1N9eWayvJmxm1RgI5Jl0MNpznZsgF7j+c+ZpzUyuPwp/RANyDdnB0xGgH2VVZw9DcF8aG1++pGvzmSgvsInGhPjTO2NxRg/kl6ZcCFWu2qpvbnJjQA7S7Q+T3YZXIfmOBsXfkI89lxa1n6DTa1GeKF1fB9YTgCR0jmqbE3wEGSnE3WWpvDtJA7ZBukS1b5QVyoCbfHLi3Qu9oVcOhPnt4UCOKL8jS138mTJ3UTkbKFRiDMo2iVeCA9OaFuRLi+NzqXJA6Fvdcl0QN/mZSKNv6H4VBHM2gsmlsgEeHSqKv9/jFsZ8f/pvQnoBnN0e+4Vv4KoKjbQ/SCmS/4MLiOHPS4BkqN/kEhdnWO78muGQXxm6M9qgMaL5VBBxGeTftc2zUNv0M0kkDaZCV9btc/av5lIw7usxcIacp1Fj0sREL5uo5iS6A9Hg7rnh4xRph8YX8Y5nqnScN0bUd8caa6I22MPknSp6nwNmfQLZU2KqM30JRG3JtLPitn1nQSMjTd1u3zfPPrY8PQqtweRoxxVZH3exMkBJfcJuYZMfEdqztDrUG3YfVJImyQqOIDia5BdPVP9eQ772wX9PXPsBOB54IiU8LTDdJfLXF83h8vi1GvJNK5J0HS4aLS3CMc9Ppoby6o4/h5iEnpgKh2/bw2rbhDz620YOHikC3C0gWF8zp/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(346002)(366004)(376002)(8676002)(122000001)(71200400001)(38070700005)(41300700001)(316002)(33656002)(82960400001)(9686003)(2906002)(66446008)(7696005)(26005)(53546011)(66476007)(66946007)(66556008)(76116006)(4326008)(38100700002)(186003)(5660300002)(64756008)(478600001)(8936002)(83380400001)(110136005)(54906003)(86362001)(55016003)(52536014)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zlp3S3JIcmRmK2Q2eDltL2NUaTB2dVhocVI1MjBYT1FWRC9qYjIrYk0zcjJD?=
 =?utf-8?B?Mkg4NmdsZHY4RTc0TWRYM2ZGVG8vWThMTis0TUJacys3SFZLRXJQLzhFWVE0?=
 =?utf-8?B?MmFIUkRzUnBGMCt2d0RpaVZZamUyN3JqVk9XUGlQdXplRTg0dThURnMzbndI?=
 =?utf-8?B?QjJMOEs0UmNtVmpUUFQvbVBoREhMOEIvSnhOK0hwb0NWVEZLM2VVTURiUkRj?=
 =?utf-8?B?NFluZU85bWlUcXoxZVlYaFJ6Rzd0TkZONmZQT04yMGNHNC9tUUJnNUFmamxl?=
 =?utf-8?B?ekM2WDNqdzVIU3Y0NDNxNU92MzZqWno3cGJiV0JzOGRuMjRMbDNnOTRiVWJX?=
 =?utf-8?B?RmVEaUFYcU9JVytZcy9ENC9JQVJvQmFpYWlRN3FoZWlPSnlCcTA3dDlZdXF1?=
 =?utf-8?B?Tkw2NkR5WjNGSEVjR2VLRmlwUWV5VUszQmZuWW94cFhFcVBnR3ViNFQyeHdZ?=
 =?utf-8?B?L2NFTHZvaFhNYXhBdFUyZW5NaGhuUFdjcU1ud0prN01aaDJhNFAzS0FVdFlr?=
 =?utf-8?B?eFZ1QkVYTW01YlZSRlZEZFBsU1pES1RtZzhpVGxVMnlMM1dIRG84d29DczZr?=
 =?utf-8?B?UWswL3k1dm96S0trQ3puck5DWUFqOG5wVEsvN0p6U2h2NjR5a0hUSkNmWFBW?=
 =?utf-8?B?aXRWcnhpbDVFTm13ckQ0MmdDMk5JV3Ftdmd6M0xvK2JIWmlJSHVrR2Z1cGZI?=
 =?utf-8?B?bkg3T0ZEWjhUdTl4eDN2S0prcHJjenBhUmZuZWxMbWszUm9ZMEh6dHREME9q?=
 =?utf-8?B?eWRIU0VCY3FMTkJBRk5mVEpCOVpMd2dCM2pHVkVhRzlLdXhucWlWU2NtMkxn?=
 =?utf-8?B?eUtTSnNyeHludG9CaEpBa0pubnZZck1Pd3VWZEFrZzByWHFiSXhud1lpa2JH?=
 =?utf-8?B?djVVR1Fvb01DV0xKNlNJaFZBbHpQL2x4UGJEazFBQlBsT3d1Vk5HMHgwYW9h?=
 =?utf-8?B?RHd6YU1FcjM2by9ncmpmK1B4VnBCNW5IcDAxcC9qRFJNeUVoa0t5OHVWOXVq?=
 =?utf-8?B?ZkhzdFBSUVBqKytSUkRaOERCY2xDL0FseE12ZWIySGYzYWhGOFg1Z0xmQ2JZ?=
 =?utf-8?B?aGdYbWRLY3NPUEZzMFFIREhsWk1haW5KdDFPUU1GUmhEcnlzcXpPVVJVMWRn?=
 =?utf-8?B?Qy9qT29Xay80K05FZW53V29QYnBJVUhmM3RwdUx6Sm00VitDZlFDZmhjd3lR?=
 =?utf-8?B?Qmk5a0pBdzU4WUROYy9HQ1ROdjJLQkVQSkthVFBwRXdlQlhjZWtBZFBEckdO?=
 =?utf-8?B?UDgvTlZ5a0xKTXQ2Uk5JblpxMEpSeTNtRkU3K0xNTWhuTG90M2twNjhLam9J?=
 =?utf-8?B?OXpRUGF0V2ZVOGVvdUppcFNDaEVVdThrR3gvQW9tV0s5TlZYbkYyTDB0VkNo?=
 =?utf-8?B?NCszeEl4QmpYVzNESnhZOVFRQUJzNzg3NTlBVW5DV0IwRGtvempDNGlDTWtB?=
 =?utf-8?B?aCtlU1Vtemg3alNUcUZzdFVQd1BhakJEajVJRS9sbkFIWExVR1VNbWVyQkxE?=
 =?utf-8?B?MlVFYVFBNWxCTHlhbExybXppWmYrUWw4SE9Jazl2K21GSGhFUTM5YVZwSFZn?=
 =?utf-8?B?NW5VYTFnZjE3Rzc1NVd2WmtLTjRmK0J6a01QUVNxLzh6OTNkSFl2d3FjV3pu?=
 =?utf-8?B?N3U0WEgrQjZFWkF5SjZBU0hoQlBZTjljcUg3N3hEb0E0SysrakpCaS9kcjVo?=
 =?utf-8?B?dGxRelV2Vm55bENRNG4xZmV3Z3ZHeG1ZTTFSMmpJSU8zTGNOUHUvb1M0b2RO?=
 =?utf-8?B?Qm5vQTdpMlNreHp1cmUxdjBEeEU0aVBGa0puOHNGVlVOU0FmQ2xVeG0zUDBV?=
 =?utf-8?B?S09yUWxYRWlZSWNzVWpLWXdjRTlLZ3ZQR0JidHFhNyt2Q3dUVjREQ3NxRy9C?=
 =?utf-8?B?UkZoNTBVN1d6V0lKTXlyNUhHTnRqNmtDMS91emZ2bVdPd2RGSm5rWERUL3hv?=
 =?utf-8?B?empZbGw2VjhXRmdmd1dFdDF6Y2phZHRrSWxrb1FtQ203THpYZGRoRURnT1pt?=
 =?utf-8?B?RWJ6RTNlYmxicnBIaXpuemZQSFVyKzB4UkpBMnI2eUlZaXpYWmgrcENJb0R0?=
 =?utf-8?B?UGJWSFplUCtzTk5DV3NEa01aaDE2aUJaN1ZmdForeU15ZFRJNWVPdXpNa1VZ?=
 =?utf-8?Q?JX5cd+RsuddwFpByiAVlRr7Tc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8657607-c5f0-4ab5-96fa-08da7e59d54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 01:02:32.1411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3A9vRVfJMJzSZyhkC1KrabrBKDIfP8vaj64ueVmaF7ZF56F6T8qvze1SL7FQX6QSiJ0niR0sJNwTu4uTeoGJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8
ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMTUsIDIwMjIgMDA6MzEN
Cj4gVG86IFdhbmcsIEhhaXl1ZSA8aGFpeXVlLndhbmdAaW50ZWwuY29tPjsgbGludXgtbW1Aa3Zh
Y2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnOyBsaW5taWFvaGVAaHVhd2VpLmNvbTsgSHVhbmcsIFlpbmcgPHlpbmcuaHVh
bmdAaW50ZWwuY29tPjsNCj4gc29uZ211Y2h1bkBieXRlZGFuY2UuY29tOyBuYW95YS5ob3JpZ3Vj
aGlAbGludXguZGV2OyBhbGV4LnNpZXJyYUBhbWQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMS8zXSBtbTogcmV2ZXJ0IGhhbmRsaW5nIE5vbi1MUlUgcGFnZXMgcmV0dXJuZWQgYnkgZm9s
bG93X3BhZ2UNCj4gDQo+IE9uIDE0LjA4LjIyIDE2OjA1LCBIYWl5dWUgV2FuZyB3cm90ZToNCj4g
PiBUaGUgY29tbWl0DQo+ID4gMzIxOGY4NzEyZDZiICgibW06IGhhbmRsaW5nIE5vbi1MUlUgcGFn
ZXMgcmV0dXJuZWQgYnkgdm1fbm9ybWFsX3BhZ2VzIikNCj4gPiBkb2Vzbid0IGhhbmRsZSB0aGUg
Zm9sbG93X3BhZ2Ugd2l0aCBmbGFnIEZPTExfR0VUIGNvcnJlY3RseSwgdGhpcyB3aWxsDQo+ID4g
ZG8gZ2V0X3BhZ2Ugb24gcGFnZSwgaXQgc2hvdWxkbid0IGp1c3QgcmV0dXJuIGRpcmVjdGx5IHdp
dGhvdXQgcHV0X3BhZ2UuDQo+ID4NCj4gPiBTbyByZXZlcnQgdGhlIHJlbGF0ZWQgZml4IHRvIHBy
ZXBhcmUgZm9yIGNsZWFuIHBhdGNoIHRvIGhhbmRsZSBOb24tTFJVDQo+ID4gcGFnZXMgcmV0dXJu
ZWQgYnkgZm9sbG93X3BhZ2UuDQo+IA0KPiBXaGF0PyBXaHk/DQo+IA0KDQpKdXN0IGFzIHRoZSBj
b3ZlciBsZXR0ZXIgc2FpZCwgZm9yIGFwcGx5aW5nIHRoZSBQQVRDSCAyLzMgY2FuIGJlIGFwcGxp
ZWQgb24NCkxpbnV4LTUuMTkgYnJhbmNoIGRpcmVjdGx5LiBJIHdpbGwgZHJvcCB0aGlzIGtpbmQg
b2YgZml4LCBhbmQgZml4IHRoZSBpc3N1ZQ0KZGlyZWN0bHkgaW4gdjMuDQoNCj4gSnVzdCBmaXgg
aXQuDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQoNCg==
