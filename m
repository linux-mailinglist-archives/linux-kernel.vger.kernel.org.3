Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E41B56C014
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiGHQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiGHQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:15:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2119.outbound.protection.outlook.com [40.107.220.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D113F06
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im4d60EoqNvkF6vdH7zTu6qBgw7dhx291Cfy54+ytSxquUTpGStadUbkyJ5PqgNxLnBqQfXxbY9SJcCpr+4dCd5UWFfZZd2ek7JPMIRsePjUzvc/joHTrLT4cgylO+tsAFMjzOC7HXmtbm4kvcAVmV0TGu4wGgBsFbBNwqzxtOCuIOVl3f7oVQm4LYUMqjNNzyQQRWiOlwv83/QsXZPDkBOf9nl7CBQL/HJ6YL9iPb487UqF8ZUE+csrhs8M+aR7ViVwyr+zhm7Qkw9Kn07wa8Qf94uTyPh/zB+IZ13ZyKtxYaW4tI4ouZ0qsNh7Tp473PrQlnnnLVkfkZymy8Mufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVpQ2OHasWGS5hBaZFKeEZk5vi0XZimXtYfTrgf1UmI=;
 b=W6+8UheTNY/I9HwiwFEjIxlXXmAP3zzM/g0F4KsPySkM11QSWW4r91sdRIHkarcmNdiaZybX3VPdO/zlXb9KZ7Bodvl3PohuhgD4hYZFHih0ZMtGk3rb/NuEigs0g52cP/StwZnCoSBDhhXqg1HkMRHIhBy7KeSBCK+UCL7KOm3ildJufpvCLqys+/LGpKhiWkgzxVF1U48c9gt2LPYf3RMtMT1rMZ2UIixeOvXmWy2/CQ7q5ZBGNYbT6jM77tkpIJ9njbEY6ZyvCoviJfOT/74hNy0AfAaDby54kZQJGkyPMgtKuza2AqeYGV+2sS2IawBHkbIhQZFZ4E05zAgqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVpQ2OHasWGS5hBaZFKeEZk5vi0XZimXtYfTrgf1UmI=;
 b=pjBQXUsuoCfpG36jR6M8OeqQ5Ut88oFbVC0VPMnjjnAjXrXIU0XNi1kPIHJfT6wlDAgHFKThL5qBx/dNAwOCH12/G7QNtv3HNckrCyJwYOQnZR1rRj9bG2PQFTCopRQn7n/l5MVSCwvA+eV+k/HiWUUy3dFNxpl1lyatgqESMm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR01MB2638.prod.exchangelabs.com (2603:10b6:300:fe::18) by
 BN6PR01MB2722.prod.exchangelabs.com (2603:10b6:404:cf::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Fri, 8 Jul 2022 16:15:01 +0000
Received: from MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2]) by MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::e1e5:b43e:c774:40d2%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 16:15:01 +0000
Date:   Fri, 8 Jul 2022 09:14:59 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 17/21] arch_topology: Limit span of
 cpu_clustergroup_mask()
Message-ID: <YshYAyEWhE4z/KpB@fedora>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <20220704101605.1318280-18-sudeep.holla@arm.com>
 <Ysd160PQdWoDIdRC@fedora>
 <YsfzXL7fp3sYVgda@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsfzXL7fp3sYVgda@arm.com>
