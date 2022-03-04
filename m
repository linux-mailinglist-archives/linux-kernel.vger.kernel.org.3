Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2694CCAF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiCDA6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCDA6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:58:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B474BC12;
        Thu,  3 Mar 2022 16:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646355445; x=1677891445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v333GX5rmXvmUD/lHPVmjsknBmzZAwpXpU9/fW7kCkk=;
  b=oJk5548mnISLmWzSsZK6uRZkn7cNSNBdyI1fnH1mwDIy20PfDSu2HYs7
   SKfiIMQLUcxxlYFvX1AIdzdE/FaRXvUszSIilGx+mfwrMu+gXYSVcGSah
   UP4NX7mJmlNr/reDGgX2XxeCPg00hLJgnnbVIeWpyR5p+qWjt/9TprRz6
   JVwXq6F2vRYJ2WEVvarKePiLx2+S3GnzTdcpwfrohySz1T7WyFa8mzptI
   OPJdvI8utikHTbN3fLAibcoeuBYJ6wjWI+vMrpDgKbUZwIGAIW4uX/L7O
   bkKn8bU/hJY0FA7T1z2le9zuzDwCQ9M/JoAWrk9u3hAcOBPL1Ki2OBlry
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="254050825"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="254050825"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 16:57:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="494159709"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2022 16:57:25 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 16:57:24 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 16:57:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 16:57:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 16:57:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq+TZMQXiyzFqd1IujT/fgWNBOSQrn5be+y4wBHeLh4JW2O8xaozkGXXnzmML3uNhR8HlpKs4b8Q+00p8opVZOyyS2GKobDf11dQWFhCCWsybdgSMVR6yNpHXTWIA0iF0xYnNIXr62YO5bhaQMqsAEmdTKwEcVBHnjnM4oOdkPcUPfN7kjKqvufnW6ZWui9kTY2cbXuEoymMfD9dTGQkN68eI2kqsASannEhVqDEfFj0i33hiqfvB67BEvJU291Tva8vAYz2x/iwxgYZij9tx9XgtnzmXJazBXdziK9hmaeqZR78IQ3D2dDxWsGpcHY9+ORtDsTBrZvfrUNAwCLIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v333GX5rmXvmUD/lHPVmjsknBmzZAwpXpU9/fW7kCkk=;
 b=ODEDRBo2ZCioVbyLG800TuouBz5MQGOCvbKqjj73ag/agFux4d++MlnFfEjOHIhTODngQ08fg8vDyWW17Go0IZX7WgrCHJ718U7AN8ODh0+K2aM93YdtiGmNIL62/5D7/NxEoBORKIUKQLZTizTpx7kqgKjGN6QUCqTsiR6ihzpBUq4jGE4KI/zJRn8j3FmOBcDNT+99PUUFgkEjXPDEjeYW6solMmW7XjZRD7gELxv4bm1EGEwTzOcCXcp2gXGHheAh9ei28M9VIOm1Tr2iex5tboy76DbYBQhqQz7ctU/SFzI7NkyEi2h3yIXQg9UetdZAVhg8Z3adw8a5L0bhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR1101MB2291.namprd11.prod.outlook.com
 (2603:10b6:405:53::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 00:57:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 00:57:21 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 09/10] platform/x86/intel/ifs: add ABI documentation for IFS
Thread-Topic: [RFC 09/10] platform/x86/intel/ifs: add ABI documentation for
 IFS
Thread-Index: AQHYL2LN468NcesaH0OUFtbImBAY9A==
Date:   Fri, 4 Mar 2022 00:57:21 +0000
Message-ID: <803223bb89f083585508c98be81cd216a41a5311.camel@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
         <20220301195457.21152-10-jithu.joseph@intel.com>
