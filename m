Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E14EF852
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349466AbiDAQrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347276AbiDAQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:47:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2617FD1D;
        Fri,  1 Apr 2022 09:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9WwH9mKh994BvKY6Fqc/ih1DegBrSbNjyYpUxtP6CIoJna31Iz9qrPGGBZuSp3etD9GF9eISjUtJ3luEvIM0d6BAp3Yc9wvsMGZr8wM7agP6gydcGAJrj1Xwsz2WT3ICd/jywEsZuyyO1dneofveH4IbVBvtQecYZNefQtBHuddzRvKYJ77RT2h0f/HdOJ2y/cDqkD3Lf/PAdY/uPAxfCygdgjONA/cq/yHbQsM3FENw5MfUE3GUL/nVjwipaBrBywyQurUJKTQO+howgodPZNSPknY4JzlsMbRnpuhhsbRnso1K/a/8GdREdMBzJq0ZJ6iZhiD2w9qECbbmI82Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlEKtjhJR8XvCSKVfXC0Qna2OE4vsUeqQ1RxnFCBbj0=;
 b=H9nOoIOLaBGsxeLpklfljasVSpaUAJjfBZ2jRr4TR7I3IuQYPcX2aiUIQVRMTdeq9uTTakXYcWoM/eJEqpNrluSML8lgLKPU3Lej/uh6lusDbJayJV8vj1dGYKGqixvLQ6U31+7aW0ZJ8b77PEHVVg+hpXXNc2KT7povP6tlwuh7r5ByhfdHCrhXRM+PSyNA6GMZDKNe5CJnAyeSUWiO5G0aBNwhladTqw7zRl43CXWMTYy66SXcnHXfxAB9E28HlIbUKo4YcaYM0SBUFeNsfebwlStNK7tb+M8LFMFPZ8QL3IF74DxsNzcaeUJbzlHNv/DzTzwqnxVPELHMJQ4Byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlEKtjhJR8XvCSKVfXC0Qna2OE4vsUeqQ1RxnFCBbj0=;
 b=qmmpLeod4eM/rvudLX2zQsnmewBfTaN/oaliQDT6gp9R3QhxSaQZcwNjtv3chKi77EINoiDrzjMWC63mr8RC/+yqwyAVk+ZYs360N/bwWXa1FKVIIw2raXNnbWH6kWL0h9v+WZHp2Hsc0BoYgh04gC0DQ22E157oJjreWCG5fl8=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.28; Fri, 1 Apr
 2022 16:32:20 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 16:32:20 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@lst.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Jian-Hong Pan <jhp@endlessos.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND makes
 system resume failed after suspend (Regression)
Thread-Topic: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND makes
 system resume failed after suspend (Regression)
Thread-Index: AQHYRZ3V68XuTiqqgUaaieIAsf4QmKza64WAgABVGpA=
Date:   Fri, 1 Apr 2022 16:32:20 +0000
Message-ID: <BL1PR12MB51571269CB0F40E4257D2232E2E09@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <edba451c-1798-c60e-5d84-0a9f6a5d134d@leemhuis.info>
 <20220401112649.GA14810@lst.de>
