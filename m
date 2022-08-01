Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3D5863C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiHAF26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHAF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:28:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4196DF71
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659331735; x=1690867735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fnJA2N4BlsQJQig0zFxKAUGxel99425sq0Qw9NnY5No=;
  b=F8pBeZAAq55Ou3qa3nCCpJ5GvZ+vTieEeCHPk3cXgSpajrWYLKTjlTGe
   1t/ojYFVcyyaZEQC/7YWDBBKcY7XjbTVLTPWKn9hpSySPFsKAq9NY0Ywi
   BIKI74okNOZSTCEgYhd5DW5GIXFIE3NX8A1JJH9JC0WBfhsr2v1oK2e2W
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 Jul 2022 22:28:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 22:28:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 31 Jul 2022 22:28:55 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 31 Jul 2022 22:28:52 -0700
Date:   Mon, 1 Aug 2022 10:58:48 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>, <mhocko@suse.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_ext: remove unused variable in offline_page_ext
Message-ID: <20220801052848.GB18790@hu-pkondeti-hyd.qualcomm.com>
References: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:36:37AM +0530, Charan Teja Kalla wrote:
> Remove unused variable 'nid' in offline_page_ext(). This is not used
> since the page_ext code inception.
> 

Just to be clear, should we say "drop nid argument from offline_page_exit"?
With this change the symmetry between "online_page_exit" and "offline_page_exit"
is lost. But that is not a valid point to keep an unused argument.

> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/page_ext.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3dc715d..e22a928 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -336,7 +336,7 @@ static int __meminit online_page_ext(unsigned long start_pfn,
>  }
>  
>  static int __meminit offline_page_ext(unsigned long start_pfn,
> -				unsigned long nr_pages, int nid)
> +				unsigned long nr_pages)
>  {
>  	unsigned long start, end, pfn;
>  
> @@ -362,11 +362,11 @@ static int __meminit page_ext_callback(struct notifier_block *self,
>  		break;
>  	case MEM_OFFLINE:
>  		offline_page_ext(mn->start_pfn,
> -				mn->nr_pages, mn->status_change_nid);
> +				mn->nr_pages);
>  		break;
>  	case MEM_CANCEL_ONLINE:
>  		offline_page_ext(mn->start_pfn,
> -				mn->nr_pages, mn->status_change_nid);
> +				mn->nr_pages);
>  		break;
>  	case MEM_GOING_OFFLINE:
>  		break;

Looks good to me.

Thanks,
Pavan