X-ClientProxiedBy: CH2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:610:4d::13) To MWHPR01MB2638.prod.exchangelabs.com
 (2603:10b6:300:fe::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b32f8f-aed6-4d9d-1030-08da60fd0264
X-MS-TrafficTypeDiagnostic: BN6PR01MB2722:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeIhZguEwEWuoO+ketWqk3bY/lfYRVqLIiB5owmMwAJX/T4dsLAdUhiPEBJsYa6p1LfcYapRXHmmjJW/zzwzbgG/JyY8AJtsqiq3a3NLJCaWgxQlhzwrbWiaMAUu/s9JelAEccViz/nbKpOE+TKkc/eM33iZS4FpK0ydGOWYtO7EVp6ZAg1E5vnqoRzcN9BpygAmw6ccTNvU97TTKn2ABUTuMfhyiJJQcGpoikZG8o8GXkZuM0/tXPvYrHfk8dsde7zYjFln7J/eqdspUl60kvSwRu+ZSLFSgHkIWoq+bNj3d6Gcg+2LOgOBr8+Mv7tIcFUSJcFCBnvvEpv7kgDQV/0kBRAnC4rqWpOt+POV3tcnIQG9wcKBL99B/btjjatGOA4clypFmywTtpUvIVDkLEX1IiB8whwjBbkAPOYvhh08uF0LiqQKimc3EESmvvxIkrgTfKVpeCmS3YBVXZKkajVZjPXSPfQqL8oxE0ywosMRI6x4i2WZ7IAR7fRkULGwJNTEFGnm+TAcwhJONMgmSFsazT3ZFcbIoF4+G1C6fTj0Kj7yp45tIjtgtVpf4fWJJMBbL7oSILsGuscz2/tD24bT17grTkasvj8rr4yNMwGpzfNILhBWr5mgzL+kLUPnUNzD2MWMJG3Qg0KeYjY+Y6tHVLepjGaqPwqXoB3Culo+QQwDHfUzHSi6PDggtsEv4Ays7415b3uXjdN82bmsLW9iXNnXXSTe/DlnojteUnNPOp8gWkDtM9wM9As+NxcjvFCLY/1DFScsiVyiHs3g2ecGbXQtecGI5gqQ1kjE+GTKvAAexAcG5+vJL0FBO3E9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2638.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(136003)(39850400004)(346002)(376002)(396003)(8936002)(5660300002)(2906002)(54906003)(6916009)(478600001)(8676002)(316002)(6506007)(33716001)(52116002)(41300700001)(26005)(7416002)(66946007)(4326008)(6486002)(6512007)(186003)(9686003)(83380400001)(66556008)(86362001)(66476007)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W35dQ7Bm1cnJ1lkD8cHVaDsI5fipYZZt178zroLzATSHiuf5+2hAAn+OBPXg?=
 =?us-ascii?Q?b6pPlFlPQyv9OIuiOQE3RyZs/1lShwXmbf08mdl6UQOQYOYXxWzYLf3kes4y?=
 =?us-ascii?Q?ErKQnwRd7lqVeWJI+Zmp1Y58MspLX/ozAZ8a8hnCenHXmAVpPL/Yem7Q8t8P?=
 =?us-ascii?Q?59k+Tj6N3IQOd7bBlE5Qk4OsahYhi9C/UTrlsd3s821fvKUkGR9vTJyFBrEq?=
 =?us-ascii?Q?2se3CEA2qmFVIe+omNePZeuKghHrmKTUGdokx8LfjEWLtZImMyXX4uwoVWjk?=
 =?us-ascii?Q?9VXXgJF4p1gxNcifRNpMn56ZuK/mEzrTi4pcvICk7IrCQ3tq6fSiPA4tX2Kj?=
 =?us-ascii?Q?erFHq4MZoW965CX4A821KwymuHMYRF26dkljV4e9pYgG7Ak6RuPvgiobbbMB?=
 =?us-ascii?Q?gbMvhXkDEjbGDE3P4KDfXOs7SG4jRu6B6noEDSgQXC5gm5mOTtFNXyJY5p3p?=
 =?us-ascii?Q?gKoojjlQLEKVMDc3Hn+WLVa5QNdmRL36k343mwKYSJOf8c4EuFt9UBm62Y1n?=
 =?us-ascii?Q?5nRmLp2HxPoPnI2aGDrdvnEhDbfPm6e7dVXzz43TBWdxfwcZOwe5RGETJYNW?=
 =?us-ascii?Q?VVWyp8QBPxO6DWLxJPM8EcdEQpNdTPQJYvrS5kgtokwL27HXkDZxQciY/ixq?=
 =?us-ascii?Q?aMVg2vGfWePPu510jlKXcmcyqc0EKPMhHHvfus8afsyIVSVJjX5dJUkNiNl7?=
 =?us-ascii?Q?/abMChGa5GnN5T0VqSVZzYvGKzdInNvBTImC6anbLO0QRu0mPGKKdgXbXbHE?=
 =?us-ascii?Q?BG2vGD3NXdJ+afcpQXKJrcFmgJHCYNFNW8zLLZBjJ2zLMG5C0dmjoXl0YUD8?=
 =?us-ascii?Q?bOAo+tK+ukdguSFA8KembjkJOmCtU3Zvfdl7962yoXnMIjhYlk32i/yjFzLD?=
 =?us-ascii?Q?VOs1x3YSDdE8JoP+LNpHY2+F2Ji5G1B0j7CmNiH5Vf4E1BMiXZENOC3vj4yp?=
 =?us-ascii?Q?FyAQMIbjYl0DPyfeEevRTyp9neOBRdl9X4ROD4bHqFYC2HrH14TOyEUN0cPV?=
 =?us-ascii?Q?L2o9LtFBb4WCic7+il38ZyGPXZBhdAsJhO2UHjXkDA40MjwbftUI5aZdaQgi?=
 =?us-ascii?Q?Um8lMBJuONZKLOXbJz8arfsYjsqO4Ww8aO+KXdgS9XafT3FdiKP0a1/3yP3Y?=
 =?us-ascii?Q?BODb761+hnHwJaqDJpi9qkt4fSo7KfZhZiQ1nF3obeOeDlMcHUEPKe/i+dJs?=
 =?us-ascii?Q?yEp5VsK3p/aPawaMMwkPiCMNtL8xlEZM/Nbzfsrf/W1VBvXX17QPsQZkZP4F?=
 =?us-ascii?Q?/cnU1IpxKvpCbl+Q2ALQWoDGfrk6IupVZ8mQOfoK0qTbrhHNsNJxxMeofgOo?=
 =?us-ascii?Q?pg2pV7EUDrRCWNxqVk6Q5D2/Jcee5acYq+tOZ0NYJrszd90tiKF2gQ9x+/7y?=
 =?us-ascii?Q?rcKss//rm5g0QZBxbO0M+KKA5YTaOOiE8FJSD4qV1MqRA+p+H6Cxh6B5vkt0?=
 =?us-ascii?Q?+mtPJnMvvFBSU/FNM3Uuuds35PnKAUmRp3r1mV88U9/w7Do8vHLkZBhbvaIu?=
 =?us-ascii?Q?Um4Vh3QGdtcSkzbluSFUEt8Y1Boz2qtISR5e3U1LmPVsw3VD/nTcs5h3LexV?=
 =?us-ascii?Q?rnhCdSYjj89LRMiITuaOo9BoPSEDFm2BdO4a76dHWD6mGB78V2Y2Bdo5GYUb?=
 =?us-ascii?Q?8v6iGTcZzpK65RFg+297ILk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b32f8f-aed6-4d9d-1030-08da60fd0264
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2638.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:15:01.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPmffw12xws8NcE3/7sN5virnA2muCNqa+fnhKmWBECsgS1MvqmiFOZgNZVb+h+OUKdgCoRcw6L1s8zPdzsxvNyhDxSjO7VdHvQ6H3pg62y6lOfVSrg8IP6mFZGDu7o3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2722
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 10:05:32AM +0100, Ionela Voinescu wrote:
> Hi Darren,
> 
> On Thursday 07 Jul 2022 at 17:10:19 (-0700), Darren Hart wrote:
> > On Mon, Jul 04, 2022 at 11:16:01AM +0100, Sudeep Holla wrote:
> > > From: Ionela Voinescu <ionela.voinescu@arm.com>
> > 
> > Hi Sudeep and Ionela,
> > 
> > > 
> > > Currently the cluster identifier is not set on DT based platforms.
> > > The reset or default value is -1 for all the CPUs. Once we assign the
> > > cluster identifier values correctly, the cluster_sibling mask will be
> > > populated and returned by cpu_clustergroup_mask() to contribute in the
> > > creation of the CLS scheduling domain level, if SCHED_CLUSTER is
> > > enabled.
> > > 
> > > To avoid topologies that will result in questionable or incorrect
> > > scheduling domains, impose restrictions regarding the span of clusters,
> > 
> > Can you provide a specific example of a valid topology that results in
> > the wrong thing currently?
> > 
> 
> When CONFIG_SCHED_CLUSTER=y, all typical big.LITTLE platforms will end up
> having a CLS level instead of MC, with an extra flag for the CLS level:
> SD_PREFER_SIBLING. Additional to this, potentially broken cluster
> descriptions in DT (let's say clusters spanning more CPUs than the LLC
> domain) will result in broken scheduler topologies.

You addressed my primary concern below, thank you. Re this point, I was
concerned that we were prioritizing correcting "broken cluster
descriptions" over "correct, but unusual cluster descriptions". Your
solutions seems to elegantly address both.

> 
> This drew our attention that the span of clusters should be restricted
> to ensure they always span less CPUs than LLC, if LLC information exists
> and LLC spans more than 1 core. But the Ampere Altra functionality you
> introduced is maintained. I'll detail this below.
> 
> > > as presented to scheduling domains building code: cluster_sibling should
> > > not span more or the same CPUs as cpu_coregroup_mask().
> > > 
> > > This is needed in order to obtain a strict separation between the MC and
> > > CLS levels, and maintain the same domains for existing platforms in
> > > the presence of CONFIG_SCHED_CLUSTER, where the new cluster information
> > > is redundant and irrelevant for the scheduler.
> > 
> > Unfortunately, I believe this changes the behavior for the existing
> > Ampere Altra systems, resulting in degraded performance particularly
> > latency sensitive workloads by effectively reverting:
> > 
> >   db1e59483d topology: make core_mask include at least cluster_siblings
> > 
> > and ensuring the clustergroup_mask will return with just one CPU for the
> > condition the above commit addresses.
> > 
> 
> It does not change the functionality on Ampere Altra. cpu_coregroup_mask
> will still return 2 CPUs (cluster span). The difference is that
> cpu_clustergroup_mask will see that cpu_coregroup_masks spans the same
> CPUs and it will return a single CPU. This results in the CLS level
> being invalidated, and the MC level maintained. But MC will span 2 CPUs,
> instead of 1, which was the case before your fix. This is alright as
> MC and CLS have the same flags so the existing functionality is fully
> maintained.

Ah, of course. I missed the combined impact of my earlier change plus
yours, which is to first expand MC and then to collapse CLS. It's a
little round about for the Altra, but that seems reasonable as it's a
bit of a corner case in terms topologies.

Thank you for the explanation.

-- 
Darren Hart
Ampere Computing / OS and Kernel
