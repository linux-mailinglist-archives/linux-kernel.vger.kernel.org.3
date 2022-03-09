Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070044D3840
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiCIR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiCIR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:56:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF313E38B3;
        Wed,  9 Mar 2022 09:55:14 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22961Ncg005807;
        Wed, 9 Mar 2022 09:55:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=CaO3rycb2hQFNcTYCKw8XzBrhdmzulJeQJCErwlPENw=;
 b=GKaE1QiOZUWwkU7WcMlChaOQYMFkvholxOcfQGPq/wDgXy1kxEeGkhg+V0LaMHjSv0+F
 LJiT7OHyeiZ2G51h4JL2biF93pa3yjJKTPQUIdjYryd1ovi/M3sl2raA0FBM5aaRifSv
 9uqmsbz1afhUpggIHNxTlCpCUEiAgO55vmY= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eppkk3ybp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 09:55:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhR9dwxhWqnp5oDCyLcY7Ko67uCeTEbp0CUQ+5tqz1F5xzLQHwYr5gVEx9cVjO/vHeGFRWvuiKTkXxagD5bta1UdleJrssCyUCSAenxATPExulaS0AmIBAA9TWXRL0zHw3SjvTv5o1zcyICWSlbqTaut4xdGOeyjrBo/Wl4L6yqhipVvdyN1F3wRXNmK/y+VHOcPhehzpiEm1UfyZGWZ3hZzjan8mFAmiR7XrbV0g/4ahuY8AuVTPwRktFnAzeY7Csbb/1XhdANWy+akPxLLCtkHARJoiKRH5xhmrccA4uGgIrXulelAqr9GkZalUC9wj7C5oZ5j9eulF7hvZTfmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaO3rycb2hQFNcTYCKw8XzBrhdmzulJeQJCErwlPENw=;
 b=od4rCD0BffehJWy9Ez4l74/doB4qKnJYiUzF4Ncrbh8AWRJoBqOv5KEaKlQBFBMCIUBvY5zeVK/8pJ9whz15wIoxORaoH4Axh2f9UOiAp96HlS8YzolobwKbnHnjpVaLbkb9Bet0TuM5xzGfenM7JatJBIluJNUe5JN/ZOh/2uZsHf5dXeeL9z95eSZyHFSHd1CnxkvpkUAEQHEjwi7HgR6yt93ZLHwHsn7udpk3iQuwlZnwWSGVRi4Xmn4Nlfc1GQK6ArwVVulHuY0o2VbHHErZJk1ILQELvnSVhTdZg8PNQcRkCkSQSBM5iZ8om8TJokL7Z+tXTgXIjb20SriXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 17:55:11 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 17:55:10 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
CC:     Dmitrii Okunev <xaionaro@fb.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Xiaoyan Zhang <xiaoyan.zhang@intel.com>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT
 status
Thread-Topic: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT
 status
Thread-Index: AQHYM6IJ2oHmymlKRU22/keFD+BGbqy24J6AgAB0YAA=
Date:   Wed, 9 Mar 2022 17:55:10 +0000
Message-ID: <Yijo1rutEdEVbH2u@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com> <20220217123753.GA21849@duo.ucw.cz>
 <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
 <20220222093101.GA23654@amd>
 <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
 <20220309105343.GA14476@srcf.ucam.org>
