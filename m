Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51484A2B92
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 05:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352347AbiA2EWN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jan 2022 23:22:13 -0500
Received: from mail-tycjpn01olkn2064.outbound.protection.outlook.com ([52.100.215.64]:5706
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230242AbiA2EWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 23:22:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzCjqHQ9hYrTYAG17VZOeEi0zls7ZwGakESYgcfb/WVLUOF2byrujh59ZKzE8dm44UyRmPctMyPBaKLFJpm8IE9M2tRUSn0/TJrpsrH0lDXJ0m8psQ7ACLHJz4Mx1qFF6JLRCg6XLwD/vzvBg0Xh5txyNocHBbXt3ANwI3qMJvH226oUaZkX34c9KYbq1IHgnamjTPtPWpCCvmiWpwVLjzWcW9+lgZZyXx93eVkIhbc9A6oTanB+YmwKnBjBI3tTDLMSyO5mKQc+iRndqDoPFwZ1e0OQVbUoCgXEtYofa9fKwgwzwYQi2pg4igJF2ljp51PnIq+x/6L49dmRiS1Tcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QarM8+djMkVHv2hJYB3XCKeV8fk57M8Rn4+zaFdiee8=;
 b=moW0rqYBcvu1413Po/ZUizCQXAO0UQD2pxkd1+3PpYwATmwX5wiJxi0xtiF0wsrdJlr2DXsDzWosP9DwQSwIkKaG4FQloXgu9dYWQ4C435ERwcgi/MUL2j1MTcYlmdHKlh5/RV3IZiDak0jkFaP4yUlNiOM7g3XloAMPB3TccdnWKKsYmxZVl5DFRXFFtx2Ss5zqkczwhTRsQZVCWAN2aWXDFf1npC6zcTHzLh0AkveUGBpCsRoyFfuYpfNlbvvh1LpRI3gDR9k5MvXdWKsCRiLVZ5wGmDzL3wuoE8L7247+IjojNl6a86QIemHI9nz6OU25C6HoaNTNkstobjFzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by OSZP286MB2444.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 04:22:07 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6%4]) with mapi id 15.20.4930.019; Sat, 29 Jan 2022
 04:22:07 +0000
From:   =?iso-2022-jp?B?GyRCOH4bKEIgGyRCN0pPSxsoQg==?= 
        <oscar0225@livemail.tw>
To:     Marcelo Tosatti <mtosatti@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v10 1/10] add basic task isolation prctl interface
Thread-Topic: [PATCH v10 1/10] add basic task isolation prctl interface
Thread-Index: AQHYFMfEv6IFusoDjkC35kI0Md7K1A==
Date:   Sat, 29 Jan 2022 04:22:07 +0000
Message-ID: <F94506EB-DA71-43F1-9126-8FBB134F6104@livemail.tw>
References: <20220127173037.318440631@fedora.localdomain>
 <20220127173206.358254456@fedora.localdomain>
