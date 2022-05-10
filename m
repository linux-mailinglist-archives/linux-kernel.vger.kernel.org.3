Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD2F522499
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiEJTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348329AbiEJTRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:17:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2109.outbound.protection.outlook.com [40.107.244.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9635E2609DF;
        Tue, 10 May 2022 12:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+thg1bvbrnjFIeLbS7ElxliKh2noyxACAF5Utg0uvruvox19HOt8zGLvr+l9FyhCIx6FPuofu1qd7wLSQDkKHX/cqnTzk7mPWf1ykBIPZdMP49DqTp2EyFt7O15t/KsCO+cAwBWxgWz3KJaSS7lSLJg18DiuR1oH86LQn9Uy4GOFA8sy5mKrdAObnwIRK7F2QX6h7VHeQdOREMz5WCVouel4GA25t9mcVqp+3SL+fyZvvSvxdIEOIGl8+nhfGeHyC63YpOcsSUkz1+mztn0Q4Q3iYY3z1xgA+C2Yu6GAM4Stw+aoqYNhSwTctwUrfVo9js4WiLCQJgtGrKVLpxv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtB8BwITv5AEgIWeWK5z4tMB6qT8Kaajn4c/1tUKRwA=;
 b=B76x3NI/FTUovRCILn176RbIT2UGegrMCI0tSHSO72wiV4n4AP2Mp90jKFvARf23u070U5iCYGyqNAwnPmS3isXx4toBLSGyr8Xl7iGzDN8B8L7erFlADh6YPRCPJ+b86Kepc0N4LVbDouMLDnsyv8wKj8PnGHERccfckda4k0dyzgAudtqLsSlm7K1n5qPix2Kkcc5V8Gnpu0szV+N+9c+9hoQItkWaFsen2rdqi355MLKs6Kh66Fex/9ofrYPoZpr+dSHbTPdTGzWCTYjVLTBO171Ar+UbK+RHMb37SKgzCNROnStuM87mHsXR9CqkcIeu3MJ4sK7f6BXw4js7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtB8BwITv5AEgIWeWK5z4tMB6qT8Kaajn4c/1tUKRwA=;
 b=nvGv8Wg2pQUDo6tLj+fcIZ8Hbtc+Kchf6Ao5F9AiZ9pJ1l6v2GwiXtQpytQVvNXsq0kqmZXUBZUiYLltGXy8kyhX4AR/Tm2Hm9YdG2gu2miZD3n5FLsPHFViO9+BzE+qXt6u8toTkYDFK5XRpzbCzxOvgdYVG7t/Qb2jlzb8+N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6329.prod.exchangelabs.com (2603:10b6:806:ee::12) by
 BYAPR01MB4903.prod.exchangelabs.com (2603:10b6:a03:1e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Tue, 10 May 2022 19:17:47 +0000
Received: from SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6]) by SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6%3]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 19:17:46 +0000
Date:   Tue, 10 May 2022 12:17:42 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Barry Song <21cnbao@gmail.com>, bp@alien8.de,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, juri.lelli@redhat.com,
        bristot@redhat.com, lenb@kernel.org, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, rjw@rjwysocki.net,
        sudeep.holla@arm.com, tglx@linutronix.de,
        aubrey.li@linux.intel.com, bsegall@google.com,
        guodong.xu@linaro.org, liguozhu@hisilicon.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        msys.mizuma@gmail.com, prime.zeng@hisilicon.com,
        rostedt@goodmis.org, tim.c.chen@linux.intel.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        will@kernel.org, x86@kernel.org, xuwei5@huawei.com,
        yangyicong@huawei.com, linuxarm@huawei.com,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [BUG] Re: [PATCH 1/3] topology: Represent clusters of CPUs
 within a die
Message-ID: <Ynq6Vt0oNhq7brEf@fedora>
References: <20210820013008.12881-1-21cnbao@gmail.com>
 <20210820013008.12881-2-21cnbao@gmail.com>
 <65da3fc4-46b4-c6ee-c84f-3fb5a7f917ab@arm.com>
 <20220509111553.0000266d@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509111553.0000266d@Huawei.com>
