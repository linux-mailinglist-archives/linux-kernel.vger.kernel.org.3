Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A027527912
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiEOSYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiEOSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 14:24:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD432FFED
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652639045; x=1684175045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mtpg7qcPQwk+Mj993U56S4U/UHgKX8ZKCyIhaAmJGf8=;
  b=DaoQo4NdsivOywy0C9Ua9gumg0UGBVftHeGcOROZOWHP+S5cDtTxLoTY
   KZihogCQG08R09s8jgw/h6LIThvqYmrGX8y/6PfGavDH/Xz5TArnnx3s/
   c06zTlMqUG3qogRGbexVSc/H4K23JPYz/Ui4IL9XWCUcnZRX2KO6R+jtW
   nDKcHWD8/lIE6VjHiz6Go9RLLbabat1osQFCEh2FiXynKCfmXRxeFJmUw
   dmKUpnZ1sBjmsVSn5EDpDZ3PmSawi7H/VOUH3/f9IyblGIa4PSVTaCKTk
   n1aq6RqxsJc+XE5RIRmBkDVNioLiQVYPBhuWoD81FJ5pdPPz5yAX6+JSr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="357071188"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="357071188"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 11:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="604566445"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2022 11:24:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 15 May 2022 11:24:03 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 15 May 2022 11:24:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 15 May 2022 11:24:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 15 May 2022 11:24:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL/sKUUw+LFpWJl1CfEtUQ0FTgnMG9oH5xdj3FlbL6io8Tm4otmIMVbHVct6cCpxqJaFfCPbRgHWwZFWn3pyBLrgGEdRjIKSaW2snDaQ5SQ5S58p81qILsKmhUUou4UIDkIet7N3gbAOSjVFmgi/jLuMUD7C+A5W/fHk2ZzP5s+XBscrnfjdfzqCbn4SHg8ZgP2qmi8HxIsVET7GCG0mQpIhYotNro/ShbMyqL2CZyd9413387mIPUgButQil2ymHmCeD9Pos2kn3jmj8pv4/4HiKB7LHvtXIl/YJWWgE60vrXTpk6VourS4pZDWwVbSVWYQNrEQx/cJScCnri2KEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtpg7qcPQwk+Mj993U56S4U/UHgKX8ZKCyIhaAmJGf8=;
 b=UMjNxB7VzIbRpa0ZDvtDk7dWVAdKrCE4bmGNoCUM7GfUlkVU4+8ylpG2FCjQ0BFhseVxguEFCywomEFSWELN+uYIAta9oHppBv5u8bDixC/vYcFoHyAZTin7Bpssmv0Tqi3WjQK6HrKNYGbcdxV1f5BMAhVa8G6pJ8fckdWG/yqhcV3GyFSeD9hUEo7P0cX/JryHH2q9B2AAkgudNWOZAKWe3SWutg7/B3Gap4V1f47tzjRhqKu0hEA9sDC5FkhYl2cXpayA4rYXpO6x37kV0yyCheRa0WNZfpQYTd1IMhrB/xUdLhzf6dPyWB6Hz8HvLm1PWGGxZQtDwZlGIHZaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sun, 15 May
 2022 18:24:01 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.018; Sun, 15 May
 2022 18:24:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Topic: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Index: AQHYZOBkvB2PlILtfUOVczGp43rrrq0c3EGAgAA5TwCAAF3QAIAACzIAgACTWYCAAPLzAIAAplKAgACc9AA=
Date:   Sun, 15 May 2022 18:24:01 +0000
Message-ID: <95efb5ae85a96914fff3939d4924e46686196cc7.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
         <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
         <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
         <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
         <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
         <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
         <87k0aose62.ffs@tglx>
         <9e59305039f2c8077ee087313d1df5ff06028cfe.camel@intel.com>
         <87zgjjqico.ffs@tglx>