In-Reply-To: <20220127173206.358254456@fedora.localdomain>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [cqWvOJx5vgBTP+KPzm6NStz6ZfJkiETjvquf0Nhigrm3qm1+NBnYYtHeNWNzTQrdoa3WtWrlUDs=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc3b6b14-3db6-49b1-a551-08d9e2dee979
x-ms-traffictypediagnostic: OSZP286MB2444:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdnLcTVCXxLWnm4SFD/84Ki+dzASSZDYLzSCVoUB+bHmThDUSu0Bquyw1LgPrIv4//daG8UR5bQZWp/5sO2tHkowp7TJd+0zEqxEfs+FP2EtpNP9Pppu+k663vvqamRwx42A8s5JH1GDxeIoByt6w0xxHPIS4Jn1CnTCqa4w5Nyh5AkuhuCEIb0sugz656Ks9PbrIb9LnhUKdltuDyWbVoYERGKDcVysU3HnITPfjCGPSv+DA3+85QyT9m2F/KVH60l31yjediQLSV4YeiWottJq9K8lhbwjxYTaTOUTtrXCx/Isb7cPwQSib+P/aP5Uw+iCiXEAu34lyn3a1m844bY1dbaUw2WQZN0jv2ousNgkpcmhpBIMH9SiCiLhs4cp1DYS6sZVO2HF5GWy+KVM1+f6mjLjxW8JgBbeSpO1Yaz3rTkYk1btCoEDMH4+9Ec/MWb/zQj+hV3689aB4hm0OignS5AbSATWfN0hjj6rtRv4HIfE+ZIE1GQNR5GLQ0KaASAdBOvRpk2jlHB6KfE+Q7YL+bDEiMdxnzt4MvXPSovCHk/BpYQI6p0YL7989UQcpwi3aF4mpXOxHfM5uzBAeg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NUMyajlUVWNEUGhVejR2V1pmMWFLdjBPempOblpsWDdwOFllSkRJbnJF?=
 =?iso-2022-jp?B?Ly9IdmtHRXVRK0lwU0pTRG44VkZBS1R1Uk9KNDhMcjBvbGxMNmZKcWt1?=
 =?iso-2022-jp?B?d1RHakF5MWpkMXZWTTFRUzFoS2oxbU1DcUlTWXN4bFpXZURlZ3JBQWsx?=
 =?iso-2022-jp?B?djFaYXZUL1NHakVQelI4NjIveXdZRUd0MGZEL2pqc2g3Yjc3VnRtRE5o?=
 =?iso-2022-jp?B?QTNOVzhTYmVBU0J3TXh4dTNOTVgyaDY3UVNUYjNQcDFCSlNLWVFzRzBt?=
 =?iso-2022-jp?B?eUhESWREQmVkZ2FjL29RNkFRRjZ3TmkzZkdzalFlVnF4Z2h2SXpmaWJm?=
 =?iso-2022-jp?B?U0Y4UC8vdnVZYTRFN2NFTGhkUHJYUmViS1RLUXVaUFhZREErVU9SaVZr?=
 =?iso-2022-jp?B?SHFvcTc2N1JhYUp4M3I3Q1BNR2tDbzNJZGUxayt4QjBieTViV2RHbGZN?=
 =?iso-2022-jp?B?NnplRnh1SXZjdk5uS01TREpTN0JOZEhOWkRueUVCQ2ZWR2NRRWdTekcw?=
 =?iso-2022-jp?B?Z0RpcG9rQ0pFMWFEbWhsbEtPcjFOMDZiWVZabnllb1RHWHB1dzNlbElF?=
 =?iso-2022-jp?B?eWl0QTU2Tm1hai9aa1hoSnlhS0x2NFF0VVNmQ2ppWUxSY0c1UnBXM3NH?=
 =?iso-2022-jp?B?TFg5M3RLVjZaNm5HUnMyZUh0SG16VWpnUE5WRys5YUlCbUlPVWIzcTZN?=
 =?iso-2022-jp?B?ajZCRnB5M3dWanMyaGJIaXhZUUQ3N1ZNTGV3ZW5IWHo1UlBuYldCMG9z?=
 =?iso-2022-jp?B?eEkvc3JGS2JGNzdHb2F6eFM1Sk1Ea0ZVUGtCaElOTkd3ak8zTDU4WWJo?=
 =?iso-2022-jp?B?K1RTV3oxZ25YSGhGVlY2UDFrVEVwcnFDQVFkQjNQenhMWm5YZWNMT2Y0?=
 =?iso-2022-jp?B?cFlsdEt5OEJGVGh4bXk5Q1RGWElMUEhhNEFaMHJ0SGc5RWlXWGxXL0dY?=
 =?iso-2022-jp?B?aDZST1RmT0FKUjJsRDcxdlBLTHM5Uk9ma1dEQW5iWGp4K1p0bnd5ZFla?=
 =?iso-2022-jp?B?TnFudG5lMWFJekdpWjhpNC9EbTE5ckJtTHIrYjVZeXVzalJieFVTMVVz?=
 =?iso-2022-jp?B?WjdZb2YxbDhjVVBCbUNLSUVCQ3lHSGM1WjNUSVc4bWMwZlBLbmVldUtk?=
 =?iso-2022-jp?B?aXdaZHEzSDlWZndZZ2VnWU9DOTRzTnJac1VVOEZvL3RxaGh1TW9USVc1?=
 =?iso-2022-jp?B?ZkNuQzJJajJ4RWdBcG1vYlpEM21GamxQL1pIQ05YQVg1RHlIQmlVZG1D?=
 =?iso-2022-jp?B?VXZoQUJqV1N4T3RndXJhOFBmcUV5a2VraFJMMXNxelFheWllTkd4T3U5?=
 =?iso-2022-jp?B?MnVSZ3Nad3VmQm4wOG5PV0lVaVBQWHBtdXIzTGhxVVFTTXhJdUhEU1RL?=
 =?iso-2022-jp?B?YlJpZml0NU9MbUZBeloyS1Evem8vSnl4NTltY2VEREEvV0UvSzFzclNY?=
 =?iso-2022-jp?B?SUc5RSs2K0pVcUNnRTNFc3FrNFBRSjA5QU8wdzZxZUkvd3N0d1czalli?=
 =?iso-2022-jp?B?MjFEWVp4d3pINWJKeEZSeG89?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <762F0556AB4335489F1C1BE3CA9960BA@JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3b6b14-3db6-49b1-a551-08d9e2dee979
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 04:22:07.7004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Jan 28, 2022, at 1:30 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> 
> Index: linux-2.6/include/linux/task_isolation.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6/include/linux/task_isolation.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_TASK_ISOL_H
> +#define __LINUX_TASK_ISOL_H
> +
> +#ifdef CONFIG_TASK_ISOLATION
> +
> +struct task_isol_info {
> +	/* Which features have been configured */
> +	u64 conf_mask;
> +	/* Which features are active */
> +	u64 active_mask;
> +	/* Quiesce mask */
> +	u64 quiesce_mask;
> +
> +	/* Oneshot mask */
> +	u64 oneshot_mask;
> +
> +	u8 inherit_mask;
> +};
> +
> +extern void __task_isol_free(struct task_struct *tsk);
> +
> +static inline void task_isol_free(struct task_struct *tsk)
> +{
> +	if (tsk->task_isol_info)
> +		__task_isol_free(tsk);
> +}
> +
> +int prctl_task_isol_feat_get(unsigned long arg2, unsigned long arg3,
> +			     unsigned long arg4, unsigned long arg5);
> +int prctl_task_isol_cfg_get(unsigned long arg2, unsigned long arg3,
> +			    unsigned long arg4, unsigned long arg5);
> +int prctl_task_isol_cfg_set(unsigned long arg2, unsigned long arg3,
> +			    unsigned long arg4, unsigned long arg5);
> +int prctl_task_isol_activate_get(unsigned long arg2, unsigned long arg3,
> +				 unsigned long arg4, unsigned long arg5);
> +int prctl_task_isol_activate_set(unsigned long arg2, unsigned long arg3,
> +				 unsigned long arg4, unsigned long arg5);
> +
> +int __copy_task_isol(struct task_struct *tsk);
> +
> +#else
> +
> +static inline void task_isol_free(struct task_struct *tsk)
> +{
> +}
> +
> +static inline int prctl_task_isol_feat_get(unsigned long arg2,
> +					   unsigned long arg3,
> +					   unsigned long arg4,
> +					   unsigned long arg5)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int prctl_task_isoln_cfg_get(unsigned long arg2,

I think this line should be "prctl_task_isol_cfg_get". 

> +					   unsigned long arg3,
> +					   unsigned long arg4,
> +					   unsigned long arg5)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int prctl_task_isol_cfg_set(unsigned long arg2,
> +					  unsigned long arg3,
> +					  unsigned long arg4,
> +					  unsigned long arg5)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int prctl_task_isol_activate_get(unsigned long arg2,
> +					       unsigned long arg3,
> +					       unsigned long arg4,
> +					       unsigned long arg5)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int prctl_task_isol_activate_set(unsigned long arg2,
> +					       unsigned long arg3,
> +					       unsigned long arg4,
> +					       unsigned long arg5)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif /* CONFIG_TASK_ISOLATION */
> +
> +#endif /* __LINUX_TASK_ISOL_H */



Thanks,

Oscar