In-Reply-To: <20220401112649.GA14810@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-01T16:32:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1bd51392-ff91-4db7-a099-36d4837e7b7e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-01T16:32:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9e5eb39a-b390-4a1f-ab97-0a845335e8a1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5048efee-b1ec-40aa-2709-08da13fd31b2
x-ms-traffictypediagnostic: BL1PR12MB5288:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5288B967976EEDF60F522033E2E09@BL1PR12MB5288.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OS3/4PChJXfcyYj0wO/lRAi7HsyVjgorfXmsy/SZFYT2TK1ZIfBkJuMGeaOmpGdHbaNfXxriqftZrABG7G9cFHG3cOQzY8MWeiYwvhJoxi8tcFaSopP33Rn6c9jBmyNA7ofYHeNW1NTcYXjTyQUa7SPJhGeUBL8zFlwwBj4onZ2+rj0wMP9gF3HpkGaI41yj3178pRHEQZhsN1rXPScbGNYK8rJeARLxWssrdZGE7r1SWsNKPKptF4W+kyPEmH20mlme86klTh6mbizIKGG3cUcm4qUybw2NEbfMZ43q+6VOlHE+Q72bZMAg9zO/YEU9S0x3wld1ov2uSm0El39qwdM1V9RlRWuW2i8vLhNdeGbxyuYfAOhhnCaQLv72uW2BcNM4sWgg5ho8KhIr27a9/fwZz9/Yfiudj1Yn4zx6/cXCLEhmojuuLrVEN8+gdhOm+67l+sV/gJk3H8eizYW391IJ9XYaf6zWL5X9NJ2F1K1sdHZKYMTL7BjXUKkr3FVbkZsv4OcXaT8eW9KtDi2fzfI5TsN7nHdSeyb7OycsUxV8G23Za2jKGwyjKk9CWucLlOQYGlVF20CYmaPRywF2MUjO2CJj5XEsze3OuDGeDhrVVu2ZkDybAUgh5j/YQ5jSLvqYZfNevWgMsCWPbOuK5dDdcyY+B5kcF8lq5w8jzbvLMrlMKu3HoueVmMz8qfvFkiUEa0tgds53fU3wI1RYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(9686003)(7696005)(53546011)(122000001)(186003)(4326008)(8936002)(5660300002)(33656002)(15650500001)(2906002)(52536014)(8676002)(83380400001)(55016003)(71200400001)(64756008)(66476007)(66556008)(66446008)(66946007)(508600001)(38100700002)(38070700005)(86362001)(316002)(110136005)(76116006)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wh0733oUcF5aeAvV5X8OjLiJrRgkWGbBI0WZvpfeM39ozEIW4rWwfMcoFOs5?=
 =?us-ascii?Q?irNdt9t8dL1RdHqacqihoXNlbSh2cQuhoNHyS2mqffyW9/NbapoVYl6JquIC?=
 =?us-ascii?Q?LhiTKJf1va9rOHmGPLVnRqS0OzfSVZQiW7bV4oIj6Me6CezKEeJXtKG99l0t?=
 =?us-ascii?Q?jDzgEM8F2I81FTyo3/TFBaU7VJRxu+NWMuJvpLpR3V6u5WC8PhzZbtenSX6w?=
 =?us-ascii?Q?uIASkcFTlN7exvB5Gv17mFFTWlBODpkFL3/6lWUgP3TkV8dpA3/raWQzWPf2?=
 =?us-ascii?Q?w8w6cKGGDVGEr/wmw6vEUWART/2KsZKy/DG2ftHd/0RXVBtOpPnxhDZ9I+aj?=
 =?us-ascii?Q?szNIfx2iBo7FVq+2yljXQ++0GF5b+sdG6pJ1UbQq+x3ldZWy2uJ7HU9aBOri?=
 =?us-ascii?Q?TAwV4pIO1kLSOv5OioYrSI8KTfP5a6W25W8/SM5ii622OMgCrES+Y0hnDlZV?=
 =?us-ascii?Q?dNSEKJOp3V72FEc1FjpYZCBqKFALLNUjRKwAO+h9wE7bClcymITlZcYwiGVS?=
 =?us-ascii?Q?XL3meg7+TrMmOtqEeUDqzoOuqE+zKdq3/4+Dg7Ni7lq/z/X7tLx1CcSvBsg2?=
 =?us-ascii?Q?24vaflLVLWFDf3II7WHPeEuQmGGim4rbz1vWOo8nvo9pa4Iv3cDiHoJEt9TH?=
 =?us-ascii?Q?6dcwYBHLiKJZPU12TaDtXFgtT+xSddxy+Uh3l+/YohqEwFBEHrhvAjy+FExT?=
 =?us-ascii?Q?vqA0ROJqG4nC1ga289aZZB/xo0ziyUDNOBYOmDJXEMT1KVGrPWCtPy8dl95L?=
 =?us-ascii?Q?J69KtxJC8Cg+7Yul3u0ZaSKDyZkpVlPYzLwP6HKM56JTQ05KYpvzzEvnpkJz?=
 =?us-ascii?Q?ZVsRsOMj8xnJmiZzjaIXQsF9AJpNeG19bFPdbsyG4yOYejMBKjfKl+b70wPy?=
 =?us-ascii?Q?yqtQRWHhzBe3s1rciuB8X9G4Ckc7qkgre8iqBL/YTSZFG+Kb5T/60LtiI0GD?=
 =?us-ascii?Q?a/FhPgwno/eCdJRTu5JVLHbUzswXIYJkKtGMBbL4zDZsORGXQlOeVAYQBeTk?=
 =?us-ascii?Q?5L+2SvCrL84ENuoclXR6JB/BEDkIrBwMQMlK/IdJRpjLbcIiKz2qazvWVh8m?=
 =?us-ascii?Q?RvHrmVfniL/hdZERAGje4jJz3BRLR2HcGRsFShoKrypqEEp/DEYCaTG0gHMt?=
 =?us-ascii?Q?HtW4OSn+HjCaVhJOCsyxgnYYwGECCpkJEHx/3aXXe8H58TBketUNApmp8NA4?=
 =?us-ascii?Q?GyEFYHUX5zfEXz+k5aaz3u7VipKsBJy92EwDf4BEogUJjiJzZ2Mywekgf/oS?=
 =?us-ascii?Q?JgHcww5h8x/MofX466aHvDFWnx3w4iQatvK3LIpE2F+WJDBKs6vik5ZKXUOi?=
 =?us-ascii?Q?rRrgWtgVh5RjAVkWfIbZ3QbFsNz20HfPnwD9FV/Ik+SNcXiVVVELK7nBCWZ8?=
 =?us-ascii?Q?9X5uGy6MKLvDwi3wvQsGBL9ZlWlSeN3uEbMFP6zv9S1BsPZEwnbMsJALk8QO?=
 =?us-ascii?Q?CRwriNgGIt1TpXShyTpuoAYA7ljG4hznr7w7nSK/frHi/4P96VTuHCxh/MQ/?=
 =?us-ascii?Q?fYnPa1f7QUe4lRNd+ilrctdWzRP4xjfc4xcpq/w+bNW98occyxoj3ntu7/Tp?=
 =?us-ascii?Q?trZF9+Xrn2BUMYzUKtOSiViZ2vonb0nZUEv8jmJDyUz82qDJUe7JACvwJwmF?=
 =?us-ascii?Q?a4574EW+P+6L9IoMAGCbPyMjvepGkMYv7f9ml71F3AGetNxPt9FB+3XV4SpQ?=
 =?us-ascii?Q?GELrN3TJ7oHFV7BktyIEjOHZTwR+ftGTiQC92vDFvNKlb2Jpn340wTRdo97d?=
 =?us-ascii?Q?3DrFsoxTNVML8goDFMxJLB+1jJpwjfxtmP2oHO+8qN4AKxHlva9A1Pg1hTTO?=
