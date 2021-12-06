Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B9B46A4B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbhLFSi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:38:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:58206 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239809AbhLFSi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:38:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237188083"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237188083"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:35:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="515084222"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2021 10:35:26 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 10:35:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 10:35:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 10:35:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF/fhnxDwZ693cbpOFSKzrHZs29z0FDjNjOOLL37lhH1kwkVJZ6fMeUjxKVaJwTNWjeREaYC27uSzKd1XQ7UQeLK6rDHnSRxKLGRWyXjFwAPc7l60J9GgZn+nA9KrPTrs9jhOQatN0mpWZFpLtPxep6P8K+gfUx8zo/29jazrKRmfhYlfSMB0qitjc6R0P5K8CogZdAzj4zHywX+w0GqG8uz5cSFufqh9pUyCyANyn+Jkh51v/yXHtjMuGJiRLbBFL4+XgotC9xlZvY0U9s7q61luBb4zauZ/j0eXyMn0ZfdOqCpv9C+iXlSV8Qz0zMBYB4KBXkvQmPZKE3ZAKjxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe2ZeNL70uh327zIJu2Tu/oBN/6RLl6jeZTP5qa2w0o=;
 b=SIHEf4wfUNnDEBZrM0qycrPqqsedUu97l+G01s6Y2PipsqtKZKE1DdtBihvJI5pUK4DlzGpl6FyBY8wu1sbZp3WMnMfGN68cJRv9xEUvm7Np/Z/38muCPhJutGZ2YGNh4uERf2Vzk63jGwZ8lHdF1xUrCaVpVxd6hQauuoDLdeiPPk465HA5345rvwsT7Zq4iRVzJXKr4D5j2ZlFD1NhrmknzHqGo+wCFLWVrqwCakOkbnomgI0j75DtUDD3c4jTGIe+rSZbK0NQG/ur1Z1/EAThP/s7KziCvwyKOceGF3lhuvok4oLl1PIEOSTrCsTC7/joKkQ2uK3HI+0bJQEBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe2ZeNL70uh327zIJu2Tu/oBN/6RLl6jeZTP5qa2w0o=;
 b=Swf7n12nsSIdfPJadhYsrUoWMV0gedfy3En0Zg4u1zod9upmX9nd3ZT3oy89e4Ml/jJ0PkjF3yv0d86bpcaT9w9AcVG15M8be9tuW35E+igpzEcBkiioC1TcsiMfXadnA24rhJBszQy7BACJWEiXYROqYwUrhv490KVpOTpzIPE=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 18:35:25 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 18:35:25 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Alexander Potapenko <glider@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        "Taras Madan" <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Potential information leak in save_xstate_epilog()
