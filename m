Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAAD580B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiGZG0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbiGZG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:26:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15AA31358;
        Mon, 25 Jul 2022 23:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658816532; x=1690352532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dzh+1CSSIH6C14edPRoY7J2NHub9uUBWlrGKu3JDw6E=;
  b=Rrr3mKjHZoInyfZ482hBlsNEH4K5YcLW5sQIiwSD4x1vCzdJdb9cHBWw
   9E3CpTseh5fkcNcawMnNbeP91wAsdTvtwpitqBPy8ySIlJu87hwjXctdL
   3ghpd+RZbxQz776Y3u0QUwbIadBoL9daG0EIcamivnz9P9ixR6BVnG9Jj
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jul 2022 23:21:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 23:21:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 23:21:49 -0700
Received: from [10.253.34.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 23:21:45 -0700
Message-ID: <b0a4ef07-afc8-51c7-c395-92ed798b914b@quicinc.com>
Date:   Tue, 26 Jul 2022 14:21:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
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
 <DM6PR04MB657540D8D6584C15C8701767FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <DM6PR04MB657540D8D6584C15C8701767FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,

On 7/24/2022 12:32 PM, Avri Altman wrote:
>> +
>> +/**
>> + * @ucdl_base_addr: UFS Command Descriptor base address
>> + * @sqe_base_addr: submission queue entry base address
>> + * @sqe_shadow_addr: submission queue entry shadow address
> When you are editing your commit log, could you please also say something about the shadow queues concept?

Sure, we will add comments in next version.

> And why it is a good idea to maintain 2 sets of addresses, which basically points to the same place?

When block layer chooses one task tag for one command, that tag will be 
used to link these pre-allocated data structs -

ucdl[tag]<->lrpb[tag]<->utrd[tag], and the tag chosen by block layer is 
random (it does not increase from 0 to n and goes

back to 0 in a circular way). But, in MCQ mode, when we submit the 
command to UFSHCI, we need to make sure the SQTP

get increased one slot by one slot (we cannot skip slots). Hence by 
keeping shadow utrds (or shadow SQEs), the data struct

linkage ucdl[tag]<->lrpb[tag]<->shadow_sqe[tag] remains same, and we 
copy the shadow sqe to the sqe[sq_tp_slot] only

when we finally decide the very sq_tp_slot used to submit this command 
in SQTP.

The benefit is that we can 100% leverage the existing initialization 
logic of lrbp in ufshcd_queuecommand path without changing a line.

Otherwise, considerable changes would be required to implement the idea 
of dynamical SQE assignment (to lrbp).


Thanks,

Can Guo.

>
> Thanks,
> Avri
