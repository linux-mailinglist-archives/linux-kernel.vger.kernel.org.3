Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FB4D1CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbiCHQLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiCHQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:11:05 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3260F4BB8A;
        Tue,  8 Mar 2022 08:10:09 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228F561U031509;
        Tue, 8 Mar 2022 16:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=ni2RcHbBWbxRqXJonIpINAZ0VoX/b33Cib5ToW/CQGI=;
 b=DHzWU5SjE7wpEDAGRDbYX9jspPgrNg8qviHUblWtzURUtD/L1cCZhPwAUB9FyG5B3VMY
 u+sl05OH2gIoEJRunC7YJ4K0l/4n4gHX/wEWyoOB45wmuedCF++K4oh7g8kn55X1QTjU
 5Bo+KqD+a3D7p4DzvS0GYIuYc9fgSEZnfwbcQ+7Oxp1BQpH4geQR0uB/26yDMTec/YjF
 n6KgU0vUx6hYOY8jPvinY50XD3PU22yC2tLVD6gfJcnn9OgfgNTotvYRAkqjO4qhHhGo
 LkHpaOVSSh8Uqfw88kG/dT+WD2sL2btroFJjYQ5X43utgm6D2u26lgxtZgRqeWLFoWRf Sw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ep9f60pm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 16:09:47 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 0A0EA86;
        Tue,  8 Mar 2022 16:09:46 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.218.77])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 2CDAB36;
        Tue,  8 Mar 2022 16:09:44 +0000 (UTC)
Date:   Tue, 8 Mar 2022 10:09:43 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/platform/uv: Add gap hole end size
Message-ID: <Yid/x8NUqOP8fO+7@swahl-home.5wahls.com>
References: <20220308010537.70150-1-mike.travis@hpe.com>
 <20220308010537.70150-5-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308010537.70150-5-mike.travis@hpe.com>
X-Proofpoint-ORIG-GUID: sM0N9yHvhj5r9rnLtS38Y1m-6bv9beEO
X-Proofpoint-GUID: sM0N9yHvhj5r9rnLtS38Y1m-6bv9beEO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=898 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080087
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

I know you're trying to get this out and don't really need another
delta, and I'd be holding it back if I didn't think it might make
things smoother upstream.

But what I'd consider for this one is:  Add the word log to the
subject line, perhaps "Add gap hole end size to log", or just "Log gap
hole end size".  Without it, the reviewer has to ask "add to *where*?"

And I believe the second sentence of the description, "The structure
stores PA bits 56:26, for > 64MB granularity, up to 64PB max size," is
perhaps not necessary, and I think it may slow down somebody trying to
read the patch quickly.  So I'd consider deleting it.

With those two changes the description still matches the code, and
seems simpler and easier to accept.

Your call on either / both, of course.

--> Steve

On Mon, Mar 07, 2022 at 07:05:37PM -0600, Mike Travis wrote:
> Show value of gap end in kernel log which equates to number of physical
> address bits used by system.  The structure stores PA bits 56:26, for
> 64MB granularity, up to 64PB max size.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 387d6533549a..146f0f63a43b 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -1346,7 +1346,7 @@ static void __init decode_gam_params(unsigned long ptr)
>  static void __init decode_gam_rng_tbl(unsigned long ptr)
>  {
>  	struct uv_gam_range_entry *gre = (struct uv_gam_range_entry *)ptr;
> -	unsigned long lgre = 0;
> +	unsigned long lgre = 0, gend = 0;
>  	int index = 0;
>  	int sock_min = 999999, pnode_min = 99999;
>  	int sock_max = -1, pnode_max = -1;
> @@ -1380,6 +1380,9 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
>  			flag, size, suffix[order],
>  			gre->type, gre->nasid, gre->sockid, gre->pnode);
>  
> +		if (gre->type == UV_GAM_RANGE_TYPE_HOLE)
> +			gend = (unsigned long)gre->limit << UV_GAM_RANGE_SHFT;
> +
>  		/* update to next range start */
>  		lgre = gre->limit;
>  		if (sock_min > gre->sockid)
> @@ -1397,7 +1400,8 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
>  	_max_pnode	= pnode_max;
>  	_gr_table_len	= index;
>  
> -	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x) pnodes(min:%x,max:%x)\n", index, _min_socket, _max_socket, _min_pnode, _max_pnode);
> +	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x), pnodes(min:%x,max:%x), gap_end(%d)\n",
> +	  index, _min_socket, _max_socket, _min_pnode, _max_pnode, fls64(gend));
>  }
>  
>  /* Walk through UVsystab decoding the fields */
> -- 
> 2.26.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
