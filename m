Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7745425EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiFHGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbiFHFzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:55:52 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064016.outbound.protection.outlook.com [52.101.64.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FFE251964
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDiF/4lRHCzTRR/2UMfSTM1KRx83pS/Rbz43aU4lTk1YaRw/q4tlA9v9yiw2D1SlfqHHuxnLFnTQwviOpRHbyPHaAZSaWt1Ibtpq5DPC0KfPC3sSBm+nb2nP6VroftazI5GbysyEnKpq5JUV24ZtoeUJG7yfHqEmwDxPGOLQmuqI2uyDjU25jSgkufXXAA/i/G8EcS++titxEOPiKiy8RVA4rr/w387IXUgr22eMCvDvmVuzx/RDVnPmo0DZj7jdTVv0K0Li6v8Bt3Ow/XC+RruBg/4mQzndfp4e/W0gxcBiPjnfWszlVuTsMozvyPMI0kE58YfnA7izYkPXspu9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1Dv6GjyAMNnh6Y/d7LlHoDJ8APcy8Tjtt1vlwSHupI=;
 b=iPGERceK9+H5LOrLQwHpQVpVgglRhq/uO8ZmvgpAjdqZwCKdBS1RmwZFSdPj30mfEr5/4cScE5iUiS4TUaQYpLy3Dy9pmHV1tv/pF1ElvlvMslaH306Hg54738qvVSYv/m9zeX9g9utXEywjwXUeEuYU65Ys2v0g6/e9Zrqcavgxb/Zomm87X8FB+btcyWcAcU3FfCos/Kl9cljERG4kwTiso0SO5rybiEhTkZr3v+I4xKHrmJpjOI67DMfxz0gubm4b6FVlQdh0ftH1Oc4wec3SVa5jnm8OQ92cNC5iMB4Puq39UxHUuakvU6WMLf8j7emVypgAj8qBm9Tt32Zhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1Dv6GjyAMNnh6Y/d7LlHoDJ8APcy8Tjtt1vlwSHupI=;
 b=QXJhrXd0Vk6yxUro5J7ArnChpjz1QtgbzvijzUEM5AmDlIKc+ykp/TmDDO8jsmQW36PUN7rjzjMqtp3z7lkct0aOx5IYEnFlc5shDChRITG1Ow22R5J9GhLIAcv7Y5w70wUfyr92FL1VX9Z/9jOT9T4zTMFrZVT/XOm5FMU4caI=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SJ0PR21MB1296.namprd21.prod.outlook.com (2603:10b6:a03:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1; Wed, 8 Jun
 2022 03:59:00 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.007; Wed, 8 Jun 2022
 03:59:00 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>
Subject: RE: [PATCH v3 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Topic: [PATCH v3 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Index: AQHYegPAfmbLbbh7zk6WMSOLg+2tw61DwKAAgAEivxA=
Date:   Wed, 8 Jun 2022 03:59:00 +0000
Message-ID: <PH0PR21MB3025187DD97DA485E6931793D7A49@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654560915-22449-1-git-send-email-mikelley@microsoft.com>
 <1654560915-22449-2-git-send-email-mikelley@microsoft.com>
 <20220607103538.GA25071@lst.de>
In-Reply-To: <20220607103538.GA25071@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0bb635bc-4865-4ea5-bdc6-84d8fcabc310;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-08T03:56:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59bba5a3-a0b6-4efe-71e2-08da49033866
x-ms-traffictypediagnostic: SJ0PR21MB1296:EE_
x-microsoft-antispam-prvs: <SJ0PR21MB1296A5FD9231535CDE980861D7A49@SJ0PR21MB1296.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XzeK+VZFtl7LUr+CWAm1bEw/cB0quOlUfXPLzzEgM29UJkOe9dYmtwp7FP6dwPrIW0A3Z+PP2jcMcT1yMZyC+t4ZZnHv4cZSKiCxPIrZjyPBlInFl4ZBGgpmNLZ0sq4wUcOzpFHfrMog74CY6SKphJ81GlIUuCsHP+6drrnJKD21Xh07SWHSUSmlAP0xWiVxZZpMvVYisExgdhwerkxCFLY2ejmyStN5zoxu2MHnfmfAiMNZVpd9cPNcESqB4mV81Znk/i42CJvbTUPx6V422ZAwtBdQ2nm7nykdkiUJ+wWTC5kNkApFyaJXkGeaKF6zpvhl//B6qQEOnI5Cl5rVboSYX/urRVNjHe4ZiDxpoZpkiDyJHhQNKEzWgTbKjvZkwGpyQQ17rFALCgY+5UL9G1In+ZR6uBY38puhMt0RXR0FFvi2PUDSB0FjeTzJb86aDn//0tGHRGD0V3SD2xF6cmqYdlPRuZtk0XKp9P1e29HT/V5n/JAf3sy0fHi3LITTtGsmBCAMewDJ0w9oPUH5tyjxeuqR54G8irImugJvMnrPGjkLE7BjYFwYdEKBxPB9rszuTWorV/GP74gf1OW40/fZzl/mCfy+xl9kK6fHiBzZ+ZGsP75Ah6sgFauVXSZFUumZZuXl/1MHE1cDKkfuSRB/2Eh7fTYDZtTOOAqC7kKU7Si8d5iUDT4qWkWneM0s0ywKROiHR+7AaMgFIZmXrfImXP4ey4K9s17ke3IS6mKX8RMP3dVnXj+NVEaKf/3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(508600001)(9686003)(71200400001)(316002)(2906002)(33656002)(10290500003)(86362001)(6916009)(54906003)(38070700005)(8990500004)(122000001)(5660300002)(6506007)(82950400001)(7696005)(82960400001)(55016003)(38100700002)(186003)(107886003)(26005)(66946007)(52536014)(76116006)(64756008)(66476007)(66446008)(4326008)(66556008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9CyZcSXq1FXygNYPm7opMo7ZVm9WGIbEIfgZO9ILWjUynsw7CYeI52JL6pzz?=
 =?us-ascii?Q?6JI2Hbba3hoUc6sh7oFnJsK7Sbi0UJsgfb+68WCRyjpfy9jOi2AQWzNdgTap?=
 =?us-ascii?Q?bRiRINaFISDiruxwB2m8Rra0epmHdvuHsMOadS9N6zr6e3t7XmAksVAMsid/?=
 =?us-ascii?Q?UV4nptIco4+OeFodXGITvr9DfVahbZ7HLjFy52jua/NtxuN3BlHkp6LpE6aG?=
 =?us-ascii?Q?N11VA0JSJJQwTeMZKkHYduWR6Bo7JRYngfdRKQkrmjhDd8jif0OnSWCvg3HN?=
 =?us-ascii?Q?9axORhcnUUXdo/hwuxI5yFQPNU/MlxwBQFBKUXh8KHqlwEuM/HJCW2Qyyb5k?=
 =?us-ascii?Q?BO3PRq5LywaykGd760jxMkLj7h+mihVRTXoex9FqSWdLFDTbgw+N9gpPT+UX?=
 =?us-ascii?Q?a0y0h8fjD03X8xyqFSVp0vFraTD6++G8A8+dgBJ9mua4IT9Lo7hxFsDNtgAv?=
 =?us-ascii?Q?F5PymRICyhnX4cSieTB1Nnc3SFr4HeHR3vShjYwtVjWS5ytt3CY3l8nOmSio?=
 =?us-ascii?Q?6hzXlD9lRP9Zz9UQ1xGTDAjIGBNVHA6OP/FLUg1Fks/ZxwE+rBvkz0SPWXkw?=
 =?us-ascii?Q?FdFzHtAdSl+w1PdM8rEO0rh94kwAHiHrN6GEjXsEbM7V4os2nAz8l9v7Qr9m?=
 =?us-ascii?Q?TC6Fq/OL8JdoI6/hgevIDN3d25qehA3IjJkrwqT4q7E2x8g8Vj7jkelKKA/6?=
 =?us-ascii?Q?7nDniYCIcpuEbY+T8uvRAp0zfeAOpJpZIWhOmYPjTJ6EWRbU4YcHbAT859no?=
 =?us-ascii?Q?52ABZHUxbgw10+DwpcBVWF9LgWq6zuLgA5p9VfQ3UwpKlVFJY7goYr/d/Hf3?=
 =?us-ascii?Q?2YsmEI0SWw7E8hOJi8vqRJCulCQ1rNBeRP1XSiHGpSSHyZwwaa9IYDGmesFX?=
 =?us-ascii?Q?G3BcsYoZj+6WVVrAmowL1eo8cK4OM5Ys5ikTgSb/yRHkUJtvKLvFgfZMH7jl?=
 =?us-ascii?Q?Lmucnw0BU4ZdPeZsUfQMLJM7jGHjGZswEqL4TWWizZwXe3atBwhh5zTTrCjF?=
 =?us-ascii?Q?/ivDOaKCZO3CwqVPO45HC/i2dIn+m93wkeNMe+5VgjTLZFo2p5b9Tte/mRiQ?=
 =?us-ascii?Q?acqL466vZTmegxYpTPYVjtPSyAzrYyvpI2gpb5L2nQDnJ7BF7gutcKztmnAJ?=
 =?us-ascii?Q?Et39FSQgpY7PYsyL6f8WiZWLXAGpbhRGTDrenq7TK1pfHulVVctMEHRbxNW0?=
 =?us-ascii?Q?IAlDt+9OikYfkK2bjjz2cGEQq5iWx7atioEP6eOWWnQrUXWpiNbZBV6loPMj?=
 =?us-ascii?Q?N0vq9PtT0mYwRX3sLjlQNSLQyaU7E8W9wlsHSx2aXxXrEuq9rmwCyPHidEOV?=
 =?us-ascii?Q?XIIu59+PaCBTNb7N/prtbI6BqlnJwJUb34tamXKv300qJ3lJZBRPvOYVNYkU?=
 =?us-ascii?Q?oIREoN71zIx+bCgA9DnZT73T9oJjpgU00j1oPX62VMS856T1NiEjLlVAxUzL?=
 =?us-ascii?Q?1rVEoE6bpP0F+HEFLML/NfgMsNlMn1XwNGc7O7Oi867LPgcXgRF5pKPUg4Hm?=
 =?us-ascii?Q?Uhl/u9+GgbWhtuKf/BhaZbTcDpz25dS2053DC4terQtPQD7Th/DXoth7XlQi?=
 =?us-ascii?Q?UyWEKJzQpz/7XyMR+Cd5giiziKViqawsKOdmHxJ7C5Bi8/p/ufmjaqgHCSQo?=
 =?us-ascii?Q?fla0MuNaTzbwBZ2turoDwDfVzME5pdnOVEl0DGc+jsSmZIBG02xHKe2aa9ux?=
 =?us-ascii?Q?fWYmWmP+zkunOuIoeCH3F2gWM+B9mFRaVaHRqLlQqBewHzLg4NjA+3V7QKxq?=
 =?us-ascii?Q?WYkhBncSe2H4hDkUppDufZH0qX846Os=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bba5a3-a0b6-4efe-71e2-08da49033866
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 03:59:00.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLSE9KNqLgdk4aAZ33AbTrWu56d54MadpIgzI+FrW+qLVSCl8vlkco+f+9Isw0UuwYGeOJ2PyhBBHNth6KEz9JvyiXxg2qpkkZhzLK6/t9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1296
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de> Sent: Tuesday, June 7, 2022 3:36 AM
>=20
> On Mon, Jun 06, 2022 at 05:15:15PM -0700, Michael Kelley wrote:
> > +static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
> > +{
> > +	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
> > +
> > +	/*
> > +	 * We can't read the CSTS here because we're in an atomic context on
> > +	 * some transports and the read may require submitting a request to t=
he
> > +	 * to the controller and getting a response. Such a sequence isn't
> > +	 * likely to be successful anyway if the controller is reporting a
> > +	 * persistent internal error. So assume CSTS.CFS is set.
> > +	 */
> > +	if (nvme_should_reset(ctrl, NVME_CSTS_CFS)) {
> > +		dev_warn(ctrl->device, "resetting controller due to AER\n");
> > +		nvme_reset_ctrl(ctrl);
>=20
> I don't think we even need the nvme_should_reset check now.
>=20
> nvme_reset_ctrl first calls nvme_change_ctrl_state, which only allows
> the transition to the RESETTING state if it previously was NEW or LIVE,
> so we are already covered.  The only downside would be an extra kernel
> message if we already were in another state.

OK, I agree.  Patch 1/2 can be dropped since there's now no need to
move nvme_should_reset(), and patch 2 is simplified even further.

I'll do a v4.

Michael
