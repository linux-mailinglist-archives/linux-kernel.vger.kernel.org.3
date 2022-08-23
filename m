Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841E359D2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiHWIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbiHWIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:01:24 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C33659D3;
        Tue, 23 Aug 2022 01:01:21 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N78hfE024458;
        Tue, 23 Aug 2022 10:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=VGil/aQXx8aFFdqtu8yfkzPoDDu+4QVF29mk2llx6+8=;
 b=N9lwxC7NsIUCP0sm2Hnh3ay+sQefIWD7kA9YKHUTuFXYHPNd/5Jg05EqYI1sZ8DfbfYh
 vXP/V9YUaCg8X3TVf9qRZk7lSpivWDXlWCmJlkY5pL4B1SrJCHLpiOe7D9kev/GY1qrF
 SyLqOiZPXMHem1w26SvGpGqS45paQpZ7FcQYavzzJSTRtJZw/hIh24FiR4QIfJM6WT8+
 ARPRw52ob7XKWL2D6z0J+EKE7UmsJttycHPTkuPB0Tjd41+QzKqKlZd3jLr2YSUbdh6X
 uXq8m2hcWqP8IFTqcsYDBl+ViSgqOjivOM8thhYB4gRmDv7eF+wK7RR+NbYpCGGOWEQ7 +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j2x2rckyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 10:01:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C7CA510002A;
        Tue, 23 Aug 2022 10:01:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFFE3216EF4;
        Tue, 23 Aug 2022 10:01:06 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.47) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 23 Aug
 2022 10:01:06 +0200
Message-ID: <cd7ba3ad-c6d8-618a-c11c-f8b719236af1@foss.st.com>
Date:   Tue, 23 Aug 2022 10:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: (subset) [PATCH v3 0/2] spi: stm32_qspi: use QSPI bus as 8 lines
 communication channel
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220816161344.2599908-1-patrice.chotard@foss.st.com>
 <166118433897.209120.16190099503428270567.b4-ty@kernel.org>
 <319927f9-5265-81fd-2c6b-7c5146d90687@foss.st.com>
 <YwOz4MJ5zc4YOb4s@sirena.org.uk>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <YwOz4MJ5zc4YOb4s@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_03,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On 8/22/22 18:50, Mark Brown wrote:
> On Mon, Aug 22, 2022 at 06:21:16PM +0200, Patrice CHOTARD wrote:
>> Hi Mark
>>
>> I just noticed that the cleanup() callback is useless as the gpiod is 
>> automatically freed by devm.
>>
>> As you haven't send your pull request, do you accept a fixup patch you will squash 
>> with patch [2/2] "spi: stm32_qspi: Add transfer_one_message() spi callback"
>> or standalone patch ?
> 
> Normally you should just send an incremental patch but since it was the
> top commit of the branch and I only just pushed it I've dropped this
> commit (b051161f44d414e736fa2b011245441bae9babd7) so you can resend
> with the fix squashed in if you want.


I have resubmited the patch with the fix squashed in : 
https://lore.kernel.org/linux-spi/20220823075850.575043-1-patrice.chotard@foss.st.com/T/#t

Thanks
Patrice
