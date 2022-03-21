Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B554E2460
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346288AbiCUKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346420AbiCUKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:33:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD7541AF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647858704; x=1679394704;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sy3CF8Z4e2feNAVIFFQSC73HbkEG62+LS09TtgKhkaw=;
  b=V3JTeYKcSXCwUdd8+a12c8QEExkRaHTwdKJzoDzUSWllZSQvpYwQNyoi
   wwlz6y6UahcWmHFe/O3HS3FhJGjlDYHsVn2t09I13SzIsYUPoVl4hePVf
   9+5erozruV4FEYoa5p47bdKNbGTONGBHqQ7M5E6PzaeqVCmZnqE4rZlCk
   aLoAh8N3NDaiM7Sg0Ok7jNly8AJzUrGzprcLnkyWVZnV2YtvQ9yAJF7V+
   MXWONOcPdSksbsf28XGUOEWdjE8XtTgIqDBGh3EKCkz78M+Y9vi6XxBQy
   n51rJbU7Avg/yR+pDk/JjMCr60W8x+W2ccFkGbM4E9g9atoXzn0xhKF9b
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="255083853"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="255083853"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559808315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2022 03:31:41 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 03:31:41 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 03:31:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 03:31:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 03:31:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek1lQMXw9Z9QL9O/wheU8e+0fZE9yRtxRD0FHmj5eXf/lb4EmLCfJ23Nt/ug2XWmEzbNEiS3LITear4qSRpC3Fzr9SGzOQENFX3sef0dq447tP4NnmPFJKbCCdINlrvaW6eaoSataZ43FJp9Lbt0zl9522p0zP8tG+FLyS/YL/go4LWBN2E8WWmYpDJvFa6KiP04tVVKP40CEYdXvAh47omWhwm2AKQvkTKCMuYq+qB/eFX4McgEJw6/v7zFQLlI95kzJX9LbWi96RoMzniDkq2DrKqXZDnm+C9d3gySPiCTkVOshYwhue/yW83bSyGrbGgwLmlT/tDcfwI61bUVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy3CF8Z4e2feNAVIFFQSC73HbkEG62+LS09TtgKhkaw=;
 b=nb88l0DEI+XDBoWFswKsC9YzJp2FSpglAvvTwdJ83438ZKJhMe506jciw90SHENvlDtXn/1dY7t0lH7s01nlszrgsO/5s/qpybDyigdyLnWfOOUxbkcOJbATp/dE3AdUADw9tROrp1FgOn5lJpXAm13SVUbNty9stTZnKUtEAaxN22gbbX1b65AI7GZu/BSzlJ6c9clLch8tRjNf8f/t+n89AkV+8kpjOJ//Q9QrD4XMo7bB7lD4W4c2cJo1d7cV4T59cf5f+fj8YrFEo+YW5o5Ks9mYZZ5pElQ14rlDnDf01bHWbGA0xhvlT3lsf1M9NL1DvUewiB+hvwmio3jYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by DM5PR11MB0042.namprd11.prod.outlook.com (2603:10b6:4:6b::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 10:31:37 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::4847:8b4a:79a5:d7e7]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::4847:8b4a:79a5:d7e7%9]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 10:31:37 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bacrau, Radu" <radu.bacrau@intel.com>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>,
        "Lee, Kah Jing" <kah.jing.lee@intel.com>
Subject: Recall: [PATCH v2] firmware: stratix10-rsu: extend RSU driver to get
 DCMF status
Thread-Topic: [PATCH v2] firmware: stratix10-rsu: extend RSU driver to get
 DCMF status