In-Reply-To: <20220309105343.GA14476@srcf.ucam.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a1897f4-ff79-4c5c-7128-08da01f5f460
x-ms-traffictypediagnostic: MN2PR15MB2878:EE_
x-microsoft-antispam-prvs: <MN2PR15MB28782D5B2FF2AC2DB78906DDC10A9@MN2PR15MB2878.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5b2qXsMmL6JB/g4Zy36m2V1kapJDQ+zqpQmYHRwXyQTBMhGzRIPkLOvsiFj8e0RbOH5FnmIgqLercU+4VBc9q1P5SP5PZwDeC1o1aACeqIfZMTzUKjQleUXxx8VFF1ms768P25FrLvl1kjYO9ija53dEEepqYJVywiDYJ89/CHxUKQJYpqE2q4ddBQpUwI8KuXPvOXA8rL1SMNlY0kZAIXlcmxz9gA39KLbcxFAydcSbLPg1p9bbiJGAATjS8gKht4qBybvDJu2pHL8grsk/f8f/lkHme/FxgS4ucuIjEVYJloJEfZ2Ukqom0eg/4QTKFK2vI2KxuCFnN4quqnjlJiN17FKr6MmOgkeXudMraOuZqqO5ZCuC26AXEQvnLma9eTstdghss/sjXyVhBnfDF6YpsGMEmN6TcHQuocCBT8Mvvf5BPJEM0zsLEF7B+0QI8T3VUSW/qrLmPqHwKvsTW58wyd0nSSBJYUhO5fBuO02ClM+aGv4fjaa2uoDJuDMuh/sDjkTk+iM9nobxz9so3FzXRnsnHvxHK2Eu/ERlsWw6ckV4dlEfvngibjo/ha61fTB/cCCPT+ZY1qodgDdTQEvND5RSHb4XCasF8q1aHILr9jZymuY6/0iwco/pghiniZwGEjVWNP5t49zPqqztnxi7g0x0NdDp7+Lw8i4orfYNdhk+TRA9awDTpr9e9FbYVlPgvWQ/sa/2MSp++I+Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(8936002)(7416002)(26005)(508600001)(54906003)(91956017)(76116006)(71200400001)(4326008)(66946007)(66446008)(66556008)(66476007)(86362001)(6506007)(6512007)(9686003)(2906002)(8676002)(6486002)(186003)(122000001)(38100700002)(38070700005)(316002)(6916009)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+m5ncWm6Q9Dfw5VDvl0ygROpWDCkld0a9yaj/KTfCrFoVLhCF8oXf8QkXs7H?=
 =?us-ascii?Q?SdfE+7TUFL072wkpRj9CEa4FjqvE2VIWo7jrVTyUIF5m0TulQVvXWul9bDj+?=
 =?us-ascii?Q?ZBLR7hZxMh2OzVzKrTvIl+yJ8X8oO9X9xXIZ2MNdNHayztYv8Ydn5RX4QeKd?=
 =?us-ascii?Q?+0pwSG3Tw1HS4WQvbYJQ026h4tbW1TFPyR8ErGjH2JCaiWep9zbGvdLJe21P?=
 =?us-ascii?Q?vy7Sin2/B//SuAfSq2HWWy0+lEnKaVya81F1zfrTMX/wh1qAboB9moJm/Czz?=
 =?us-ascii?Q?HdgYTK72V6i/YvXQ3KGuHynAqjWzv35GvuZGLw0AHtZ1lMr82za6fVMUvEFL?=
 =?us-ascii?Q?dksOQ8a/ekmFbs1T4ObxUWostmJ5jkVIBaDPbZYQ45I5rKWvn/FdEnVqjHQ/?=
 =?us-ascii?Q?3yndT/dF1QGSfjarH+yt1hEQYso/szCURhl7lJcP2786prGtOOLpIghjlcUx?=
 =?us-ascii?Q?OYjwsk/xDp4Ig3IAFI4GAaKDprHS5JJjYmaf7N0jBNKiKRn5g//OEOK1tkr2?=
 =?us-ascii?Q?Th8r8SpEnhufSDqPTkzWjjg32Ut7ZX+41STfvsMuEbDfFaBgpyT1kD9VF6h8?=
 =?us-ascii?Q?ejA1mZGB4Ltpz4RKx3aFyFIxQ2Ver1GMMaNyaXUMdMptSDSPk/e3+r1KUMBd?=
 =?us-ascii?Q?nxlGvf0iZgOusF9IfkCS+vUQK09mArzE1PWLSbPWL2JggxJ3vbBFkg9v0y8q?=
 =?us-ascii?Q?fz4ksq8EDphQUMuOO3FhA2zfZEmZkaOiKAPX83zzM5mV5Db9ONry0uvVK9up?=
 =?us-ascii?Q?JQp3yOSsa6WF7hMoIW+ZbssdpW1uqu7W1La4X7zfIwU9pRfjeJFEDA9dekXa?=
 =?us-ascii?Q?9r1R9cAMLANFCilKu0rlfYlN9eYnX6bgtzf48AkKAZ3gL9J02ge8xK9aYso1?=
 =?us-ascii?Q?eDWP2ZGWvHUUfWJzqwcssc5zIcnOJ82ykbLdl9u/2wCH2OfjL3Z0BasuAcd7?=
 =?us-ascii?Q?f0mQcAAl1hbRrTPWWPXNhACloqTnt+PimFu+Ibe6r58ulkDkfsGotmKTQwcK?=
 =?us-ascii?Q?YjN7H7BD0YHgFQcf5NVu6JBql0LPF57sj9aDQ2B8g9zMYbnjEaSBMkowoCje?=
 =?us-ascii?Q?T2cqJ+4ymsmP8VJIsQXEuynJPvILeFusBuXcr9gPdn3iE9ioeNI2Fco5FHOa?=
 =?us-ascii?Q?hk1ze7SrBTP+KjjREPBYVgh9layj29R7niBXWHuv+gtHEPrIEhlNuRHrtfqe?=
 =?us-ascii?Q?320w37CjUGB7Ujxozfi7tG+IsTIDVsFTGw1vE3J9vvIQr3MvHXLicjkjPVZM?=
 =?us-ascii?Q?u+UjICfTSU+xPFrixwkqCx2ELhQHhee+gUnke557HlyS3i4DNxxJwKLH/vx0?=
 =?us-ascii?Q?pigF85CK8De0UbEUjsNMbACPPtoIMF6rLaoQ7m825FKO5b/eMSLi+fdkD1u+?=
 =?us-ascii?Q?sfGZ4J6h63DgmozoCxnq3fpXLJlI+JitQkgrvhLqcoa1xmEdSsHigOuBvhjq?=
 =?us-ascii?Q?qn5gyz75KVgpcUkq5/gwNVQ+/olKqcMy?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95FBBE519844CF46B5283C91411AFD97@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1897f4-ff79-4c5c-7128-08da01f5f460
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 17:55:10.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ht1zI705tHMD8qLFQVDQBNUyzuORnyL+K7BsQNWWGWQSm7OJwLHA7qr10UO+huz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2878
X-Proofpoint-ORIG-GUID: FNk62J3Usc3oenJTUapHTd-hyUABQ9PC
X-Proofpoint-GUID: FNk62J3Usc3oenJTUapHTd-hyUABQ9PC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_07,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:53:43AM +0000, Matthew Garrett wrote:
> On Wed, Mar 09, 2022 at 10:40:03AM +0000, Jonathan McDowell wrote:
> 
> > This module provides read-only access to the Intel TXT (Trusted
> > Execution Technology) status registers, allowing userspace to determine
> > the status of measured boot and whether the dynamic root of trust for
> > measurement (DRTM) has been fully enabled.
> 
> So there's the obvious issue that in the event that the system has been 
> compromised this information is no longer trustworthy - is this expected 
> to just be informative for diagnostic purposes rather than forming any 
> part of security policy?

