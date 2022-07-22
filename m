Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34B657E61F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiGVR6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiGVR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:58:29 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D757B61105;
        Fri, 22 Jul 2022 10:58:27 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id c3so5040057pfb.13;
        Fri, 22 Jul 2022 10:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XI6aI/fJE0zfHg81LO7kfFCj4mcwWmAT78t/HxVPB5c=;
        b=qcm8G3X12FJ7VxU+7fJHzlsss77YGiCq30PqsllDJ3BwZglyW2E/4QtoWNt5VxYcwz
         AsmG6aCV7Q3brPf1PdDmdePBk9P/7CQxlk/6b0uFvle3XnSPYQmOasGfIFZDIIGkoqFY
         KOuQO1sN9THff/MD6L9Vi9OHUk6NTssqYJB8kYpD8lU747gI/eqvTBnW1cbbXJl22R6q
         3+bAeBtUeltArTwekjuTezvAdVoqkOXFJTrxF6gpyO7wnRCN8UijYgk1fQ71FPC5wM9c
         R2ejg5rspP4AVKTCYmWE8WUjrD0xVQP9TH0m4Pu/Wtb9k9CpPXsry3R6qzyCbCVJVfhv
         LHyg==
X-Gm-Message-State: AJIora+ebT3cI30yjSVoB7f8CIbBPtaWYaqiFQSHXCoMiKEB/G5hMd7O
        L0slcirHlD/sfAoqhOpJNoU=
X-Google-Smtp-Source: AGRyM1tEbmCsZ17e5zfJFAHUCqG+l7LdCnTCt0iQrz00mXvdvvA31CYlcGjTBybG0R7PgETIt6p5Yw==
X-Received: by 2002:a63:500d:0:b0:415:e89e:42b7 with SMTP id e13-20020a63500d000000b00415e89e42b7mr821297pgb.140.1658512707195;
        Fri, 22 Jul 2022 10:58:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9cf6:7e29:d977:6fc7? ([2620:15c:211:201:9cf6:7e29:d977:6fc7])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm4037363plr.53.2022.07.22.10.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:58:26 -0700 (PDT)
Message-ID: <1de1372e-1c69-611b-0999-c162da8013ac@acm.org>
Date:   Fri, 22 Jul 2022 10:58:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Can Guo <quic_cang@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
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

On 7/22/22 00:31, Avri Altman wrote:
>> +#define UFSHCD_MCQ_IO_QUEUE_OFFSET     1
> Maybe add a comment above: "queue 0 is reserved for query commands" or something
> That is if the query commands don't use the  legacy doorbell

Is it essential to reserve a queue for device management commands? 
Wouldn't it be better to have one additional queue for submitting I/O 
commands rather than reserving a queue for device management commands?

Thanks,

Bart.

