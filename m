Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8457E825
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiGVUO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGVUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:14:54 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889DFA9BB5;
        Fri, 22 Jul 2022 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658520893; x=1690056893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2zVs0b9FB/T51HFHlQCR7ofMmfzoiPTm4/PYGj82vc8=;
  b=jVMF1K86mipLuQt/scisRGZRd1dIF9laxmajVzt/eQ8x4NWfYcELxHX3
   +zAwAYMRVJtyeSp/crCOUywLbreWz+BP2IbiQAVJVpNW8Bt9FRFKfZCWD
   76PoRJVI5fRypeWrCjk4DcTQQFsAP1gy/J1hBgqNFGAz/ql7fM95SJC6g
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jul 2022 13:14:53 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 13:14:53 -0700
Received: from [10.110.117.123] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Jul
 2022 13:14:52 -0700
Message-ID: <34bd42f1-bf2e-854f-90ba-174db7c68adc@quicinc.com>
Date:   Fri, 22 Jul 2022 13:14:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Avri Altman <Avri.Altman@wdc.com>, Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4838bb09-d5a8-9b6a-9011-5394b8869695@quicinc.com>
 <DM6PR04MB6575B4E2707200BDFFEE4A08FC909@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <DM6PR04MB6575B4E2707200BDFFEE4A08FC909@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/2022 12:37 PM, Avri Altman wrote:
>>>> +
>>>> +       /* Manually allocate MCQ resource */
>>> Did you consider to force providing the MCQ configuration?
> How about this one?
> 
Sorry missed this comment.
Do you mean to return error if MCQ configuration is undefined?

-asd