Thread-Topic: Potential information leak in save_xstate_epilog()
Thread-Index: AQHX4rXJONPQSCYnwUmQmX4382ThjKwl2qWA
Date:   Mon, 6 Dec 2021 18:35:25 +0000
Message-ID: <BC2CE4CC-744D-483D-B4B6-E37BFFF8D203@intel.com>
References: <CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com>
In-Reply-To: <CAG_fn=V9T6OKPonSjsi9PmWB0hMHFC=yawozdft8i1-MSxrv=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 914754b9-271b-4f09-340d-08d9b8e72b92
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5013E6F32624BDBDCE4EE6E5D86D9@PH0PR11MB5013.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZYFeJ3EqrrcZVUNC3N+M9SrEfrmHkgwcA4TCSYVrczKb1CNt7/GOY30ii3N1iyPpXhH61KdmZwHgS7SFtqJdNBnH0p0qz8NwNCjmJ4ONveqYrqfX7MDkNpBkfWqyPT3ZqO6mcyRlbYSpJrEygzdudjGzYuD2mUhUhQ89M6QDOjrFsDuPumPK+ng6hx0HePRIDl42jmKeX/BtQLmYP97jJMSHkoOObnWTkGai3zWGTAv+HV8q4O6+DCLU00RxbZlNp41AuT2EMOwBBPUsc4XWoBuCCXm+1aDFKaK+BqKhum+4+K0Wd2jWmmIUMAUOXFrQKh5KgHsHEl5+k9mjrTRi7lnvB/CaDIV42IoOJkatak8YFBTtEMe4T1vK8BN0kSHWrWw29h2kDYEDA16quuMM30zEiyHRzsIX5Q+0w6jCYw6OlW7nZNpLWZwTaw80IaXFn7A6dXjkIsOVYQsjZHiENVK7f6UCBM1tCqmZTRw0pGRZYSnNh4tcBwrEXcqaxXbr5UoIW4YgbAf+UVQePO1NlBCc7ACyD+60byOxhzK8PwkJ/nl7uehwewcpA+JUu4ix3c4F71jCYdDWnT6a7qdeobfKHL53+URKg0UyXLxmLYa1LPaCBQMhAoVP4jcYFtMcXZ0Jow0zLb1VztVQnDVCvias/p25PoXoyeDPJGpMbYBn9LKTUv1DB+G6i84p2obfFHzYnNrAA64c8Cfy4fhf2hWMekjGbjmMd21FskRjf2EydmVhtVHOyiYTsCsvKf/mASneoNmmyehZaTUMTfn52eywMxBrNjrIjXYwDYLUyEklhuDYWyzy24d47d+Jp6S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(508600001)(26005)(5660300002)(36756003)(966005)(186003)(6506007)(38100700002)(4744005)(122000001)(33656002)(53546011)(82960400001)(86362001)(6512007)(2906002)(2616005)(6486002)(54906003)(8936002)(66446008)(71200400001)(64756008)(76116006)(66946007)(66476007)(66556008)(316002)(6916009)(38070700005)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+DPxClSF/ASngaqXjElDb6+6XZfsnwsxJis7nxD0azDTzUfKtYJrDnpTWfip?=
 =?us-ascii?Q?vMhQZNbv1Iqy5mUWHH3NwCJYqgOq6EpcHyHBAc5d72slM1zzaxvq9ezhrEQ2?=
 =?us-ascii?Q?H60y1nUh0+AFsQ3nNFe7z0zdHpZ0j4uRzc5vEAr27p/vWnjO1wjiVub3DwOB?=
 =?us-ascii?Q?PswHwTARce6ComPgU2A8tvwctN+Yrl9mWEfHeSJbH9rKckBolu4iaI2r3o1w?=
 =?us-ascii?Q?XzQKFXuSsri8Qy5bU6IX6GIG1frHwZhKnVrU2nkAlyDel3aYKOwRiNEFn6oX?=
 =?us-ascii?Q?G6H/sgnFzLxOdQj5yxYiN5Zlfy44tSCoUSAn7d0iimVjKo8mlZURS3tDSUIg?=
 =?us-ascii?Q?dd6gxNRN9LQfR9i7u7NrhhdNfHoGOMThojhmoCi1CcX+IYvtu1t2GRfO0aLf?=
 =?us-ascii?Q?yT93vrRo5MmEBVh57MOUthaTiJMhTM6NWrMZW4Vynt8w81bXa7ABoFF1vpiD?=
 =?us-ascii?Q?dcyS7yi4jq9imlP7XCYNhRHqwaEd9NQ04dYO3k+7IAXpP02F5fmK9spLrIyx?=
 =?us-ascii?Q?6IusaAbFlw3ziIKAab3ifc8jRUSSil5LU6HSkd9YyyIK4/kw9BM4XroGpmUB?=
 =?us-ascii?Q?3+Kqz+sY5saYGJXwn4x7rw6KeJ5zYYcLgK2hXBaluybS4OLr5l9C/g0puHus?=
 =?us-ascii?Q?y/9RwDKAyeAkgR/lO7XiQRqV+VsYgqIYIwOIqopJYNYoyW5INHSWz5OG5lA6?=
 =?us-ascii?Q?MKg8PZHJKCZQDy/cLQfs+u1p3ZnpI1h7kTgwrbJ7Pe0mpssp5bjYqKIe2Z0y?=
 =?us-ascii?Q?J8SpYx7c7yNvS6MxO3zsUklEBIXtNN1YP/62I8t2Axq4WaS/QjbMoyCMsgQb?=
 =?us-ascii?Q?SPWZVXVNP3M2MQpHFFHTmSTK5DEXjdfGGsRk0EzgHgi2jr/gK6ZmvIECpwkn?=
 =?us-ascii?Q?iXZRVqFgk5yBHSZ22Fza5QlZtY74dnopQRTwYI+0ArNkNOTxM+kxPM+9UH0Y?=
 =?us-ascii?Q?gYwVpeM5rb8wT9NnsxHAD35b0gaKx513It3t7i0sz/L5aGJGM2exqFb55ZLn?=
 =?us-ascii?Q?NynxG9YNGfdHJKZvDSe3RQMfAydzzgKiAg2aWCcyLNeYjLof08l3pNNSaTlU?=
 =?us-ascii?Q?PErFlXDnFf5lH0vpM6A5iXq4h6i7c5vbBdvLOPjcdPrif7AYyB14fhwfDTIt?=
 =?us-ascii?Q?cXGA15DMxivZHwgZXoStEMUgAYbemhcnjsPTyFJsyRRqBkjLt+dHyC8ilUZc?=
 =?us-ascii?Q?lFQGBHiMbPpLcWlpqsk/i0LEXeOQL7UvFPSQN/6pJ8bczygKZZ2FEmfsLgNA?=
 =?us-ascii?Q?4yYyh+j7qhUz3iYny+/n8ppEAVOvZybwJ7a4QhoKq8WqHWLOsPbzBu0K8RSD?=
 =?us-ascii?Q?+bk2zp53qn951aRt93m3soRBcGp2u9WS2GrCklGmAUZdHdKVfY3chTHmEyTQ?=
 =?us-ascii?Q?jpGzTv4zc/thOJxftIKpWVhmphuNic3mmkS7UazRp3Yajk6gTcK9mgcDHBNy?=
 =?us-ascii?Q?NrN+VdcfvXpwb1TEy5AoP6RdH1GIDfzaQ61wAPA/jJ1Vuu9wUKY5fXre5UtV?=
 =?us-ascii?Q?vnBGrBbutjV7eUCMVxgcNgqEer1Pr6NBRW02/ywml4U2KW0UEQOOOUuf13CJ?=
 =?us-ascii?Q?HWZDTwQiR2hdxsDkc0/j6ZM9RYE745asurMapICwGVY32koGUdQg1lH0vbQh?=
 =?us-ascii?Q?QajPsZS2jS5mwf02TAbuKHZpCuRWJ77VcrSM3KWuxp7GBONUBf6+4As1WgIL?=
 =?us-ascii?Q?MQ2qWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <007F2435E696194B876C405DEBA13502@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914754b9-271b-4f09-340d-08d9b8e72b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 18:35:25.6500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3nWInCEu52r3Rqpssa1+3cM4/wLpuxf9eLu28sufkLfqXpRYI/YaU00a7uRkbWpsQR7eZUqMJrpjzMnQICEtVxANPlqKnTOuR++Mjz8IfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2021, at 03:06, Alexander Potapenko <glider@google.com> wrote:
>=20
> Hi Chang, Thomas, Borislav,
>=20
> "x86/fpu/signal: Prepare for variable sigframe length" has presumably
> introduced an information leak to the userspace.
>=20
> According to https://elixir.bootlin.com/linux/v5.16-rc2/source/arch/x86/k=
ernel/fpu/signal.c#L126,
> save_sw_bytes() only initializes the first 20 bytes of sw_bytes, but
> then the whole struct is copied to the userspace.

Looks like your fix was picked already though, thank you for catching this!

Thanks,
Chang=