X-ClientProxiedBy: CH0PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:610:33::32) To SA0PR01MB6329.prod.exchangelabs.com
 (2603:10b6:806:ee::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0352c9d3-2072-4678-1c4c-08da32b9c405
X-MS-TrafficTypeDiagnostic: BYAPR01MB4903:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB4903C64A6CD9B7EFA3E2B6BFF7C99@BYAPR01MB4903.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvOFPceP07bKxAoSmTXrl9mSOVmMlEmixphhVzyo3CzlZqw9OG736W4my0ILq5y7Gbe4RKBgMAAOwv0bWrb11d2YvKTjWq/PJWAm8pUKKH6QNjlZcFCK0yu+hOE5EzQsLtM9CgNV1zi5R4IzKRzYVHz8JAArfjSys6jkamUpFyBYqCebKsd4U4oiEkTgWINlhj82RJRPOw3bNaZ+8URdJTKisqkbUuX0FIatCabygLuXEEh4UDYzql5wsLCFMh2vfdti7eNAe2D7Ro4wt0I3KzqQir5qXtx9+q+NIZC7sSuYlxX0XJNVXaoNTLdX/8E3GsIy9kVL8dLIkulWid6yz7RchrPEBzcIvZb8ZDEH1w0AzzrIVpsYbrWIbJTeAeHzzqHm/IvgbZlXZ3kYCjWCxp+AUgWJOHZCeb7XTY3CK+tOWjyvNQUV4TLoBDtdZCbnSdPFmXB7Sa5k1zqi9/PPpoABiMttTFT2RG1w2mcJWq+M4yK1cnFlMqT2oH0FvFckwr1eWKTdWiIojIl8WtaSCCRIDzbmqaNEyNmMGXucRsXJYKbt+kA4lCTPLrJwsygKa0mZHcZcN2249TZYXCHr6h92NXJ7/pM4nJiNpTKsSvnqB4/b30PEMfaWc14VACupGnze1gy3PokagEhm9EcM/dDDxLI7XImqPQlSTOwZ07tw/NFs2ZMssmof5Hr9yNQmXhIj7Y7qt4uMvqB+GsfF1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6329.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38350700002)(6916009)(54906003)(9686003)(83380400001)(38100700002)(6486002)(186003)(86362001)(52116002)(6512007)(508600001)(26005)(6506007)(6666004)(316002)(2906002)(8936002)(33716001)(66946007)(66556008)(8676002)(66476007)(4326008)(7416002)(7406005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSKWFY1mTogVvhmoUCwGleoj1soFCq9sfJRoXWuhzuqv60S5EPsfqBsiUOqu?=
 =?us-ascii?Q?JbeQBVY3nU6psFbKz2V9HEjZ25n7dJerQQ0lrSwAJBa3O9d1AtiF5TIfX9Od?=
 =?us-ascii?Q?rXjSVRJLNAs/VKYKNT2gkjILBqsQ/Gd5dF4X3bUe5VLDjwLM9Mqorl3W1Fvv?=
 =?us-ascii?Q?44a7hVUGk+KnHPI8Sr4MggM/hqPzPhH0QdAfcgfgq/kb/IlsHNIzEEd04nE0?=
 =?us-ascii?Q?BpDigAZOc8s+tIUDmvbxtgQZsJiIJIf/g4xGQEaZWRBzNu01lXrIKCcatSuw?=
 =?us-ascii?Q?8GX91FceQO9bHSoV0TU2HHMbFjwlKK1DIVzxRsrVG5h5ysCiYwTpj9ZjJNpW?=
 =?us-ascii?Q?9udpE1hqHw28uOkDxsx/ixVoRenny56/cl7m4d0rTd0R8BLPC1e/3s9OuTL3?=
 =?us-ascii?Q?3wkqli+++3OZnNAz+xmuF4t5EknEDtxWL9Z0fIdbB1R2KscPBPzKS9L4Zj+G?=
 =?us-ascii?Q?YIFEFO6rX5dkAOJvZ3wL+IKFQjrTGGApKrr7H7bgNkGy/GSRn7nv3BaVRscS?=
 =?us-ascii?Q?9pFJqNHXAWN/IowkBDS88C7JcGE7akujn8ED9KIRx0nkz++HUfkd+GvxYBh/?=
 =?us-ascii?Q?LDquo78Ma+92t0JQeWlEgfcD3OUSWUyGCiXWX3BtVYgkAVAuX/hbpOVE61AN?=
 =?us-ascii?Q?wYkyFhxGAUMxqM2VuX0jgLk/Pxw+WURzZ0EqbrQiTF8RAstE5X7cdQ+zd6XX?=
 =?us-ascii?Q?J1fvTU+HW6JYiSJJT/LKqZR+jE4cIC4Kj/B+JmGfaPiGXEV1WzsKwrRVoJlS?=
 =?us-ascii?Q?4aiUL9+VAefvEYDl3og9GXiCEzpMF78SitN85SuTXnOLxSPAUj7lrmda5eiB?=
 =?us-ascii?Q?bPDbjSEFP2+sQ+bSjhO+hyytKcR/7yQn4L9Nmx4y5e+BADycLHY5/qfW2w1X?=
 =?us-ascii?Q?5b3OFxrqwNxZ3CjG+YnmLt2U3gM9wP7uqYVgOW0PRl/huwty/X4ZnikzEY3S?=
 =?us-ascii?Q?qj1Knfz+b/gQlkEKXukPIhVSJzslJIrFdmUPM16mE7SP+9hb9Uz9ZMLxRYiN?=
 =?us-ascii?Q?lGhyWMtbQ9qCcTZ4je+1j2OS4oFH2DVy2gURYwTKLfE+bvzBK01mD5wOhRJd?=
 =?us-ascii?Q?p2nKKMyyJOCy99nuBCjHICheEih73KN/zxZQi1mrIt9GBVwejTUM3t53Zo8d?=
 =?us-ascii?Q?H9qWMoc0QefmW7+C+QCJ+zUoYQpWpYEu42SlwKKlMasqvQp4rGAVhS/t0iEo?=
 =?us-ascii?Q?03lcisYcgYmL5rt8ZCUvSJxfHwh2uzX9BGEZwoaE6isOvpGIX1qHCGY9eqac?=
 =?us-ascii?Q?sjrqWJ8cw4WQek9fXcIMHq4VVi8g2l6P/JgfSN3kVKm2kpVo0PNXucq2mlB1?=
 =?us-ascii?Q?66YBh3Ik+zgoTlBmddZRtTjlz6LpoJr5Vk3FQLVik8ytiT9zZinp45n0Vy1V?=
 =?us-ascii?Q?7Sv0p1/sXilWBJIdQGzdqH+RKDdhlT73FYh6AJBFpX8P+pyyWmfwdv1mPCzI?=
 =?us-ascii?Q?yaR1rdI+MpKhIf8xgW7eWeRuGbVzX1i58nUtGhtnM0BGCY2bOqhzyOr6H9YY?=
 =?us-ascii?Q?I7hUM1/O5J6ZTxlbBp4sxoboE1805xMdaKWFe38r2b3nO1b6Xcm6IhhHh5du?=
 =?us-ascii?Q?3OhCB1VZ30H128W5AxntHEGn9xM0MFF3bAj0hEhEFWCD714R2pjwR5dKFE02?=
 =?us-ascii?Q?OtfG1di3CAtFyKdJhkgn4ub9JMrRzr5apCtLIaoi5Tv669Pwme1j7HxZ1yEq?=
 =?us-ascii?Q?QsRCnqo22f2EugDykXHOi+UGPFQBI7Z1yKWTA4URcgmJUwfUkQMHan6Wr9mG?=
 =?us-ascii?Q?Lq/ZxOGPmAkL+GoIxRZoMOMh2GH3Q/gRJFoHUn4daYvnKYUQ7w2d?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0352c9d3-2072-4678-1c4c-08da32b9c405
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6329.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 19:17:46.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jIK12LrWFawwoEVug8oALDV7kXqi+lNHMWBYalWKqq7VGOuPAk7xK5vLY/ywyfOQDAMjuCIB6l6yexQbhoKjr3yJkN7rhl2I8hzH2oKBoClokLZUR9Mx2Gf6oxsmcth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4903
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:15:53AM +0100, Jonathan Cameron wrote:
> On Fri, 6 May 2022 15:24:27 -0500
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
> > Hi,
> > 
> > It seems this set is:
> > 
> > "BUG: arch topology borken"
> >                     ^code
> > 
> > on machines that don't actually have clusters, or provide a 
> > representation which might be taken for a cluster. The Ampere Altra for 

Hi All,

The fix for this particular issue is upstream:
db1e59483dfd topology: make core_mask include at least cluster_siblings


> > one. So, I guess its my job to relay what I was informed of when I 
> > intially proposed something similar a few years back.
> > 
> > Neither the ACPI/PPTT spec nor the Arm architectural spec mandate the 
> > concept of a "cluster" particularly in the form of a system with cores 
> > sharing the L2, which IIRC is the case for the Kunpeng.
> 
> It is not. Kunpeng 920 shares l3 tag cache, but not l2 cache (which is
> private for each core).
> As such the existence of a cluster is not distinguished by sharing
> of any cache resources that are in PPTT.  There is an argument for potentially
> adding more types of resource to PPTT to give a richer description.
> 
> Whilst ACPI doesn't mandate a cluster (there is an example, though that happens
> to have L3 shared across the cluster), it does allow for addition
> hierarchy description. Cluster is just a name for such an extra level.
> 
> > And it tends to 
> > be a shared L2 which gives the most bang for the buck (or was when I was 
> > testing/benchmarking all this, on aarch64) from scheduler changes which 
> > create cluster level scheduling domains.
> > But OTOH, things like specJBB 
> > didn't really like those smaller MC levels (which I suspect is hurt by 
> > this change, without running a full benchmark suite, especially on 
> > something like the above ampere, given what is happening to its 
> > scheduling domains).
> > 
> > So, the one takeway I can give is this, the code below which is 
> > attempting to create a cluster level should be a bit more intellegent 
> > about whether there is an actual cluster.
> 
> I agree that more intelligence is needed, though I think that belongs
> in the interpretation of the cluster level.  This particular patch
> should present that information in a consistent fashion.  My understanding
> is it is consistent with how other levels have been presented in that
> it's perfectly acceptable to have multiple levels that can be collapsed
> by the users of the description. (perhaps I'm wrong on that?)
> 

Collapsing redundant levels is indeed an intentional part of the design as I
understand it.

> > A first order approximation 
> > might be adding a check to see if the node immediatly above the CPU 
> > contains an L2 and that its shared. 
> 
> That rules out our clusters, so not a great starting point :)
> 
> Darren Hart's recent set for Ampere Altra is fixing a different combination
> but is in some sense similar in that it corrects an assumption that turned
> out to be false in the user of the topology description whilst leaving the
> description alone.