This is purely for diagnostic purposes when the system ends up in an
unexpected state, to aid automated remediation. In particular dealing
with unexpected PCR0 values that have failed attestation; the state of
TXT helps with trying to diagnose how we got to the unexpected value.

> > +	  These registers provide details about the status of the platform's
> > +	  measured launch and execution environment, allowing userspace to
> > +	  make trust based decisions. See tboot
> 
> Mm. This makes it sound like it's expected that userspace make decisions 
> based on this, which sounds like a bad plan?

I should clean up the description to be clearer for v2.

> > +/* Shows if TXT has been enabled */
> > +static int txt_enabled_show(struct seq_file *m, void *v)
> > +{
> > +	/* If the BIOS has enabled TXT then the heap base will be set */
> 
> Sorry it's not that I want to say "Wait are you trusting that the BIOS 
> will do the right thing here" but wait are you trusting that the BIOS 
> will do the right thing here? Does setting the heap base guarantee that 
> TXT was enabled (and, conversely, are there any scenarios where TXT was 
> enabled and the BIOS could have cleared the heap base after a 
> measurement event?)

If the BIOS hasn't enabled the heap then it won't have been able to pass
any data to the system for a managed launch environment, so I think it's
fairly safe to assume if it's never been set we're not in a situation
where anything has tried to initialise TXT. If we're in a situation
where we've tried to initialise it and then something has gone wrong and
the BIOS has managed to clear it that's probably a firmware bug and I'd
expect to see some status register oddities too. We're not trusting the
BIOS here, we're just using the fact the heap is actually setup to
indicate that we've tried to do TXT in terms of diagnosis. (And, in
fact, one of the failure modes we've seen is where TXT is supposed to be
configured in the BIOS but it doesn't actually get setup at all and we
correctly see a 0 entry here.)

> > +/* Shows the 256 bit hash of the public key */
> > +static int txt_key_show(struct seq_file *m, void *v)
> > +{
> > +	seq_printf(m, "%016llx%016llx%016llx%016llx\n",
> > +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY)),
> > +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 8)),
> > +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 16)),
> > +		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 24)));
> 
> What's the expected consumer of this, and what are they expected to do
> with it?

I added it purely because txt-stat is already showing it, and it differs
between platforms. I note 315168-017 says newer platforms use CPU MSRs
0x20::0x23 instead. So it's informational at this point for older
platforms.

J.