Thread-Index: AQHYPQ7YNAkdFhqOV0qu5kR+F/bW1A==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Mon, 21 Mar 2022 10:31:37 +0000
Message-ID: <PH0PR11MB56732F4F914FFDBD1A02FE44CB169@PH0PR11MB5673.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd16aa81-0748-41a0-78c0-08da0b25faab
x-ms-traffictypediagnostic: DM5PR11MB0042:EE_
x-microsoft-antispam-prvs: <DM5PR11MB0042F46E5759A1662D51F5D0CB169@DM5PR11MB0042.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bR46gSqri7YuRiOEqCM9ohQVO1gWnA47iGfa/Ow6gN/6jQDF6sy55q6Y/RhjbsACTwEHpyqnmuZHE1WdefDDpWanxk2rlNVSm26OSyLyQylcW13LT6K8OTExYFpI6FDwZZl1mLdNUhYKGRCy/iicliYn8I+i17D/ep76/ljdsjPJUjE0L3EDqBp+UK5gKdaK0lxDpft7AwQGn86ANk+SomxZkFU9mt/m/DhbMdqPS+cnENRHyR/ZSDIsdAt+XWLiYDnc+om9KAKIAhoNEvOYuFDnJ6JBdOkqkYKRgLpMIkFD3pNTXax+xq6rKPFCc/xDHO/EXhCSo9+C3OpF4gnjNViIcUS/ZKn79SqQ3CMIj1VQGxd+6ZxO8+IEvt1VCYyE8PFFkPpWXa/is4Cm2tDpr8pSDCK0L3GFzlN1O9n2hxgEY8MohP7y7cTPWwOff31HPf5B++usxweSFTlg7gdBn6UAxccV7CoKFTWSnTF/a58Zr4QZlnVaSLkQMy41tCLZ3UWDGd8Py2aK7LhcpDTFu1SqvjrNexbAqfBIfoLvSD4lKIYjLZ+Kp1FSWkROaKr28qJ5xH4ClL+QXR7ZE4nEBLks6ru4BN7JLB3sgYn4leSNsKKuUUbd6vhsP7NunZz+6qG7kicF/II8KorVn5wl4S0jbZlakwC6Ox7sBwQ9ujTbN5yMMNjlya9VsaWp2eZ9BnZL3GXm6jpSuASCB4dT3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(558084003)(55236004)(2906002)(86362001)(9686003)(316002)(8936002)(52536014)(33656002)(6506007)(122000001)(55016003)(8676002)(4326008)(38070700005)(71200400001)(107886003)(508600001)(38100700002)(83380400001)(7696005)(54906003)(6916009)(66946007)(64756008)(186003)(66446008)(66476007)(66556008)(76116006)(82960400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?49zFR9dL5gNCyba68Fl7mSMk10zqt4BZ4s05tx1IBei95EDbpiVs+wfs0pwt?=
 =?us-ascii?Q?jCsEjIkoJ1cgCAxaPtkN18/tIStYP97d4SJX7V+fXOrMI3jkF76+Iv7F8sKt?=
 =?us-ascii?Q?EIyetI7SyajZR4lB5LvdUfnGvOo2fbG80S7+KKxaDIoBeLSEbyi3uyZ4D06v?=
 =?us-ascii?Q?lHvAoh3Fdkflt05KLcPkQLBnvtVsE6b+kVAdLm+xgiBxAYm1HB9d9o4ezWGg?=
 =?us-ascii?Q?ssKY6FC+TxlvaCiSGUaVXwjNKU/NWOXFmaTA71zbiJU2xQcUf25L3F9UISao?=
 =?us-ascii?Q?yID7zxl4PxOKCXs3y4F/j+YHMHoLQpg4lxWMdQxkmU+v7D4BMdAbz+LEFLMt?=
 =?us-ascii?Q?T+csMo7WEPv+1lF86VKd52JAn/mbgzr/qjZswWelsJ85NYWciMSPfFRImSlU?=
 =?us-ascii?Q?Ge7+2cY4DUGAT9fMwchp9LwPE66zBpietB8fBhFOkks0FXfGuSS5Gth/+CK5?=
 =?us-ascii?Q?2h11jNvrP4mJIJbeWAd+IVD5sVU0g71SwW+LRzEvizwvGaBHvRPu8mIrTjQM?=
 =?us-ascii?Q?LXM9BH8gVV2Uzxmmz48oww186FdfMRvl694kBAEdEkCY9Vm87td7sscCuHBF?=
 =?us-ascii?Q?Lb09ALvfL506Te/27u2pR0NZrtsWLAKekLNQvORUuZa3oWwspovz5hjSEKoO?=
 =?us-ascii?Q?3p0Wy0vWsIEpJxKP5rj4m2PcSOLs6eSX+rgJBwxXCDGUsdG9JTkbl+gWVWOw?=
 =?us-ascii?Q?ra7aIEDRP5lvIF5fzPugNEWm5uVlZ6nazWSpaoErbrLObeFJPULs4Pbj3sqz?=
 =?us-ascii?Q?zUr8U+RKrPTgoGq5+sBuydI7S/iabA0kPQKFg8ouqs6LDs8pvRiVRnRhFpk2?=
 =?us-ascii?Q?ZNJTYbzxYsA22bL1s4Zvt+mft280f6s/DmO8Y2+dP0t0QCM7h6NfWEQ1PU4+?=
 =?us-ascii?Q?90MMpQt5vvNYLnu/I78Vg+cC6f4nbl+6DcwXkTKMYprStb1t0wF7vUgSu6Id?=
 =?us-ascii?Q?/1jUTI0qp1LmixqlJ23t2JlHgkNh24ug37vrSTEVTxPJtEs7137o64UIbBO5?=
 =?us-ascii?Q?FxuHMeJNA9v9Vh4NrM7qZL+D4caD+OQq9TmtUQKXJaQ1GuFOyS03t1bOlg2p?=
 =?us-ascii?Q?OyUtG7WQXP53porVLEeJn4o/N6nhjtQAmAkd/dZdFt4zTVnIutQqMUs67mLU?=
 =?us-ascii?Q?cJqv7ZOLXj3u3f/6XxV9yiq0qG6Qo/m/DGSXT4ubeEOtYheFaz5ZaNzLSrsh?=
 =?us-ascii?Q?TQGELkO3VDIuM+s0yT2+4H+zDE7muzPm8GXIjGbKUa+4hJ3a9zPkOZkPORDI?=
 =?us-ascii?Q?AqxU8oUwu4t6boypCU9oFmc9lMKdvZahk/s8b9qNCvIR399fyfDDr7XtPJ4l?=
 =?us-ascii?Q?ks8MWcaWAdDv65sJ25VoF1mUuW6r7LGB/V/A+oh62Ed5tr8V0FAJtZqaifyl?=
 =?us-ascii?Q?c9CvOiKTlDbxsfPGeNYit7mlhQoCy+8xFKsTtr1ZVnYEVuJ0FSP/EUmWwwnS?=
 =?us-ascii?Q?LZs3c7pj2/DaLihEpbNkVKi6lh/7yztU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd16aa81-0748-41a0-78c0-08da0b25faab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 10:31:37.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGkgqghoC3efharNIiujSN4iG68zKfKaxQxK41EBVeF6dqmsICPJickXmsYvu+9rAx/AvpJ8rzMNurAxwao4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee, Kah Jing would like to recall the message, "[PATCH v2] firmware: strat=
ix10-rsu: extend RSU driver to get DCMF status".=
