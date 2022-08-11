Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7247258FA6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiHKKId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKKI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:08:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED728F95F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660212508; x=1691748508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i6BgU/nLZAo12eQ64a0o7ZQzftqjJa4VLdecoeNLx5c=;
  b=dW6gf+KEC1UG2qBzHu4a3g0+kWhEJo2RHlZcr0cXTTgI6Y619psaVkSy
   g4OzQc2jn9m76nhE7bBFc2LeCu8Iz4tK9RUl1kWcXxijd1TqzvBCQcACC
   LRwBs4VFgVeT1RuWRdyBo4ejdFnt63cdAl35sEhCyqVfJyniOCJiip/+l
   H9NVo9L1GZib8g9A3dC9ZACNbSlNekeBDlalBbarxPIVXF2woEfWGscJa
   VTORFICJhL0Si5qZ5KqSp/h3jdYNKRvKGr5Ssf90ItANLH3gjkRBsyCHk
   I6CKrmYgB3B1EAT5eVRkctlzp0zgiF7SpySbdXqrBEExmKrcdPG//jb1W
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271695819"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271695819"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 03:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="556073095"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2022 03:08:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 03:08:26 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 03:08:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 03:08:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 03:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuurfLVhj8hAZQC6Sy4QN8JgqfPmkk+glxCupkT06/9Cn2ZBzA8uTworDEG+umOBQRjO4NRToP2zbGPktDRCzU0Kas8rwr8SqnkvZUQOsUUtqXiCsiHQoLi0FTMX4AJS9tTf9LeYeD2BtAIuWalqWH1NkJL6l31V1XTalLtn+cbN04k/W2BFwalJWIq5gLe+0AT2fQz3Py9SPNxa/i2UPEm9KmSGh8aH4kB2DCRSSJXWJD7QqosEYDw1Y7u3OQisrp85vB7AaIXDigU9h5DYRMYq8/3vteyaIIs0gfciBlssKdHB0vzp6UZuVPCorS7mWLwQktWt9HjbHqgKW2FCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6BgU/nLZAo12eQ64a0o7ZQzftqjJa4VLdecoeNLx5c=;
 b=TiRVtwTZ95u2ieB1rtRqNmMw/KygE4lR5Tq0aPtO6+IC5fV6b24MT4WWhVLMxSl+so/TFrZf0jEFEZjjp6Hh9rF/8fGsQ8NjkZhJPOJrfnIlED6oVeQo5mXkL/x4Xwkdv3r1IiYu8KrrXLXvrbYk7MhMaNo2F3t6MKnzoXZHrqVNBqfMpmGMaHZGKEFI5wr4TGvlF/Kce8xS79OiX/QS2cHynHigJDQ2YQf8ZIhRVxYQNqtAbAwcBS5e33EwK6C4wjNiSVTMp3ZBwJWzKmvyZ4AZlWozPR59hR6+SxmrbqVl2d/TDAmDh6Jvl2X4zwRmMnvPXpbGw4kMQRK5AZcREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN6PR11MB2736.namprd11.prod.outlook.com (2603:10b6:805:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 11 Aug
 2022 10:08:23 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee%4]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 10:08:23 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Thread-Topic: [PATCH] x86/apic: Don't disable x2APIC if locked
Thread-Index: AQHYrElrtTvS9DTMZUu9twTFYg+jeq2obduAgAAIB4CAAAZPAIAADV2AgAAoqgCAABAYAIAAAXkAgAAIXoCAAAF+AIAABOqAgAAKQgCAAAXCAIAAmW0A
Date:   Thu, 11 Aug 2022 10:08:22 +0000
Message-ID: <5aff93ec9cbd0cef1a75b265eddd889897b84bc6.camel@intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
         <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
         <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
         <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
         <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
         <87r11nu52l.ffs@tglx>
         <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
         <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
         <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
         <9888a920-37b8-9a1f-b887-6630492955c6@intel.com>
         <1d81ef6a-7505-fc13-ecbf-f3ca7a6fbfce@linux.intel.com>
         <87lervty0h.ffs@tglx>
         <b6da06e8-6d79-4dd6-4a98-fbbc8b990d54@linux.intel.com>