In-Reply-To: <87zgjjqico.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66532d9-511b-4854-359e-08da36a015b4
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY5PR11MB631816CBD83DF0810D0CE63EC9CC9@CY5PR11MB6318.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDH+Cy/Q+49SmIP5JV4g7IT/9h99e+HdLIGU9mpF3M640wxdXdcM0aY0zSvZknZoZW2qiupIT3I13qilKjyzJYndthQ81JO/tBtzJIssdo1sliIyl3LyaTTp4MckLiDZpMB96cgfmaDrMAT7lyCJXsbqrRYVMoJxAjCvegGBTIx/poDe+OFxqK09Jz71WW1VXv+Ew0gCbpoGZmnRkrUmGuicqSb+/Q+I9MKw1wEtNqWUdNnW5yaCnIgdQ+8GiEQfCe0oCa3GvSOrGWBeF4aGdhawLNyua98HluXxMw3eYOqVhNG6O+LSqBRce/c+fvEuuMMjhU4/bfVE7YW9hSLZgPuzk0MpmyclURW/KVWDATT0vXrRMX4NVm+gi0JSY4PtdTdvX4xjsytSVTnoKbyeddg90M8/r+uJSRP1yFMjWQke6AKzPFdyoG5AZ+Owd//ljrAGSkOcMNHFM71ODWIaWWrL6DsObGgBTUOO5jMD6S42nzXfVDkbXZtTg5Se4UiuOEzBll9nNOZcRzOIFHfjszCef3qwu7t6Q/2BjeqM/U5HsRX8vzG0Ry8BzjjnKNH8UrWMkvNHMyYHWge4uiW4+W60VcGzSpv4DJXq3lmoiQ/z3c53uF5wvY1qGd+iHKDuOpQSqPU0nGEhNg7m2+V5FsAtxmUxi1zPVCEFKQqexMBfxIKW4ZAwUhscCaYOSBj7y7dcAuw3pdXfzcYvP+rEMW4mPvcGb4Gn69DfqTWytyE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(83380400001)(8676002)(66446008)(76116006)(66556008)(64756008)(2906002)(6486002)(86362001)(508600001)(186003)(26005)(6512007)(91956017)(82960400001)(71200400001)(122000001)(66476007)(2616005)(7416002)(6506007)(38070700005)(316002)(36756003)(54906003)(8936002)(5660300002)(110136005)(66946007)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnRtb1ltUldEeTg2V255U2FtZDQ2Qmx2VFlOaVZSVHQrZnVjSTE0c3graFNt?=
 =?utf-8?B?azR1bmgwTDQvRm4xUHBmdDJTZjJ3MHRHN1NKL2ZwTDl5YkdlVG5ObDVZRmsx?=
 =?utf-8?B?SnpBK0JIeC84TjMwQXdpZDF5YWRheGNGdldjLzlGS0hkRmpEZHZlYnIxOGEx?=
 =?utf-8?B?dHp6UVRYQm9tcVAycUwzVDQ2RW1vOUVVb0c2OTk2NDJ0d2tUaGhleFdacCsx?=
 =?utf-8?B?QldQSkp2Z3hsTUFUSlM0bk1JMTJialZDSlpXSlE5dldzaUpSdkwyRU9KNnd6?=
 =?utf-8?B?NjJ4MUJzQS8yM3o1c2QwWWVKUTEwZUU4VmRaTHA2VGF4czJjaXIxdkFpY01F?=
 =?utf-8?B?Mml5QVB2anpXYlRxeFdTenZ1SWpYRy9Bb0NxbkRTNysrUXFtemRWOHFKK2tM?=
 =?utf-8?B?ZUNHV0hrc2VoSVFISmpTOTVPd0F2QlczenJIczI0YkV2TFhxS2RzRDF6bFAr?=
 =?utf-8?B?Ym8zQm9rd20rUVQ2a2xJQy95UHhNWjNZSW1EbkloMWY5S3A2b0psVGlDWm92?=
 =?utf-8?B?MDl6TC93VmVLa0VVL2tENEltTFRIdjlIcXVvY1hQb2JCc0dJWjFpVFFaN2Fk?=
 =?utf-8?B?WDRHRytTaWl1enNDandKSFp5eHlMUXVJaG51aEZidFNWR1Y1SGdOZ21XQXBa?=
 =?utf-8?B?SU9sd1RoY3BXUW55L1l0Ti9wYjJ2Mk8zRlREbVN5ZUFMYWJ4Qm5nSDZ1NUFr?=
 =?utf-8?B?Z1ZyM0MvSFJJNFhZSW1GcmFBdG5Ncm1sNVZvU2h2Uy82d2pzd2l0d0JUc1RD?=
 =?utf-8?B?WDh6SUxDcUI3dlo5VjZQc1pTaWd6S1JZR2JiS1FGZUV6c0FFc3dSVU0vZlA2?=
 =?utf-8?B?S1lsNGxhR1c0cVBXUHVTZXpFNmZyUlNweXZIUEx5aFFZVDJweTFvb1JZOUw1?=
 =?utf-8?B?K3VvVktpSytJY2sxQXllWCtrMnh4SU91anFmQm1EVkg1VzN4MWNuYUtnUHl1?=
 =?utf-8?B?a3V6cVpRVnlDbkNkRWdkUzQva2ZDdUtKa1YwYzRvckhjVEt5L0t2Qm5pNEpX?=
 =?utf-8?B?TUJaZStjdUhvZFpmOWhsS3ZlU3RVd1M3cXBpZU9ZRHlDdkloQUFDa1crdjN0?=
 =?utf-8?B?bFpRVDhXLzlXa214NGFMS1Vtb29DTEZFU1p2U0tEdXdzTHdDa2RtOUZLUUtB?=
 =?utf-8?B?aFpWRUhaRU0rNjF5WDRlcXE4UWVKSmhXNkFLWUtDc1Y5YmV4ZHhHekdPSCtw?=
 =?utf-8?B?cmNKOSs5KzBIeFZTRThXL2R3ejMxeXRYTzNSWEp1N1E3ZVJETy9RQ3pGQVds?=
 =?utf-8?B?ZkhZVWJVaE45a0NDem82dzVXc1dXeWQ0dEc1YjRBMytoVGdRL213V01mRVFD?=
 =?utf-8?B?ZnFpRURCU0xlMWE3ODE4OTFlYjBnVWJqa2dzWG0zOCtrUWFJVHBaUUtrVTBa?=
 =?utf-8?B?aXRLL2Z6VGVpRWVFeVdnMEk0UmxCUnBmRlVLVGxOMjAyQUpubTVVMVdUL3Fn?=
 =?utf-8?B?M3BUamltRysvdlQ4ZUs4Zm50RW16eHB4bEFndzIwT3UzelZXQTU0RHVoYkVO?=
 =?utf-8?B?OGZ1N1pyRE8vY3QzdzNnVVE5c3VnUWtmQWZYKzJ4c0ZIKzVWMDRsQlUzb2I1?=
 =?utf-8?B?WTBZSmdJdHgxOFlPa0JPV3dNMDZyMTBQeTE5OEVuQWJsYU5vNlhEZ2tYUlV2?=
 =?utf-8?B?bHk1OEQ3eVBUTkpRd3ppV2Z6ZWgyS3FjdkloRnoraGZ2bFZzK1M4K2EweW5R?=
 =?utf-8?B?MmhvNUhPamQ5YVpWZVdSOHJ1azhMWllLaW5WaUMrMGdONHhDWEJsdnJpam1J?=
 =?utf-8?B?S2JNRUV1dkV2RE9TZVJ5QzB0WmFIZUtjZHg4eVpRVDQzNnJEeWdHclRFRFFW?=
 =?utf-8?B?YWVvYnFMa05ZNVFZYzJpbkhQL041bjJBNy96Y3RXVEZLRW5WZHB2NDhLM2lm?=
 =?utf-8?B?TWkrdzlnaWQxbkswT3c3SC9MZzZYYS9yQzlRdkNoK3VWS3pUemFNemRVWGJm?=
 =?utf-8?B?WjNTVG1rNWpWRVZtc0VhWmZOQlU5OUdoeUExTmwwU0VNU0s0Z2hnYUpuSk5H?=
 =?utf-8?B?OHdtbXJnbjlucVdLeFpvWEdJYTV3ZjFaYlJsNmVqMC8vM1phekRBWHBEaW4r?=
 =?utf-8?B?V0lMUWdpQTVRaUNLaXo5ZG11Ly80aXZWc1RWZjk4Nmo1blo4ZVl2TnBRNEdm?=
 =?utf-8?B?Zk54ZlJmamlEUEkrSU9DU1hKbjlkUTB6dS9pUVQ5ZUhqSlh1aU1EcG9TdVpl?=
 =?utf-8?B?N0xIZzBoUTZjMzk3QjN6aVlmU3pkcC9rVVVkaEQyMkFMMXdIOE4vc01vUENF?=
 =?utf-8?B?UFQ5T1pXSUx0SEt3OWcybjV0QjNFa2JQM0E1MjBWQ05TQWJZNWd2VmxnVUJB?=
 =?utf-8?B?SzEwaGNVOU1zREgyaHo3VkZDdVZBbUdQUXpDWHN4L2sxbHpibGg5M3ZtMkdN?=
 =?utf-8?Q?LUiYoHWcBokp9jPD/8ggB1p+wADjuzfkl45o1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9CA2A1F5A705F4EBE5145548478821D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66532d9-511b-4854-359e-08da36a015b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2022 18:24:01.2833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VvKwJS51pqS+Ms7lPcm8I9JFBxTZWKnMmGu2xl2IF3wjHVVtkl6w3ZzF99CwWvPWyXP5plOOvbCibJyNJVoq9IwFvSDdrdUi+nNqvToDQso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTA1LTE1IGF0IDExOjAyICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+ID4gT3RoZXJ3aXNlLCB0aGUgb3B0aW9uIHRoYXQgdXNlZCB0byBiZSB1c2VkIGhlcmUgd2Fz