x-ms-exchange-antispam-messagedata-1: tn8IpOtzCvvdYg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5048efee-b1ec-40aa-2709-08da13fd31b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 16:32:20.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: potIVK2bjqM+A5+c0VdhaRO6iuRMoDGzXrq1IqsXK7u40Y29pp5yYpre0orwYZMc221BdLxCrkpGHedMkaI8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, April 1, 2022 06:27
> To: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Jian-Hong Pan
> <jhp@endlessos.org>; regressions@lists.linux.dev; Christoph Hellwig
> <hch@lst.de>; linux-kernel@vger.kernel.org; linux-
> nvme@lists.infradead.org; Rafael J . Wysocki <rjw@rjwysocki.net>; ACPI
> Devel Maling List <linux-acpi@vger.kernel.org>
> Subject: Re: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND
> makes system resume failed after suspend (Regression)
>=20
> On Fri, Apr 01, 2022 at 09:55:14AM +0200, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker.
> >
> > I noticed a regression report in bugzilla.kernel.org that afaics nobody
> > acted upon since it was reported about a week ago, that's why I decided
> > to forward it to the lists and all people that seemed to be relevant
> > here. Mario, could you maybe take a look at this? Or is that something
> > for the NVM or ACPI people? Or was this discussed somewhere else
> > already? Or even fixed?
>=20
> I've not seenthe report.  Looks like the BIOS sets the StorageD3 flag
> in the ACPI tables in this system but doesn't actually want it,
> which is really strange.  We could add some kind of quirk based on
> DMI matching, but this all seems weird.

I've added some comments into the report.  I would be suspect that this jus=
t
uncovered a wider problem and we need to dig into more of all of the
circumstances to confirm.
