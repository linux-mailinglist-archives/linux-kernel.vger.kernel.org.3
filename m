Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535AD56C2FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiGHTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGHTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:21:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3652E1EAC5;
        Fri,  8 Jul 2022 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657308069; x=1688844069;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=L9KFAiDE5W7B3xoB1ooeoH9TotjIjz+NtCDKgaiP9sE=;
  b=RqxxgUBKeP0W/KkxzNTFjOipM9AnXdlTtIKZyIrBivdgzIML2vnlZQSf
   JeIAXc2MwLyFW0r6w4q2BJNUC12v5iSZtt8jB8T3H1ZeFfmVJGCar72UR
   VfT3lbpkpa4zcPNg+8+z6SxrVnbRLcdsSfYLkoQkVLQ/+wIMNQKISRXWE
   lI/x7kdbV5rB4Z3ib2ER99KG4lMo8AW0fSz5QdcZitmyMuBWKVXb7ktsG
   pt9BCCmWB0AEh1gUOdrLhC+3oN+ZKmnm5ZAjMCuANWc7FsefiboqngT33
   7niShP7IgvGAzlNCVT8/R9Yi1Qg+IuZAZt0t5It2nsRFHw3GMndw2Qmlr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348334611"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="348334611"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 12:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="569049699"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 12:21:08 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 12:21:08 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 12:21:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 12:21:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 12:21:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdfD0ymEkyvS36n49SGFVltWIA5bFDZsEY443dHgt92fsTJRnDPVc/NzplrpY7WqYWccPpfErd+GlOpV6tFJ1+r5sTpalKHIt/WNRIiTprhIPJ1hTVx0RLS/24i9TfYKwG97R2qbM3mHyJ3EXldsfEx1bb2HFDVgleVVpACL/r5JhNKxBHPg1FkxOSh9L61ZlF3HpfRrONifmetF5K2iOFNGv7qWdKAZXWz29ZFgDqeXn+s7TAzCGM80NPB7PbQKlkUmbXzzVHmLeQskrXk2+QCxp2o9p8TnhpaMzFBoDnl2z2CmkQEFavJn0hHO0Vh7P5wAf0O8E9tfdN4ulCGJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9KFAiDE5W7B3xoB1ooeoH9TotjIjz+NtCDKgaiP9sE=;
 b=E//uCb1fx8LzsxgSZJd8y/hmP0Yk3i978llqWqh2yMMNRK7wkiPjOax3BqJKP+hNc8f0/RvHHvkYBQ86y6EZgTMVjpIqtNiViqaXd6e/YalKJWgebX/B9+2ej83yx7LfZHp87mvt2KxkNpIwtBEVwbLwQ1RjdUX/RDA5P7NfC069evAf90PZwVUMEarR0vgdrgHiHXAqTQ2rlkTSedUJBFQ9zZsyCRTWl5Dg43TiUMhOomaD6V6E/z3izzWg5eUjATwf01noPHG7xCgmwR94Drfj3fVb31KwUq6J2r0WHbSAzywZjTllMfrCGiNqOCPxi6L7ybkjtJz1/erehPq4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 19:21:05 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::61f9:fcc7:c6cb:7e17]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::61f9:fcc7:c6cb:7e17%5]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 19:21:05 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] cxl fixes for v5.19-rc6
