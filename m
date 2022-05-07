Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464DF51E39F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 04:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445379AbiEGCkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 22:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356739AbiEGCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3711A6AA6A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651890983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQzOPSWhtPUTGSpnflEE6jkGGkhhHHWuhrYd3CJyGAI=;
        b=HozoLmjgJrKGPTe9AVXqpjsM+xtxSh/88aX8vFysUA2DNJb357tIgqMnT3I4G4bnofTDCq
        kmqVfpiJxUDhaxFTQj5gkKj7+2GSqp+qrjoCyYK5qMPSWVzVi4YNbXCV1TZFevaegoNpsG
        /H0FvPluDa+gG+5Sd6zL1CXmlUqrQzU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-vVK9huJtMPGbYuwP1K6bbw-1; Fri, 06 May 2022 22:36:15 -0400
X-MC-Unique: vVK9huJtMPGbYuwP1K6bbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C83C329DD9A3;
        Sat,  7 May 2022 02:36:14 +0000 (UTC)
Received: from localhost (ovpn-13-18.pek2.redhat.com [10.72.13.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3F227AEB;
        Sat,  7 May 2022 02:36:10 +0000 (UTC)
Date:   Sat, 7 May 2022 10:36:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v24 5/6] of: Support more than one crash kernel regions
 for kexec -s
Message-ID: <YnXbFv0crHQDoGqM@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-6-thunder.leizhen@huawei.com>
 <20220506231737.GD122876@MiWiFi-R3L-srv>
 <55e201f1-f136-607c-78f8-eb4ec481909e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e201f1-f136-607c-78f8-eb4ec481909e@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/22 at 09:42am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/7 7:17, Baoquan He wrote:
> > On 05/06/22 at 07:44pm, Zhen Lei wrote:
> >> When "crashkernel=X,high" is used, there may be two crash regions:
> >> high=crashk_res and low=crashk_low_res. But now the syscall
> >> kexec_file_load() only add crashk_res into "linux,usable-memory-range",
> >> this may cause the second kernel to have no available dma memory.
> >>
> >> Fix it like kexec tool do for option -c, add both 'high' and 'low' regions
> >               ~~~~~~~~~~~~ 
> >               kexec-tools does
> 
> OK, I will update it. Thanks.

Let's wait and see how Catalin considers. He may pick these with
minor fix directly or your v25.

> 
> > 
> > Other than this, LGTM, > > > > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> >> into the dtb.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  drivers/of/kexec.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> >> index b9bd1cff179388c..8d374cc552be5f2 100644
> >> --- a/drivers/of/kexec.c
> >> +++ b/drivers/of/kexec.c
> >> @@ -386,6 +386,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> >>  				crashk_res.end - crashk_res.start + 1);
> >>  		if (ret)
> >>  			goto out;
> >> +
> >> +		if (crashk_low_res.end) {
> >> +			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> >> +					"linux,usable-memory-range",
> >> +					crashk_low_res.start,
> >> +					crashk_low_res.end - crashk_low_res.start + 1);
> >> +			if (ret)
> >> +				goto out;
> >> +		}
> >>  	}
> >>  
> >>  	/* add bootargs */
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