I think that concept is important: "correct assumptions in the abstraction while
leaving the description alone" (provided the description follows the relevant
standards and specifications of course).

> 
> > A better fix, of course is the 
> > reason this wasn't previously done, and that is to convince the ACPI 
> > commitee to standardize a CLUSTER level flag which could be utilized by 
> > a firmware/machine manufactuer to decide whether cluster level 
> > scheduling provides an advantage and simply not do it on machines which 
> > don't flag CLUSTER levels because its not avantagious.
> 
> While I obviously can't predict discussions in ASWG, my gut feeling
> is that would be a non starter with questions along the lines of:
> 
> 1) Why is this level special? The spec already defines a hierarchical
>    description with caches described at each level, so you can infer
>    what is intended.  If we define cluster, we'll also need to define
>    super cluster (we have designs with super clusters and it's only going
>    to get worse as systems continue to get bigger.)

While I share Jeremy's concern about the lack of specificity of the term
Cluster, I suspect Jonathan's point about that path leading to more and more
categorization (e.g. super cluster) in a space that is rapidly evolving is
accurate.

Beyond the topology of cores and cpu-side caches, we have other properties to
consider which affect scheduling performance (like the shared snoop filter,
memory-side caches, etc.) and could/should be considered in the heuristics.
Comprehending all of these into a fixed set of defined topology constructs seems
unlikely.

It seems to me we are going to need to respond to a set of properties
rather than attempting to rigidly define what future topologies will be. Even
terms like die and package start to get fuzzy as more and more complex
architectures get pushed down into a single socket.

-- 
Darren Hart
Ampere Computing / OS and Kernel
