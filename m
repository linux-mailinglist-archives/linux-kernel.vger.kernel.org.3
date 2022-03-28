Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887344EA301
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiC1WSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiC1WSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:18:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB3BE7A;
        Mon, 28 Mar 2022 15:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu29d05gOWSiQhlUKFGv8g87xAAILjkSL1uMkHsA30OT0XszfPNd2fZsQPA7i3JNhVhJHqCsA/pC4ldoK6Zxqb4fBDA/Q3kI7kxw2EMoiz7wDvxI0Zqb7gFLUHhejKanPytgUXYhDLuKDoHBoQ68LnNuYck3HvtudwNV08hk0OOQris6eu3IIWV5E9uSGi5cGpUxkVBAHmo6C0HkbjHT12e/J3OhT2tHWr12lQeiTfMxQC/g0bULV2Hg1IFURZocsNBR1FlEj+mnvzvr3AaoPWnCaK5Vhr3R7m55kqz5BQNYwMU6egdnutW1LHcH8fI5QIpJZOuFZgYVAGNydCFPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHcsop71DwBcVMnd0WQLLptotjlrSH7fp9iMLs5HjBw=;
 b=l4wYKB8osP3GH8GqayWsOVIRjQdR1ZyL/Trysh9Jj7hx+1GKcFaTaFLmXA6pOJeU7mzniV3O0zmJ+z/k6S9eXc9+9cg2Ci05mC8SK96PsV4EJcgN8QJpQJ1u1AjPe7O0ida5Ddty5KPCdbnQ1TeRwCbuDyjHpCIM0JCUJ0XHwToBKy3gXgVHnt2gIOe8LuYJytefiMHvWwfQNHJZAfL0+0QXZpjk/KgZuETTkFf1iexcFgAyK2RqaNuy+lbLUpswvkC8UillIOWUl44kc/wuDLQwUbxT95uW9ujuF4z+mT/EzmCSzk9R0XaElgup4xAZnXWBfnl/qWZCJI1ss/CPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHcsop71DwBcVMnd0WQLLptotjlrSH7fp9iMLs5HjBw=;
 b=YT1v6eEv+q/oM2sShYTJOHtjldRaLNqa7m9OhrmVVyvbdkRbM4dW9bZCOxPAxX4m7dYzl+et3twjOt9N4+kduu7KBhgkCVyXPhl3TeteXUHvc6AvcGKrVJ+3R3ZadTz7SFXcjrSq/efUGGnUPBTopruqi+ffYIjftuUx30ZxnLU=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB2715.namprd12.prod.outlook.com (2603:10b6:5:4a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 22:14:59 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 22:14:59 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] Improve usability for amd-pstate
Thread-Topic: [PATCH 0/3] Improve usability for amd-pstate
Thread-Index: AQHYQAsN0/gEe0j8DEeyCqZmzLGXZKzTI0WAgAI+z4A=
Date:   Mon, 28 Mar 2022 22:14:59 +0000
Message-ID: <BL1PR12MB5157E8B3EF9E0F87629198F8E21D9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220325054228.5247-1-mario.limonciello@amd.com>
 <YkBQ548oCbCqd6lE@amd.com>
