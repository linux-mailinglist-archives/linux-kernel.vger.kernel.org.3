Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6925B2690
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiIHTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHTMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:12:44 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C43B0B27;
        Thu,  8 Sep 2022 12:12:42 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288DXUHm030055;
        Thu, 8 Sep 2022 12:12:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=r6H+40G9lUVv1D9oybKjQC82BdNb3VOZVa28rXz8QAQ=;
 b=Qa0mf3qeW3IWdmWB/eQqvJCtwLa/eEKtu1WFXVs6cdpnQsQnTg9NxTVSK1fdqoeuEz/P
 Pc/tM4/rnMUo0ppTq3K7DT4P/uSTrf5LXgL+tyVylmTfUmM3mSPO0kyKVCnxm25rXuIH
 LZmS9rGsi2tdRxtkw5ZJaM+zNzoIMI4bYyzxv0VWOlLvhEhIjj+xPvoFK6AZWqBQo2Rv
 aoxQF7GKpbKeFXLUImDsud1gEP9z0yonjXwQiMwcJ+1WBGWAiopufULq8lMu3yCXJtTP
 GBpKEdGAIAKeoLmwc7AJq6/hbzu1jL4iWWymIygtsrso6XCmSV+CqWCUirh2BJ7+qiyw Gw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3jen9x0kjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 12:12:27 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 8 Sep
 2022 12:12:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 8 Sep 2022 12:12:26 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id CB6633F7054;
        Thu,  8 Sep 2022 12:12:25 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 288JCPxS025295;
        Thu, 8 Sep 2022 12:12:25 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Thu, 8 Sep 2022 12:12:24 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [EXT] Re: [PATCH v3 1/1] tracing: Fix compile error in trace_array
 calls when TRACING is disabled
In-Reply-To: <28bd97af-2932-f75e-ecf5-6c5e42f8d7ad@acm.org>
Message-ID: <b642171e-441f-7117-2ed0-74619c27e376@marvell.com>
References: <20220907233308.4153-1-aeasi@marvell.com>
 <20220907233308.4153-2-aeasi@marvell.com>
 <28bd97af-2932-f75e-ecf5-6c5e42f8d7ad@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: 2OE3AJtW7n-CwmfESgNfPI7ewXNk8cjy
X-Proofpoint-GUID: 2OE3AJtW7n-CwmfESgNfPI7ewXNk8cjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_11,2022-09-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022, 9:55am, Bart Van Assche wrote:

> 
> ----------------------------------------------------------------------
> On 9/7/22 16:33, Arun Easi wrote:
> > diff --git a/include/linux/trace.h b/include/linux/trace.h
> > index bf16961..b5e16e4 100644
> > --- a/include/linux/trace.h
> > +++ b/include/linux/trace.h
> > @@ -2,8 +2,6 @@
> >   #ifndef _LINUX_TRACE_H
> >   #define _LINUX_TRACE_H
> >   -#ifdef CONFIG_TRACING
> > -
> >   #define TRACE_EXPORT_FUNCTION	BIT(0)
> >   #define TRACE_EXPORT_EVENT	BIT(1)
> >   #define TRACE_EXPORT_MARKER	BIT(2)
> > @@ -28,6 +26,8 @@ struct trace_export {
> >   	int flags;
> >   };
> >   +#ifdef CONFIG_TRACING
> > +
> >   int register_ftrace_export(struct trace_export *export);
> >   int unregister_ftrace_export(struct trace_export *export);
> >   @@ -48,6 +48,38 @@ void osnoise_arch_unregister(void);
> >   void osnoise_trace_irq_entry(int id);
> >   void osnoise_trace_irq_exit(int id, const char *desc);
> >   +#else /* CONFIG_TRACING */
> > +static inline int register_ftrace_export(struct trace_export *export)
> > +{
> > +	return -EINVAL;
> > +}
> > +static inline int unregister_ftrace_export(struct trace_export *export)
> > +{
> > +	return 0;
> > +}
> > +static inline void trace_printk_init_buffers(void)
> > +{
> > +}
> > +static inline int trace_array_printk(struct trace_array *tr, unsigned long
> > ip,
> > +				     const char *fmt, ...)
> > +{
> > +	return 0;
> > +}
> > +static inline int trace_array_init_printk(struct trace_array *tr)
> > +{
> > +	return -EINVAL;
> > +}
> > +static inline void trace_array_put(struct trace_array *tr)
> > +{
> > +}
> > +static inline struct trace_array *trace_array_get_by_name(const char *name)
> > +{
> > +	return NULL;
> > +}
> > +static inline int trace_array_destroy(struct trace_array *tr)
> > +{
> > +	return 0;
> > +}
> >   #endif	/* CONFIG_TRACING */
> >     #endif	/* _LINUX_TRACE_H */
> 
> Thanks for having addressed my feedback. The above looks good to me. However,
> I'm not very familiar with the tracing framework so I will leave it to others
> to formally review this patch.
> 

Thanks for the review and suggestion of the clang-format command line, 
Bart. That is a useful one to remember.

Steve, does this look ok? If so, your approval is appreciated, as this is 
a build blocker fix.

Regards,
-Arun
