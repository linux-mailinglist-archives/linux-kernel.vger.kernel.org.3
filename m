Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A0520B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiEJCrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiEJCrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:47:37 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A827F11C;
        Mon,  9 May 2022 19:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652150621; x=1683686621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=InTny3n7yeTKHBypR3lvOVYf18pf04hsVskSXrNlYf0=;
  b=yOmnkI6MWqYkfM8CbKLTrSW4rWd1a1WLJcVMTCQcVMw18WZGOAAT+z2a
   bJwMzLNfupEWZASLBUpHp5ey72cHmglxT3igTJNMLC2d+O2qlodbhZrBa
   7d/LHUAxt/FMKLHVYXW1GLEvQd3u/YRc65TuIS+JUBVT8s/30XtVidGVA
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 May 2022 19:43:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 19:43:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 19:43:41 -0700
Received: from [10.216.42.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 19:43:37 -0700
Message-ID: <51bc6d33-c5f5-2a6e-fd83-ffebbe2e0202@quicinc.com>
Date:   Tue, 10 May 2022 08:13:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dma-buf: call dma_buf_stats_setup after dmabuf is in
 valid list
Content-Language: en-US
To:     "T.J. Mercier" <tjmercier@google.com>
CC:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Hridya Valsaraju <hridya@google.com>, <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
References: <1652125797-2043-1-git-send-email-quic_charante@quicinc.com>
 <CABdmKX2V55tA-Or6Dd+bpbcv3fDHps_+zHHJQwhz819LX_2RSQ@mail.gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CABdmKX2V55tA-Or6Dd+bpbcv3fDHps_+zHHJQwhz819LX_2RSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mercier,

On 5/10/2022 3:19 AM, T.J. Mercier wrote:
> On Mon, May 9, 2022 at 12:50 PM Charan Teja Kalla
> <quic_charante@quicinc.com> wrote:
>> From: Charan Teja Reddy <quic_charante@quicinc.com>
>>
>> When dma_buf_stats_setup() fails, it closes the dmabuf file which
>> results into the calling of dma_buf_file_release() where it does
>> list_del(&dmabuf->list_node) with out first adding it to the proper
>> list. This is resulting into panic in the below path:
>> __list_del_entry_valid+0x38/0xac
>> dma_buf_file_release+0x74/0x158
>> __fput+0xf4/0x428
>> ____fput+0x14/0x24
>> task_work_run+0x178/0x24c
>> do_notify_resume+0x194/0x264
>> work_pending+0xc/0x5f0
>>
>> Fix it by moving the dma_buf_stats_setup() after dmabuf is added to the
>> list.
>>
>> Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF stats in sysfs")
>> Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>
> Tested-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: T.J. Mercier <tjmercier@google.com>
> 

Thanks for the Ack. Also Realized that it should have:
Cc: <stable@vger.kernel.org> # 5.15.x+