In-Reply-To: <b6da06e8-6d79-4dd6-4a98-fbbc8b990d54@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57265cc9-ce01-4168-11aa-08da7b816ca6
x-ms-traffictypediagnostic: SN6PR11MB2736:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHUwwpu4bbu50yd5LyVnZ11cR2Wt8WyQCLSYvGNWI4AUBUjz4RG9+yXzhWmmnD1QKwTOP1SfuTi5q5tPH5CHhIhbvqvFC/rLgGRXeiNa0btwiI3eePAlyN0Syxcn9l29/3tPTt3LOcS3xnZQeBzaGUB42+zf3l+tipZdwJxOETj87oInHxpyyec2dDhkUSqP31bLHUMp0dScgcrrP5OnamUc4++++ir7JuoH9FTMY7UDjKbrI98wU0cwLUYgNPEfmV9S2kd+7LbtH5ecpisrvJ05EhzU4I2oppAvEHajkPyuvqyaRfYu025HpCHjPKcmb6903dByq9QKWr5u5L8d4ymf5uaS57ipBROymNBbovwpCzh5veKnSaItvIPWMhJiPishCUwcTgXeBo5Abk7IinBcUAGB3T+FJIhU1wg2Tj9jRqbm0iBFurvO0e+4DDhd5nnJF1OYXQvJ+pdq7RB4fmF9q70Byf/bRhxYNE5ruEqwTre8aoOXwJyhsaCaVmgFxRwcUpz3+/gyaoNxs9dhyuxxxmRHyzdKfxJjZxpVbI/Yt7aWVB8kNPl3hpFuwzgz1WW6jxkIo6oqfzyUvEqjq/hb/kjj9zT1tAMo79VpNataySwz6MHb5elubqCb6AujZ0d9PeNzBbXHc+Amxo3HIMjlDhYnvW3iI7g2r+EDSVGD1L2HaNuKJbF8XEMJP/Lhwx6zKiOVW75g9P7DEk0dq5tDoAQKTb++9VnIov/bacnbK4Eb5RNLYHaivTquVmd/BYAoSkJc4VRIZA0C9wi99GXiKYZXyia/f0/COuUiARcewNlM4hNDCxXUTzUSC73/ZW+ULsTJgkUf5A2GAnkckw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(376002)(366004)(82960400001)(6506007)(41300700001)(38100700002)(86362001)(6512007)(53546011)(921005)(26005)(83380400001)(38070700005)(122000001)(2616005)(186003)(5660300002)(66446008)(4326008)(8936002)(8676002)(64756008)(66556008)(76116006)(66946007)(66476007)(36756003)(91956017)(2906002)(71200400001)(110136005)(54906003)(478600001)(316002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2U0dzZwOWFCWi9tYlp3V09aRmVjZEt1bnFRV0NRZGZZK1ZKUDRNSWZrTzZS?=
 =?utf-8?B?K2tKdVRnSHovVDgram1lUjM0UGM0RVA1czJRSktDbDFML3VrUVA5WE9HVnB2?=
 =?utf-8?B?K3FSZ2w0aHFZcENMYUtYNlNzaVptclNHTVM1Mlo4ZGN3Q1Q5OVVxV3EvRG42?=
 =?utf-8?B?a2FGUG5CK2hXalUvZEowUlp5dW1uK1N2ZnBxUllqYkdpb0U4Y1JxQWdaZ0lV?=
 =?utf-8?B?VjlPb2tweVl1L3lQS1BEb2VOazZ1UUsvREF2QklLTGFFN2xOYW50REZVMUJh?=
 =?utf-8?B?M1RYZFZqOHJxZXh1ZDZhY004d1NKeHRGdVI0Y3hBWGd2TkpyVE5rMUF6b0F3?=
 =?utf-8?B?c3NPTTBhU1Yxc1NFdmxMZUNOT01HU1haNENFMk1DeFFicUxFMkliMjN6U2hy?=
 =?utf-8?B?MGwvTEptVWVqMHYzOXhFdmFKS1JqWkxMTGhVcHNQYVVjN0hwQXpvV2ZLUGs4?=
 =?utf-8?B?U0JnRlRudXRDbUtxTmtqQVVweW9FYSs3ZVFNaTFQRDErZlFHWDdqRXhGRTFF?=
 =?utf-8?B?dHJXNkk3TVRlL21UanFTL2lXM01lU21tTVBxODZpY2NyeVhMS3pFWm9SU2xj?=
 =?utf-8?B?aWxkMCtNMndLWXFQNVk1MXBLK0krQXZRcUxVLzNwckdQLzh3YUhETWZkeVhS?=
 =?utf-8?B?MCt5L2JjQUxaRjBxajArNjRMdHFKdGJ5OG15a2pJSTFyNWxWQVMzS2gxUVdw?=
 =?utf-8?B?Y0ZuN1lkZDZmdFRsYXU3cXUzU3I4YzZpWVF1bzM3Y1ljSWtPTHNaYUQ0akRi?=
 =?utf-8?B?b1AwbGowaVE2c0xKUm4zSmZPR1pSN1lRaHR0dFFBRDB6Y2NvRmxaNDQ4UTR1?=
 =?utf-8?B?OWZ1cU5CR01xb01hNVJobXo3ckhIU3JnUVRxSllzZTcrMzFEMkc1Y2tLRTl6?=
 =?utf-8?B?cndKNU53WW5QOTYyMHoyc2xXZXBrOXJKZFBpcnRNSHhVVWh1MlM4WCtiaCty?=
 =?utf-8?B?eXJyNFRvNWs3aDh5OWhNR3pDYkY1Zm1WL2VuNm9KcHlRSjhZeTAzRHY0dmU1?=
 =?utf-8?B?VzV4b0FkVTZhUWhsc0VrbTA1QVdqTXFzaUZGSzBYUEJucXJYb0JnL3l4MXlE?=
 =?utf-8?B?cTRGa0cyOWp5cDZTUUJNeG9SSkpOZUlPQW5FTGNCRzR1TjdERXRHWE5IVzQx?=
 =?utf-8?B?Nzg2QjBuOGZ5ckpjR3M2RWVxMkVabW1aOUxmV09Lc0M1UEV0QVJDSW50Vnd2?=
 =?utf-8?B?em9EeW1hTlA2OEExdm1RM1FNTHJrbGtubW9FMVhlcVdWVElNVjl4UGFuMGZG?=
 =?utf-8?B?VEFpVWc4ZDl1MnFVZDk0UVl0UHlVMUZqS1Y0eVJzdXlYd3N3bmNUbHBha2JS?=
 =?utf-8?B?dE1kUElyTGJQTkk5dnRQMFV5bytJV3k3RVRzSEdEZHVXOXNSNlpYVDdud3Vi?=
 =?utf-8?B?Q01aVFlsWEpPeVM5ZEc5eEJRdjlEK0xJUzJ3YjFjcjlsbkdrQkFGbU5TM2lE?=
 =?utf-8?B?cUd0eWg3SmpDOENpc09pZVNoU1VWdVpFcEE5YzZFUzgzQU9mb2pZc09IS2F6?=
 =?utf-8?B?cFZNYVMxUmNobVlUcisyZ1ZoSkRpRXIzU25XYWpxOGtVRS91anpJcTFQUmcv?=
 =?utf-8?B?eXRTaDM0Z2pmVFZCazE0NE8wcC9ONllxOWhTQTh4cFI1UlZ5NjcrdzJXOU9Z?=
 =?utf-8?B?Slc0eWRzWTFBVUpONDV0N2xRWkpveWJYQ2hyWFhNZndmSVlEbCtZeUVVVjVu?=
 =?utf-8?B?TkR4TUNMei9mdGlmWlF4M2NMUC84UklibnRiVTJsNnZEMmhzWG9GVXo4NHow?=
 =?utf-8?B?QlMxcWJUdVl2b0UrUmt5THk2N2NvQjNJK3hJMHBaRDVHVVVyOFJ2UFdubVh1?=
 =?utf-8?B?WHdjZmt5VTZqZ2prWFdGdk4ybUdxZzlVR05wQmp4SXhjNUdPcVZhcEtrT0dG?=
 =?utf-8?B?N21ES1BHRXhaYUVWQ3lrUFlkc0thcXVYZ2JZK05MbFhFOVYvN3loUmxEcWVV?=
 =?utf-8?B?dTJacmE1akVJQjhEakd1THhsSGUrSVZxYWtWNFJRS0NoT2J1VXBnVXhOd2RQ?=
 =?utf-8?B?OGtsUDBXdG1xSzlZM1B4RVV6dG9WeUhSNEVtV0V1SFJoVTI3RmRnN2VrOFIz?=
 =?utf-8?B?cDcxK3gvdHAxLzZsRkNiakowRmVTUjdEdzZMR01EYzlFOW83NUdrb0d0MXph?=
 =?utf-8?B?dEJGQkpJVXo3VEcxOGtDeWhOMHhmdzRYRW1ybkZLMVpYL2xjS2hoZU9OUElm?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12064F1752179E4C832FF3E9645C446E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57265cc9-ce01-4168-11aa-08da7b816ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 10:08:22.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 414FlYQ9Xl9+s614jAsV9X7Gh6AeFAFAFL0T6ns6onugaMCThNNDm5Gas9ywqqt4/Lqp+uyA5o9jAbC/1n92yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2736
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTEwIGF0IDE3OjU5IC0wNzAwLCBEYW5pZWwgU25lZGRvbiB3cm90ZToN
Cj4gT24gOC8xMC8yMiAxNzozOCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+IE9uIFdlZCwg
QXVnIDEwIDIwMjIgYXQgMTc6MDEsIERhbmllbCBTbmVkZG9uIHdyb3RlOg0KPiA+ID4gT24gOC8x
MC8yMiAxNjo0NCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+ID4gPiA+IE9uIDgvMTAvMjIgMTY6Mzgs
IERhbmllbCBTbmVkZG9uIHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBjb25maWcg
SU5URUxfVERYX0dVRVNUDQo+ID4gPiA+ID4gPiAgICAgICAgIGJvb2wgIkludGVsIFREWCAoVHJ1
c3QgRG9tYWluIEV4dGVuc2lvbnMpIC0gR3Vlc3QgU3VwcG9ydCINCj4gPiA+ID4gPiA+ICAgICAg
ICAgZGVwZW5kcyBvbiBYODZfNjQgJiYgQ1BVX1NVUF9JTlRFTA0KPiA+ID4gPiA+ID4gICAgICAg
ICBkZXBlbmRzIG9uIFg4Nl9YMkFQSUMNCj4gPiA+ID4gPiBTbyBJIGdvdCBzb21lIG1vcmUgaW5w
dXQuICBTUFIgYW5kIG5ld2VyIHdpbGwgbG9jayB0aGUgQVBJQy4gIA0KPiA+ID4gPiANCj4gPiA+
ID4gQ291bGQgeW91IGdldCBhIF9saXR0bGVfIG1vcmUgY2xhcml0eSBvbiB0aGlzLCBwbGVhc2U/
ICBFeGFjdGx5IGhvdyBhbmQNCj4gPiA+ID4gd2hlbiB3aWxsIGl0IGJlIGxvY2tlZD8gIFdoYXQg
ZG9lcyB0aGUgQklPUyB3cml0ZXIncyBndWlkZSBzYXk/ICBXaWxsDQo+ID4gPiA+IHRoZXJlIGJl
IGFuIGV4cGxpY2l0IHgyQVBJQyBsb2NrIG9wdGlvbj8gIE9yLCB3aWxsIGl0IGJlIGltcGxpY2l0
bHkNCj4gPiA+ID4gbG9ja2VkIHdoZW4gU0dYIG9yIFREWCBpcyBlbmFibGVkPw0KPiA+ID4gDQo+
ID4gPiBUaGUgQklPUyBkb2Vzbid0IGV4cGxpY2l0bHkgbG9jayB0aGUgQVBJQy4gIFRoZSBBUElD
IHdpbGwgYmUgbG9ja2VkIGlmIFgyQVBJQw0KPiA+ID4gbW9kZSBpcyBlbmFibGVkIHdoZW4gdGhl
IEJJT1MgZG9lcyBhbiBNQ0hFQ0suICBYMkFQSUMgbW9kZSB3aWxsIGJlIGVuYWJsZWQgaWYNCj4g
PiA+IFNHWCBvciBURFggYXJlIGVuYWJsZWQuICBTbyB3aGVuIGV4YWN0bHkgZG9lcyB0aGUgQklP
UyBkbyBhbiBNQ0hFQ0s/ICBUaGF0IEknbGwNCj4gPiA+IGhhdmUgdG8gZ2V0IGNsYXJpZmljYXRp
b24gb24uDQo+ID4gDQo+ID4gU29ycnksIHRoaXMgaXMgdW5jb21wcmVoZW5zaWJsZSB3b3JkIHNh
bGFkIGFuZCBub25lIG9mIHRoaXMgbWFrZXMgYW55DQo+ID4gc2Vuc2UgYXQgYWxsIHRvIG1lLg0K
PiA+IA0KPiA+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gdGhpcyBpbiBjb21wcmVoZW5zaWJsZSBz
ZW50ZW5jZXMgdW5kZXJzdGFuZGFibGUNCj4gPiBieSBtZXJlIG1vcnRhbHM/DQo+IA0KPiBCYXNp
Y2FsbHkgaWYgdGhlIEJJT1MgaXMgY29uZmlndXJlZCB0byBlbmFibGUgU0dYIG9yIFREWCwgaXQn
bGwgcHJvZ3JhbSB0aGUgQVBJQw0KPiB0byB1c2UgeDJBUElDIG1vZGUuICBBdCBzb21lIHBvaW50
IGl0J2xsIGhhdmUgdG8gcnVuIE1DSEVDSyAod2hpY2ggaXMganVzdCBhbg0KPiBNU1Igd3JpdGUp
LiAgV2hlbiBleGFjdGx5IHRoZSBCSU9TIGRvZXMgdGhpcywgSSdtIG5vdCBzdXJlLiAgSSd2ZSBh
c2tlZCBmb3INCj4gY2xhcmlmaWNhdGlvbiBvbiB0aGF0LiAgQXQgdGhlIHBvaW50IHRoZSBCSU9T
IGRvZXMgdGhlIE1DSEVDSywgaWYgWDJBUElDIG1vZGUgaXMNCj4gZW5hYmxlZCwgdGhlIHVjb2Rl
IHdpbGwgc2V0IHRoZSBMT0NLIGJpdCwgYW5kIGFueSBhdHRlbXB0IGFmdGVyIHRoYXQgdG8gZGlz
YWJsZQ0KPiB0aGUgQVBJQyB3aWxsIHJlc3VsdCBpbiB0aGUgZmF1bHQuICBOb3csIHRoaXMgYXNz
dW1lcyB0aGUgQklPUyB3aWxsIERUUlQsIGFuZA0KPiBhbHdheXMgZW5hYmxlIHgyQVBJQyB3aGVu
IFNHWCBvciBURFggYXJlIGVuYWJsZWQgQU5EIGFsd2F5cyBwZXJmb3JtIHRoZSBNQ0hFQ0ssDQo+
IEFORCBkbyB0aG9zZSB0aGluZ3MgaW4gdGhlIHJpZ2h0IG9yZGVyLiAgSSdtIG5vdCBhIEJJT1Mg
Z3V5IHNvIEkgaGF2ZSBubyBpZGVhDQo+IHdoZXJlIHRvIGV2ZW4gbG9vayB0byBzZWUgaWYvd2hl
cmUgdGhhdCBpcyBkb2N1bWVudGVkLiAgSSBjYW4gY2VydGFpbmx5IHRyeSB0bw0KPiB0cmFjayB0
aGF0IGRvd24gaWYgbmVlZGVkLg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIHRoYXQncyBhbnkgY2xl
YXJlcj8gIEkgZ3Vlc3MgSSBjb3VsZCB0cnkgc29tZSBjb2RlOg0KPiANCj4gaWYgKFNHWF9lbmFi
bGVkKCkgfHwgVERYX2VuYWJsZWQoKQ0KPiAJc2V0X3gyYXBpY19tb2RlKCk7DQo+IA0KPiAuLi4u
Lg0KPiANCj4gTUNIRUNLIDwtLS0tLUF0IHRoaXMgcG9pbnQgaWYgeDJBUElDIG1vZGUgaXMgb24g
dGhlbiB0aGUgdWNvZGUgc2V0J3MgdGhlIGxvY2sgYml0Lg0KPiANCj4gLi4uLi4NCj4gDQo+IA0K
PiBIb3BlIHRoYXQgaGVscHMuDQo+IA0KPiANCg0KSGkgRGFuaWVsLA0KDQpUaGlzIGlzIG5ldyB0
byBtZS4gIENvdWxkIHlvdSBhbHNvIGluY2x1ZGUgbWUgd2hlbiB5b3UgYXJlIHNlZWtpbmcgZm9y
IGludGVybmFsDQpjbGFyaWZpY2F0aW9uIChhbmQgZG9jdW1lbnRhdGlvbiBwdWJsaWNhdGlvbik/
DQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
