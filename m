Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751AD5B103A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIGXLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIGXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:11:13 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BEA9F76F;
        Wed,  7 Sep 2022 16:11:12 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287DqqYT020003;
        Wed, 7 Sep 2022 16:10:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=383dXuZxLnT0vZl5h33GqcO0C/xKxiCwkZXbNJs55g4=;
 b=Hd9hXvU+y6EI5IkIs6aMb2Cl7x568RAuYEkN8S4Cn4iFZ7ghmbpYeDj80SttMyeXZhf3
 T81NAi/MJC8l7XigI1a0kgQ/Z3hclIr9Lf2URAcMGjliyjaeTz3U0L/S7wyWWTx2ai3o
 d6Gh/lEU3G/wEpf8VfKPmC/k670ZHGXlWT4krA/nOF0wEAI4j9ZXAvesspHfOz7gFyRF
 cV8siYmCisuNCXVCp4cbkrVju6oDzTWkC4BW1KQDB8Y6DRZYr3HQ0vV8Kg8qj/bX1It4
 /dwefyR7ze3BrpG+00+4swmJl0plBBSxh4rWZjlZKrM7jD8LhAOE/7lrDLpWf1NdeiYs bw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jc6eq0r83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 16:10:59 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 7 Sep
 2022 16:10:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Sep 2022 16:10:57 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 02BE15B6934;
        Wed,  7 Sep 2022 16:10:56 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 287NAtjp027054;
        Wed, 7 Sep 2022 16:10:55 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Wed, 7 Sep 2022 16:10:55 -0700
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
In-Reply-To: <32dee739-58fb-e371-2808-d40a2ee90ee0@marvell.com>
Message-ID: <d607720a-b940-de99-2e78-bd6207d03c5a@marvell.com>
References: <20220907185745.14382-1-aeasi@marvell.com>
 <20220907185745.14382-2-aeasi@marvell.com>
 <60870376-3518-896b-7a6b-a4b9ea05264f@acm.org>
 <32dee739-58fb-e371-2808-d40a2ee90ee0@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: WIfzGuLaEDXkhh1N_XnQUUtz7gTpaxwP
X-Proofpoint-GUID: WIfzGuLaEDXkhh1N_XnQUUtz7gTpaxwP
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

On Wed, 7 Sep 2022, 3:52pm, Arun Easi wrote:

> On Wed, 7 Sep 2022, 12:27pm, Bart Van Assche wrote:
> 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On 9/7/22 11:57, Arun Easi wrote:
> > > +#else	/* CONFIG_TRACING */
> > > +static inline int register_ftrace_export(struct trace_export *export)
> > > +{
> > > +	return -EINVAL;
> > > +}
> > > +static inline int unregister_ftrace_export(struct trace_export *export)
> > > +{
> > > +	return 0;
> > > +}
> > 
> > Isn't it recommended to leave a blank line between function definitions?
> > 
> > > +static inline int
> > > +trace_array_printk(struct trace_array *tr, unsigned long ip,
> > > +		       const char *fmt, ...)
> > 
> > This is not the recommended way to format a function definition.
> 
> That was mostly a Y&P from the prototype earlier in the file. Is it the 
> linebreak after "int" you are referring to, or are there more?
> 
> > Consider running git clang-format HEAD^.
> 
> It is a bit cryptic to me what it is complaining about (sorry 
> clang-format newbie here):
> 
> # git clang-format -v HEAD^
> Running clang-format on the following files:
>     include/linux/trace.h
> YAML:671:20: error: unknown enumerated scalar
> SpaceBeforeParens: ControlStatementsExceptForEachMacros
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Error reading /root/aeasi/src/mkp.git/.clang-format: Invalid argument
> error: `clang-format -lines=29:30 -lines=51:84 include/linux/trace.h` failed
> 
> Perhaps my clang-tools are not recent enough.
> 
> # clang-format --version
> clang-format version 10.0.1 (Red Hat 10.0.1-1.module+el8.3.0+7459+90c24896)
> 
> Still digging..
> 

Never mind.

Moved to a different machine with newer git and "clang-format" is working 
fine. I will post v3 shortly.

Regards,
-Arun

> 
> 
> > 
> > > +static inline struct trace_array *
> > > +trace_array_get_by_name(const char *name)
> > 
> > Same comment here.
> > 
> > Thanks,
> > 
> > Bart.
> > 
> 
