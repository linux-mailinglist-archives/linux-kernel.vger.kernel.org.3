Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E31462D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhK3G74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:59:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:26426 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhK3G7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:59:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="296961683"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="296961683"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 22:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="477019405"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 29 Nov 2021 22:56:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 22:56:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 22:56:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 22:56:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFR2u48HL7nGGVT3I/NW9mnqlv1P/bE4yjusWVn9wH7tsiYrNa6nMB+r1zss4B7TpGz49HhTjx3wnqqSilEbGNFk06beptsIHzT44DI8obDc9qM+EYJ0rv6A/s7MHdwQtijfdmiHwxzY3hGz7o6bjSRn9oo0ytzYfDTiMGzPtClZnJ74Nmdpym1UR8mJVYmEKR6PTlj5tVlMtrkMXM150JrlPdxzvJ4EHq4T9MMUveGBlvYdWjbJV8WLGXkYu21wQRfS0vATP6Hz6TuJ1uETVBFK5d/Jlof+sITet/YcdQ48OIXWv6co4nqMDVzWDFA2wQtkM//kjkooxKgQq5ap2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI+xfsutUXBEa4viZH17WJBGl7AzJ/lbIq6bSdrWn2U=;
 b=fAAAl8H67GdIUe+68SIYsvL/PqakOniM/39+uMmvmplgRV/Gogkb89E5jlgaYRpJ3t0SUAmn+0LphAzECWNs5mRHYzfONmSUjMrrQ898tThHk3nZ/Z11sG7G3tz9QoOoaon4m0UsumoQXurnPc4+JmnqDTp2DBVC6RtUl7doMoCJEFU7Xf8IdsxxHK10HHdF/6x14UWM4YQ6d1MxumVvYJMWS7qYsEqdvJSpAjlVwVNGwuD7PfTSgi6h6r1j++AWOuO4J/KtzyOOYA3Sy25tQiDOmddZ1QrzDV4bkIGkv/KRaQFl/rkccRWEH22VXiTDXJfyyC1I40RTT+LRfglOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI+xfsutUXBEa4viZH17WJBGl7AzJ/lbIq6bSdrWn2U=;
 b=n+GV+9tE5Cb772kIFMAxHd3uAkUE9Td84XIuAYdc93bAvNAwpCoOx/sUj0tc+mSYuAi+0HkukRDTvXBh76+od5TM8zh/HqcjKrktyoX3SKMaLd13F8RMue0lNoLaQyPCvYqPReOMmOqQeX8vdKkJeCmCbyflDrF6XfzLe2shzuU=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 06:56:31 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 06:56:31 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 08/15] x86/power/keylocker: Restore internal wrapping
 key from the ACPI S3/4 sleep states
Thread-Topic: [PATCH v3 08/15] x86/power/keylocker: Restore internal wrapping
 key from the ACPI S3/4 sleep states
Thread-Index: AQHX4XAEJFOJQ1w1J0ysoCyRSv0seKwbcmWAgAA5ioA=
Date:   Tue, 30 Nov 2021 06:56:31 +0000
Message-ID: <157E75DE-4567-42FB-B4F7-BE2A401045B8@intel.com>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-9-chang.seok.bae@intel.com>
 <YaWa2+2eVSFXY1U3@sol.localdomain>
