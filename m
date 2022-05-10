Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB83520A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiEJAvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiEJAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:51:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC032670A5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652143635; x=1683679635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tqsVoEJJ+Zu6mF0qe58ZixbLthASlVW6n6kOyCVigjM=;
  b=Zaf/rDQExT2wxQJyo0tuFifKMrBCMsgMBPwgbtgWmJxQrTq9jIEszbYO
   jJrOvqW0UAmIXmQKz3e6MS86Z4sx2/+44rLVmzMITzg9/CoDsu1kjJ916
   ndldgUELJlrbkJXFXAPowd1zyRqjOnl/kh0mvoaPoywmFEpYM4R/uEe8M
   9SrUCb9K+hLTGbGjzTXtK9ofIE4n3C0ysoM3y/q1pnJNvLAcLFPOLP4zv
   pUmG/7rAEe3I12kmjOnwRHnKy8SE4cJxcBtn8mo3Ce3D4Yhm2gf0Ltc87
   u+l9pciBIlJXusmw7HAmkRLvqFOsmX+ckSU4deRP0WyZdycG3nsDBtVdV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251260262"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="251260262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="669610271"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2022 17:47:14 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 17:47:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 17:47:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 9 May 2022 17:47:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 9 May 2022 17:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOtxIQShBrXZC5i1Qw3jFCCsDQPQRdi5+5jjxRz/TVnfGlrXeAzdPsxV55KeWmeTcYPZUUNMTfrEwDgQag/rETva1wnCz1sHm9cql/6K/dDV3xqo9K/1x3QmSBWZ9D0i4wrkFMNfZUFpWm5oy+B3ckhSk0qgptXHxW18cVWhkeUeYlpbGAwKHi2TMKh5iynT17a40v6gpgbkLKV0L+we5b7WYUCZq9+wietcB7orvhUiJeFRkU691cuR812Y60qugawdJE5PKPy9VEnmd6TQcKRpCsJgoSMIkhQIiD+ewMhjuwetD2bH5YevBJvDeU2yWctym1RP/+1AzHyCRI2P7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqsVoEJJ+Zu6mF0qe58ZixbLthASlVW6n6kOyCVigjM=;
 b=ONWfUzyfijIkVkV7B/GKbnH2BZgiXqszqNHYuu8ERNkd94F565+1VxY/L7rkITqSqPsRdGZ60fO1ZyMkQoTnICDqwuu5dtKchzhMgwxhkHFX7+8Ck8KjVhkSqnquwJZMeEwv+bvC6yO2BbUSQKUFkXU1qn0yXl96VWO4+gwOoWbZSc9yctccSaQYGu6ZooBg/UiK8HRg8FIqjnU6eHSXCo61nY2W+iSSJUkkTj/jCmtcVD4otSfSF6MKivpKzgnTeRMRT4oxUYQ5tty2Gagx1qf4QgIROSeIQZBAk/sGlouCftoznkEJUjkSTk5RGf8XqYu9J/opBBEqVtJIX0eZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5599.namprd11.prod.outlook.com (2603:10b6:a03:3af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 00:47:12 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5227.023; Tue, 10 May
 2022 00:47:12 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Thread-Topic: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Thread-Index: AQHYYQlUbv+/dni+y0+PmXXltVqJaq0XTOMA
Date:   Tue, 10 May 2022 00:47:11 +0000
Message-ID: <2cd129af8d66fc4bffcb124a3675bffbf1becd85.camel@intel.com>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
In-Reply-To: <20220506051940.156952-1-42.hyeyoo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2a3e58d-0a0d-4a54-3480-08da321e9eb7
x-ms-traffictypediagnostic: SJ0PR11MB5599:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB5599C7391C8BFC6BF7E778C1C9C99@SJ0PR11MB5599.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DgTpl0JACGPkziFIdYTUP+bl/iElL20IjfZ+2jlkw9ulfcPUIZzsTcbtnT3eCiy7tFetaCbr1O8rpuUwAjAmpMt+HowfdgP2vhKtKnE01ViKInTvx6NzUNExCnofkBODnkfyz6qWLZquHdgieC+GOiuulPhSVkrAfzQwFhhIrdxPKBBZKLH5dGjGF6D8bTEV/Bueu10ixmQG7P+Td/VattoNmwslXfWkYX0T/65pggSGoDcwf7uazNfXns/2UK+jwlT4OVq2AawKFVKuEWNkPzuhps0PRCwJs7DjQvZTm+sVyFiuGuCa6gY8tq7d3exnCAlwaqjZRTO3Ldq8tQz/AQ7G7uKci/DStf6ypckmdv+Ji6bPh2fdjjCsNpueBl3h0+jsxiTvGQ/zRSG2yp1Jti4AP7wld4njqQqOu7gnzj54jU0Yw4kXKuZUBHnSg/9RtSWjAAYYhAIJHT3EQv5r1FzINcHtvCY5VU+7cyHQ6Rf9xqXYlPrSnOnUkyyVIPnPsvh1lEzpYjbrBb4Jhn6JMNuhsnv7AdninzIEGgkVpQ3T7s19eSrYWniPdFxR+cIh8xBdIjzt/hol1yZXmjh5YIhzvbr1VmWFwVag9idhJ37cdSj6MXvPcjdAas6l1oQ84rhe9gmiq/AaVG7EElsTlIhYYwswS3OfCNTLjl5T4bgpVoO6Nmv1w1MDpG9hsATiwZEhWV2bweQAFmV3JcdZ+NRDO4inrSSHa0DGD2aQJvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(38100700002)(38070700005)(71200400001)(76116006)(5660300002)(8676002)(66556008)(66476007)(64756008)(66446008)(91956017)(122000001)(508600001)(8936002)(54906003)(6486002)(82960400001)(7416002)(66946007)(36756003)(4326008)(186003)(86362001)(83380400001)(6512007)(2616005)(26005)(316002)(6916009)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGVNaGwxa3pyTGhDdHNyUmEzQXJEQkpZYmVvMy9EamhiQXNOaHBPRENTS2gr?=
 =?utf-8?B?cm1ZRGVXQkRXZVI1V0xHRldmcVNHM2NpVEtMUE1sM3R6SGRWZEZZY3lWKzBp?=
 =?utf-8?B?aXBycWpWaWhvV1dhZlpLdmYyM2VqUWdrQ09oQXI1M1BWdlJXWVQ5RnJ3a01a?=
 =?utf-8?B?c3FWS0VTT0QyMVhWbS9WRW5tbllnZ0hjZW9oQ2RBMmp1cTRTdVhMbU9yWG5F?=
 =?utf-8?B?dVFkVnhRQXlKRlVhYjJ5c0phK1hWWnVvUmNiTzhPNzhPeklkMHZXcXFwL0hv?=
 =?utf-8?B?TkxVV0hvbUVuR3pTa0djUFFXUTFJMFdlQ05qclcvVmRYUlh5WXV3Y0NNSk90?=
 =?utf-8?B?QWM0bnhrODN1cTB4UjdlTTdXVE11MlRlYnhEV2VXTE03MkZONkV1azZNOTJy?=
 =?utf-8?B?Mm5jZTRhaXF1bGQ5T0Y1VWYzME91SVFjUUVqcXE0b3F2TXVacVFsbVZxc3Ja?=
 =?utf-8?B?S21zak8xeTlETmIyL1FVakozbnZvWS96dVp0TTRkRjY1cjZmVmRDa1RjVWxO?=
 =?utf-8?B?T3BCeGFxaDBkOUVWNkZFY3pTeGF4Umg4N1JxeVdRL0RtVGRuYlU5aHFtNFA2?=
 =?utf-8?B?RnB2Z0VRclo0bGtCUDN0cEVNM2hocmoxU3dYaDJpSGtoZHZrcnk0K2R0SERh?=
 =?utf-8?B?cEpCbEN1MEgyNWtmb0FBOGtqY2xFNXl3RzFFWk0zZWJDbUVHcURnNFZYT1FK?=
 =?utf-8?B?czRXbERQcEdiTng3cVZaMlgyUTR5V3dJZjdqb00zRTRablNGdkEwdUdXVUpV?=
 =?utf-8?B?bVZjWkZsb05xblpFbWw3TmgxYUFadFdnbUt3LzdmUXpHRFoyRndJTkF6NExC?=
 =?utf-8?B?NVhQdm5TVzVic3ZWU2dXZWxmVjZ4bmhlTjIrd2lNckxqV051STNPbWs4SS85?=
 =?utf-8?B?akZiMUMybms4T1pFb3hPbXk3TlVvVFBUbG9vSjM4Y0Jqd01Fa0hTeG9QS1JX?=
 =?utf-8?B?d0VWZ1hKckJtc3NXanovWG1LUmVKTlI2UFVCWU1iVFhPblR2ZUYxV2RJSjB0?=
 =?utf-8?B?bG5LeE1qVjdIaVdFZFoycmhaaWtEUEhKYjhCbXhlWWlhQlF5YWUyaE5sdXN2?=
 =?utf-8?B?TitzckdsRnZ5VlBrMllNMzJ6b3c0WFZOQnp4WWNIRWNzZ3VwY1RZd1JHKzFI?=
 =?utf-8?B?dXRHKzliM283Uk5kc2IyWjJBQkgyQXJDT1RUZE1EeWdQTEJTQ2xYeXcxNnJD?=
 =?utf-8?B?QWlyclNZQ3dzdVlIRDFOTG9Wc05LMWhYdWdzcGZBQXAyS1ZPUXBMS3RxcTlL?=
 =?utf-8?B?QlhROVB0VmZRWk5OakdzRGNpanlVTjlaNVpWMTFITGtEeDVoMkR1ZERKZkVs?=
 =?utf-8?B?aWVFWTRFdGN4eTN5alRrbFVnT2VvWjYxZmZiV240SlFzNkYwQWpBb2JQL3o5?=
 =?utf-8?B?YVBuUHhuQUlGR1gvUnkzYk9LRE1iM2N4RjlhQ1RNc1pEbDdVM3JxSTBobld4?=
 =?utf-8?B?VzFuOWNoT3ozRlZrU1dUbVUvTEYwV05NYnRGWlBFbUU4R041S0lXVWpLQ3VJ?=
 =?utf-8?B?OVJLMUpERUpwQlErbFh2dURoZmk5OVJXckVRT2k2U1FoNjcrUExxWG80VDZv?=
 =?utf-8?B?THpZMUFYdjNMMkRHSzJiTXF3dWIwelE4Y0Era0J5MldWajlmZ3B6UEp3Wk5s?=
 =?utf-8?B?S2NiblVPTnpKV3hnNVJaY1c4SHRCMms4dHNPb21rQU1ENUVHMFRRUTJjNHZo?=
 =?utf-8?B?Q25PeDRaRkNqS3R3TkV1VnFUQTRValVET0dhT0ljUHFYLzdnS1d3a2hLak5I?=
 =?utf-8?B?OFZyUlNUWVRGUjlVbVVJc0VWalJ0WFA3bFEwZnFmcGZ6YnI1dlRpTFVhOVNY?=
 =?utf-8?B?cEJVSzJMaENRYlIva2dmaXhuRm9XRHFTa1hUdHNVV0ZyUTRWSG1VYUhLc3ZG?=
 =?utf-8?B?cTF3YXNwK3A4Sm5oekEraUhBbXl3aWxBRUVZdFdaVzhROGhhMnNKUFhqTGZI?=
 =?utf-8?B?L2t1RFB6KzhVQTRpcEgxZjM0M2pNaWVpcVVwTUY1V1RraFMxN0JYMndMRGli?=
 =?utf-8?B?dDB2RkFia1ozMG1UbHQxU2lCM2pOdEtXc2ZOQnAvclJJaG80OUxwdUdRbEhw?=
 =?utf-8?B?M1d1cW41VDlnRmdxZ3JQOGhYVGV3QVhtZGh6cWV5eDE5aTlvSkVSMGlrNDNa?=
 =?utf-8?B?ZHZVOENkOTFOcnArREZWYzJ3VHh6UEdtRzgxdU1ueUZmV0cyWHp0c3E4dTM5?=
 =?utf-8?B?RGFzdVRHN3VJa2hUSWErcEVkRXRKcnR2MlRqUmxsUkFxREJLemJSeVNLdTRn?=
 =?utf-8?B?bW00a1BHWDVvYzhzWm5QV2tWbVFjejdzdnpyTGkzRjJjem5yK05VZVVnZ0ts?=
 =?utf-8?B?NUxMUEJKSFdpVWZoQkI1UzFBUW9OeVZuTzdra2phZW1vZTIydDA1WWZoNjUy?=
 =?utf-8?Q?xUnIEq+HchPEQMcP/xBvmO9rfaC0pqGqqWkXv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC81CD22E3983E4C8EC5AF73AFD6DB62@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a3e58d-0a0d-4a54-3480-08da321e9eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 00:47:11.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoCcUKs+mtN8DBhVssO/l2M+v5um5638++JlO4lTh60JHJNj7YYLgKni4tFfcY4LoN6KwG0AUVCknn/EsjY27ykIaXc20jPlR+3JMQtCMHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5599
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTA2IGF0IDE0OjE5ICswOTAwLCBIeWVvbmdnb24gWW9vIHdyb3RlOg0K
PiBfX3NldF9wYWdlc19ucCgpIG5vdCBvbmx5IGNsZWFycyBfUEFHRV9QUkVTRU5UIGFuZCBfUEFH
RV9SVywgYnV0IGFsc28NCj4gY2xlYXJzIF9QQUdFX0dMT0JBTCB0byBhdm9pZCBjb25mdXNpbmcg
X1BBR0VfR0xPQkFMIGFzIF9QQUdFX1BST1ROT05FDQo+IHdoZW4gdGhlIFBURSBpcyBub3QgcHJl
c2VudC4NCj4gDQo+IENvbW1vbiB1c2FnZSBmb3IgX19zZXRfcGFnZXNfcCgpIGlzIHRvIGNhbGwg
aXQgYWZ0ZXINCj4gX19zZXRfcGFnZXNfbnAoKS4NCj4gVGhlcmVmb3JlIGNhbGxpbmcgX19zZXRf
cGFnZXNfcCgpIGFmdGVyIF9fc2V0X3BhZ2VzX25wKCkgY2xlYXJzDQo+IF9QQUdFX0dMT0JBTCwg
bWFraW5nIGl0IHVuYWJsZSB0byBnbG9iYWxseSBzaGFyZWQgaW4gVExCLg0KPiANCj4gQXMgdGhl
eSBhcmUgY2FsbGVkIGJ5IHNldF9kaXJlY3RfbWFwX3tpbnZhbGlkLGRlZmF1bHR9X25vZmx1c2go
KSwNCj4gcGFnZXMgaW4gZGlyZWN0IG1hcCBjYW5ub3QgYmUgZ2xvYmFsbHkgc2hhcmVkIGluIFRM
QiBhZnRlciBiZWluZyB1c2VkDQo+IGJ5DQo+IHZtYWxsb2MsIHNlY3JldG1lbSwgYW5kIGhpYmVy
bmF0aW9uLg0KPiANCj4gU28gc2V0IFBBR0VfS0VSTkVMIGlzbnRlYWQgb2YgX19wZ3Byb3QoX1BB
R0VfUFJFU0VOVCB8IF9QQUdFX1JXKSBpbg0KPiBfX3NldF9wYWdlc19wKCkuDQoNCk5pY2UgZmlu
ZC4gSSB0aGluayB3ZSBjYW4ndCBhbHdheXMgc2V0IFBBR0VfS0VSTkVMIGFsc28gYmVjYXVzZSBv
ZiB0aGUNClBUSSBjb2RlLiBJdCBzb21ldGltZXMgd2FudHMgdGhlIGRpcmVjdCBtYXAgdG8gYmUg
bm9uIGdsb2JhbC4NCg0KTWF5YmUgc29tZXRoaW5nIGxpa2UgdGhpcz8NCihfUEFHRV9QUkVTRU5U
IHwgX1BBR0VfUlcgfCBfUEFHRV9HTE9CQUwpICYgX19kZWZhdWx0X2tlcm5lbF9wdGVfbWFzaw0K
DQpUaGF0IHdvdWxkIGFkZCBiYWNrIGluIGEgbGl0dGxlIG9mIHRoZSAiZGVmYXVsdCBnbG9iYWwi
IGJlaGF2aW9yIHRoYXQNCndhcyByZW1vdmVkIGluIGQxNDQwYjIsIGJ1dCBJIHRoaW5rIGl0IHNo
b3VsZCBiZSBvayBiZWNhdXNlIGl0IGlzDQpsaW1pdGVkIHRvIHRoZSBkaXJlY3QgbWFwLiBPdGhl
cndpc2UsIEkgd29uZGVyIGlmIHRoZSBleGlzdGluZyBnbG9iYWwNCmNsZWFyaW5nIGxvZ2ljIGlz
IHJlYWxseSBuZWVkZWQuDQo=