In-Reply-To: <20220301195457.21152-10-jithu.joseph@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-3.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9d11dc8-fdc2-4d9f-e54f-08d9fd79f03c
x-ms-traffictypediagnostic: BN6PR1101MB2291:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR1101MB2291311B3A8684BE42CC72CCC6059@BN6PR1101MB2291.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwcudQbRniPOFm8YTnSbs/rc1KaqGs4b7floG7MoanlvLKy0uamVYZ0xWM90unvRaSyhHTtBl5v3fJBJzVB+ESTqDaaVXCbfYDg82X1iFkFi9BSmkT0yD9BpG4R1TNn6VgpwJXr3hq0nT9/eF6duIH41oi1eMtgN8uCCE1xN4wwYtPZ7o+gBHBSp571LuXM7Z/ZyVmXW9V5SlZ+YomsHpMWi4hbz3H1tUmjnQdxAXndLu9krydHB7H/GHFyUirPImnvymeGitc46bHLxwqZfm+6i+2S28n8gO4i2aBWbFvqCBn22dVRHG319yForTi7b5eWEsBNpI0yBZGaznb5/j/xUrw5sXM73lakVkjh+WmLorWekySeM5FbQ0Xwii9edoY0+q5aWBVxe1rZUtdVyFsnfq+TohLnx+X5T5e0CifQBLRpFB03ivGiGfpU0EPZ8lKwcMxNevWtQxY77TYfwmKHPt4HIWtylXvnC8nQfXt+S40uk5YECyZJyfB7zy0rU73y+VsINqgqYW31awd/ANunNonLXa/iwKFXyEz4Wpa4ku2DHFGtQ86AX/mh2Li9sgcIInbi5U1mKxJn6EF9k1Um/iu4CRoxLPZOM9I++yLZfasCKTJZgnPaW3/uSIVqdsIGZk1bVtwOtckSQH/iNBr4aByCETcS8rAb/pKqfUA3eHotBdQwatTBHV5nrj1ihoVkU2g2rbI22ScsPZ3Gb5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(8676002)(6486002)(6636002)(38070700005)(4326008)(38100700002)(54906003)(76116006)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(26005)(508600001)(186003)(83380400001)(7416002)(5660300002)(6512007)(110136005)(2616005)(6506007)(122000001)(82960400001)(2906002)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUNBekdwRWFQbHdFOWhGeXJmTVoycG81ZWYxZHY2L3o5M3U4dWMrY29aU3VQ?=
 =?utf-8?B?MWNOVW5nNlRLUDJ0YWNuRDc2YUJGUlRQK2VDaXNTN1ZBdzM5MmdhKzBtYjZV?=
 =?utf-8?B?ZzJHMHVvR2orR0w0SS9TZWxFZVFZWFp1MTZyUXZidEZEak5Id1RoREE1Mm8y?=
 =?utf-8?B?eE9nQWxHdW1JdEpJQ3VEMitaN01hN3hnUDJCZ0ttTVE1RktkcjNkZ1V5MVB5?=
 =?utf-8?B?VTFGb2FqUEF3NUgvQmhjZ1prMlVvM3VUUkNKYkFua1QvK1hiT0Fyd0VCSjRF?=
 =?utf-8?B?RDhXcU9QMHY1a3R1SEZwb2JHd2NJSmZjWm9TSDFLQnk4MkY1cnpoZC9MbDJu?=
 =?utf-8?B?a0ZOQlVHWlcwUEhDQUIvTkR1WUtuS2VQdXlTRUlDcWo3RWZZV0xvTEFBUWFa?=
 =?utf-8?B?UUZEQ1FBMFFqR0VtT0F4RGJnTU1UK1NBRVMyMjJYaG1wQlM3eko4UDdnVGx0?=
 =?utf-8?B?cFlma0V4VUZybEgvWWQ3VnFHeUJHK0w1ZEV1NnlPZWMrWVoxOExndUtaKzVK?=
 =?utf-8?B?ZDdRMkkwYzlMV29ZRnNVclVSQVRhQmlJYjF0MmdXMk5Fa0ozMkFmVjBGanBS?=
 =?utf-8?B?YjJnVG4xekZNVmNFSTE1NjV2TDlzci8xQ0ZRMm93MDNlTWtaNUh6dlp0NGVU?=
 =?utf-8?B?L0haODlzUi9XeEJTcmk4dkJ2M0JUWDNlc2w1YmhYTmh2ZHFkWDdGNGd6eGQ5?=
 =?utf-8?B?QUpHM2VWb0llVGRoUCswVnlaOThOZ2ljblFoWGFVaUVJcGM3T3ZpekJBQ3Ew?=
 =?utf-8?B?QWJ5TXl3VUt1M1FNWVEzWGs0cHJHQXo1ZmJPWjJ3OHNET0lMdmlUU1RxT2Fm?=
 =?utf-8?B?dVZCR0pJUmdsb1hObGVxemJ0R3h3SmJBQjAydjFaWXdXNFpxanZuTGNJVUJn?=
 =?utf-8?B?NTROK25vaThZR3R2YTZqR3BKN2JuU1dPQm9HOWMrYTlCVDVabVpEazZBSTYr?=
 =?utf-8?B?MlVzYWEvRHlZekNzWTNsWHhYSU9LYlBBWUxIaVBjT05jdzRsdTdsZjRuRURE?=
 =?utf-8?B?VVM2MkorOFRnRmdqRXRUTmhlNmRsRy9nZlBPWHEvaUc3UTZ6WjJpQTBTTGQr?=
 =?utf-8?B?NVVNeEF2SVNwS1hDbmpnT3c1NDcyNW1pamdyVVpDNkYwRHVVcVRBazk5K3RN?=
 =?utf-8?B?STdzRzFnajNKdVJYSXh1eEpXN1FSOWUzVzlXZWpxNER2Q0JMeURrbW5rYUhh?=
 =?utf-8?B?NFJlSU0wVW93RXVlQkp6dDlkRjM0K09Menp5RGExVjNCeG9IK3BOVkQ3YnZu?=
 =?utf-8?B?TzRYdktIODk0UHRHaXNuMTV3RlRzNUdwUFdncWxsd09xMHBNckhXVVV4eE1G?=
 =?utf-8?B?bUhNUEp2TjhIOVJzelhFc1NjTHB6WlRXVVZHVTdpVkFwWUNzbFJwRWI4cWpr?=
 =?utf-8?B?ZDh6K0xNN2JnbFNEZWdwQldFMHFmaTNaTjQ0ajJaSHBUaW03TlphMlhIelAx?=
 =?utf-8?B?UlNZaUgyTzcrOHg4cUtBM2xxQnVMaFBDZXhGSzBodFFCallXQm11eHA4UWs0?=
 =?utf-8?B?VW1XSG44YUtzcjk2UW5zQzJ5M2hoNHk5bjArTEluam9jcVJxTmZxS2Y1cy9Q?=
 =?utf-8?B?aUxPWlRGTUxJK0N2ZEY4Yk55ZXMxSHVOU01mY1ZCT1Q0dGNKZmJrckQrYkMw?=
 =?utf-8?B?VnAxMUpxV2lsVzVGTGxBdE5VRGhtMFhDZVZ2SmV2YzVqUWxrbUZNbFNJbmZZ?=
 =?utf-8?B?ZzkyRXhBdVdyMmVTVXE1QkZFaU16VnlJR0ZjV29PT1I1Tk03eXhCM05UQnl0?=
 =?utf-8?B?NDYzTFpkQjFqTTlrdW1rUkZWYjJMQm05QkwzK3VlS3g1ajNwN3U5ejYzVld5?=
 =?utf-8?B?YlJKSkZvck5PbXVmeDVzTzUvcTRGWkxCdGM4UElYbnB2V2VPczJMUG5QeE1C?=
 =?utf-8?B?OGlqSlViVXE5K0JJTjZFaTlGcjluNkdWSkhoaVhKRlFhZmFIUHF4dUtCMXEv?=
 =?utf-8?B?cm5WVmFxa3pmbVFFakdkR05uV0RwQ0dVWU5pRThxY0hJRTVkVmgybjZZNXRp?=
 =?utf-8?B?a0cwUHhUMmZsK1UvYlQvQzNTOExvTUtyLzZiU0R2V0kzZEJtb3pkb1BCUkVx?=
 =?utf-8?B?b3NNbHQwT1lvYmN6ZHlSRFBkZU1BVVBFOTZwTjBtVlpSbzk2NzRwUWwrOFFC?=
 =?utf-8?B?UGNtWG9qTmRJSzhoT3pWWEYxUjlyUHF2a2E2ZXk5MlUyYUJXd0NoUERaWmpX?=
 =?utf-8?B?NkZRN0NXN0huRlhzSGNCN0FDbElCbitJWGd2dGIxUzYwVDZzRkFkdGs3RHFm?=
 =?utf-8?Q?PqFb7Xl2mtsYEbvGiaoHBlyaoVglzPmWlWCNgt5Bww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDFB293376008E4ABFD0ED13B90A6935@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d11dc8-fdc2-4d9f-e54f-08d9fd79f03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 00:57:21.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDvXp/FDOXEmh5JbxUwNmz7Pa0Gr+YLRrE/OW8+B3G4pcCkG9FI853jEXBEeAR/U9v1EVW9gKWuHz6ZtwY9bTLTCW2V5Czsxxmu216OyUu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2291
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTAxIGF0IDExOjU0IC0wODAwLCBKaXRodSBKb3NlcGggd3JvdGU6Cj4g
QWRkIHRoZSBzeXNmcyBhdHRyaWJ1dGVzIGluIEFCSS9zdGFibGUgZm9yIEluLUZpZWxkIFNjYW4u
Cj4gCj4gT3JpZ2luYWxseS1ieTogS3l1bmcgTWluIFBhcmsgPGt5dW5nLm1pbi5wYXJrQGludGVs
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKaXRodSBKb3NlcGggPGppdGh1Lmpvc2VwaEBpbnRlbC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4KPiBSZXZp
ZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPgo+IC0tLQo+IMKgRG9jdW1l
bnRhdGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWRyaXZlci1pZnMgfCA4NSArKysrKysrKysrKysrKysr
KysrKysrKwoKSWYgeW91IGVuZCB1cCBrZWVwaW5nIHRoaXMgZnVuY3Rpb25hbGl0eSB1bmRlciAv
c3lzL2RldmljZS9zeXN0ZW0vY3B1CnRoZW4gSSB0aGluayB0aGlzIGRvY3VtZW50YXRpb24gYmVs
b25ncyBpbjoKCkRvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZGV2aWNlcy1zeXN0ZW0t
Y3B1CgouLi5vdGhlcndpc2UsIEkgdGhpbmsgaXQgaXMgYmV0dGVyIG9mZiBpbjoKCkRvY3VtZW50
YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZGV2aWNlcy1wbGF0Zm9ybS1pZnMKCgo+IMKgMSBmaWxl
IGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLWlmcwo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLWlmcyBiL0RvY3VtZW50YXRpb24vQUJJ
L3N0YWJsZS9zeXNmcy1kcml2ZXItaWZzCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjhiNmI5NDcyZjU3ZQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9Eb2N1bWVu
dGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLWlmcwo+IEBAIC0wLDAgKzEsODUgQEAKPiAr
V2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2lmcy9ydW5f
dGVzdAo+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgRmViIDI4LCAyMDIyCj4gK0tlcm5lbFZl
cnNpb246wqA1LjE4LjAKPiArQ29udGFjdDrCoMKgwqDCoMKgwqDCoGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcKPiArRGVzY3JpcHRpb246wqDCoMKgZWNobyAxIHRvIHRyaWdnZXIgaWZzIHRl
c3QgZm9yIGFsbCBvbmxpbmUgY29yZXMuCgpTb21ld2hlcmUgaW4gdGhpcyBmaWxlIGlzIHdvdWxk
IGJlIGdvb2QgdG8gcmVmZXJlbmNlIGJhY2sgdG8gdGhlIGNvcmUKZG9jdW1lbnRhdGlvbiwgYmVj
YXVzZSBpZiB0aGlzIGlzIHRoZSBmaXJzdCBwbGFjZSBzb21lYm9keSBsYW5kcywgdGhpcwpkZXNj
cmlwdGlvbiBpcyBub3QgdGhhdCB1c2VmdWwuCgo+ICsKPiArV2hhdDrCoMKgwqDCoMKgwqDCoMKg
wqDCoC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2lmcy9zdGF0dXMKPiArRGF0ZTrCoMKgwqDCoMKg
wqDCoMKgwqDCoEZlYiAyOCwgMjAyMgo+ICtLZXJuZWxWZXJzaW9uOsKgNS4xOC4wCj4gK0NvbnRh
Y3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gK0Rlc2NyaXB0
aW9uOsKgwqDCoEdsb2JhbCBzdGF0dXMuIFNob3dzIHRoZSBtb3N0IHNlcmlvdXMgc3RhdHVzIGFj
cm9zcwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhbGwgY29yZXMgKGZhaWwgPiB1
bnRlc3RlZCA+IHBhc3MpCgpSYXRoZXIgdGhhbiB0aGlzIGxvc3N5IGludGVyZmFjZSB5b3UgbWln
aHQgd2FudCB0byBlbWl0IHVldmVudHMgb24gdGVzdApjb21wbGV0aW9uIGFzIGEgd2F5IHRvIG5v
dGlmeSB0aGUgcmVzdWx0cy4gVGhhdCBjYW4gYWRkIHBhcmFtZXRlcnMgdG8KYW4gZW52aXJvbm1l
bnQgd2hlbiBjYWxsaW5nIGEgaGVscGVyIHRvIHByb2Nlc3MgdGhlIGV2ZW50LiBTZWUgaG93IE5W
TUUKdGFrZXMgYWR2YW50YWdlIG9mIHRoaXMgaW4gbnZtZV9hZW5fdWV2ZW50KCkgYW5kIG52bWVf
Y2xhc3NfdWV2ZW50KCkuCgo+ICsKPiArV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2lmcy9pbWFnZV92ZXJzaW9uCj4gK0RhdGU6wqDCoMKgwqDCoMKgwqDC
oMKgwqBGZWIgMjgsIDIwMjIKPiArS2VybmVsVmVyc2lvbjrCoDUuMTguMAo+ICtDb250YWN0OsKg
wqDCoMKgwqDCoMKgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+ICtEZXNjcmlwdGlvbjrC
oMKgwqBWZXJzaW9uIG9mIGxvYWRlZCBJRlMgYmluYXJ5IGltYWdlLgo+ICsKPiArV2hhdDrCoMKg
wqDCoMKgwqDCoMKgwqDCoC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2lmcy9yZWxvYWQKPiArRGF0
ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoEZlYiAyOCwgMjAyMgo+ICtLZXJuZWxWZXJzaW9uOsKgNS4x
OC4wCj4gK0NvbnRhY3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Cj4gK0Rlc2NyaXB0aW9uOsKgwqDCoGVjaG8gMSB0byByZWxvYWQgSUZTIGltYWdlLgo+ICsKPiAr
V2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2lmcy9jcHVf
cGFzc19saXN0Cj4gK0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBGZWIgMjgsIDIwMjIKPiArS2Vy
bmVsVmVyc2lvbjrCoDUuMTguMAo+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZwo+ICtEZXNjcmlwdGlvbjrCoMKgwqBMaXN0IG9mIGNwdXMgd2hpY2gg
cGFzc2VkIHRoZSBJRlMgdGVzdC4KCkZvcm1hdCBvZiB0aGlzIGZpZWxkPyBJcyBpdCBldmVuIG5l
Y2Vzc2FyeSBpZiB0aGUgdXNlciB0b29saW5nIGNhbiBqdXN0CmNhcHR1cmUgdGhlIHBlci1jb3Jl
IHVldmVudHMgYXNzb2NpYXRlZCB3aXRoIGEgdGVzdCBydW4/Cgo+ICsKPiArV2hhdDrCoMKgwqDC
oMKgwqDCoMKgwqDCoC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2lmcy9jcHVfZmFpbF9saXN0Cj4g
K0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBGZWIgMjgsIDIwMjIKPiArS2VybmVsVmVyc2lvbjrC
oDUuMTguMAo+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZwo+ICtEZXNjcmlwdGlvbjrCoMKgwqBMaXN0IG9mIGNwdXMgd2hpY2ggZmFpbGVkIHRoZSBJ
RlMgdGVzdC4KPiArCj4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2RldmljZXMvc3lz
dGVtL2NwdS9pZnMvY3B1X3VudGVzdGVkX2xpc3QKPiArRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDC
oEZlYiAyOCwgMjAyMgo+ICtLZXJuZWxWZXJzaW9uOsKgNS4xOC4wCj4gK0NvbnRhY3Q6wqDCoMKg
wqDCoMKgwqBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gK0Rlc2NyaXB0aW9uOsKgwqDC
oExpc3Qgb2YgY3B1cyB3aGljaCBjb3VsZCBub3QgYmUgdGVzdGVkLgo+ICsKPiArV2hhdDrCoMKg
wqDCoMKgwqDCoMKgwqDCoC9zeXMvbW9kdWxlL2ludGVsX2lmcy9wYXJhbWV0ZXJzL25vaW50Cj4g
K0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBGZWIgMjgsIDIwMjIKPiArS2VybmVsVmVyc2lvbjrC
oDUuMTguMAo+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZwo+ICtEZXNjcmlwdGlvbjrCoMKgwqBTQUYgdHVuYWJsZSBwYXJhbWV0ZXIgdGhhdCB1c2Vy
IGNhbiBtb2RpZnkgYmVmb3JlCgoiU0FGIiBpcyBuZXZlciBkZWZpbmVkLgoKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlIHNjYW4gcnVuIGlmIHRoZXkgd2lzaCB0byBvdmVycmlk
ZSBkZWZhdWx0IHZhbHVlLgo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgV2hl
biBzZXQsIHN5c3RlbSBpbnRlcnJ1cHRzIGFyZSBub3QgYWxsb3dlZCB0byBpbnRlcnJ1cHQgYW4g
SUZTLiBUaGUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdCBzdGF0ZSBm
b3IgdGhpcyBwYXJhbWV0ZXIgaXMgc2V0LgoKVXNlciBpbXBsaWNhdGlvbnMgb2YgdGhpcyBzZXR0
aW5nPyBMaWtlOgoKIk5vdGU6IHRoaXMgc2V0dGluZyBtYXkgY2F1c2VzIGFwcGxpY2F0aW9ucyB0
byBtaXNzIGxhdGVuY3kgLyBxdWFsaXR5Cm9mIHNlcnZpY2UgZGVhZGxpbmVzLCB1c2Ugd2l0aCBj
YXJlLiIKCgoKPiArCj4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL21vZHVsZS9pbnRl
bF9pZnMvcGFyYW1ldGVycy9yZXRyeQo+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgRmViIDI4
LCAyMDIyCj4gK0tlcm5lbFZlcnNpb246wqA1LjE4LjAKPiArQ29udGFjdDrCoMKgwqDCoMKgwqDC
oGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiArRGVzY3JpcHRpb246wqDCoMKgU0FGIHR1
bmFibGUgcGFyYW1ldGVyIHRoYXQgdXNlciBjYW4gbW9kaWZ5IGF0Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGxvYWQgdGltZSBpZiB0aGV5IHdpc2ggdG8gb3ZlcnJpZGUgZGVmYXVs
dCB2YWx1ZS4KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1heGltdW0gcmV0
cnkgY291bnRlciB3aGVuIHRoZSB0ZXN0IGlzIG5vdCBleGVjdXRlZCBkdWUgdG8gYW4KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXZlbnQgc3VjaCBhcyBpbnRlcnJ1cHQuIFRoZSBk
ZWZhdWx0IHZhbHVlIGlzIDUsIGl0IGNhbiBiZSBzZXQgdG8gYW55Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHZhbHVlIGZyb20gMSB0byAyMC4KCkp1c3Qgc2VlbXMgbGlrZSB0aGlz
IGlzIHNvbWV0aGluZyB0aGUgdGVzdCB0b29sIGNhbiB0cml2aWFsbHkgaGFuZGxlCml0c2VsZiB0
byBqdXN0IHJldHJ5IHRoZSB0ZXN0IGlmIGl0IHdhbnRzIHVwb24gYSBmYWlsdXJlLgoKPiArCj4g
K1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUjL2lm
cy9ydW5fdGVzdAo+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgRmViIDI4LCAyMDIyCj4gK0tl
cm5lbFZlcnNpb246wqA1LjE4LjAKPiArQ29udGFjdDrCoMKgwqDCoMKgwqDCoGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcKPiArRGVzY3JpcHRpb246wqDCoMKgSUZTIHRhcmdldCBjb3JlIHRl
c3RpbmcuIGVjaG8gMSB0byB0cmlnZ2VyIHNjYW4gdGVzdCBvbiBjcHUjLgoKQXMgbWVudGlvbmVk
IG9uIHRoZSBsYXN0IHBhdGNoLCBpZiBhIENQVSBtYXNrIHdhcyBhbiBpbnB1dCBwYXJhbWV0ZXIK
dGhlbiB0aGlzIHdvdWxkIG5vdCBuZWVkIHRvIGJlIGEgcGVyLUNQVSBmaWxlLgoKPiArCj4gK1do
YXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUjL2lmcy9z
dGF0dXMKPiArRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoEZlYiAyOCwgMjAyMgo+ICtLZXJuZWxW
ZXJzaW9uOsKgNS4xOC4wCj4gK0NvbnRhY3Q6wqDCoMKgwqDCoMKgwqBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnCj4gK0Rlc2NyaXB0aW9uOsKgwqDCoFRoZSBzdGF0dXMgb2YgSUZTIHRlc3Qg
b24gYSBzcGVjaWZpYyBjcHUjLiBJdCBjYW4gYmUgb25lIG9mICJwYXNzIiwgImZhaWwiCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9yICJ1bnRlc3RlZCIuCj4gKwo+ICtXaGF0OsKg
wqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1Iy9pZnMvZGV0YWls
cwo+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgRmViIDI4LCAyMDIyCj4gK0tlcm5lbFZlcnNp
b246wqA1LjE4LjAKPiArQ29udGFjdDrCoMKgwqDCoMKgwqDCoGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcKPiArRGVzY3JpcHRpb246wqDCoMKgVGhlIGRldGFpbHMgZmlsZSByZXBvcnRzIHRo
ZSBoZXggdmFsdWUgb2YgdGhlIFNDQU5fU1RBVFVTIE1TUi4gTm90ZSB0aGF0Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoZSBlcnJvcl9jb2RlIGZpZWxkIG1heSBjb250YWluIGRy
aXZlciBkZWZpbmVkIHNvZnR3YXJlIGNvZGUgbm90IGRlZmluZWQKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaW4gdGhlIEludGVsIFNETS4KCidzdGF0dXMnIGFuZCAnZGV0YWlscycg
Y291bGQgYmUgdWV2ZW50IG91dHB1dCB2YXJpYWJsZXMgcGVyIGNwdS4KCg==