In-Reply-To: <YaWa2+2eVSFXY1U3@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d68d1f98-065f-43db-1331-08d9b3ce8a8e
x-ms-traffictypediagnostic: PH0PR11MB5158:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB5158EC69D87D7DB98AE1ACC9D8679@PH0PR11MB5158.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:246;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fvoEjuiPuquNFVSkFWBC6qDyNnMPpkQ8RtTKocJBX0S809ZOs/2ibM0jVwfp8Olkg7+NPWs3LJcpGVlgZG+dWikw3V5aB1az7urirhs1tkLpITmqcrGwBasbM+Ejzp0aIUdhg91HGtxT3w+SEswT47mvMXC5yETZBNW9i7myPxaX2ZJXJfEcNjHBjSFcVr1xte+G/+Klo8OjMIy0oOUwWPwhNBeHZQR1cj4R6Fvo8Qf/RYhxU6ZFCizCfutEljFaShytXNbBARbYvYDcPcdWYTnTQ26Kt1PPLA2w7gDMTtzDRvJoWQviA3EF0VLZaT/s8MqKiTg1H6BhuQ3qz1vzEdP17F+0ZPr4w2r/ul+44D39Eq4p1H7k3VujHfNK/qUDSMIKLIsNjPFAQ0h18P/vPzoDRw2fd/UAiU1l2nQmOkG+bOAu6GY8UpH/iXiBhtDif8XMWcFCEzwVW94ef6SgFw2FkR1z0kqb8CrW28zlvcBtVRQyMZLXfaQScgusB1P51+QXySSuXavBOZoZsNNWqXbkJktQirywxx7snTdU73CRU4IzK22Od3ox2mb+8OiQeQx5upTdt+kSVu8Prb5uJ82V1AjIa3sBJ6uR1u8jlS9xuCD6ZVDjanGcVNkJ/5TJcwXLM3rj006uGKpzp0fsrgWu5K+mQAACB5Xln1X5+gGPoHSNuLaqZFxS4Y2Iu9trazgLEFRQY2h4xrAdGEiV2gog3HL9GX0ZsKKlf2Ug/77/qKyQ/gTw/rAPivSqB1KC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(36756003)(4326008)(54906003)(5660300002)(122000001)(2906002)(33656002)(508600001)(26005)(316002)(6512007)(8936002)(186003)(71200400001)(4744005)(6486002)(8676002)(86362001)(83380400001)(2616005)(53546011)(6506007)(38100700002)(38070700005)(66476007)(64756008)(66556008)(66446008)(6916009)(82960400001)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J6IVPHrgocliEyniTpIsR7WzEoPEqDb5BEGBlMnfJxNRYppftscVc7denLf0?=
 =?us-ascii?Q?5xp16R/tePXbsszBt69yWKI4jY2scLzL5iBxMT/VQNn7V2wu3KvWx9FCGWcb?=
 =?us-ascii?Q?DY1ufGQjvF7HAw2W2qKJGG0aZ1toVFQpAGpMND6LtuzlYNipvbotEeHf7Avl?=
 =?us-ascii?Q?GgK5B+Ou3eU0s71USUXqNRT9FFgM8+5tKvfzGharyRBAE9JoHqwXLl5/6niy?=
 =?us-ascii?Q?qT8gEzhbbsWyjGTGogO1DDu8U4hASXJsRj59jxsyZMbS/NqTK87Ok5btKVTc?=
 =?us-ascii?Q?ursqfBvlppEqWyiCNcAM1ZgBu6JPqSYV4sf4cD4SBfHE9CizLz6bGlx4DVbE?=
 =?us-ascii?Q?FlUE0Ycs4uqO6/7LAiZ3GZg/9h+R8g6nnK0PQjDg74wAEQ39DdGu2vP42iYa?=
 =?us-ascii?Q?WRmdO9JVNhzwWuaM1TG7ol7ukP6eStYglXqs5J6Sw4SKSdeauScasfWYcsuL?=
 =?us-ascii?Q?tLu6pjzlNQ0WO68Ryb/51NBS9xVgBWEboqjqrvFZCJbaXwFwSwSq6t0j1BTR?=
 =?us-ascii?Q?SlAcQg4z7f4FCZgsGMe6TYh22hCdE0/bF5vkbRgZSFSiNB1vr/CaDUMyo923?=
 =?us-ascii?Q?6CUAwwMh9ff0PZPogwcdKPEIN3kD71AsXseMZ/4psDDCRzip+h1ypKOf3Nim?=
 =?us-ascii?Q?ulFOn03N4iQCBX9s7Qwo/ctrZ+Jx6ygfx5mKPl6OY2Gws/fcMca+mRGmDRKO?=
 =?us-ascii?Q?QgPobN5B3yW4YMjsXwZXZxjFt1Owx4k7XHR5NyN3bxP0Q7K4hl1BGtiYFiNu?=
 =?us-ascii?Q?JqWlb/JUYhZL8KBPdiIyP//dnCaV1A6ghFZ0IpHCOrEAo2jH29myIVu4NwuL?=
 =?us-ascii?Q?0Qy25US2LocCicvUHyGXD3f1bHlEGgjbaPcyTG+711lZrx1Iwwvf5Y3XaVG0?=
 =?us-ascii?Q?kOD40uQ2NsadFxchJk2wgy5PSKql0XC1nqo/9U623YrO0R+vHJkCzYEC11CS?=
 =?us-ascii?Q?Url7up3TaIH/ZBs3OBM6eV2XlWPrviZfZuQ8zbAoFYFwjKuis3/Jt1THoTNV?=
 =?us-ascii?Q?OiKout/STfBaKYiBVX44EmjgxxDE3jlZiMygNUOLtGs4ZyqLt6c6X/d9b1nF?=
 =?us-ascii?Q?SP8V0mmn7THXv5HuNPZKR2jXYCcHiFAPrHO2R3joJfhT1k/fXQ7b1NEAk0MA?=
 =?us-ascii?Q?RoiQjYVBAkI7Xvhg0UPwlG/A06fz8gF+W5XldJPJQIU3ZyGqewpy6pkM0Xj5?=
 =?us-ascii?Q?AkBdK87JDzcY0ViMV/8x3MFDrx+lOfpgKifoj9AbTQCfiTGO3M1pknYRYOHt?=
 =?us-ascii?Q?q39EmcHdGrCceKuni1T7OnnfA5FDP9yBdQxB1mcRFwzqNTiPMdqilwAEwBzB?=
 =?us-ascii?Q?RwREZnaWnkQc33V0GGs3Ul/niua7zSomY+GcKDaxZzA8zSC5Kk8aRo1E03+B?=
 =?us-ascii?Q?5rzQVupiw7RF5rsywa1n5IBmiJNL6lASxnf/3j3MD+KdW2PCNzKsdAoboCyL?=
 =?us-ascii?Q?7C49XSFJqTzsgfJHqNVqywcrSb+YtSPwpttgFY2HOeLj1OFbi3ThnPMUieWv?=
 =?us-ascii?Q?pfTZ4wSlbjAC4jn8j4BIpjOUR7X04712HuDC+fE82f19rgGJj1NyTkcQ7EtX?=
 =?us-ascii?Q?cMWSZFz02rEMHO16Z+kaktsf43mmiNyJA2rGndEuMgxeYVw+sIppgpHQthlD?=
 =?us-ascii?Q?ppcgaDOk9t5Z7tEOuiJy8mKt0TH19GZ9M6w6JIOPbDGhId1nqN7DFc7TRg3J?=
 =?us-ascii?Q?jUYHEuG8n9mxK4uXENXe/kXfvtg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F95ABDCC035C8045B323BD4418A57E0D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68d1f98-065f-43db-1331-08d9b3ce8a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 06:56:31.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIFWvYsXrG7dZ6UgcGznZk6CLKPx3ExH54eoBBcU1KXLAdkhXdtZ1Nbh/MONQnF8PSzD2mgpU3iZ+eYcKKtIpY31xKsO997GJH1BGypgbJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2021, at 19:30, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Nov 24, 2021 at 12:06:53PM -0800, Chang S. Bae wrote:
>> diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/key=
locker.h
>> index 820ac29c06d9..4000a5eed2c2 100644
>> --- a/arch/x86/include/asm/keylocker.h
>> +++ b/arch/x86/include/asm/keylocker.h
>> @@ -32,9 +32,13 @@ struct iwkey {
>> #ifdef CONFIG_X86_KEYLOCKER
>> void setup_keylocker(struct cpuinfo_x86 *c);
>> void destroy_keylocker_data(void);
>> +void restore_keylocker(void);
>> +extern bool valid_keylocker(void);
>> #else
>> #define setup_keylocker(c) do { } while (0)
>> #define destroy_keylocker_data() do { } while (0)
>> +#define restore_keylocker() do { } while (0)
>> +static inline bool valid_keylocker { return false; }
>> #endif
>=20
> This breaks the build when !CONFIG_X86_KEYLOCKER.

Ah, sorry. My bad on the last-minute change.

Thanks,
Chang=
