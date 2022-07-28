Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984B584697
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiG1TiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG1TiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:38:20 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E9BC91;
        Thu, 28 Jul 2022 12:38:19 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id e16so2748228pfm.11;
        Thu, 28 Jul 2022 12:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vIxmQnkl3fMccyRP7AFD2Lb9/2fToNcLZtlAYIfiBfs=;
        b=1aScTeH9IMwd9KgvGBksY3vSB0MgLm7pInsW/sCqV7XLnhQD+LdjHiECRF1uvQpfQP
         ZiWrcwFDNUMc+EjR54Zjnqv+I0Ex+bNTHvs1gKFgNyPW3zexP5JdupOtT4DodVhfOk2j
         rE2cPuxUac9mY1xJO2gyUYg+9NsI063Dz5iVGZ6+WJ03ekkT9SY3wlFLd1oGERmWori9
         yosvs8Cu55bIjw3p8X8nETRemXtS2AcURIyr0qj+doEeSHmyYg2iPgY2Eb3XczEiRl0m
         bK8G7gHRjSSro14qeMKDU89iWc/tM8sZ1ccZEVXdWunGL50Uxq1awNXI/W4T6YpJ+4sr
         Zxdg==
X-Gm-Message-State: AJIora+cxEnI+Uj0//xjOWdpEpHJ06M0wIUFd1v1r1Gkq3kj65j0vzVR
        401UN9+Vatm0apiEUjQlSew=
X-Google-Smtp-Source: AGRyM1sQ2Iw/wfAEfc5Eohl7Ndyvtt0tx8n5tb4166A/8q/gKzMD0H2xapDfJxgN08wLwp9e8ILEqA==
X-Received: by 2002:a65:49c8:0:b0:41a:eb36:d1a7 with SMTP id t8-20020a6549c8000000b0041aeb36d1a7mr266848pgs.66.1659037099101;
        Thu, 28 Jul 2022 12:38:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9520:2952:8318:8e3e? ([2620:15c:211:201:9520:2952:8318:8e3e])
        by smtp.gmail.com with ESMTPSA id g1-20020a625201000000b0051bada81bc7sm1121860pfb.161.2022.07.28.12.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 12:38:17 -0700 (PDT)
Message-ID: <f803e7fb-9dde-e4d4-a55c-6427516dfdbb@acm.org>
Date:   Thu, 28 Jul 2022 12:38:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        linux-scsi@vger.kernel.org, kernel-team@android.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 00:01, Can Guo wrote:
>   static int ufshcd_map_queues(struct Scsi_Host *shost)
>   {
> -	int i, ret;
> +	int i, queue_offset = 0, ret;
> +	struct ufs_hba *hba = shost_priv(shost);
>   
>   	for (i = 0; i < shost->nr_maps; i++) {
>   		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
>   
> -		switch (i) {
> -		case HCTX_TYPE_DEFAULT:
> -		case HCTX_TYPE_POLL:
> -			map->nr_queues = 1;
> -			break;
> -		case HCTX_TYPE_READ:
> -			map->nr_queues = 0;
> +		map->nr_queues = hba->nr_queues[i];
> +		if (!map->nr_queues)
>   			continue;
> -		default:
> -			WARN_ON_ONCE(true);
> -		}
> -		map->queue_offset = 0;
> +
> +		map->queue_offset = queue_offset;
> +		if (i == HCTX_TYPE_POLL && !is_mcq_enabled(hba))
> +			map->queue_offset = 0;
> +
>   		ret = blk_mq_map_queues(map);
> -		WARN_ON_ONCE(ret);
> +
> +		if (ret)
> +			return ret;
> +
> +		queue_offset += map->nr_queues;
>   	}

It is not clear to me why the WARN_ON_ONCE(ret) statement has been 
changed into "if (ret) return ret;"?

Thanks,

Bart.