Thread-Topic: [GIT PULL] cxl fixes for v5.19-rc6
Thread-Index: AQHYkv/e+qJ1+cfEckSBmreskM1B3A==
Date:   Fri, 8 Jul 2022 19:21:04 +0000
Message-ID: <e3b03cdf0c0ef173a11d30262eadb3d355e7dfea.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10f69a31-9608-42bb-651d-08da611700ae
x-ms-traffictypediagnostic: MWHPR11MB1789:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G3idG4/B+OTY7Bk1jIOc3MxE53ffHLazFvqlMc0Ez+lpGFqoEy2UIPRgn2SFAlFbva6YxGz8nhn9c/7h19Gwbe7uJlrgTM5mPMuWMgc5aQWoHls2K17Tzzk/cd9UpQMhSnjd6VSYpCYrzNL+spSMGihmeu5/gyrUMVf/6n07ftuorTZkHWUeKE5AFJ6jRcjYjCbD5Dct5mCa0seQj8U1ziju3vJ0rxKqR+cwYkv1FkY2i/Loqha94h0JLucLrjjU+S6CnvUeqNaprrKu5vKeksFYOf07hjEgdPZy7lu3ZgoobuIwCW7+FkQkywKcW5U4Sgf4ok41Sahl1PspiUHPyLrHEw8bNek4kv4nQdFkBf4ARVEW6myskXZ3GUT2o62+5lQSfOeFilRpzXDMYU7ZzWvw5zHxSNV0tUhRDp84G9Qa8WC2UYyl+gyWSXq/NJ7nOgsCKvAIHRR5AigQ7xlDoi0gGQA9ax07JWU2YfWO780yjijPqNRCAmgglxoS41Jq7eNWqkpdP006d+SfJ4P6K1DXG57FMzXn3wGPxExcuaaIZNMcTIgrYRWUBEvAfcFah2chYkmujZSDad8NQgu3NmstvlcW0PkWe7POXHhm5Z1mOYiw9K/0wzxvKi0wwx9MXdTpZXk9lYp5C0uRpil7paOBXDXBeMiaIkMXyppWMP1ECw8khrk52YrPQmr3i/3wgQXOxOOx1jHwC6zFG+3RVAoZCDBgKijdDQjlgzkINNne2RcdQydLwjNOvELLxkR9ZQA5vE8sNYSVcP0o372xvXwI7iuVa5ZhiFzHcha/QuYpl1sc7woohYKAtz8Qnoal
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(346002)(136003)(376002)(2906002)(36756003)(38100700002)(186003)(82960400001)(5660300002)(122000001)(8936002)(66476007)(38070700005)(6486002)(2616005)(91956017)(64756008)(8676002)(66446008)(66946007)(66556008)(83380400001)(76116006)(4326008)(86362001)(6916009)(71200400001)(54906003)(6512007)(316002)(26005)(478600001)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNzNXpERXlXQjZXSkJpb0Y1aTBpZGhjY0wxRytrZnlYWks5azZwVExBMkp6?=
 =?utf-8?B?ekxORi9mU0QyYnBIeHdHcDFKQ3dNY0VlSk91ZmVGYnlQeFZXcjlRMC9WRDFB?=
 =?utf-8?B?dHdVT1V2TGVuMmx2ZFo0c0YxclBRanhjV0h2VkhjN1JkSWx6akpZUkJNcGI2?=
 =?utf-8?B?aEhHZXZqSnZ0TjlORGNpSmRTQ3VyTG9pZE0wRVQ1ZTh5Y0U4VDl3MGJUN3Vv?=
 =?utf-8?B?QVF2RTgyTmJ6VlA0d080ZFkzQ3g5VlNISDNRUXFkMTBlTVROaUczcVVuT0Ux?=
 =?utf-8?B?S2h1WVFhc2drVUhJYnRFZm9VTkZ4OGI4QU9HaE96RlY1YWZ5N1JmSFZxVDE5?=
 =?utf-8?B?SUhJemQwOVZuako3UzJpbnoxSmdOOFlSaThvU0F1UjZ1RFJkUkNYOTJIZDNn?=
 =?utf-8?B?V3pXZzczVjMxVWJFYUdWUGFLUExRbU5kNi9OckY3Vm1RVE1nVm4yUUlIeXRP?=
 =?utf-8?B?ZlRWRDRTUktNS2ZhWGtwc1J5Mm1ZR0h2dWJCQzhHMGJUTCs3VDU2NnBMcHB3?=
 =?utf-8?B?dGJyTng4S3JhKytNcGw5ME51Vk1nUGxqK29RaDdYZ3l5c21Wb0VKZ3duRHlM?=
 =?utf-8?B?UDdmMldiOEp2SzZEcGt1Zk5Ualg5bUlFQklMUy9JZy83ZDBZL003SDNZTU9u?=
 =?utf-8?B?ck8venF2MWNRNlhnUVhJVmZUWHlWYzExUUdHS1V1UzJBMVV0S1pQeXJnMW96?=
 =?utf-8?B?a3pmU1JteklscFlTVFF5VXFWU3BaUmtvWGtudWJ5NCsvMElSS2VvYjBFcWta?=
 =?utf-8?B?U3FlR3NoejhSYkJkS3g3elpkZm5Pb0hjK0dFc2IxWWVtWVhsMVUrNmRqRWx6?=
 =?utf-8?B?cEcydlJydnM0SHRLbG5WRHlsQVlvVmVZL043eU50T3dEWHZVTy9WclF1SlM2?=
 =?utf-8?B?dzVjN2M5L28zbUxrV3MzcnY1WThHTkNuRVErc0xNZGJ3WW5WWnY2UCsyN2Yy?=
 =?utf-8?B?azFuUENGOFVQeHFSNUNNT21OR3lnSmxRdDdrTlMwYkdDNzlZTEQ3a2QxazFV?=
 =?utf-8?B?RjJaRVJpNmx5Rzh3RlNyVkNZd01CMVBhc2JjYWRpbXRDYjd0MTQ5aUY1dVZF?=
 =?utf-8?B?K1BlSERERjFPS2FUbis2YWc1ZUEzRDdwZjhLb203VnFkOXgvRTE4a2dhZ0FC?=
 =?utf-8?B?eENzaW1zOTg2TkVtK2w3d2J5M3M0YUFLNXNHbFN2ZnZQbFNsT25WWDAwUTZR?=
 =?utf-8?B?eUJXa3MzcUFLMzE1UWJ0TkVoWFIyaDV4bHN2enl3Yk5DVXI3enlYMWcrMjdX?=
 =?utf-8?B?SXlTQ0NDZXdRNXhwdXV5Vm1BODJhU2ZiRUcva1FuZzVoR05ZU2szSS93MzJ1?=
 =?utf-8?B?NnRtWXVuTHJ5YUpYQVREZTBadm0yL3R5b3FFcUxhc0JJT0JzU2lTVllVandl?=
 =?utf-8?B?MWVxS2dUcVJ5Y1JMU01ERUFta0RXS1lLRkNqcTMrblVzUVdjRUFTQnVtdXJ1?=
 =?utf-8?B?VVBxZ3pjSGx5emxhN1YzVnUrTHd5SkJzS2hESEt3YkV5cDVUL2JtWC9xRTBu?=
 =?utf-8?B?QWFhUnc4OUN4VE5tbUJvVXVwTVNvQzUxWkthZVNNcEpmVW42d2pKK05jejFD?=
 =?utf-8?B?ZHV3ejZodW9LUEpLcjNKS1ZuelRQeTFxZTJBRHNRRUdYU0ZaYmVXbFJGYUFG?=
 =?utf-8?B?Qjd3VVB0cFM0MFA3aUxTb2pkYkZiWExSOEduVlNnMU96U3hjazNpSzdES0Z4?=
 =?utf-8?B?SGI2NE1BNFg5TzFld3JiMmFITnZuSlN4QTRNbll3djZtbmllV25rYTJHUzVv?=
 =?utf-8?B?MTJMYVFkcEpiajI1M0JlbzhmZmQyU3ZsZVd6WDNmS3ZXL3NSWG0xNlRhTEhK?=
 =?utf-8?B?UEtUdWl2MjdzbktRcEhhWEM0eHdGdzJraDUvSDZKZW10c05oR3pzMU92V3NB?=
 =?utf-8?B?UHpaaEQ4TW1HeHg4NkwrQkxTNWQxR2dpT0NkU1dWSVo1Z1oxeU1IMHZYbVdv?=
 =?utf-8?B?TW9TemVYOVRFdEpSODVXd0JDaXFlbjc0aEJucENlcUEwd3B5ek1yUENOd1NJ?=
 =?utf-8?B?czBKdWtyMnFOcENKd2JuU0NxeXNDRVE3OHVmUXJzbnVkV3I5d01pejUyM2Ro?=
 =?utf-8?B?QXR6ZldnTVVMQk9vZ2g2djRuSml6NU13U1p3bkxSODhiWHhYUkR4dmc0c01O?=
 =?utf-8?B?UnBGZWI0RHVXTTN6U3BHWnVpVlQxZ1RZQWtDY0xUZWxpenIycWtPaGk4TkJB?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A930D5BCA5B8E54CAEB2C2DCCC0B7D47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f69a31-9608-42bb-651d-08da611700ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 19:21:04.9449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfNEqhuq4R0eN0nKbxKTMJrbNgyMZCEDs5UudjlkOkr8WUnylUnSPCMUA+UTIKz+rFmNStKW0YdvcMm75bTPoQnnu1OiNjESinjMCxq5c6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsIHBsZWFzZSBwdWxsIGZyb206DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2N4bC9jeGwNCnRhZ3MvY3hsLWZpeGVzLWZvci01LjE5LXJj