IGEgInN0YXR1cyINCj4gPiBhcmNoX3ByY3RsKCksIHdoaWNoIHdhcyBjYWxsZWQgc2VwYXJhdGVs
eSB0byBmaW5kIG91dCB3aGF0IGFjdHVhbGx5DQo+ID4gZ290DQo+ID4gZW5hYmxlZCBhZnRlciBh
biAiZW5hYmxlIiBjYWxsLiBUaGF0IGZpdCB3aXRoIHRoZSBHRVQvU0VUIHNlbWFudGljcw0KPiA+
IGFscmVhZHkgaW4gcGxhY2UuDQo+ID4gDQo+ID4gSSBndWVzcyB3ZSBjb3VsZCBhbHNvIGdldCBy
aWQgb2YgdGhlIGJhdGNoIGVuYWJsaW5nIGlkZWEsIGFuZCBqdXN0DQo+ID4gaGF2ZQ0KPiA+IG9u
ZSAiZW5hYmxlIiBjYWxsIHBlciBmZWF0dXJlIHRvby4gQnV0IHRoZW4gaXQgaXMgc3lzY2FsbCBo
ZWF2eS4NCj4gDQo+IFRoaXMgaXMgbm90IGEgcnVudGltZSBob3RwYXRoIHByb2JsZW0uIFRob3Nl
IHByY3RscygpIGhhcHBlbiBvbmNlDQo+IHdoZW4NCj4gdGhlIHByb2Nlc3Mgc3RhcnRzLCBzbyBo
YXZpbmcgdGhyZWUgd2hpY2ggYXJlIGRlc2lnbmVkIGZvciB0aGUNCj4gaW5kaXZpZHVhbCBwdXJw
b3NlIGluc3RlYWQgb2Ygb25lIGlsbCBkZWZpbmVkIGlzIGRlZmluaXRlbHkgdGhlDQo+IGJldHRl
cg0KPiBjaG9pY2UuDQo+IA0KPiBQcmVtYXR1cmUgb3B0aW1pemF0aW9uIGlzIG5ldmVyIGEgZ29v
ZCBpZGVhLiBLZWVwIGl0IHNpbXBsZSBpcyB0aGUNCj4gcmlnaHQNCj4gc3RhcnRpbmcgcG9pbnQu
DQo+IA0KPiBJZiBpdCByZWFsbHkgdHVybnMgb3V0IHRvIGJlIHNvbWV0aGluZyB3aGljaCBtYXR0
ZXJzLCB0aGVuIHlvdSBjYW4NCj4gcHJvdmlkZSBhIGJhdGNoIGludGVyZmFjZSBsYXRlciBvbiBp
ZiBpdCBtYWtlcyBzZW5zZSB0byBkbyBzbywgYnV0DQo+IHNlZQ0KPiBhYm92ZS4NCg0KVGhhbmtz
LCBzb3VuZHMgZ29vZCB0byBtZS4NCg0KS2lyaWxsLCBzbyBJIGd1ZXNzIHdlIGNhbiBqdXN0IGNo
YW5nZSBBUkNIX1RIUkVBRF9GRUFUVVJFX0VOQUJMRS8NCkFSQ0hfVEhSRUFEX0ZFQVRVUkVfRElT
QUJMRSB0byByZXR1cm4gRUlOVkFMIGlmIG1vcmUgdGhhbiBvbmUgYml0IGlzDQpzZXQuIEl0IHJl
dHVybnMgMCBvbiBzdWNjZXNzIGFuZCB3aGF0ZXZlciBlcnJvciBjb2RlIG9uIGZhaWx1cmUuDQpV
c2Vyc3BhY2UgY2FuIGRvIHdoYXRldmVyIHJvbGxiYWNrIGxvZ2ljIGl0IHdhbnRzLiBXaGF0IGRv
IHlvdSB0aGluaz8NCg0K
