Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED52050B3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiDVJSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445966AbiDVJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:16:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5851E73
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:13:54 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23M64Qfx017497;
        Fri, 22 Apr 2022 09:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=TZgyIPlkGLCdojtSdCQucp73gJGlRtfYthUNqVUThto=;
 b=n6PpOrzztvLdVthwpQ9ctNgMwvEDcAb9XVg8Zfg5J2Hw7+IvULY4hhCukROrZri+KqOu
 e1GSOTKV/uEFTGmmvXqMBQk/9Fay9oWGk0UzSFeYGNPVLKJ7he2TTn7HSh2lkm1TMVkx
 y8vsPLE/S1nW2yPs5PaXcvBsINVH720DpxeJ4Vb6kHYNyHD2kbauASPrUjusaT+wdcaq
 bcVkPrMjuJiok9X/XrLQWLgsHNoafvvW34N3EX0wdpjgk83Fyz6MRU9M1P3iYtRSMujC
 q9khM7iwInRnG1PYMcFAZFcnyGs6O0s3OrqP8ecLCFJ1yKOl+nb3Gd5ez2bSk1CojLdc PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2jky2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 09:13:48 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23M90Wgv007560;
        Fri, 22 Apr 2022 09:13:47 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2jky1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 09:13:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23M9BSUl005902;
        Fri, 22 Apr 2022 09:13:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ffne8y6vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 09:13:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23M9Dgek20971844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 09:13:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACC8B42041;
        Fri, 22 Apr 2022 09:13:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9FEA4203F;
        Fri, 22 Apr 2022 09:13:38 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.59.166])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 09:13:38 +0000 (GMT)
Date:   Fri, 22 Apr 2022 14:43:30 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH v2 3/5] mm: demotion: Add support to set targets from
 userspace
Message-ID: <YmJxukA2DYogWA6E@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <20220413092206.73974-4-jvgediya@linux.ibm.com>
 <CAAPL-u9OHuRWXvc0RAPvEtLQLy0AkLbAwjZtGERhmhn-yFZgrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u9OHuRWXvc0RAPvEtLQLy0AkLbAwjZtGERhmhn-yFZgrw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ayHiZfLd2lD5ibxomojZVjEQa5HtpCXl
X-Proofpoint-ORIG-GUID: QaL3ZsXMwHb3HE1SjXvBETvo_I3AzLnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_02,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:26:34PM -0700, Wei Xu wrote:
> On Wed, Apr 13, 2022 at 2:22 AM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> >
> > Add support to set node_states[N_DEMOTION_TARGETS] from
> > user space to override the default demotion targets.
> >
> > Restrict demotion targets to memory only numa nodes
> > while setting them from user space.
> 
> Why should we restrict demotion targets to memory only nodes if they
> get set explicitly from user space? For example, if we use NUMA
> emulation to test demotion without actual hardware, these emulated
> NUMA nodes can have CPUs, but we still want some of them to serve as
> demotion targets.

If nodes have memory then it should be possible to use them as demotion
targets in case user wants to explicitly set them, will correct it in next
version if we finalize the same approach for demotion target override as
per discussion on this series.

> > Demotion targets can be set from userspace using command,
> > echo <nodelist> > /sys/kernel/mm/numa/demotion_target
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > ---
> >  .../ABI/testing/sysfs-kernel-mm-numa          | 12 +++++++
> >  mm/migrate.c                                  | 35 +++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> > index 77e559d4ed80..10e9e643845c 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> > @@ -22,3 +22,15 @@ Description: Enable/disable demoting pages during reclaim
> >                 the guarantees of cpusets.  This should not be enabled
> >                 on systems which need strict cpuset location
> >                 guarantees.
> > +
> > +What:          /sys/kernel/mm/numa/demotion_target
> > +Date:          April 2022
> > +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
> > +Description:   Configure demotion target nodes
> > +
> > +               Page migration during reclaim is intended for systems
> > +               with tiered memory configurations. Preferred migration target
> > +               nodes can be configured in a system using this interface, based
> > +               on which demotion table is prepared in kernel. If demotion is
> > +               enabled then pages will be migrated to set demotion targets
> > +               during reclaim.
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 516f4e1348c1..4d3d80ca0a7f 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2564,12 +2564,47 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
> >         return count;
> >  }
> >
> > +
> > +static ssize_t numa_demotion_target_show(struct kobject *kobj,
> > +                                         struct kobj_attribute *attr, char *buf)
> > +{
> > +       return sysfs_emit(buf, "%*pbl\n",
> > +                         nodemask_pr_args(&node_states[N_DEMOTION_TARGETS]));
> > +}
> > +
> > +static ssize_t numa_demotion_target_store(struct kobject *kobj,
> > +                                         struct kobj_attribute *attr,
> > +                                         const char *nodelist, size_t count)
> > +{
> > +       nodemask_t nodes;
> > +
> > +       if (nodelist_parse(nodelist, nodes))
> > +               return -EINVAL;
> > +
> > +       if (!nodes_subset(nodes, node_states[N_MEMORY]))
> > +               return -EINVAL;
> > +
> > +       if (nodes_intersects(nodes, node_states[N_CPU]))
> > +               return -EINVAL;
> > +
> > +       node_states[N_DEMOTION_TARGETS] = nodes;
> > +
> > +       set_migration_target_nodes();
> > +
> > +       return count;
> > +}
> > +
> >  static struct kobj_attribute numa_demotion_enabled_attr =
> >         __ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
> >                numa_demotion_enabled_store);
> >
> > +static struct kobj_attribute numa_demotion_target_attr =
> > +       __ATTR(demotion_target, 0644, numa_demotion_target_show,
> > +              numa_demotion_target_store);
> > +
> >  static struct attribute *numa_attrs[] = {
> >         &numa_demotion_enabled_attr.attr,
> > +       &numa_demotion_target_attr.attr,
> >         NULL,
> >  };
> >
> > --
> > 2.35.1
> >
> >
> 