Ng0KDQouLi50byByZWNlaXZlIGEgc21hbGwgY29sbGVjdGlvbiBvZiBDWEwgZml4ZXMgZm9yIHY1
LjE5LXJjNi4NClRoZXNlIGhhdmUgYmVlbiBpbiAtbmV4dCBmb3IgYSB3ZWVrIHdpdGggbm8gcmVw
b3J0ZWQgaXNzdWVzLg0KDQotLS0NCg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1p
dCBhMTExZGFmMGM1M2FlOTFlNzFmZDJiZmU3NDk3ODYyZDE0MTMyZTNlOg0KDQogIExpbnV4IDUu
MTktcmMzICgyMDIyLTA2LTE5IDE1OjA2OjQ3IC0wNTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRo
ZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvY3hsL2N4bC5naXQgdGFncy9jeGwtZml4ZXMtZm9yLTUuMTktcmM2DQoN
CmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBlMzVmNTcxODkwM2IwOTNiZTRiMWQzODMz
YWE4YTMyZjg2NGEzZWYxOg0KDQogIGN4bC9tYm94OiBGaXggbWlzc2luZyB2YXJpYWJsZSBwYXls
b2FkIGNoZWNrcyBpbiBjbWQgc2l6ZSB2YWxpZGF0aW9uICgyMDIyLTA2LTI4IDIyOjAzOjE4IC0w
NzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpjeGwgZml4ZXMgZm9yIDUuMTktcmM2DQoNCi0gVXBkYXRlIE1BSU5U
QUlORVJTIGZvciBCZW4ncyBlbWFpbA0KDQotIEZpeCBjbGVhbnVwIG9mIHBvcnQgZGV2aWNlcyBv
biBmYWlsdXJlIHRvIHByb2JlIGRyaXZlcg0KDQotIEZpeCBlbmRpYW5uZXNzIGluIGdldC9zZXQg
TFNBIG1haWxib3ggY29tbWFuZCBzdHJ1Y3R1cmVzDQoNCi0gRml4IG1lbXJlZ2lvbl9mcmVlKCkg
ZmFsbGJhY2sgZGVmaW5pdGlvbg0KDQotIEZpeCBtaXNzaW5nIHZhcmlhYmxlIHBheWxvYWQgY2hl
Y2tzIGluIENYTCBjbWQgc2l6ZSB2YWxpZGF0aW9uDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkFsaXNvbiBTY2hvZmll
bGQgKDEpOg0KICAgICAgY3hsL21ib3g6IFVzZSBfX2xlMzIgaW4gZ2V0LHNldF9sc2EgbWFpbGJv
eCBzdHJ1Y3R1cmVzDQoNCkJlbiBXaWRhd3NreSAoMik6DQogICAgICBNQUlOVEFJTkVSUzogVXBk
YXRlIEJlbidzIGVtYWlsIGFkZHJlc3MNCiAgICAgIGN4bC9jb3JlOiBVc2UgaXNfZW5kcG9pbnRf
ZGVjb2Rlcg0KDQpEYW4gV2lsbGlhbXMgKDEpOg0KICAgICAgbWVtcmVnaW9uOiBGaXggbWVtcmVn
aW9uX2ZyZWUoKSBmYWxsYmFjayBkZWZpbml0aW9uDQoNCkpvbmF0aGFuIENhbWVyb24gKDEpOg0K
ICAgICAgY3hsOiBGaXggY2xlYW51cCBvZiBwb3J0IGRldmljZXMgb24gZmFpbHVyZSB0byBwcm9i
ZSBkcml2ZXIuDQoNClZpc2hhbCBWZXJtYSAoMSk6DQogICAgICBjeGwvbWJveDogRml4IG1pc3Np
bmcgdmFyaWFibGUgcGF5bG9hZCBjaGVja3MgaW4gY21kIHNpemUgdmFsaWRhdGlvbg0KDQogaW5j
bHVkZS9saW51eC9tZW1yZWdpb24uaCB8IDIgKy0NCiBkcml2ZXJzL2N4bC9jeGwuaCAgICAgICAg
IHwgMSArDQogZHJpdmVycy9jeGwvY3hsbWVtLmggICAgICB8IDggKysrKy0tLS0NCiBkcml2ZXJz
L2N4bC9jb3JlL2hkbS5jICAgIHwgMiArLQ0KIGRyaXZlcnMvY3hsL2NvcmUvbWJveC5jICAgfCA2
ICsrKystLQ0KIGRyaXZlcnMvY3hsL2NvcmUvcG9ydC5jICAgfCAyICstDQogZHJpdmVycy9jeGwv
bWVtLmMgICAgICAgICB8IDcgKysrKysrLQ0KIGRyaXZlcnMvY3hsL3BtZW0uYyAgICAgICAgfCA2
ICsrKy0tLQ0KIC5tYWlsbWFwICAgICAgICAgICAgICAgICAgfCAzICsrKw0KIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgfCAyICstDQogMTAgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KSwgMTQgZGVsZXRpb25zKC0pDQo=
