Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF265B100A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIGWxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIGWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:53:03 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB35BD091;
        Wed,  7 Sep 2022 15:53:02 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287G66wG029954;
        Wed, 7 Sep 2022 15:52:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=RnYoNn9nnI1JSlDLAHuBQRio8gmVgs0NZIrdhh4SLH0=;
 b=EmsK29mSBeevw8S3aWjlEubwyKc/7O0fC5xeVqKNiKcjL0RCT6r3H23+/T3cgKyJ+7uF
 QQlP2QKyzdrz6KFUSlc00jA8aUuDnjP0OUjdNxrhcRug6afDMyjvtbzf/wdQSyP0xIxk
 xatq4WEwO1EK67Prd6XkwikTQjZnYb7bsXMY8EMpCNJLKIhwndOPZe1Sfck9aYkdoqxJ
 QFLR5L+r7gzukr39eKTDhLxooZO03rBz3VHnum/OPb0oVsBpHPj7G5lFNmE71dQeCBw2
 5mi0nqZPwe3blQN34z3bMCXz5EPTx83W8YFFzJ5Nzc4jPlK2XdXthnWTlbn+aJSRi1Jp FQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3jen9wuuxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 15:52:56 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Sep
 2022 15:52:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Sep 2022 15:52:55 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id D39EF3F7127;
        Wed,  7 Sep 2022 15:52:54 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 287Mqr3a026578;
        Wed, 7 Sep 2022 15:52:53 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Wed, 7 Sep 2022 15:52:53 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [EXT] Re: [PATCH v2 1/1] tracing: Fix compile error in trace_array
 calls when TRACING is disabled
In-Reply-To: <60870376-3518-896b-7a6b-a4b9ea05264f@acm.org>
Message-ID: <32dee739-58fb-e371-2808-d40a2ee90ee0@marvell.com>
References: <20220907185745.14382-1-aeasi@marvell.com>
 <20220907185745.14382-2-aeasi@marvell.com>
 <60870376-3518-896b-7a6b-a4b9ea05264f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: mk2XP8odf7dyPH3c1_H3GSSySr_dl0df
X-Proofpoint-GUID: mk2XP8odf7dyPH3c1_H3GSSySr_dl0df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022, 12:27pm, Bart Van Assche wrote:

> External Email
> 
> ----------------------------------------------------------------------
> On 9/7/22 11:57, Arun Easi wrote:
> > +#else	/* CONFIG_TRACING */
> > +static inline int register_ftrace_export(struct trace_export *export)
> > +{
> > +	return -EINVAL;
> > +}
> > +static inline int unregister_ftrace_export(struct trace_export *export)
> > +{
> > +	return 0;
> > +}
> 
> Isn't it recommended to leave a blank line between function definitions?
> 
> > +static inline int
> > +trace_array_printk(struct trace_array *tr, unsigned long ip,
> > +		       const char *fmt, ...)
> 
> This is not the recommended way to format a function definition.

That was mostly a Y&P from the prototype earlier in the file. Is it the 
linebreak after "int" you are referring to, or are there more?

> Consider running git clang-format HEAD^.

It is a bit cryptic to me what it is complaining about (sorry 
clang-format newbie here):

# git clang-format -v HEAD^
Running clang-format on the following files:
    include/linux/trace.h
YAML:671:20: error: unknown enumerated scalar
SpaceBeforeParens: ControlStatementsExceptForEachMacros
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Error reading /root/aeasi/src/mkp.git/.clang-format: Invalid argument
error: `clang-format -lines=29:30 -lines=51:84 include/linux/trace.h` failed

Perhaps my clang-tools are not recent enough.

# clang-format --version
clang-format version 10.0.1 (Red Hat 10.0.1-1.module+el8.3.0+7459+90c24896)

Still digging..

Regards,
-Arun


> 
> > +static inline struct trace_array *
> > +trace_array_get_by_name(const char *name)
> 
> Same comment here.
> 
> Thanks,
> 
> Bart.
> 