In-Reply-To: <YkBQ548oCbCqd6lE@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-28T22:14:41Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=237b5a9b-f614-4839-8a58-036eff14015d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-28T22:14:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d31fd233-8418-4fd1-9cc5-bcaf386cc5ef
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 860cc6d8-fab4-4733-7e50-08da11086616
x-ms-traffictypediagnostic: DM6PR12MB2715:EE_
x-microsoft-antispam-prvs: <DM6PR12MB27151783D3D7F7956F35C350E21D9@DM6PR12MB2715.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+DHx/ejPZelSYZLVXDW+KpToMRzXbKrhFPwFuOf0vSlYvtNAW/67QuhXNcoOk1THIIAex4jFGlh5iOZOF+h9NSYRmV9Mqy8uwk6n7xQRuZGzA5nbwJqDdhz+nf8Lqwr0QNRj2Dbtj5ZjftSay5sq3TOnNGlhL64Hv0z28lVZLpo1/YOEsHiSMl1kQc9/t46x23P2gteXTHX3/vDufGWdvQqGRGfWf/pgF6mmh0WBtUsB3Qh32lobLrfEafe46mcoe7LDxXK0KjUQYtDwsWfLNEE9Lp94bUZbnhGTKVnLIp/1+6i8sc8efNN237khqo3wvTupjfKKlaLyCb/rWkUZOVBnwWAJ+XU7dRu77ZfPhpeeFyBa2+lHZfqRSjEb1VIJIZmLoBR2mpZYioFWH5BMYcvUQwHmzvZEyk+hO3YLydawrwnoj1trlcB+/g0YbinrRfLDvFZxcuZGK9stZEzoG1v+sIITz49rlTuLc2AoU9KqQwcyU8fs0Ko9PpBmcUhxm+7bzclT2zP+iPSXFRRnJE+PYlQWcz/OwACvnnS/mRTDJkyhDGBE73w7/w+HBdoXGIZ8SrokP3j8OgaAVXQFiD28D6RwryxhGwyqSDeK1lVnDieb4deH+KwTb/WGg1yHae4VVxodciwQU6mjJz4s4EHnVcU6wIeqBo7yfbeloICZ32rQix/xg0Jl/s73UVCvA72NIPGOBfAleMVCLbc7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(38100700002)(71200400001)(66446008)(5660300002)(76116006)(8676002)(66556008)(4326008)(64756008)(66476007)(6862004)(52536014)(66946007)(2906002)(8936002)(33656002)(508600001)(26005)(86362001)(9686003)(53546011)(7696005)(6636002)(316002)(83380400001)(6506007)(186003)(54906003)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ewxRgu2Zk8dUclXRgOgZ/5iX/G6I+2WeplP59lHjqbulsJXgLEjqKboNcwv?=
 =?us-ascii?Q?lE/jmYtgnlk1w8TV62VS8XSKCXIlgTOmdRzmpsacXGKEDzZHvQqRXs19iF8/?=
 =?us-ascii?Q?KRhN4mIbsZD9y9kR82ATTCJRBa7fMQf9PZJpjt5iUmScT0Ujge8IyD/NnmOa?=
 =?us-ascii?Q?UsoHImzlcWzCJ2WKA+mjXXswhidpZRVCeAWN+xugaousBFMVkvM1gZAUS674?=
 =?us-ascii?Q?IfphayTsZ6GUCKJHnO28SDiPHZ438ZDD6Q0NAE8OUgpeYWOyEoXzW1oPb8ed?=
 =?us-ascii?Q?hrL2jRzte/eakQVP89eP7V9FPBMdCW2G+kilHueH1tLKcIt/pMtz7I7RlF4M?=
 =?us-ascii?Q?FdqFb4zndRoBpM41VbMLoNceny0vuHiWY3tsu5+P1sdSNhkUKdZw76F87tbo?=
 =?us-ascii?Q?rHDuL2AysfO9N5kVAZKOglhRT3gKzm6BVpU6T57Y30y6N2z3CWLz2w13H4sN?=
 =?us-ascii?Q?70WrK4SQLLQjGU2wDYnE7yOPhCMHcTyEzEYUMsJp10eKlz1huiAQk80rVGXh?=
 =?us-ascii?Q?5UhFXbxa+76gtfHlLFJI2mdLmNkF9H4u4lTZ7XOXvhkufWUr5HehT9WER8xf?=
 =?us-ascii?Q?Ot6e93+KE1EAE94bPGetXHq8rOVCoOn+y5RHJHuaXSTRq37ZEycMCn1IQwY+?=
 =?us-ascii?Q?flGXdjdagNgOkh23PjWEMkbNDhtMCi3Isi7rDHqgmmrH067F+ywREThI3ABX?=
 =?us-ascii?Q?SXHD6hNB4btd5r9pkubyDdctvPxMDerWcLclLys0LoKziJ+SiixGf+JqxyjS?=
 =?us-ascii?Q?eDyw8vidy0cbJVxf7iK3l5eYKKfzUvcK6i5vIOmUOmb2SbLsnDr7SYlnkxEf?=
 =?us-ascii?Q?cmGZ5kWb0mbio002+rFQUfBmcNfkI+Kymn0siEEINNS7r920kWnzWwLdSacR?=
 =?us-ascii?Q?CjhXFKurOkyP4A+cQFnp2MkY2dCWsiksjS+/0uExrfFfBANO7mPiH+u0HxT+?=
 =?us-ascii?Q?DwpY8wAuDPpH41nm0tmidCpS/gIhS31kmsmOoaJKhibZHRNNwTEIwHYpu47Q?=
 =?us-ascii?Q?pfBvNrgTuWkJ9CLNr/jKl5eU2k8kl1hgWkMFIuwV0pYmygT+wXEYM1kCR6m9?=
 =?us-ascii?Q?zdT5O5kN+Oqftef9eJP3zuuiD87/XzTmAFyhiuU/1ZylPgDa1QwfbQ5e3pZN?=
 =?us-ascii?Q?4Tk2ahxQ0kp+dwqR5qIKiAgEyZZmh1OK1uAZAC8d2/o7z295tOCOu9nQxAme?=
 =?us-ascii?Q?g0TA0Xg8cvdvUDX9N1smxzIVMt5i/vjtP368IzgKGucDCEW1cgtKdKhEDvpJ?=
 =?us-ascii?Q?5pKMshbkvJqYL6PWyTNfNkq5I8xYADaRY9rfb61ZKLq6H7qEvsHsiqyEaYFT?=
 =?us-ascii?Q?NvFu0yL990Q/q4TikldsNVIJyj1JMtbllmWLbFvLW3LEedSL+vjJV45yYyJ8?=
 =?us-ascii?Q?OaOKffBPUMCVCD2e0tbgTCr7dsWd7X1u/QLuAbr9O2uG943q8fVUUC/X3GZO?=
 =?us-ascii?Q?tB46RYAS0nDMKSyUecO515QxZcsTXiqqE3TkEZqPjqhxSQFApQCtEawuFtKT?=
 =?us-ascii?Q?1MKE3Ri3ePmiFwx1AghfuuMV/IzAaTWx723YQdFL8kXHqhmXPaeDMsg354Rp?=
 =?us-ascii?Q?tpaprLEdqLY/CPOXlxuOtSn46GTh9BeYBZqKsrK0pOQtOCCW3TH2BsHzuytY?=
 =?us-ascii?Q?wlNGzubxCQ8DKn1ObSSXf+VkjFujl3lZ1dCDgKrPVvID0Ax05rgn+RUZlIWf?=
 =?us-ascii?Q?b8kSofyavcWG8TGSyzJuPGbbPnXdGWlxLvMCV7HYgwIJIBoVWgV8XNkXVQkE?=
 =?us-ascii?Q?yTi5h4Th0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860cc6d8-fab4-4733-7e50-08da11086616
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 22:14:59.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upcnbmR4L4kEWaiBYn6O8zwoABVgy4BrcufMW/d0bKvhHSFkNcRHIYcXX7FOxFvNdVarYT+Q0X9Rir3CSswPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Sunday, March 27, 2022 06:56
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Rafael J . Wysocki <rafael@kernel.org>; Viresh Kumar
> <viresh.kumar@linaro.org>; open list:AMD PSTATE DRIVER <linux-
> pm@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 0/3] Improve usability for amd-pstate
>=20
> On Fri, Mar 25, 2022 at 01:42:25PM +0800, Limonciello, Mario wrote:
> > There has recently been some news coverage about `amd-pstate` being in
> > 5.17, but this news also mentioned that it's a bit difficult to use.
> >
> > You need to either block init calls, or compile the module into the ker=
nel
> > to force it to take precedence over acpi-cpufreq.
> >
> > This series aims to improve the usability of amd-pstate so that distros
> > can compile as a module, but users can still use it (relatively) easily=
.
> >
> > A new module parameter is included that will force amd-pstate to take
> > precedence and a module table to let it load automatically on such syst=
ems.
> >
> > With the patches in this series a user can make a file
> > /etc/modprobe.d/amd-pstate.conf:
> >
> > options amd-pstate replace=3D1
>=20
> Actually, because the amd-pstate is fairly new for current distos, we can
> modify /etc/modules-load.d/modules.conf to add one line "amd_pstate" to
> inform the system this module should be loaded at boot time.

Actually I don't believe that would work in the case that acpi-cpufreq is b=
uilt-in
or gets loaded first.

>=20
> But your method also looks fine for me as well, the amd-pstate can force =
to
> replace the acpi-cpufreq. I am not sure whether anyone objects to this wa=
y.

Thanks for your suggestions in the series, I'll adopt them for v2.

>=20
> Thanks,
> Ray
>=20
> >
> > Then upon the next reboot amd-pstate should load automatically even if
> > acpi-cpufreq was included on the system.
> > Mario Limonciello (3):
> >   cpufreq: Allow passing NULL as the argument for unregistering a drive=
r
> >   cpufreq: amd-pstate: Allow replacing existing cpufreq drivers when
> >     loaded
> >   cpufreq: amd-pstate: Add a module device table
> >
> >  drivers/cpufreq/amd-pstate.c | 19 ++++++++++++++++---
> >  drivers/cpufreq/cpufreq.c    |  4 ++--
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> >
> > --
> > 2.34.1
> >
